package com.fanyin.mapper.user;

import com.fanyin.model.user.BankCard;
import org.apache.ibatis.annotations.Param;

/**
 * @author 二哥很猛
 */
public interface BankCardMapper {

    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(BankCard record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    BankCard selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(BankCard record);

    /**
     * 根据用户类型查询银行卡信息
     * @param userId 用户id
     * @param userType 银行卡
     * @return 银行卡信息
     */
    BankCard getByUserType(@Param("userId")int userId,@Param("userType")byte userType);
}