package com.fanyin.model.project;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 借款人还款信息表
 * @author 二哥很猛
 */
@Data
public class ProjectRepayment implements Serializable {
    /**
     * 主键<br>
     * 表 : project_repayment<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 借款人ID<br>
     * 表 : project_repayment<br>
     * 对应字段 : borrower_id<br>
     */
    private Integer borrowerId;

    /**
     * 标的ID<br>
     * 表 : project_repayment<br>
     * 对应字段 : project_id<br>
     */
    private Integer projectId;

    /**
     * 还款状态 0:未还款 1:正常还款,2:提前还款,3:部分还款,4:逾期还款<br>
     * 表 : project_repayment<br>
     * 对应字段 : status<br>
     */
    private Boolean status;

    /**
     * 第几期还款<br>
     * 表 : project_repayment<br>
     * 对应字段 : period<br>
     */
    private Byte period;

    /**
     * 总期数<br>
     * 表 : project_repayment<br>
     * 对应字段 : periods<br>
     */
    private Byte periods;

    /**
     * 预计还款本金<br>
     * 表 : project_repayment<br>
     * 对应字段 : capital<br>
     */
    private BigDecimal capital;

    /**
     * 基础利息<br>
     * 表 : project_repayment<br>
     * 对应字段 : interest<br>
     */
    private BigDecimal interest;

    /**
     * 平台加息利息<br>
     * 表 : project_repayment<br>
     * 对应字段 : platform_interest<br>
     */
    private BigDecimal platformInterest;

    /**
     * 加息券利息<br>
     * 表 : project_repayment<br>
     * 对应字段 : coupon_interest<br>
     */
    private BigDecimal couponInterest;

    /**
     * 预计还款时间(精确到天)<br>
     * 表 : project_repayment<br>
     * 对应字段 : repay_time<br>
     */
    private Date repayTime;

    /**
     * 实际还款时间(精确到秒)<br>
     * 表 : project_repayment<br>
     * 对应字段 : real_repay_time<br>
     */
    private Date realRepayTime;

    /**
     * 备注信息<br>
     * 表 : project_repayment<br>
     * 对应字段 : remark<br>
     */
    private String remark;

    /**
     * 添加时间<br>
     * 表 : project_repayment<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 更新时间<br>
     * 表 : project_repayment<br>
     * 对应字段 : update_time<br>
     */
    private Date updateTime;

    /**
     * 预计还款月 yyyy-MM
     */
    private String repayMonth;

    /**
     * 实际还款月
     */
    private String realRepayMonth;


}