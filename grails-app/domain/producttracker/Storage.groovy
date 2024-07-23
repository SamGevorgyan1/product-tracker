package producttracker

class Storage {
    UUID id
    String name
    static hasMany = [storageProducts: StorageProduct]

    static constraints = {
        name blank: false
    }

    static mapping = {
        table 'storages'
        id column: 'storage_id', generator: 'uuid2', type: 'pg-uuid'
        name column: 'storage_name'
        storageProducts cascade: 'all'
    }
}