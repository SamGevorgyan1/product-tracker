package producttracker.storeexception

import producttracker.exceptions.ApiException

class StoreApiException extends ApiException {
    StoreApiException(String message) {
        super(message)
    }

    StoreApiException(String message, Throwable cause) {
        super(message, cause)
    }
}
