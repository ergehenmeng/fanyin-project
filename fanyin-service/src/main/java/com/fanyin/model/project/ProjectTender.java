package com.fanyin.model.project;

import com.fanyin.model.user.DiscountCoupon;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 投标信息表
 * @author 二哥很猛
 */
@Data
public class ProjectTender implements Serializable {
    private static final long serialVersionUID = -389207993019161887L;
    /**
     * 主键<br>
     * 表 : project_tender<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 用户ID<br>
     * 表 : project_tender<br>
     * 对应字段 : user_id<br>
     */
    private Integer userId;

    /**
     * 标的id<br>
     * 表 : project_tender<br>
     * 对应字段 : project_id<br>
     */
    private Integer projectId;

    /**
     * 投标金额(元)<br>
     * 表 : project_tender<br>
     * 对应字段 : account<br>
     */
    private BigDecimal account;

    /**
     * 基础收益(预计收益)<br>
     * 表 : project_tender<br>
     * 对应字段 : base_interest<br>
     */
    private BigDecimal baseInterest;

    /**
     * 平台加息收益(预计收益)<br>
     * 表 : project_tender<br>
     * 对应字段 : platform_interest<br>
     */
    private BigDecimal platformInterest;

    /**
     * 加息券收益(预计收益)<br>
     * 表 : project_tender<br>
     * 对应字段 : coupon_interest<br>
     */
    private BigDecimal couponInterest;

    /**
     * 抵扣券收益
     */
    private BigDecimal voucherInterest;

    /**
     * 投标状态:-3标的撤销,-2:已转让,-1:转让申请中,0:投标加入,1:回款中,2:还款完成<br>
     * 表 : project_tender<br>
     * 对应字段 : state<br>
     */
    private Byte state;

    /**
     * 投标渠道 pc,android,ios,h5,other<br>
     * 表 : project_tender<br>
     * 对应字段 : channel<br>
     */
    private String channel;

    /**
     * 投标ip<br>
     * 表 : project_tender<br>
     * 对应字段 : ip<br>
     */
    private String ip;

    /**
     * 投标时间<br>
     * 表 : project_tender<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 更新时间<br>
     * 表 : project_tender<br>
     * 对应字段 : update_time<br>
     */
    private Date updateTime;

    /**
     * 投标使用的优惠券
     */
    private List<DiscountCoupon> couponList;


}