package com.fanyin.mapper.system;

import com.fanyin.dto.system.log.OperationQueryRequest;
import com.fanyin.model.system.SystemOperationLog;

import java.util.List;

/**
 * @author 二哥很猛
 */
public interface SystemOperationLogMapper {

    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(SystemOperationLog record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    SystemOperationLog selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(SystemOperationLog record);

    /**
     * 根据条件查询操作日志
     * @param request 查询条件
     * @return 列表
     */
    List<SystemOperationLog> getList(OperationQueryRequest request);

}