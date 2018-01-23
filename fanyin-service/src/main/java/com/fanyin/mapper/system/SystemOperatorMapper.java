package com.fanyin.mapper.system;


import com.fanyin.model.system.SystemOperator;

public interface SystemOperatorMapper {
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
    int insert(SystemOperator record);

    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(SystemOperator record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    SystemOperator selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(SystemOperator record);

    /**
     * 根据主键来更新数据库记录
     *
     * @param record
     */
    int updateByPrimaryKey(SystemOperator record);
}