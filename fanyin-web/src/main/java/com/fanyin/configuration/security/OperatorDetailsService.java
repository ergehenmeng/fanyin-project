package com.fanyin.configuration.security;

import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.mapper.system.SystemMenuMapper;
import com.fanyin.mapper.system.SystemOperatorMapper;
import com.fanyin.model.system.SystemMenu;
import com.fanyin.model.system.SystemOperator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;


/**
 * 权限验证获取用户信息
 * @author 二哥很猛
 * @date 2018/1/25 10:00
 */
public class OperatorDetailsService implements UserDetailsService {

    @Autowired
    private SystemOperatorMapper systemOperatorMapper;

    @Autowired
    private SystemMenuMapper systemMenuMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        SystemOperator operator = systemOperatorMapper.getOperatorByMobile(username);
        if(operator == null){
            throw new SystemAuthenticationException(ErrorCodeEnum.OPERATOR_NOT_FOUND);
        }
        if(!operator.getStatus()){
            throw new SystemAuthenticationException(ErrorCodeEnum.OPERATOR_LOCKED_ERROR);
        }
        List<SystemMenu> list = systemMenuMapper.getUserMenuList(operator.getId(),true);
        List<GrantedAuthority> authorities = new ArrayList<>();
        if(!CollectionUtils.isEmpty(list)){
            for (SystemMenu menu : list){
                GrantedAuthority authority = new SimpleGrantedAuthority(menu.getName());
                authorities.add(authority);
            }
        }
        return new SecurityOperator(operator,authorities);
    }
}
