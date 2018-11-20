package com.fanyin.mapper.user;

import com.fanyin.model.user.AccountDetailLog;

public interface AccountDetailLogMapper {
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
    int insert(AccountDetailLog record);

    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(AccountDetailLog record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    AccountDetailLog selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(AccountDetailLog record);

    /**
     * 根据主键来更新数据库记录
     *
     * @param record
     */
    int updateByPrimaryKey(AccountDetailLog record);
}