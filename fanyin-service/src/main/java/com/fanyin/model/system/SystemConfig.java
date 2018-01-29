package com.fanyin.model.system;

import java.io.Serializable;
import java.util.Date;

/**
 * 系统参数表
 * @author 二哥很猛
 */
public class SystemConfig implements Serializable {

    /**
     * 参数名称
     */
    private String name;
    /**
     * 主键<br>
     * 表 : system_config<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 参数标示符<br>
     * 表 : system_config<br>
     * 对应字段 : nid<br>
     */
    private String nid;

    /**
     * 参数值<br>
     * 表 : system_config<br>
     * 对应字段 : value<br>
     */
    private String value;

    /**
     * 备注信息<br>
     * 表 : system_config<br>
     * 对应字段 : remark<br>
     */
    private String remark;

    /**
     * 参数类型,见system_dict表nid=system_config_type<br>
     * 表 : system_config<br>
     * 对应字段 : type<br>
     */
    private Byte type;

    /**
     * 锁定状态(禁止编辑) 0:未锁定,1:锁定<br>
     * 表 : system_config<br>
     * 对应字段 : locked<br>
     */
    private Boolean locked;

    /**
     * 添加时间<br>
     * 表 : system_config<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 更新时间<br>
     * 表 : system_config<br>
     * 对应字段 : update_time<br>
     */
    private Date updateTime;

    private static final long serialVersionUID = 1L;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

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
     * @return 参数标示符
     */
    public String getNid() {
        return nid;
    }

    /**
     * @param nid  参数标示符
     */
    public void setNid(String nid) {
        this.nid = nid == null ? null : nid.trim();
    }

    /**
     * @return 参数值
     */
    public String getValue() {
        return value;
    }

    /**
     * @param value  参数值
     */
    public void setValue(String value) {
        this.value = value == null ? null : value.trim();
    }

    /**
     * @return 备注信息
     */
    public String getRemark() {
        return remark;
    }

    /**
     * @param remark  备注信息
     */
    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    /**
     * @return 参数类型,见system_dict表nid=system_config_type
     */
    public Byte getType() {
        return type;
    }

    /**
     * @param type  参数类型,见system_dict表nid=system_config_type
     */
    public void setType(Byte type) {
        this.type = type;
    }

    /**
     * @return 锁定状态(禁止编辑) 0:未锁定,1:锁定
     */
    public Boolean getLocked() {
        return locked;
    }

    /**
     * @param locked  锁定状态(禁止编辑) 0:未锁定,1:锁定
     */
    public void setLocked(Boolean locked) {
        this.locked = locked;
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
        return "SystemConfig{" +
                "id=" + id +
                ", nid='" + nid + '\'' +
                ", value='" + value + '\'' +
                ", remark='" + remark + '\'' +
                ", type=" + type +
                ", locked=" + locked +
                ", addTime=" + addTime +
                ", updateTime=" + updateTime +
                '}';
    }
}