package producttracker

import grails.gorm.transactions.Transactional
import producttracker.productexception.ProductApiException
import producttracker.productexception.ProductBadRequestException
import producttracker.productexception.ProductNotFoundException
import producttracker.productexception.ProductResourceAlreadyExistsException
import java.time.LocalDate

@Transactional
class ProductService implements MessageHelperTrait {


    /**
     * Saves a new Product entity.
     * @param product The Product entity to be saved.
     * @return The saved Product entity.
     * @throws ProductBadRequestException if the Product ID is not null or the barcode already exists.
     * @throws ProductApiException if there's an error saving the Product.
     */
    Product save(Product product) {
        if (product.id != null) {
            throw new ProductBadRequestException(getMessage('product.id.must.be.null'))
        }
        validateProduct(product)
        if (!product.save(flush: true)) {
            throw new ProductApiException(getMessage('product.save.error'))
        }
        return product
    }

    /**
     * Deletes a Product by its ID.
     * @param id The ID of the Product to delete.
     * @throws ProductBadRequestException if the Product is used in Storage or Store.
     */
    void delete(UUID id) {
        def product = get(id)
        if (StorageProduct.findByProduct(product)) {
            throw new ProductBadRequestException(getMessage('product.used.in.storage'))
        }
        if (StoreProduct.findByProduct(product)) {
            throw new ProductBadRequestException(getMessage('product.used.in.store'))
        }
        product.delete()
    }

    /**
     * Lists all Product entities.
     * @return A list of Product objects.
     * @throws ProductApiException if there's an error retrieving the list.
     */
    List<Product> list() {
        try {
            return Product.list()
        } catch (e) {
            throw new ProductApiException(getMessage('product.list.error'), e)
        }
    }

    /**
     * Retrieves a Product by its ID.
     * @param id The ID of the Product to retrieve.
     * @return The Product object.
     * @throws ProductBadRequestException if the ID is null.
     * @throws ProductNotFoundException if the Product with the given ID is not found.
     */
    Product get(UUID id) {
        if (id == null) {
            throw new ProductBadRequestException(getMessage('product.id.null'))
        }
        def product = Product.findById(id)
        if (!product) {
            throw new ProductNotFoundException(getMessage('product.not.found'))
        }
        return product
    }

    /**
     * Updates an existing Product entity.
     * @param product The Product entity to update.
     * @throws ProductBadRequestException if creationDate or deadline are changed or other validation fails.
     * @throws ProductApiException if there's an error updating the Product.
     */
    void update(Product product) {
        def existingProduct = get(product.id)
        if (product.creationDate != existingProduct.creationDate || product.deadline != existingProduct.deadline) {
            throw new ProductBadRequestException(getMessage('product.creation.deadline.unchangeable'))
        }
        validateProduct(product)
        existingProduct.title = product.title
        existingProduct.barcode = product.barcode
        existingProduct.price = product.price

        if (!existingProduct.save(flush: true)) {
            throw new ProductApiException(getMessage('product.update.error'))
        }
    }

    /**
     * Validates a Product entity.
     * @param product The Product entity to validate.
     * @throws ProductBadRequestException if validation fails.
     */
    void validateProduct(Product product) {
        if (product.price <= 0) {
            throw new ProductBadRequestException(getMessage('product.price.min.error'))
        }
        if (product.creationDate == null) {
            product.creationDate = LocalDate.now()
        } else if (product.creationDate.isAfter(LocalDate.now())) {
            throw new ProductBadRequestException(getMessage('product.creation.date.future.error'))
        }
        if (product.deadline != null && product.deadline.isBefore(product.creationDate)) {
            throw new ProductBadRequestException(getMessage('product.deadline.creation.date.error'))
        }
        def productWithSameBarcode = Product.findByBarcodeAndIdNotEqual(product.barcode, product?.id)
        if (productWithSameBarcode) {
            throw new ProductResourceAlreadyExistsException(getMessage('product.barcode.unique.error'))
        }
    }
}
