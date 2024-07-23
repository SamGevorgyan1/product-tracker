package producttracker

import grails.gorm.transactions.Transactional
import producttracker.productexception.ProductNotFoundException
import producttracker.storageexception.StorageNotFoundException
import producttracker.storeexception.StoreApiException
import producttracker.storeexception.StoreBadRequestException
import producttracker.storeexception.StoreNotFoundException


@Transactional
class StoreService implements MessageHelperTrait {


    /**
     * Sells a product from the store.
     *
     * @param storeId UUID of the store where the product will be sold.
     * @param productCode Barcode of the product to be sold.
     * @param quantity Quantity of the product to be sold.
     * @throws StoreBadRequestException if product code or quantity is null.
     * @throws StoreNotFoundException if the store is not found.
     * @throws ProductNotFoundException if the product is not found.
     * @throws StoreBadRequestException if there is insufficient quantity of the product in the store.
     */
    def sellProduct(UUID storeId, String productCode, Integer quantity) {
        if (productCode == null) {
            throw new StoreBadRequestException(getMessage('product.code.null'))
        }
        if (quantity == null) {
            throw new StoreBadRequestException(getMessage('product.quantity.null'))
        }

        Store store = findById(storeId)
        Product product = findProduct(productCode)

        StoreProduct storeProduct = StoreProduct.findByStoreAndProduct(store, product)
        if (!storeProduct || storeProduct.quantity < quantity) {
            throw new StoreBadRequestException(getMessage('insufficient.product.quantity'))
        }
        storeProduct.quantity -= quantity
        if (storeProduct.quantity == 0) {
            storeProduct.delete(flush: true)
        } else {
            storeProduct.save(flush: true)
        }
        store.save(flush: true)
    }

    /**
     * Returns a product to storage from the store.
     *
     * @param storeId UUID of the store where the product will be returned from.
     * @param storageId UUID of the storage where the product will be returned to.
     * @param productCode Barcode of the product to be returned.
     * @param quantity Quantity of the product to be returned.
     * @throws StorageNotFoundException if the storage is not found.
     * @throws StoreBadRequestException if there is insufficient quantity of the product in the store.
     */
    def returnProductToStorage(UUID storeId, UUID storageId, String productCode, int quantity) {
        Store store = findById(storeId)
        Storage storage = findStorage(storageId)
        Product product = findProduct(productCode)

        StoreProduct storeProduct = StoreProduct.findByStoreAndProduct(store, product)
        if (!storeProduct || storeProduct.quantity < quantity) {
            throw new StoreBadRequestException(getMessage('insufficient.product.quantity'))
        }

        StorageProduct storageProduct = StorageProduct.findByStorageAndProduct(storage, product)
        if (storageProduct) {
            storageProduct.quantity += quantity
        } else {
            storageProduct = new StorageProduct(product: product, storage: storage, quantity: quantity).save(flush: true)
        }
        storage.addToStorageProducts(storageProduct)
        storeProduct.quantity -= quantity
        if (storeProduct.quantity == 0) {
            storeProduct.delete(flush: true)
        }

        store.save(flush: true)
        storage.save(flush: true)
    }

    /**
     * Finds a store by its ID.
     *
     * @param id UUID of the store to find.
     * @return The store with the specified ID.
     * @throws StoreBadRequestException if the provided ID is null.
     * @throws StoreNotFoundException if the store with the specified ID is not found.
     */
    Store findById(UUID id) {
        if (!id) {
            throw new StoreBadRequestException(getMessage('store.find.id.null'))
        }
        Store store = Store.findById(id)
        if (!store) {
            throw new StoreNotFoundException(getMessage('store.not.found', [id] as Object[]))
        }
        return store
    }

    /**
     * Lists all stores.
     *
     * @return A list of all stores.
     */
    List<Store> list() {
        return Store.list()
    }

    /**
     * Creates a new store.
     *
     * @param store The store object to be created.
     * @throws StoreBadRequestException if the store ID is not null or the store name is null.
     */
    Store create(Store store) {
        if (store.id != null) {
            throw new StoreBadRequestException(getMessage('store.id.must.be.null'))
        }
        if (store.name == null) {
            throw new StoreBadRequestException(getMessage('store.name.null'))
        }
        store.save(flush: true)
    }

    /**
     * Deletes a store by its ID.
     *
     * @param id UUID of the store to be deleted.
     * @throws StoreApiException if an error occurs during deletion.
     */
    void delete(UUID id) {
        def store = findById(id)
        try {
            store.delete(flush: true)
        } catch (e) {
            throw new StoreApiException(getMessage('store.delete.error'), e)
        }
    }

    private Storage findStorage(UUID storageId) {
        Storage storage = Storage.findById(storageId)
        if (!storage) {
            throw new StorageNotFoundException(getMessage('storage.not.found'))
        }
        return storage
    }

    private Product findProduct(String productCode) {
        Product product = Product.findByBarcode(productCode)
        if (!product) {
            throw new ProductNotFoundException(getMessage('product.not.found'))
        }
        return product
    }
}