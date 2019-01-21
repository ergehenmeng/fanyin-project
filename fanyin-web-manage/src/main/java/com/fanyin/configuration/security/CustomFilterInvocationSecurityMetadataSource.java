package com.fanyin.configuration.security;

import com.fanyin.mapper.system.SystemMenuMapper;
import com.fanyin.model.system.SystemMenu;
import com.fanyin.utils.StringUtil;
import com.google.common.base.Splitter;
import com.google.common.collect.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 权限配置资源管理器
 * @author 二哥很猛
 * @date 2018/1/25 11:01
 */
public class CustomFilterInvocationSecurityMetadataSource implements FilterInvocationSecurityMetadataSource {

    private Map<String,Collection<ConfigAttribute>> map = new HashMap<>(256);

    @Autowired
    private SystemMenuMapper systemMenuMapper;

    /**
     * 重新加载所有菜单权限
     */
    private void loadResource(){
        map.clear();
        Collection<ConfigAttribute> attributes;
        ConfigAttribute cfg;
        List<SystemMenu> list = systemMenuMapper.getAllList();
        for (SystemMenu menu : list){
            if(StringUtil.isNotBlank(menu.getUrl())){
                attributes = new ArrayList<>();
                List<String> subUrl = this.getSubUrl(menu);
                cfg = new SecurityConfig(menu.getNid());
                attributes.add(cfg);
                //将子菜单放入权限中,防止操作人员知道连接,但没有权限,却能访问的问题
                for (String url : subUrl){
                    map.put(url,attributes);
                }
            }
        }
    }

    /**
     * 获取菜单所用有的子菜单及本身菜单,子菜单逗号分割
     * @param menu 菜单
     * @return 列表
     */
    private List<String> getSubUrl(SystemMenu menu){
        List<String> stringList = Lists.newArrayList(menu.getUrl());
        if(StringUtil.isNotBlank(menu.getSubUrl())){
            stringList.addAll(Splitter.on(",").splitToList(menu.getSubUrl()));
        }
        return stringList;
    }


    @Override
    public Collection<ConfigAttribute> getAttributes(Object object) throws IllegalArgumentException {
        if(map.isEmpty()){
            loadResource();
        }
        HttpServletRequest httpRequest = ((FilterInvocation) object).getHttpRequest();
        AntPathRequestMatcher matcher;
        for (Map.Entry<String,Collection<ConfigAttribute>> entry : map.entrySet()){
            matcher = new AntPathRequestMatcher(entry.getKey());
            if(matcher.matches(httpRequest)){
                return entry.getValue();
            }
        }
        return null;
    }

    @Override
    public Collection<ConfigAttribute> getAllConfigAttributes() {
        return new ArrayList<>();
    }

    @Override
    public boolean supports(Class<?> clazz) {
        return FilterInvocation.class.isAssignableFrom(clazz);
    }
}
