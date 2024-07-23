package producttracker.productexception

import producttracker.exceptions.ApiException

class ProductApiException extends ApiException {
    ProductApiException(String message) {
        super(message)
    }

    ProductApiException(String message, Throwable cause) {
        super(message, cause)
    }
}
