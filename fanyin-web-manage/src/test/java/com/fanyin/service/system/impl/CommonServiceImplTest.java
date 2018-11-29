package com.fanyin.service.system.impl;

import com.fanyin.service.AbstractTest;
import com.fanyin.service.system.CommonService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class CommonServiceImplTest extends AbstractTest {

    @Autowired
    private CommonService commonService;

    @Test
    public void getOrderNo() {
        System.out.println(commonService.getOrderNo());
        System.out.println(commonService.getOrderNo());
        System.out.println(commonService.getOrderNo());
        System.out.println(commonService.getOrderNo());
        System.out.println(commonService.getOrderNo());
    }

    @Test
    public void getDepositNo() {
        System.out.println(commonService.getDepositNo());
        System.out.println(commonService.getDepositNo());
        System.out.println(commonService.getDepositNo());
        System.out.println(commonService.getDepositNo());
        System.out.println(commonService.getDepositNo());
    }
}