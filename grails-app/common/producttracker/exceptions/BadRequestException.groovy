package producttracker.exceptions

abstract class BadRequestException extends RuntimeException {
    protected BadRequestException(String message) {
        super(message)
    }

    protected BadRequestException(String message, Throwable cause) {
        super(message, cause)
    }
}
