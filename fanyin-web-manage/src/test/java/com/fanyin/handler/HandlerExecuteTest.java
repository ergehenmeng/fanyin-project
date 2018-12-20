package com.fanyin.handler;

import com.fanyin.handler.service.RegisterHandler;
import com.fanyin.service.AbstractTest;
import com.fanyin.utils.SpringContextUtil;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;

import static org.junit.Assert.*;

public class HandlerExecuteTest extends AbstractTest {

    @Autowired
    private HandlerExecute<RegisterHandler> execute;

    @Autowired
    private ApplicationContext applicationContext;

    @Before
    public void before(){
        SpringContextUtil.setApplicationContext(applicationContext);
    }

    @Test
    public void execute() {
        execute.execute(null,RegisterHandler.class);
    }
}