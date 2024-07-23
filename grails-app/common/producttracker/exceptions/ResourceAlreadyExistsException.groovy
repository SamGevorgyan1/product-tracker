package producttracker.exceptions

abstract class ResourceAlreadyExistsException extends RuntimeException {
    protected ResourceAlreadyExistsException(String message) {
        super(message)
    }

    protected ResourceAlreadyExistsException(String message, Throwable cause) {
        super(message, cause)
    }
}
