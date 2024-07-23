package producttracker

import org.springframework.context.MessageSource

trait MessageHelperTrait {

    MessageSource messageSource

     String getMessage(String code) {
        return messageSource.getMessage(code, null, Locale.ENGLISH)
    }

    String getMessage(String code, Object[] args) {
        return messageSource.getMessage(code, args, Locale.ENGLISH)
    }
}