package producttracker

class StoreProduct {
    UUID id
    Storage storage
    Store store
    Product product
    Integer quantity

    static constraints = {
        store nullable: false
        product nullable: false
        quantity min: 0
    }

    static mapping = {
        table 'store_products'
        id column: 'store_product_id', generator: 'uuid2', type: 'pg-uuid'
        quantity column: 'store_product_quantity'
    }
}