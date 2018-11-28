package com.fanyin.mapper.user;

import com.fanyin.dto.user.CouponQueryRequest;
import com.fanyin.model.user.DiscountCoupon;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author 二哥很猛
 */
public interface DiscountCouponMapper {

    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(DiscountCoupon record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    DiscountCoupon selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(DiscountCoupon record);


    /**
     * 根据条件查询优惠券信息
     * @param request 请求参数
     * @return 列表
     */
    List<DiscountCoupon> getList(CouponQueryRequest request);

    /**
     * 根据主键查询用户优惠券信息
     * @param id 主键id
     * @param userId 用户id
     * @return 优惠券信息
     */
    DiscountCoupon getById(@Param("id")Integer id,@Param("userId")Integer userId);
}