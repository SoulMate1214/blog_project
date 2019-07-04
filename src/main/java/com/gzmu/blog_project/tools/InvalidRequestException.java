package com.gzmu.blog_project.tools;

import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;

/**
 * @className: InvalidRequestException
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 下午1:06 19-7-4
 * @modified:
 */
public class InvalidRequestException extends Exception {
    private Errors errors;
    public InvalidRequestException(String invalidParameter, BindingResult errors) {
        super(invalidParameter);
        this.errors = errors;
    }
}
