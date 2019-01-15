package com.fanyin.interceptor;

import com.alibaba.fastjson.JSONObject;
import com.fanyin.annotation.GroupAccess;
import com.fanyin.annotation.Validation;
import com.fanyin.constant.CommonConstant;
import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.ParameterException;
import org.apache.catalina.servlet4preview.http.HttpServletRequest;
import org.apache.commons.io.IOUtils;
import org.springframework.core.MethodParameter;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import java.io.IOException;
import java.util.List;

/**
 * 数据校验解析器
 * @author 二哥很猛
 * @date 2018/1/8 14:42
 */
public class ValidationHandlerMethodArgumentResolver implements HandlerMethodArgumentResolver {


    @Override
    public boolean supportsParameter(MethodParameter parameter) {
        return parameter.hasMethodAnnotation(ResponseBody.class)
                && (parameter.hasMethodAnnotation(Validation.class) || parameter.hasMethodAnnotation(GroupAccess.class))
                && isPrimitive(parameter)
                && isWrapPrimitive(parameter);
    }

    @Override
    public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
        HttpServletRequest request = webRequest.getNativeRequest(HttpServletRequest.class);
        Object args = jsonFormat(request, parameter.getParameterType());
        WebDataBinder binder = binderFactory.createBinder(webRequest, args, parameter.getParameterType().getName());
        binder.validate(args);
        BindingResult bindingResult = binder.getBindingResult();
        if(bindingResult.hasErrors()){
            List<ObjectError> allErrors = bindingResult.getAllErrors();
            //只显示第一条校验失败的信息
            ObjectError objectError = allErrors.get(0);
            throw new ParameterException(2000,objectError.getDefaultMessage());
        }
        return args;
    }


    /**
     * 将request中对象转换为转换为指定接收的参数对象
     * @param request 请求信息
     * @param cls 接收参数的类型
     * @return 结果对象
     */
    private Object jsonFormat(HttpServletRequest request,Class<?> cls){
        try {
            String args = IOUtils.toString(request.getInputStream(), CommonConstant.CHARSET);
             if(args == null){
                return null;
            }
            return JSONObject.parseObject(args,cls);
        }catch (IOException e){
            throw new ParameterException(ErrorCodeEnum.JSON_FORMAT_ERROR);
        }
    }


    /**
     * 判断是否为基本类型
     * @param parameter 请求方法参数信息
     * @return boolean true:基本类型 false:非基本类型
     */
    private boolean isPrimitive(MethodParameter parameter){
        Class<?> parameterType = parameter.getParameterType();
        return parameterType != null && !parameterType.isPrimitive();
    }

    /**
     * 判断是否为包装类的基本类型
     * @param parameter 请求方法参数信息
     * @return boolean true:基本类型 false:非基本类型
     */
    private boolean isWrapPrimitive(MethodParameter parameter){
        Class<?> parameterType = parameter.getParameterType();
        return parameterType != null && !isWrapClass(parameterType);
    }

    /**
     * 类是否为简单类型的包装类
     * @param cls 类
     * @return true:简单类型
     */
    private boolean isWrapClass(Class<?> cls){
        return cls.equals(Long.class)
                || cls.equals(String.class)
                || cls.equals(Short.class)
                || cls.equals(Double.class)
                || cls.equals(Float.class)
                || cls.equals(Integer.class)
                || cls.equals(Byte.class)
                || cls.equals(Character.class)
                || cls.equals(Boolean.class);
    }
}
