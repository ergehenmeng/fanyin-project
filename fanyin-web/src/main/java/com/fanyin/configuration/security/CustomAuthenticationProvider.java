package com.fanyin.configuration.security;


import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.model.system.SystemOperator;
import com.fanyin.utils.Md5Util;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;


/**
 * 自定义校验规则 authenticate校验图形验证码 super.authenticate方法会调用additionalAuthenticationChecks来校验密码信息
 * @author 二哥很猛
 * @date 2018/1/25 13:48
 */
public class CustomAuthenticationProvider extends DaoAuthenticationProvider {


    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        CustomWebAuthenticationDetails principal = (CustomWebAuthenticationDetails)authentication.getDetails();
        String imageCode = principal.getImageCode();
        String sessionImageCode =principal.getSessionImageCode();
        if(imageCode == null || !imageCode.equalsIgnoreCase(sessionImageCode)){
            throw new CustomAuthenticationException(ErrorCodeEnum.IMAGE_CODE_ERROR);
        }
        return super.authenticate(authentication);
    }

    @Override
    protected void additionalAuthenticationChecks(UserDetails userDetails, UsernamePasswordAuthenticationToken authentication) throws AuthenticationException {
        SystemOperator operator = (SystemOperator)userDetails;
        String rawPassword = Md5Util.md5(authentication.getCredentials() + operator.getPasswordRandom());
        if(!rawPassword.equalsIgnoreCase(operator.getPassword())){
            throw new CustomAuthenticationException(ErrorCodeEnum.ACCOUNT_PASSWORD_ERROR);
        }
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }
}
