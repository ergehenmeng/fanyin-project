package com.fanyin.model.user;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 银行卡表
 * @author 二哥很猛
 */
@Data
public class BankCard implements Serializable {
    private static final long serialVersionUID = 3952835725260806495L;
    /**
     * <br>
     * 表 : bank_card<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 用户ID<br>
     * 表 : bank_card<br>
     * 对应字段 : user_id<br>
     */
    private Integer userId;

    /**
     * 用户类型 0:投资人 1:借款人<br>
     * 表 : bank_card<br>
     * 对应字段 : user_type<br>
     */
    private Byte userType;

    /**
     * 银行编号:ABC,ICBC<br>
     * 表 : bank_card<br>
     * 对应字段 : bank_code<br>
     */
    private String bankCode;

    /**
     * 银行卡号<br>
     * 表 : bank_card<br>
     * 对应字段 : bank_num<br>
     */
    private String bankNum;

    /**
     * 银行预留手机号<br>
     * 表 : bank_card<br>
     * 对应字段 : mobile<br>
     */
    private String mobile;

    /**
     * 删除状态 0:正常 1:已删除<br>
     * 表 : bank_card<br>
     * 对应字段 : deleted<br>
     */
    private Boolean deleted;

    /**
     * 添加时间<br>
     * 表 : bank_card<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 更新时间<br>
     * 表 : bank_card<br>
     * 对应字段 : update_time<br>
     */
    private Date updateTime;

    /**
     * 备注信息<br>
     * 表 : bank_card<br>
     * 对应字段 : remark<br>
     */
    private String remark;


}