package producttracker.storageexception

import producttracker.exceptions.BadRequestException

class StorageBadRequestException extends BadRequestException {
    StorageBadRequestException(String message) {
        super(message)
    }
}
