package producttracker

import grails.gorm.transactions.Transactional
import producttracker.productexception.ProductNotFoundException
import producttracker.storageexception.StorageApiException
import producttracker.storageexception.StorageBadRequestException
import producttracker.storageexception.StorageNotFoundException
import producttracker.storeexception.StoreNotFoundException

@Transactional
class StorageService implements MessageHelperTrait {

    /**
     * Lists all storage entities.
     * @return A list of Storage objects.
     * @throws StorageApiException if there's an error retrieving the list.
     */
    List<Storage> list() {
        try {
            return Storage.list()
        } catch (e) {
            throw new StorageApiException(getMessage('storage.list.error'), e)
        }
    }

    /**
     * Saves a new Storage entity.
     * @param storage The Storage entity to be saved.
     * @return The saved Storage object.
     * @throws StorageBadRequestException if the Storage has an ID or name is null.
     * @throws StorageApiException if there's an error saving the Storage.
     */
    Storage save(Storage storage) {
        if (storage.id != null) {
            throw new StorageBadRequestException(getMessage('storage.save.id.not.null'))
        }
        if (!storage.name) {
            throw new StorageBadRequestException(getMessage('storage.save.name.null'))
        }
        try {
            return storage.save(flush: true)
        } catch (e) {
            throw new StorageApiException(getMessage('storage.save.error'), e)
        }
    }

    /**
     * Finds a Storage entity by its ID.
     * @param id The ID of the Storage to find.
     * @return The Storage object.
     * @throws StorageBadRequestException if the ID is null.
     * @throws StorageNotFoundException if the Storage with the given ID is not found.
     */
    Storage findById(UUID id) {
        if (id == null) {
            throw new StorageBadRequestException(getMessage('storage.find.id.null'))
        }
        Storage storage = Storage.findById(id)
        if (!storage) {
            throw new StorageNotFoundException(getMessage('storage.not.found', [id] as Object[]))
        }
        return storage
    }

    /**
     * Updates an existing Storage entity.
     * @param storage The Storage entity to update.
     * @return The updated Storage object.
     */
    Storage edit(Storage storage) {
        return storage.save(flush: true)
    }

    /**
     * Deletes a Storage entity by its ID.
     * @param storageId The ID of the Storage to delete.
     * @throws StorageApiException if there's an error deleting the Storage.
     */
    void delete(UUID storageId) {
        def storage = findById(storageId)
        try {
            storage.delete()
        } catch (e) {
            throw new StorageApiException(getMessage('storage.delete.error'), e)
        }
    }

    /**
     * Adds or updates a product in a Storage.
     * @param storageId The ID of the Storage.
     * @param productCode The code of the Product.
     * @param quantity The quantity to add or update.
     * @return The updated StorageProduct object.
     * @throws StorageBadRequestException if the quantity is invalid or product not found.
     */
    StorageProduct addOrUpdateProduct(UUID storageId, String productCode, Integer quantity) {
        Storage storage = findById(storageId)
        Product product = findProductByCode(productCode)

        validateQuantity(quantity)

        StorageProduct storageProduct = StorageProduct.findByStorageAndProduct(storage, product)
        if (storageProduct) {
            storageProduct.quantity += quantity
        } else {
            storageProduct = new StorageProduct(storage: storage, product: product, quantity: quantity)
        }
        return storageProduct.save(flush: true)
    }

    /**
     * Delivers a product from a Storage to a Store.
     * @param storageId The ID of the Storage.
     * @param productCode The code of the Product.
     * @param quantity The quantity to deliver.
     * @param storeId The ID of the Store.
     * @throws StorageBadRequestException if there are insufficient quantities or product not found.
     */
    void deliverProduct(UUID storageId, String productCode, Integer quantity, UUID storeId) {
        Storage storage = findById(storageId)
        Product product = findProductByCode(productCode)
        Store store = findStoreById(storeId)

        validateQuantity(quantity)
        validateStorageProduct(storage, product, quantity)

        StoreProduct storeProduct = StoreProduct.findByStoreAndProduct(store, product)
        if (storeProduct) {
            storeProduct.quantity += quantity
        } else {
            storeProduct = new StoreProduct(store: store, product: product, quantity: quantity, storage: storage)
        }
        storeProduct.save(flush: true)
        updateStorageProductQuantity(storage, product, quantity)
    }

    /**
     * Removes a product from a Storage.
     * @param storageId The ID of the Storage.
     * @param productCode The code of the Product.
     * @param quantity The quantity to remove.
     * @throws StorageBadRequestException if the quantity is invalid or exceeds available quantity.
     */
    void removeProduct(UUID storageId, String productCode, int quantity) {
        Storage storage = findById(storageId)
        Product product = findProductByCode(productCode)
        StorageProduct storageProduct = StorageProduct.findByStorageAndProduct(storage, product)

        validateQuantity(quantity)

        if (quantity > storageProduct.quantity) {
            throw new StorageBadRequestException(getMessage('storage.insufficient.quantity', [quantity, storageProduct.quantity]))
        }

        storageProduct.quantity -= quantity
        if (storageProduct.quantity == 0) {
            storageProduct.delete(flush: true)
        } else {
            storageProduct.save(flush: true)
        }
    }

    private void validateStorageProduct(Storage storage, Product product, Integer quantity) {
        StorageProduct storageProduct = StorageProduct.findByStorageAndProduct(storage, product)
        if (!storageProduct) {
            throw new StorageBadRequestException(getMessage('storage.product.not.found', [product.barcode, storage.name]))
        }
        if (storageProduct.quantity < quantity) {
            throw new StorageBadRequestException(getMessage('storage.insufficient.quantity', [quantity, storageProduct.quantity]))
        }
    }

    private void updateStorageProductQuantity(Storage storage, Product product, Integer quantity) {
        StorageProduct storageProduct = StorageProduct.findByStorageAndProduct(storage, product)
        storageProduct.quantity -= quantity
        if (storageProduct.quantity == 0) {
            storageProduct.delete(flush: true)
        } else {
            storageProduct.save(flush: true)
        }
    }

    private Store findStoreById(UUID storeId) {
        def store = Store.findById(storeId)
        if (!store) {
            throw new StoreNotFoundException(getMessage('store.not.found'))
        }
        return store
    }

    private Product findProductByCode(String productCode) {
        def product = Product.findByBarcode(productCode)
        if (!product) {
            throw new ProductNotFoundException(getMessage('product.not.found', [productCode]))
        }
        return product
    }

    private void validateQuantity(Integer quantity) {
        if (quantity <= 0) {
            throw new StorageBadRequestException(getMessage('storage.quantity.invalid'))
        }
    }
}
