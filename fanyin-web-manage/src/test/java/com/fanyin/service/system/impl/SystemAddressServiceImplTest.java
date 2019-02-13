package com.fanyin.service.system.impl;

import com.fanyin.service.AbstractTest;
import com.fanyin.service.system.SystemAddressService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static org.junit.Assert.*;

public class SystemAddressServiceImplTest extends AbstractTest {

    @Autowired
    private SystemAddressService systemAddressService;

    @Test
    public void calcInitial() {
        systemAddressService.calcInitial();
    }
}