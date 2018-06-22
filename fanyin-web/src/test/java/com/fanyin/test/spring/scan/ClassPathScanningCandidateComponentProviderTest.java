package com.fanyin.test.spring.scan;

import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.ClassPathScanningCandidateComponentProvider;

import java.util.Set;

/**
 * 根据路径扫描表 只扫描指定注解的 默认是Component,ManagedBean,Named
 * @author 王艳兵
 * @date 2018/3/9 11:24
 */
public class ClassPathScanningCandidateComponentProviderTest {
    public static void main(String[] args) {
        ClassPathScanningCandidateComponentProvider provider  = new ClassPathScanningCandidateComponentProvider(true);
        Set<BeanDefinition> candidateComponents = provider.findCandidateComponents("com.fanyin.service");
        candidateComponents.forEach(beanDefinition -> {
            String beanClassName = beanDefinition.getBeanClassName();
            System.out.println(beanClassName);
        });
    }
}
