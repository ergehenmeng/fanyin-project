package com.fanyin.service.operator.impl;

import com.fanyin.dto.system.operator.PasswordEditRequest;
import com.fanyin.dto.system.operator.OperatorQueryRequest;
import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.BusinessException;
import com.fanyin.mapper.system.SystemOperatorMapper;
import com.fanyin.model.system.SystemOperator;
import com.fanyin.service.operator.SystemOperatorService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/11/26 10:24
 */
@Service("systemOperatorService")
public class SystemOperatorServiceImpl implements SystemOperatorService {

    @Autowired
    private SystemOperatorMapper systemOperatorMapper;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public SystemOperator getByMobile(String mobile) {
        return systemOperatorMapper.getByMobile(mobile);
    }

    @Override
    public String updateLoginPassword(PasswordEditRequest request) {
        SystemOperator operator = systemOperatorMapper.selectByPrimaryKey(request.getOperatorId());
        String oldPassword = bCryptPasswordEncoder.encode(request.getOldPassword());
        if(!operator.getPassword().equals(oldPassword)){
            throw new BusinessException(ErrorCodeEnum.OPERATOR_PASSWORD_ERROR);
        }
        String newPassword = bCryptPasswordEncoder.encode(request.getNewPassword());
        operator.setPassword(newPassword);
        systemOperatorMapper.updateByPrimaryKeySelective(operator);
        return newPassword;
    }

    @Override
    public PageInfo<SystemOperator> getByPage(OperatorQueryRequest request) {
        PageHelper.startPage(request.getPage(),request.getRows());
        List<SystemOperator> list = systemOperatorMapper.getList(request);
        return new PageInfo<>(list);
    }
}
