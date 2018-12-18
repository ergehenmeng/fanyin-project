package com.fanyin.dto.user;

import com.fanyin.ext.PageQuery;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.util.Date;

/**
 * @author 二哥很猛
 * @date 2018/11/21 9:27
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class CouponQueryRequest extends PageQuery implements Serializable {

    private static final long serialVersionUID = -8743115527048636624L;

    /**
     * 用户id 由后台设置
     */
    private Integer userId;

    /**
     * 优惠券类型 0:抵扣券 1:加息券
     */
    private Byte classify;

    /**
     * 优惠券状态 0:未使用 1:已使用 2:已冻结,3已过期
     */
    private Byte state;

    /**
     * 当前时间
     */
    private Date now;
}
