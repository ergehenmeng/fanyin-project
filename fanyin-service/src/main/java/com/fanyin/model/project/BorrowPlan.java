package com.fanyin.model.project;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author 二哥很猛
 * @date 2018/11/9 16:54
 */
@Slf4j
@Data
public class BorrowPlan {
    /**
     * 当前期数
     */
    private int period;

    /**
     * 总期数
     */
    private int periods;

    /**
     * 预计回款月
     */
    private String month;

    /**
     * 预计回款利息 总利息
     */
    private BigDecimal baseInterest;

    /**
     * 预计回款本金
     */
    private BigDecimal capital;

    /**
     * 当期加息券收益
     */
    private BigDecimal couponInterest;

    /**
     * 平台加息收益
     */
    private BigDecimal platformInterest;

    /**
     * 回款时间 精确到天 yyyy-MM-dd
     */
    private Date day;

}
