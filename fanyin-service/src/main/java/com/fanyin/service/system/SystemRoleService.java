package com.fanyin.service.system;

import com.fanyin.dto.system.role.RoleAddRequest;
import com.fanyin.dto.system.role.RoleEditRequest;
import com.fanyin.dto.system.role.RoleQueryRequest;
import com.fanyin.model.system.SystemRole;
import com.github.pagehelper.PageInfo;

/**
 * @author 二哥很猛
 * @date 2018/11/26 15:33
 */
public interface SystemRoleService {

    /**
     * 分页查询角色信息
     * @param request 前台查询条件
     * @return 列表
     */
    PageInfo<SystemRole> getByPage(RoleQueryRequest request);

    /**
     * 根据主键查询角色信息
     * @param id 主键
     * @return 角色信息
     */
    SystemRole getById(int id);

    /**
     * 更新角色信息
     * @param request 前台参数
     */
    void updateRole(RoleEditRequest request);


    /**
     * 删除角色信息
     * @param id 主键
     */
    void deleteRole(int id);

    /**
     * 添加角色信息
     * @param request 前台参数
     */
    void addRole(RoleAddRequest request);
}

