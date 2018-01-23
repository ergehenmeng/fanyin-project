package com.fanyin.mapper.system;

import com.fanyin.model.system.SystemConfig;
import com.fanyin.request.system.SystemConfigSelectRequest;
import com.fanyin.request.system.SystemConfigUpdateRequest;


import java.util.List;

/**
 * @author 二哥很猛
 */
public interface SystemConfigMapper {
    /**
     * 根据主键删除数据库的记录
     *
     * @param id
     * @return
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * 根据条件查询系统参数列表:参数类型,锁定状态,nid,备注信息
     * @param request 查询条件
     * @return
     */
    List<SystemConfig> getList(SystemConfigSelectRequest request);
    /**
     * 插入数据库记录
     *
     * @param record
     * @return
     */
    int insert(SystemConfig record);

    /**
     * 插入不为空的记录
     *
     * @param record
     * @return
     */
    int insertSelective(SystemConfig record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     * @return
     */
    SystemConfig selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     * @return
     */
    int updateByPrimaryKeySelective(SystemConfig record);

    /**
     * 根据主键来更新数据库记录
     *
     * @param record
     * @return
     */
    int updateByPrimaryKey(SystemConfig record);

    /**
     * 根据nid获取系统参数
     * @param nid
     * @return
     */
    SystemConfig getConfigByNid(String nid);

    /**
     * 更新系统参数
     * @param request 待更新参数
     * @return
     */
    int updateConfig(SystemConfigUpdateRequest request);
}