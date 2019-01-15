package com.fanyin.mapper.system;

import com.fanyin.model.system.OperationLog;

/**
 * @author 二哥很猛
 */
public interface OperationLogMapper {


    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(OperationLog record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    OperationLog selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(OperationLog record);


}