package com.fanyin.service.common.impl;

import com.fanyin.mapper.system.TranMapper;
import com.fanyin.model.system.Tran;
import com.fanyin.service.common.ApiService;
import com.fanyin.service.common.TranDoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author 王艳兵
 * @date 2019/6/4 15:51
 */
@Service("tranDoService")
@Transactional(rollbackFor = RuntimeException.class)
public class TranDoServiceImpl implements TranDoService {

    @Autowired
    private ApiService apiService;

    @Autowired
    private TranMapper tranMapper;

    @Override
    public void execute(Tran tran) {
        try {
            apiService.post(tran);
        }catch (Exception e){
           e.printStackTrace();
        }finally {
            tranMapper.updateByPrimaryKey(tran);
        }
    }
}
