package com.fanyin.model.operation;

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
     * 对应字段 : name<br>
     */
    private String name;

    /**
     * vip等级<br>
     * 表 : vip_config<br>
     * 对应字段 : level<br>
     */
    private Byte level;

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
     * 对应字段 : status<br>
     */
    private Boolean status;

    /**
     * 月免费提现次数<br>
     * 表 : vip_config<br>
     * 对应字段 : withdraw<br>
     */
    private Byte withdraw;


}