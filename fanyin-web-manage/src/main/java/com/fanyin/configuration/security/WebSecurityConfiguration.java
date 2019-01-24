package com.fanyin.configuration.security;

import com.fanyin.configuration.ApplicationProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.web.servlet.WebMvcProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationDetailsSource;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.access.intercept.FilterSecurityInterceptor;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.session.SessionInformationExpiredStrategy;
import org.springframework.security.web.session.SimpleRedirectSessionInformationExpiredStrategy;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;

/**
 * spring security权限配置
 * @author 二哥很猛
 * @date 2018/1/25 09:35
 */

@Configuration
@EnableConfigurationProperties({WebMvcProperties.class,ApplicationProperties.class})
public class WebSecurityConfiguration extends WebSecurityConfigurerAdapter{


    @Autowired
    private ApplicationProperties applicationProperties;

    @Autowired
    private WebMvcProperties webMvcProperties;

    @Autowired
    private AuthenticationDetailsSource<HttpServletRequest, WebAuthenticationDetails> authenticationDetailsSource;


    @Override
    @Bean("userDetailsService")
    protected UserDetailsService userDetailsService() {
        return new OperatorDetailsServiceImpl();
    }

    @Override
    public void configure(WebSecurity web){
        web.ignoring().antMatchers(webMvcProperties.getStaticPathPattern());
    }


    @Override
    protected void configure(HttpSecurity http) throws Exception {
        //Iframe同一域名内可以访问
        http.headers().frameOptions().sameOrigin();

        http
             .authorizeRequests()
                .antMatchers(StringUtils.tokenizeToStringArray(applicationProperties.getIgnoreUrl(),";")).permitAll()
                .antMatchers(StringUtils.tokenizeToStringArray(applicationProperties.getLoginIgnoreUrl(),";")).fullyAuthenticated()
                .anyRequest().authenticated()
                .and()
             .formLogin()
                .loginPage("/")
                .loginProcessingUrl("/login")
                .usernameParameter("mobile")
                .passwordParameter("password")
                .authenticationDetailsSource(authenticationDetailsSource)
                .successHandler(loginSuccessHandler())
                .failureHandler(customAuthenticationFailureHandler())
                .and()
             .logout()
                .logoutSuccessHandler(logoutSuccessHandler())
                .permitAll()
                .invalidateHttpSession(true);

        http.sessionManagement().maximumSessions(1).sessionRegistry(sessionRegistry()).expiredUrl("/index");
        http.addFilterBefore(filterSecurityInterceptor(), FilterSecurityInterceptor.class).csrf().disable();

    }


    @Bean
    public SessionInformationExpiredStrategy sessionInformationExpiredStrategy(){
        return new SimpleRedirectSessionInformationExpiredStrategy("/");
    }

    @Bean
    public SessionRegistry sessionRegistry(){
        return new SessionRegistryImpl();
    }

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        super.configure(auth);
        auth.authenticationProvider(authenticationProvider());
    }

    /**
     * 登陆校验器
     * @return bean
     */
    @Bean
    public AuthenticationProvider authenticationProvider(){
        CustomAuthenticationProvider provider = new CustomAuthenticationProvider();
        //屏蔽原始错误异常
        provider.setHideUserNotFoundExceptions(false);
        provider.setUserDetailsService(userDetailsService());
        provider.setEncoder(passwordEncoder());
        return provider;
    }

    /**
     * 加密方式
     * @return bean
     */
    @Bean
    public BCryptPasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }

    /**
     * 登陆成功后置处理
     * @return bean
     */
    @Bean
    public LoginSuccessHandler loginSuccessHandler(){
        return new LoginSuccessHandler();
    }

    /**
     * 退出登陆
     * @return bean
     */
    @Bean
    public LogoutSuccessHandler logoutSuccessHandler(){
        return new LogoutSuccessHandler();
    }

    /**
     * 登陆失败后置处理
     * @return bean
     */
    @Bean
     public LoginFailureHandler customAuthenticationFailureHandler(){
        return new LoginFailureHandler();
    }


    /**
     * 权限管理过滤器,
     * 声明为Bean会加入到全局FilterChain中拦截所有请求
     * 不声明Bean默认会在FilterChainProxy子调用链中按条件执行,减少不必要执行逻辑
     * @return bean
     */
    @Bean
    public CustomFilterSecurityInterceptor filterSecurityInterceptor(){
        CustomFilterSecurityInterceptor interceptor = new CustomFilterSecurityInterceptor();
        interceptor.setAccessDecisionManager(accessDecisionManager());
        return interceptor;
    }

    /**
     * 声明为Bean会加入到全局FilterChain中拦截所有请求
     * 不声明Bean默认会在FilterChainProxy子调用链中按条件执行,减少不必要执行逻辑
     * @return bean
     */
    @Bean
    public FilterRegistrationBean registration(){
        FilterRegistrationBean registration = new FilterRegistrationBean(filterSecurityInterceptor());
        registration.setEnabled(true);
        return registration;
    }

    @Bean
    public CustomAccessDecisionManager accessDecisionManager(){
        return new CustomAccessDecisionManager();
    }


    /**
     * 角色权限资源管理
     * @return bean
     */
    @Bean
    public CustomFilterInvocationSecurityMetadataSource metadataSource(){
        return new CustomFilterInvocationSecurityMetadataSource();
    }

    /**
     * 附加信息管理
     * @return bean
     */
    @Bean
    public CustomAuthenticationDetailsSource detailsSource(){
        return new CustomAuthenticationDetailsSource();
    }


}
