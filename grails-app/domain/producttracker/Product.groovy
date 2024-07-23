package producttracker

import java.time.LocalDate

class Product {
    UUID id
    String barcode
    String title
    BigDecimal price
    LocalDate creationDate
    LocalDate deadline

    static constraints = {
        barcode blank: false, unique: true
        title blank: false
        price min: 0.0
        creationDate nullable: false
        deadline nullable: true
    }

    static mapping = {
        table 'products'
        id column: 'product_id', generator: 'uuid2', type: 'pg-uuid'
        barcode column: 'product_barcode'
        title column: 'product_title'
        price column: 'product_price'
        creationDate column: 'product_creation_date'
        deadline column: 'product_deadline'
    }
}