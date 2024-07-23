package producttracker.storeexception

import producttracker.exceptions.BadRequestException

class StoreBadRequestException extends BadRequestException{
     StoreBadRequestException(String message) {
        super(message)
    }

    StoreBadRequestException(String message, Throwable cause) {
        super(message, cause)
    }
}
