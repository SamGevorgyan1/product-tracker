package producttracker.storageexception

import producttracker.exceptions.ApiException

class StorageApiException extends ApiException {
    StorageApiException(String message) {
        super(message)
    }

    StorageApiException(String message, Throwable cause) {
        super(message, cause)
    }
}
