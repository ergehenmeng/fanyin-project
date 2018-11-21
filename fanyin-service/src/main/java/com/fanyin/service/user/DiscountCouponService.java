package com.fanyin.service.user;

import com.fanyin.dto.user.CouponQueryRequest;
import com.fanyin.model.user.DiscountCoupon;
import com.github.pagehelper.PageInfo;

import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/11/21 9:10
 */
public interface DiscountCouponService {

    /**
     * 根据条件分页查询优惠券
     * @param request 前台参数
     * @return 优惠券列表
     */
    PageInfo<DiscountCoupon> getByPage(CouponQueryRequest request);


    /**
     * 根据投标金额 查询可用的优惠券列表
     * @param amount 投标金额
     * @param period 投标期限
     * @param userId 用户id
     * @return 优惠券列表
     */
    List<DiscountCoupon> getEnableDiscountCoupon(double amount,int period,int userId);

    /**
     * 根据优惠券id查询优惠券信息
     * @param id id主键
     * @param userId 用户id
     * @return 优惠券信息
     */
    DiscountCoupon getById(int id,int userId);

    /**
     * 校验优惠券是否可以使用
     * @param coupon 优惠券
     * @param amount 投标金额
     * @param period 投标期限
     */
    void verifyDiscountCoupon(DiscountCoupon coupon,double amount,int period);
}

