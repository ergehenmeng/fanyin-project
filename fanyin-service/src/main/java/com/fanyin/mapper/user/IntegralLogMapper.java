package com.fanyin.mapper.user;

import com.fanyin.model.user.IntegralLog;

/**
 * @author 二哥很猛
 */
public interface IntegralLogMapper {
    /**
     * 根据主键删除数据库的记录
     *
     * @param id 主键
     * @return 影响条数
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * 插入数据库记录
     *
     * @param record 带插入的数据
     * @return 影响条数
     */
    int insert(IntegralLog record);

    /**
     * 插入不为空的记录
     *
     * @param record 带插入的数据
     * @return 影响条数
     */
    int insertSelective(IntegralLog record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id 主键
     * @return 记录
     */
    IntegralLog selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record 待更新数据
     * @return 影响条数
     */
    int updateByPrimaryKeySelective(IntegralLog record);

    /**
     * 根据主键来更新数据库记录
     *
     * @param record 待更新数据
     * @return 影响条数
     */
    int updateByPrimaryKey(IntegralLog record);
}