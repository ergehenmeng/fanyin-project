package com.fanyin.mapper.system;

import com.fanyin.dto.system.role.RoleQueryRequest;
import com.fanyin.model.system.SystemRole;

import java.util.List;

/**
 * @author 二哥很猛
 */
public interface SystemRoleMapper {
    /**
     * 根据主键删除数据库的记录
     *
     * @param id
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * 插入数据库记录
     *
     * @param record
     */
    int insert(SystemRole record);

    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(SystemRole record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    SystemRole selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(SystemRole record);

    /**
     * 根据主键来更新数据库记录
     *
     * @param record
     */
    int updateByPrimaryKey(SystemRole record);

    /**
     * 根据条件查询角色信息
     * @param request 请求参数
     * @return 角色信息列表
     */
    List<SystemRole> getList(RoleQueryRequest request);
}