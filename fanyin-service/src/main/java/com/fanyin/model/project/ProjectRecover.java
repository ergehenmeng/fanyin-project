package com.fanyin.model.project;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 投资人回款信息表
 * @author 二哥很猛
 */
@Data
public class ProjectRecover implements Serializable {
    private static final long serialVersionUID = 2430382792906631122L;
    /**
     * 主键<br>
     * 表 : project_recover<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 投资人ID<br>
     * 表 : project_recover<br>
     * 对应字段 : user_id<br>
     */
    private Integer userId;

    /**
     * 回款状态 0:待回款 1:已回款<br>
     * 表 : project_recover<br>
     * 对应字段 : state<br>
     */
    private Byte state;

    /**
     * 投标ID<br>
     * 表 : project_recover<br>
     * 对应字段 : tender_id<br>
     */
    private Integer tenderId;

    /**
     * 项目ID<br>
     * 表 : project_recover<br>
     * 对应字段 : project_id<br>
     */
    private Integer projectId;

    /**
     * 第几期回款<br>
     * 表 : project_recover<br>
     * 对应字段 : period<br>
     */
    private Byte period;

    /**
     * 总期数<br>
     * 表 : project_recover<br>
     * 对应字段 : periods<br>
     */
    private Byte periods;

    /**
     * 应还本金<br>
     * 表 : project_recover<br>
     * 对应字段 : capital<br>
     */
    private BigDecimal capital;

    /**
     * 预计回款利息(基础利息)<br>
     * 表 : project_recover<br>
     * 对应字段 : interest<br>
     */
    private BigDecimal interest;

    /**
     * 预计平台加息利息<br>
     * 表 : project_recover<br>
     * 对应字段 : platform_interest<br>
     */
    private BigDecimal platformInterest;

    /**
     * 预计加息券利息<br>
     * 表 : project_recover<br>
     * 对应字段 : coupon_interest<br>
     */
    private BigDecimal couponInterest;

    /**
     * 预计回款时间(精确到天)<br>
     * 表 : project_recover<br>
     * 对应字段 : receive_time<br>
     */
    private Date receiveTime;

    /**
     * 实际回款时间<br>
     * 表 : project_recover<br>
     * 对应字段 : real_receive_time<br>
     */
    private Date realReceiveTime;

    /**
     * 预计回款月yyyy-MM<br>
     * 表 : project_recover<br>
     * 对应字段 : receive_month<br>
     */
    private String receiveMonth;

    /**
     * 实际回款月yyyy-MM<br>
     * 表 : project_recover<br>
     * 对应字段 : real_receive_month<br>
     */
    private String realReceiveMonth;

    /**
     * 添加时间<br>
     * 表 : project_recover<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;


}