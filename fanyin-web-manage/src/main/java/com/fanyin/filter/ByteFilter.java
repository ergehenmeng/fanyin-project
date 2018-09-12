package com.fanyin.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * 请求参数重复使用 方便ValidationHandlerMethodArgumentResolver参数校验
 * @author 二哥很猛
 * @date 2018/8/28 16:38
 */
@WebFilter(filterName = "byteFilter",urlPatterns = {"/mobile/*","/html5/*","/json/*"})
public class ByteFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig){
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        ServletRequestWrapper wrapper = null;
        if(request instanceof HttpServletRequest){
            wrapper = new ByteHttpServletRequestWrapper((HttpServletRequest)request);
        }
        if(wrapper != null){
            chain.doFilter(wrapper,response);
        }else{
            chain.doFilter(request,response);
        }
    }

    @Override
    public void destroy() {

    }
}
