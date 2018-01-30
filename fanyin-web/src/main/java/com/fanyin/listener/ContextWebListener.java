package com.fanyin.listener;

import com.fanyin.constant.VersionConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 * @author 二哥很猛
 * @date 2018/1/18 18:38
 */
@WebListener
public class ContextWebListener implements ServletContextListener {

    @Value("${project.version:v1.0.0}")
    private String version;

    @Override
    public void contextInitialized(ServletContextEvent event) {
        ServletContext servletContext = event.getServletContext();
        servletContext.setAttribute("ctxPath",servletContext.getContextPath());
        servletContext.setAttribute("version", version);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    }
}
