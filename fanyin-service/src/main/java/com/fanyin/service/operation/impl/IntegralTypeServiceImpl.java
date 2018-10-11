package com.fanyin.service.operation.impl;


import com.fanyin.enums.Integral;
import com.fanyin.mapper.operation.IntegralTypeMapper;
import com.fanyin.model.operation.IntegralType;
import com.fanyin.service.operation.IntegralTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author 二哥很猛
 * @date 2018/10/11 11:18
 */
@Service("integralTypeService")
public class IntegralTypeServiceImpl implements IntegralTypeService {

    @Autowired
    private IntegralTypeMapper integralTypeMapper;

    @Override
    public IntegralType getByNid(Integral integral) {
        return integralTypeMapper.getByNid(integral.name().toUpperCase());
    }
}
