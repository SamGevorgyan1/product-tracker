package producttracker

class StorageProduct {
    UUID id
    Storage storage
    Product product
    Integer quantity

    static constraints = {
        storage nullable: false
        product nullable: false
        quantity min: 0
    }

    static mapping = {
        table 'storage_products'
        id column: 'storage_product_id', generator : 'uuid2' , type: 'pg-uuid'
        quantity column: 'storage_product_quantity'
    }
}