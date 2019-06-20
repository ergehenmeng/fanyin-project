package com.fanyin.service.common.impl;

import com.fanyin.mapper.system.TranMapper;
import com.fanyin.model.system.Tran;
import com.fanyin.service.common.TranDoService;
import com.fanyin.service.common.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author 王艳兵
 * @date 2019/6/4 15:44
 */
@Service("tranService")
@Transactional(rollbackFor = RuntimeException.class)
public class TranServiceImpl implements TranService {

    @Autowired
    private TranMapper tranMapper;

    @Autowired
    private TranDoService tranDoService;

    @Override
    public void doTran() {
        List<Tran> list = tranMapper.getList();
        for (Tran tran : list){
            tran.setName(tran.getName() + "A");
            tranDoService.execute(tran);
        }
    }
}
