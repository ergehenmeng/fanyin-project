package com.fanyin.test.freemarker;

import com.google.common.collect.Maps;
import freemarker.template.Configuration;
import freemarker.template.Template;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.io.StringWriter;
import java.util.Map;

/**
 * 本地使用freemarker进行渲染
 * @see org.springframework.boot.autoconfigure.freemarker.FreeMarkerAutoConfiguration.FreeMarkerWebConfiguration
 * @author 二哥很猛
 * @date 2018/9/10 15:48
 */
@SpringBootTest
@RunWith(SpringJUnit4ClassRunner.class)
public class Engine {

    @Autowired
    private Configuration configuration;

    @Test
    public void configuration()throws Exception{
        Template template = new Template("firstTemplate","我是${userName!},你好",configuration);
        Map<String,Object> map = Maps.newHashMap();
        map.put("userName","二哥");
        StringWriter writer = new StringWriter();
        template.process(map,writer);
        System.out.println(writer.toString());
    }
}
