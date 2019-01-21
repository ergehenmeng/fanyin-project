package com.fanyin.freemark;

import com.fanyin.configuration.security.SecurityOperator;
import com.fanyin.controller.AbstractController;
import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.BusinessException;
import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Collection;
import java.util.Map;

/**
 * <@auth nid="">html代码</@auth>
 * 按钮权限宏
 * @author 二哥很猛
 * @date 2019/1/18 17:19
 */
@Component
public class AuthDirectiveModel implements TemplateDirectiveModel {

    private static final String NID = "nid";

    @Override
    public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
        Object nidValue = params.get(NID);
        if(nidValue == null){
            throw new BusinessException(ErrorCodeEnum.AUTH_NID_ERROR);
        }
        String nid = nidValue.toString();
        SecurityOperator operator = AbstractController.getRequiredOperator();
        Collection<? extends GrantedAuthority> authorities = operator.getAuthorities();
        if(authorities != null && authorities.size() > 0){
            for (GrantedAuthority authority : authorities) {
                String authorityAuthority = authority.getAuthority();
                if(authorityAuthority.equals(nid)){
                    body.render(env.getOut());
                    return;
                }
            }
        }
    }
}
