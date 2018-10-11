package com.fanyin.model.operation;

import java.io.Serializable;
import java.util.Date;

/**
 * 积分类型表
 * @author 二哥很猛
 */
public class IntegralType implements Serializable {
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

    private static final long serialVersionUID = 1L;

    /**
     * @return 主键
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id  
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * @return 积分类型nid
     */
    public String getNid() {
        return nid;
    }

    /**
     * @param nid  积分类型nid
     */
    public void setNid(String nid) {
        this.nid = nid == null ? null : nid.trim();
    }

    /**
     * @return 积分类型名称
     */
    public String getName() {
        return name;
    }

    /**
     * @param name  积分类型名称
     */
    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    /**
     * @return 积分类型状态 0:不可用 1:可用
     */
    public Boolean getStatus() {
        return status;
    }

    /**
     * @param status  积分类型状态 0:不可用 1:可用
     */
    public void setStatus(Boolean status) {
        this.status = status;
    }

    /**
     * @return 积分个数
     */
    public Integer getScore() {
        return score;
    }

    /**
     * @param score  积分个数
     */
    public void setScore(Integer score) {
        this.score = score;
    }

    /**
     * @return 积分类型 0:收入 1:支出
     */
    public Boolean getType() {
        return type;
    }

    /**
     * @param type  积分类型 0:收入 1:支出
     */
    public void setType(Boolean type) {
        this.type = type;
    }

    /**
     * @return 是否为随机积分 0:不是 1:是
     */
    public Boolean getRandom() {
        return random;
    }

    /**
     * @param random  是否为随机积分 0:不是 1:是
     */
    public void setRandom(Boolean random) {
        this.random = random;
    }

    /**
     * @return 添加时间
     */
    public Date getAddTime() {
        return addTime;
    }

    /**
     * @param addTime  添加时间
     */
    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    /**
     * @return 更新时间
     */
    public Date getUpdateTime() {
        return updateTime;
    }

    /**
     * @param updateTime  更新时间
     */
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @Override
    public String toString() {
        return "IntegralType{" +
                "id=" + id +
                ", nid='" + nid + '\'' +
                ", name='" + name + '\'' +
                ", status=" + status +
                ", score=" + score +
                ", type=" + type +
                ", random=" + random +
                ", addTime=" + addTime +
                ", updateTime=" + updateTime +
                '}';
    }
}