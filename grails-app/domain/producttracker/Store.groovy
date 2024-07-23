package producttracker

class Store {
    UUID id
    String name
    String address
    static hasMany = [storeProducts: StoreProduct]

    static constraints = {
        name blank: false
        address blank: false
    }

    static mapping = {
        table 'stores'
        id column: 'store_id', generator: 'uuid2', type: 'pg-uuid'
        name column: 'store_name'
        address column: 'store_address'
    }
}