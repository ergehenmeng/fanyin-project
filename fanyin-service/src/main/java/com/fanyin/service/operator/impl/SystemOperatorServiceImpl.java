package com.fanyin.service.operator.impl;

import com.fanyin.dto.operator.OperatorAddRequest;
import com.fanyin.dto.operator.OperatorEditRequest;
import com.fanyin.dto.system.operator.OperatorQueryRequest;
import com.fanyin.dto.system.operator.PasswordEditRequest;
import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.BusinessException;
import com.fanyin.mapper.operator.SystemOperatorMapper;
import com.fanyin.mapper.system.SystemOperatorRoleMapper;
import com.fanyin.model.system.SystemOperator;
import com.fanyin.model.system.SystemOperatorRole;
import com.fanyin.service.operator.SystemOperatorService;
import com.fanyin.utils.BeanCopyUtil;
import com.fanyin.utils.DateUtil;
import com.fanyin.utils.Md5Util;
import com.fanyin.utils.StringUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.common.base.Splitter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author 二哥很猛
 * @date 2018/11/26 10:24
 */
@Service("systemOperatorService")
@Transactional(rollbackFor = RuntimeException.class)
public class SystemOperatorServiceImpl implements SystemOperatorService {

    @Autowired
    private SystemOperatorMapper systemOperatorMapper;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    private SystemOperatorRoleMapper systemOperatorRoleMapper;

    @Override
    public SystemOperator getByMobile(String mobile) {
        return systemOperatorMapper.getByMobile(mobile);
    }

    @Override
    public String updateLoginPassword(PasswordEditRequest request) {
        SystemOperator operator = systemOperatorMapper.selectByPrimaryKey(request.getOperatorId());
        String oldPassword = bCryptPasswordEncoder.encode(request.getOldPwd());
        if(!operator.getPwd().equals(oldPassword)){
            throw new BusinessException(ErrorCodeEnum.OPERATOR_PASSWORD_ERROR);
        }
        String newPassword = bCryptPasswordEncoder.encode(request.getNewPwd());
        operator.setPwd(newPassword);
        systemOperatorMapper.updateByPrimaryKeySelective(operator);
        return newPassword;
    }

    @Override
    public PageInfo<SystemOperator> getByPage(OperatorQueryRequest request) {
        PageHelper.startPage(request.getPage(),request.getRows());
        List<SystemOperator> list = systemOperatorMapper.getList(request);
        return new PageInfo<>(list);
    }

    @Override
    public void addOperator(OperatorAddRequest request) {
        SystemOperator operator = BeanCopyUtil.copy(request, SystemOperator.class);
        operator.setAddTime(DateUtil.getNow());
        operator.setDeleted(false);
        operator.setState(1);
        String initPassword = this.initPassword(request.getMobile());
        operator.setPwd(initPassword);
        operator.setInitPwd(initPassword);
        systemOperatorMapper.insertSelective(operator);
        if(StringUtil.isNotBlank(request.getRoleIds())){
            List<String> roleStringList = Splitter.on(",").splitToList(request.getRoleIds());
            //循环插入角色关联信息
            roleStringList.forEach(s -> systemOperatorRoleMapper.insertSelective(new SystemOperatorRole(operator.getId(),Integer.parseInt(s))));
        }
    }


    @Override
    public String initPassword(String mobile) {
        String md5Password = Md5Util.md5(mobile.substring(4));
        return bCryptPasswordEncoder.encode(md5Password);
    }

    @Override
    public SystemOperator getById(Integer id) {
        return systemOperatorMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updateOperator(OperatorEditRequest request) {
        SystemOperator operator = BeanCopyUtil.copy(request, SystemOperator.class);
        operator.setUpdateTime(DateUtil.getNow());
        systemOperatorMapper.updateByPrimaryKeySelective(operator);
        systemOperatorRoleMapper.deleteByOperatorId(request.getId());
        if(StringUtil.isNotBlank(request.getRoleIds())){
            List<String> stringList = Splitter.on(",").splitToList(request.getRoleIds());
            List<Integer> roleList = stringList.stream().mapToInt(Integer::parseInt).boxed().collect(Collectors.toList());
            systemOperatorRoleMapper.batchInsertOperatorRole(request.getId(),roleList);
        }
    }
}
