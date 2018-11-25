package com.fanyin.mapper.borrower;

import com.fanyin.model.borrower.Borrower;

/**
 * @author 二哥很猛
 */
public interface BorrowerMapper {
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
    int insert(Borrower record);

    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(Borrower record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    Borrower selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(Borrower record);

    /**
     * 根据主键来更新数据库记录
     *
     * @param record
     */
    int updateByPrimaryKey(Borrower record);
}