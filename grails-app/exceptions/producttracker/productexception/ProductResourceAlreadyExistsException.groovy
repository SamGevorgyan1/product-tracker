package producttracker.productexception

import producttracker.exceptions.ResourceAlreadyExistsException

class ProductResourceAlreadyExistsException extends ResourceAlreadyExistsException {
    ProductResourceAlreadyExistsException(String message) {
        super(message)
    }

    ProductResourceAlreadyExistsException(String message, Throwable cause) {
        super(message, cause)
    }
}
