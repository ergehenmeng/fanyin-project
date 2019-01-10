package com.fanyin.model.project;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 项目信息表
 * @author 二哥很猛
 */
@Data
public class Project implements Serializable {
    private static final long serialVersionUID = -1974870458034227066L;
    /**
     * 主键产品ID<br>
     * 表 : project<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 借款人ID<br>
     * 表 : project<br>
     * 对应字段 : borrower_id<br>
     */
    private Integer borrowerId;

    /**
     * 产品编号<br>
     * 表 : project<br>
     * 对应字段 : nid<br>
     */
    private String nid;

    /**
     * 产品状态:-2:废弃-1:产品撤回,0待初审,1:待复审,2:募集中,3:满标待复审,4:还款中,5:还款完成,6:逾期结清<br>
     * 表 : project<br>
     * 对应字段 : state<br>
     */
    private Byte state;

    /**
     * 产品类型 0:个人贷,1:企业贷<br>
     * 表 : project<br>
     * 对应字段 : classify<br>
     */
    private Byte classify;

    /**
     * 产品名称<br>
     * 表 : project<br>
     * 对应字段 : title<br>
     */
    private String title;

    /**
     * 计划募集金额<br>
     * 表 : project<br>
     * 对应字段 : amount<br>
     */
    private BigDecimal amount;

    /**
     * 已募集金额<br>
     * 表 : project<br>
     * 对应字段 : raise_amount<br>
     */
    private BigDecimal raiseAmount;

    /**
     * 单次最小投标金额<br>
     * 表 : project<br>
     * 对应字段 : min_tender<br>
     */
    private BigDecimal minTender;

    /**
     * 产品基础利息 单位%<br>
     * 表 : project<br>
     * 对应字段 : apr<br>
     */
    private BigDecimal apr;

    /**
     * 平台加息利息 单位%<br>
     * 表 : project<br>
     * 对应字段 : platform_apr<br>
     */
    private BigDecimal platformApr;

    /**
     * 期限(月)<br>
     * 表 : project<br>
     * 对应字段 : period<br>
     */
    private Byte period;

    /**
     * 还款方式,0:等额本息,1:按月付息,到期还本,2:按天计息<br>
     * 表 : project<br>
     * 对应字段 : repayment_mode<br>
     */
    private Byte repaymentMode;

    /**
     * 产品信息录入时间<br>
     * 表 : project<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 预售时间(默认产品发布时间)<br>
     * 表 : project<br>
     * 对应字段 : pre_sale_time<br>
     */
    private Date preSaleTime;

    /**
     * 产品发布时间(复审通过时间)<br>
     * 表 : project<br>
     * 对应字段 : publish_time<br>
     */
    private Date publishTime;

    /**
     * 满标复审时间<br>
     * 表 : project<br>
     * 对应字段 : recheck_time<br>
     */
    private Date recheckTime;

    /**
     * 产品完结时间(废弃,撤标,还款完成,逾期结清)等<br>
     * 表 : project<br>
     * 对应字段 : end_time<br>
     */
    private Date endTime;


}