package com.fanyin.service.system.impl;

import com.fanyin.service.system.SystemConfigService;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest
public class SystemConfigApiTest {

    @Autowired
    private SystemConfigApi systemConfigApi;

    @Autowired
    private SystemConfigService systemConfigService;

    @Test
    public void updateConfig() {
    }

    @Test
    public void getListByPage() {
    }

    @Test
    public void getConfigByNid() {
    }

    @Test
    public void getConfigById() {
        systemConfigService.getConfigById(5);
    }

    @Test
    public void addConfig() {
    }

    @Test
    public void getStringByNid() {
        String value = this.systemConfigApi.getStringByNid("company_email");
        Assert.assertNotNull(value);
    }

    @Test
    public void getBooleanByNid() {
    }

    @Test
    public void getIntByNid() {
    }

    @Test
    public void getJsonByNid() {
    }

    @Test
    public void getClassByNid() {
    }
}