package com.fanyin.service.user.impl;

import com.fanyin.constants.CouponConstant;
import com.fanyin.dto.user.CouponQueryRequest;
import com.fanyin.mapper.user.DiscountCouponMapper;
import com.fanyin.model.user.DiscountCoupon;
import com.fanyin.service.user.DiscountCouponService;
import com.fanyin.utils.DateUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    @Override
    public PageInfo<DiscountCoupon> getByPage(CouponQueryRequest request) {
        request.setNow(DateUtil.getNow());
        PageHelper.startPage(request.getPage(),request.getRows());
        List<DiscountCoupon> list = discountCouponMapper.getList(request);
        return new PageInfo<>(list);
    }

    @Override
    public List<DiscountCoupon> getEnableDiscountCoupon(double amount, int userId) {
        CouponQueryRequest request = new CouponQueryRequest();
        Date now = DateUtil.getNow();
        request.setNow(now);
        request.setUserId(userId);
        request.setStatus(CouponConstant.COUPON_STATUS_0);
        List<DiscountCoupon> couponList = discountCouponMapper.getList(request);

        ArrayList<DiscountCoupon> arrayList = Lists.newArrayList();

        if(couponList != null && couponList.size() > 0){
            couponList.forEach(coupon -> {
                //加息券直接可以使用
                //抵扣券可必须在有效期内,查询时已经过滤失效时间,此处直接判断起始时间
                if(coupon.getType() == CouponConstant.TYPE_DEDUCTION
                        || coupon.getStartTime().before(now)){
                    arrayList.add(coupon);
                }
            });
        }
        return arrayList;
    }
}
