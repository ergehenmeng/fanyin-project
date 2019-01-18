package com.fanyin.controller;

import org.springframework.boot.autoconfigure.web.BasicErrorController;
import org.springframework.boot.autoconfigure.web.ErrorAttributes;
import org.springframework.boot.autoconfigure.web.ErrorProperties;
import org.springframework.boot.autoconfigure.web.ErrorViewResolver;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 4xx 5xx异常返回页面或者json结果
 * 该类为了与全局返回数据结构保持一致
 * @author 二哥很猛
 * @date 2019/1/18 14:17
 */
public class ErrorPageController extends BasicErrorController {

    public ErrorPageController(ErrorAttributes errorAttributes, ErrorProperties errorProperties, List<ErrorViewResolver> errorViewResolvers) {
        super(errorAttributes, errorProperties, errorViewResolvers);
    }

    @Override
    public ResponseEntity<Map<String, Object>> error(HttpServletRequest request) {
        Map<String,Object> map = new HashMap<>();
        HttpStatus status = super.getStatus(request);
        RequestAttributes requestAttributes = new ServletRequestAttributes(request);
        Object msg = requestAttributes.getAttribute(RequestDispatcher.ERROR_MESSAGE, RequestAttributes.SCOPE_REQUEST);
        map.put("code",status.value());
        map.put("msg",msg != null ? msg.toString() : "");
        return new ResponseEntity<>(map,status);
    }
}
