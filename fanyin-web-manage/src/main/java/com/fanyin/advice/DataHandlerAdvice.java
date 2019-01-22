package com.fanyin.advice;

import com.fanyin.configuration.DatePropertyEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.InitBinder;

import java.util.Date;

/**
 * @author 二哥很猛
 * @date 2019/1/22 17:16
 */
@ControllerAdvice
public class DataHandlerAdvice {

    /**
     * 日期类型处理
     * @param binder binder
     */
    @InitBinder
    public void initBinder(WebDataBinder binder){
        binder.registerCustomEditor(Date.class,new DatePropertyEditor());
    }
}
