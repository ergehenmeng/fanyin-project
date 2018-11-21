package com.fanyin.service.user.impl;

import com.fanyin.constants.CouponConstant;
import com.fanyin.dto.user.CouponQueryRequest;
import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.BusinessException;
import com.fanyin.mapper.user.DiscountCouponMapper;
import com.fanyin.mapper.user.DiscountCouponTenderMapper;
import com.fanyin.model.user.DiscountCoupon;
import com.fanyin.model.user.DiscountCouponTender;
import com.fanyin.service.user.DiscountCouponService;
import com.fanyin.utils.DateUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/11/21 9:10
 */
@Service("discountCouponService")
public class DiscountCouponServiceImpl implements DiscountCouponService {

    @Autowired
    private DiscountCouponMapper discountCouponMapper;

    @Autowired
    private DiscountCouponTenderMapper discountCouponTenderMapper;

    @Override
    public PageInfo<DiscountCoupon> getByPage(CouponQueryRequest request) {
        request.setNow(DateUtil.getNow());
        PageHelper.startPage(request.getPage(),request.getRows());
        List<DiscountCoupon> list = discountCouponMapper.getList(request);
        return new PageInfo<>(list);
    }

    @Override
    public List<DiscountCoupon> getEnableDiscountCoupon(double amount,int period, int userId) {
        CouponQueryRequest request = new CouponQueryRequest();
        Date now = DateUtil.getNow();
        request.setNow(now);
        request.setUserId(userId);
        request.setStatus(CouponConstant.COUPON_STATUS_0);
        List<DiscountCoupon> couponList = discountCouponMapper.getList(request);

        ArrayList<DiscountCoupon> arrayList = Lists.newArrayList();

        if(couponList != null && couponList.size() > 0){
            couponList.forEach(coupon -> {
                //优惠券必选在有效期内
                //加息券直接使用,抵扣券额度和期限必选符合
                boolean flag = coupon.getStartTime().before(now) &&
                        (coupon.getType() == CouponConstant.TYPE_INTEREST
                               || (coupon.getFaceValue().compareTo(BigDecimal.valueOf(amount)) <= 0 && coupon.getPeriodLimit() <= period));
                if(flag){
                    arrayList.add(coupon);
                }
            });
        }
        return arrayList;
    }

    @Override
    public DiscountCoupon getById(int id, int userId) {
        DiscountCoupon coupon = discountCouponMapper.getById(id, userId);
        if(coupon == null || coupon.getStatus() != CouponConstant.COUPON_STATUS_0){
            throw new BusinessException(ErrorCodeEnum.COUPON_NOT_FOUND);
        }
        return coupon;
    }

    @Override
    public void verifyDiscountCoupon(DiscountCoupon coupon, double amount,int period) {

        Date now = DateUtil.getNow();
        if(coupon.getStartTime().after(now) || coupon.getEndTime().before(now)){
            throw new BusinessException(ErrorCodeEnum.COUPON_TIME_ERROR);
        }
        //抵扣券校验,加息券没有限制
        if(coupon.getType() == CouponConstant.TYPE_DEDUCTION){
            if(coupon.getFaceValue().compareTo(BigDecimal.valueOf(amount)) > 0){
                throw new BusinessException(ErrorCodeEnum.COUPON_LIMIT_ERROR);
            }
            if(coupon.getPeriodLimit() > period){
                throw new BusinessException(ErrorCodeEnum.COUPON_PERIOD_ERROR);
            }
        }
    }

    @Override
    public void updateDiscountCoupon(DiscountCoupon coupon) {
        discountCouponMapper.updateByPrimaryKeySelective(coupon);
    }

    @Override
    public void addDiscountCouponTender(DiscountCouponTender discountCouponTender) {
        discountCouponTenderMapper.insertSelective(discountCouponTender);
    }
}
