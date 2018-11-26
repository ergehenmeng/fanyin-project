package com.fanyin.service.system.impl;

import com.fanyin.dto.system.role.RoleAddRequest;
import com.fanyin.dto.system.role.RoleEditRequest;
import com.fanyin.dto.system.role.RoleQueryRequest;
import com.fanyin.mapper.system.SystemRoleMapper;
import com.fanyin.model.system.SystemRole;
import com.fanyin.service.system.SystemRoleService;
import com.fanyin.utils.BeanCopyUtil;
import com.fanyin.utils.DateUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/11/26 15:33
 */
@Service("systemRoleService")
public class SystemRoleServiceImpl implements SystemRoleService {

    @Autowired
    private SystemRoleMapper systemRoleMapper;

    @Override
    public PageInfo<SystemRole> getByPage(RoleQueryRequest request) {
        PageHelper.startPage(request.getPage(),request.getRows());
        List<SystemRole> list = systemRoleMapper.getList(request);
        return new PageInfo<>(list);
    }

    @Override
    public SystemRole getById(int id) {
        return systemRoleMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updateRole(RoleEditRequest request) {
        SystemRole role = BeanCopyUtil.copy(request, SystemRole.class);
        role.setUpdateTime(DateUtil.getNow());
        systemRoleMapper.updateByPrimaryKeySelective(role);
    }

    @Override
    public void deleteRole(int id) {
        SystemRole role = new SystemRole();
        role.setUpdateTime(DateUtil.getNow());
        role.setDeleted(true);
        systemRoleMapper.updateByPrimaryKeySelective(role);
    }

    @Override
    public void addRole(RoleAddRequest request) {
        SystemRole role = BeanCopyUtil.copy(request, SystemRole.class);
        role.setDeleted(false);
        role.setAddTime(DateUtil.getNow());
        systemRoleMapper.insertSelective(role);
    }
}
