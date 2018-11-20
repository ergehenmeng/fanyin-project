package com.fanyin.model.borrower;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 借款人资金记录表
 * @author 二哥很猛
 */
@Data
public class BorrowerAccountLog implements Serializable {

    private static final long serialVersionUID = -376587640486121523L;
    /**
     * 主键<br>
     * 表 : borrower_account_log<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 借款人id<br>
     * 表 : borrower_account_log<br>
     * 对应字段 : borrower_id<br>
     */
    private Integer borrowerId;

    /**
     * 资金金额<br>
     * 表 : borrower_account_log<br>
     * 对应字段 : amount<br>
     */
    private BigDecimal amount = BigDecimal.ZERO;

    /**
     * 资金类型<br>
     * 表 : borrower_account_log<br>
     * 对应字段 : type<br>
     */
    private Byte type;

    /**
     * 添加时间<br>
     * 表 : borrower_account_log<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 产品id<br>
     * 表 : borrower_account_log<br>
     * 对应字段 : project_id<br>
     */
    private Integer projectId;


}