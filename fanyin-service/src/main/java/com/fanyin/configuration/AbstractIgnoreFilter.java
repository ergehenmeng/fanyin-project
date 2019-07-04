package com.fanyin.configuration;

import com.fanyin.utils.StringUtil;
import com.google.common.collect.Lists;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.StringUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

/**
 * @author 王艳兵
 * @date 2019/7/4 13:48
 */
public abstract class AbstractIgnoreFilter implements Filter {

    private List<String> executions = Lists.newArrayListWithCapacity(4);

    /**
     * 忽略的parameter字段名称
     */
    static final String EXECUTIONS = "executions";

    /**
     * url分隔符
     */
    private static final String DELIMITERS = ";";

    private AntPathMatcher matcher = new AntPathMatcher();

    @Override
    public void init(FilterConfig filterConfig){
        String param = filterConfig.getInitParameter(EXECUTIONS);
        if(StringUtil.isNotEmpty(param)){
            String[] array = StringUtils.tokenizeToStringArray(param, DELIMITERS);
            executions.addAll(Lists.newArrayList(array));
        }
    }

    /**
     * 当前request的url是否为忽略拦截的url
     * @param request request
     * @return true:需要忽略 false:不需要忽略
     */
    protected boolean isIgnoreUrl(HttpServletRequest request){
        for (String url : executions){
            if(matcher.match(url,request.getRequestURI())){
                return true;
            }
        }
        return false;
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
