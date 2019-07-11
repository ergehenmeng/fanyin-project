package com.fanyin.validation;

import com.fanyin.enums.Source;
import com.fanyin.validation.annotation.SourceType;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

/**
 * @author 二哥很猛
 * @date 2018/8/14 16:07
 */
public class SourceTypeDefine implements ConstraintValidator<SourceType,String> {

    private boolean required;

    private Source[] sources;


    @Override
    public void initialize(SourceType constraintAnnotation) {
        this.required = constraintAnnotation.required();
        this.sources = constraintAnnotation.value();
    }

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        if(!required && value == null){
            return true;
        }
        for (Source source : sources){
            if(source.name().equals(value)){
                return true;
            }
        }
        return false;
    }
}
