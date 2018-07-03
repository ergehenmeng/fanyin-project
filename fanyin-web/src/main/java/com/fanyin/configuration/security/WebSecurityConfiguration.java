package com.fanyin.configuration.security;

import com.fanyin.configuration.ApplicationProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.web.WebMvcProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationDetailsSource;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.core.userdetails.UserDetailsService;
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
@EnableWebSecurity
@EnableConfigurationProperties(WebMvcProperties.class)
public class WebSecurityConfiguration extends WebSecurityConfigurerAdapter{


    @Autowired
    private ApplicationProperties applicationProperties;

    @Autowired
    private WebMvcProperties webMvcProperties;

    @Autowired
    private CustomFilterSecurityInterceptor customFilterSecurityInterceptor;

    @Autowired
    private AuthenticationDetailsSource<HttpServletRequest, WebAuthenticationDetails> authenticationDetailsSource;


    @Override
    @Bean("userDetailsService")
    protected UserDetailsService userDetailsService() {
        return new OperatorDetailsService();
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().mvcMatchers(webMvcProperties.getStaticPathPattern());
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
                .logoutSuccessUrl("/index").permitAll()
                .invalidateHttpSession(true);

        http.sessionManagement().maximumSessions(1).sessionRegistry(sessionRegistry()).expiredUrl("/index");

        http.addFilterBefore(customFilterSecurityInterceptor, FilterSecurityInterceptor.class).csrf().disable();

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

    @Bean
    public AuthenticationProvider authenticationProvider(){
        CustomAuthenticationProvider provider = new CustomAuthenticationProvider();
        //屏蔽原始错误异常
        provider.setHideUserNotFoundExceptions(false);
        return provider;
    }

    @Bean
    public CustomLoginSuccessHandler loginSuccessHandler(){
        return new CustomLoginSuccessHandler();
    }

    @Bean
     public CustomLoginFailureHandler customAuthenticationFailureHandler(){
        return new CustomLoginFailureHandler();
    }
}
