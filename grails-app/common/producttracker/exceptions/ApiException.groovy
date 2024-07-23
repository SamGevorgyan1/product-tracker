package producttracker.exceptions

abstract class ApiException extends RuntimeException {
    protected ApiException(String message) {
        super(message)
    }

    protected ApiException(String message, Throwable cause) {
        super(message, cause)
    }
}
