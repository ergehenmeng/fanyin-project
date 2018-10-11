package com.fanyin.model.user;

import java.io.Serializable;
import java.util.Date;

/**
 * 用户积分记录表
 * @author 二哥很猛
 */
public class IntegralLog implements Serializable {
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
     * 对应字段 : type<br>
     */
    private Integer type;

    /**
     * 获取积分的时间<br>
     * 表 : integral_log<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    private static final long serialVersionUID = 1L;

    /**
     * @return 主键
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id  主键
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * @return 
     */
    public Integer getUserId() {
        return userId;
    }

    /**
     * @param userId  
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    /**
     * @return 积分数
     */
    public Integer getNum() {
        return num;
    }

    /**
     * @param num  积分数
     */
    public void setNum(Integer num) {
        this.num = num;
    }

    /**
     * @return 积分类型(表integral_type主键)
     */
    public Integer getType() {
        return type;
    }

    /**
     * @param type  积分类型(表integral_type主键)
     */
    public void setType(Integer type) {
        this.type = type;
    }

    /**
     * @return 获取积分的时间
     */
    public Date getAddTime() {
        return addTime;
    }

    /**
     * @param addTime  获取积分的时间
     */
    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    @Override
    public String toString() {
        return "IntegralLog{" +
                "id=" + id +
                ", userId=" + userId +
                ", num=" + num +
                ", type=" + type +
                ", addTime=" + addTime +
                '}';
    }
}