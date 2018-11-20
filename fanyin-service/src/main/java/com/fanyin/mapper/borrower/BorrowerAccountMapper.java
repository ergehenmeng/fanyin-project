package com.fanyin.mapper.borrower;

import com.fanyin.model.borrower.BorrowerAccount;
import org.apache.ibatis.annotations.Param;

/**
 * @author 二哥很猛
 */
public interface BorrowerAccountMapper {
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
    int insert(BorrowerAccount record);

    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(BorrowerAccount record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    BorrowerAccount selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(BorrowerAccount record);

    /**
     * 根据主键来更新数据库记录
     *
     * @param record
     */
    int updateByPrimaryKey(BorrowerAccount record);

    /**
     * 获取借款人资金账户信息
     * @param borrowerId 借款人id
     * @return 资产信息
     */
    BorrowerAccount getByBorrowerId(@Param("borrowerId") int borrowerId);
}