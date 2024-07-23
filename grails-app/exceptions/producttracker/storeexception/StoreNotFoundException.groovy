package producttracker.storeexception

class StoreNotFoundException extends RuntimeException {
    StoreNotFoundException(String message) {
        super(message)
    }

    StoreNotFoundException(String message, Throwable cause) {
        super(message, cause)
    }
}
