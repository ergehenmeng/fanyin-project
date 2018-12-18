package com.fanyin.model.user;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 用户积分记录表
 * @author 二哥很猛
 */
@Data
public class IntegralLog implements Serializable {
    private static final long serialVersionUID = 4318166989386765228L;
    /**
     * 主键<br>
     * 表 : integral_log<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * <br>
     * 表 : integral_log<br>
     * 对应字段 : user_id<br>
     */
    private Integer userId;

    /**
     * 积分数<br>
     * 表 : integral_log<br>
     * 对应字段 : num<br>
     */
    private Integer num;

    /**
     * 积分类型(表integral_type主键)<br>
     * 表 : integral_log<br>
     * 对应字段 : nid<br>
     */
    private String nid;

    /**
     * 获取积分的时间<br>
     * 表 : integral_log<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;


}