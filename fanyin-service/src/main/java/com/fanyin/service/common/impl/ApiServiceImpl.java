package com.fanyin.service.common.impl;

import com.fanyin.model.system.Tran;
import com.fanyin.service.common.ApiService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author 王艳兵
 * @date 2019/6/4 15:53
 */
@Service("apiService")
@Transactional(rollbackFor = RuntimeException.class)
public class ApiServiceImpl implements ApiService {

    @Override
    public void post(Tran tran) {
        if(tran.getName().length() > 5){
            throw new RuntimeException("长度过长");
        }
    }
}
