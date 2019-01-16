package com.fanyin.model.business;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * vip等级配置表
 * @author 二哥很猛
 */
@Data
public class VipConfig implements Serializable {
    private static final long serialVersionUID = -5159775330918785741L;
    /**
     * 主键<br>
     * 表 : vip_config<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 等级名称<br>
     * 表 : vip_config<br>
     * 对应字段 : title<br>
     */
    private String title;

    /**
     * vip等级<br>
     * 表 : vip_config<br>
     * 对应字段 : grade<br>
     */
    private Byte grade;

    /**
     * 排序规则:小(前面)<->大(后面)<br>
     * 表 : vip_config<br>
     * 对应字段 : sort<br>
     */
    private Byte sort;

    /**
     * 当前等级最小待收金额<br>
     * 表 : vip_config<br>
     * 对应字段 : amount<br>
     */
    private BigDecimal amount;

    /**
     * 状态 0:关闭 1:开启<br>
     * 表 : vip_config<br>
     * 对应字段 : state<br>
     */
    private Boolean state;

    /**
     * 月免费提现次数<br>
     * 表 : vip_config<br>
     * 对应字段 : withdraw<br>
     */
    private Byte withdraw;


}