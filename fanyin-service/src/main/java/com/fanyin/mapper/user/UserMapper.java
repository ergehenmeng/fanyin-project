package com.fanyin.mapper.user;

import com.fanyin.model.user.User;

/**
 * @author 二哥很猛
 */
public interface UserMapper {

    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(User record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    User selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(User record);

}