package com.fanyin.controller;



import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.BusinessException;
import com.fanyin.model.system.SystemOperator;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

import javax.servlet.http.HttpSession;

/**
 * @author 二哥很猛
 * @date 2018/1/12 17:59
 */
public class AbstractController {


    /**
     * 存放session
     * @param session session对象对象
     * @param key sessionKey
     * @param value session值
     */
    protected void putSession(HttpSession session, String key, Object value){
        session.setAttribute(key,value);
    }

    /**
     * 获取当前用户登陆的系统管理人员
     * @return 系统登陆的用户
     */
    protected SystemOperator getOperator(){
        SecurityContext context = SecurityContextHolder.getContext();
        Object details = context.getAuthentication().getPrincipal();
        if(details != null){
            return (SystemOperator)details;
        }
        return null;
    }

    /**
     * 获取当前登陆的系统管理人员,找不到抛异常
     * @return 系统用户
     */
    protected SystemOperator getRequiredOperator(){
        SystemOperator operator = getOperator();
        if(operator == null){
            throw new BusinessException(ErrorCodeEnum.OPERATOR_TIMEOUT);
        }
        return operator;
    }
}
