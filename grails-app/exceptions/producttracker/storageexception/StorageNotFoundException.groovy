package producttracker.storageexception

import producttracker.exceptions.NotFoundException

class StorageNotFoundException  extends NotFoundException {
    StorageNotFoundException(String message) {
        super(message)
    }
}