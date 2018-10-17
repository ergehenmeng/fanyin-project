package com.fanyin.model.operation;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 积分类型表
 * @author 二哥很猛
 */
@Data
public class IntegralType implements Serializable {
    private static final long serialVersionUID = -5845325860026976820L;
    /**
     * <br>
     * 表 : integral_type<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 积分类型nid<br>
     * 表 : integral_type<br>
     * 对应字段 : nid<br>
     */
    private String nid;

    /**
     * 积分类型名称<br>
     * 表 : integral_type<br>
     * 对应字段 : name<br>
     */
    private String name;

    /**
     * 积分类型状态 0:不可用 1:可用<br>
     * 表 : integral_type<br>
     * 对应字段 : status<br>
     */
    private Boolean status;

    /**
     * 积分个数<br>
     * 表 : integral_type<br>
     * 对应字段 : score<br>
     */
    private Integer score;

    /**
     * 积分类型 0:收入 1:支出<br>
     * 表 : integral_type<br>
     * 对应字段 : type<br>
     */
    private Boolean type;

    /**
     * 是否为随机积分 0:不是 1:是<br>
     * 表 : integral_type<br>
     * 对应字段 : random<br>
     */
    private Boolean random;

    /**
     * 添加时间<br>
     * 表 : integral_type<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 更新时间<br>
     * 表 : integral_type<br>
     * 对应字段 : update<br>
     */
    private Date updateTime;


}