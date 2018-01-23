package com.fanyin.service.system.impl;

import com.fanyin.service.system.CommonService;
import com.fanyin.utils.Md5Util;
import org.springframework.stereotype.Service;

/**
 * @description: 常用服务类
 * @author: 二哥很猛
 * @date: 2018/1/18
 * @time: 14:17
 */
@Service("commonService")
public class CommonServiceImpl implements CommonService{

    @Override
    public String encryptPassword(String password, String random) {
        return Md5Util.md5(password + random);
    }
}
