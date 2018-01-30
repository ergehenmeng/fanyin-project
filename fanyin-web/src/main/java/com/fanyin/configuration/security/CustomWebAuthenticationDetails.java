package com.fanyin.configuration.security;

import com.fanyin.constant.CommonConstant;
import com.fanyin.constant.SecurityParam;
import org.springframework.security.web.authentication.WebAuthenticationDetails;

import javax.servlet.http.HttpServletRequest;

/**
 * 获取图形验证码信息
 * @author 二哥很猛
 * @date 2018/1/25 14:49
 */
public class CustomWebAuthenticationDetails extends WebAuthenticationDetails {

    /**
     * 前台传递过来的图形验证码
     */
    private String imageCode;

    /**
     * session中存放的图形验证码
     */
    private String sessionImageCode;

    public CustomWebAuthenticationDetails(HttpServletRequest request) {
        super(request);
        this.imageCode = request.getParameter(SecurityParam.IMAGE_CODE);
        this.sessionImageCode = (String) request.getSession().getAttribute(CommonConstant.AUTH_CODE);
    }

    public String getImageCode() {
        return imageCode;
    }


    public String getSessionImageCode() {
        return sessionImageCode;
    }

}
