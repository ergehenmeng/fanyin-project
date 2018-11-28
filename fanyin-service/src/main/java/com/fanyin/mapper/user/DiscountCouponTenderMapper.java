package com.fanyin.mapper.user;

import com.fanyin.model.user.DiscountCouponTender;

/**
 * @author 二哥很猛
 */
public interface DiscountCouponTenderMapper {

    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(DiscountCouponTender record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    DiscountCouponTender selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(DiscountCouponTender record);

}