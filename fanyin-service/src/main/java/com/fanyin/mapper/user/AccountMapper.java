package com.fanyin.mapper.user;

import com.fanyin.model.user.Account;
import org.apache.ibatis.annotations.Param;

/**
 * @author 二哥很猛
 */
public interface AccountMapper {
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
    int insert(Account record);

    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(Account record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    Account selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(Account record);

    /**
     * 根据主键来更新数据库记录
     *
     * @param record
     */
    int updateByPrimaryKey(Account record);

    /**
     * 查询投资人资产信息
     * @param userId 用户id
     * @return 资产信息
     */
    Account getByUserId(@Param("userId")int userId);
}