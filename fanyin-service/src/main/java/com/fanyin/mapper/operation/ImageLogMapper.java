package com.fanyin.mapper.operation;

import com.fanyin.model.operation.ImageLog;

/**
 * @author 二哥很猛
 */
public interface ImageLogMapper {
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
    int insert(ImageLog record);

    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(ImageLog record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    ImageLog selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(ImageLog record);

    /**
     * 根据主键来更新数据库记录
     *
     * @param record
     */
    int updateByPrimaryKey(ImageLog record);
}