package producttracker.productexception

import producttracker.exceptions.BadRequestException

class ProductBadRequestException extends BadRequestException{
     ProductBadRequestException(String message) {
        super(message)
    }

    ProductBadRequestException(String message, Throwable cause) {
        super(message, cause)
    }
}
