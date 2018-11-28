package com.fanyin.mapper.user;

import com.fanyin.model.user.AccountDetailLog;

/**
 * @author 二哥很猛
 */
public interface AccountDetailLogMapper {

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

}