package com.fanyin.mapper.borrower;

import com.fanyin.model.borrower.BorrowerAccountLog;

/**
 * @author 二哥很猛
 */
public interface BorrowerAccountLogMapper {


    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(BorrowerAccountLog record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    BorrowerAccountLog selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(BorrowerAccountLog record);


}