package com.fanyin.service.common.impl;

import com.fanyin.service.AbstractTest;
import com.fanyin.service.common.TranService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static org.junit.Assert.*;

public class TranServiceImplTest extends AbstractTest {

    @Autowired
    private TranService tranService;

    @Test
    public void doTran() {
        tranService.doTran();
    }
}