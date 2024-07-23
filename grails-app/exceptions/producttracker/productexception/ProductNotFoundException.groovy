package producttracker.productexception

import producttracker.exceptions.NotFoundException

class ProductNotFoundException extends NotFoundException {
    ProductNotFoundException(String message) {
        super(message)
    }

    ProductNotFoundException(String message, Throwable cause) {
        super(message, cause)
    }
}
