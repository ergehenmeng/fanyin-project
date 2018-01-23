package com.fanyin.model.system;

import java.io.Serializable;
import java.util.Date;

/**
 * @author 二哥很猛
 */
public class SystemDict implements Serializable {
    /**
     * <br>
     * 表 : system_dict<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 字典中文名称<br>
     * 表 : system_dict<br>
     * 对应字段 : name<br>
     */
    private String name;

    /**
     * 数据字典nid(英文名称)<br>
     * 表 : system_dict<br>
     * 对应字段 : nid<br>
     */
    private String nid;

    /**
     * 数据字典隐藏值<br>
     * 表 : system_dict<br>
     * 对应字段 : hidden_value<br>
     */
    private Byte hiddenValue;

    /**
     * 显示值<br>
     * 表 : system_dict<br>
     * 对应字段 : value<br>
     */
    private String value;

    /**
     * 删除状态 0:正常,1:已删除<br>
     * 表 : system_dict<br>
     * 对应字段 : deleted<br>
     */
    private Boolean deleted;

    /**
     * 锁定状态(禁止编辑):0:未锁定 1:锁定<br>
     * 表 : system_dict<br>
     * 对应字段 : locked<br>
     */
    private Boolean locked;

    /**
     * 添加时间<br>
     * 表 : system_dict<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 修改时间<br>
     * 表 : system_dict<br>
     * 对应字段 : update_time<br>
     */
    private Date updateTime;

    private static final long serialVersionUID = 1L;

    /**
     * @return 
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
     * @return 字典中文名称
     */
    public String getName() {
        return name;
    }

    /**
     * @param name  字典中文名称
     */
    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    /**
     * @return 数据字典nid(英文名称)
     */
    public String getNid() {
        return nid;
    }

    /**
     * @param nid  数据字典nid(英文名称)
     */
    public void setNid(String nid) {
        this.nid = nid == null ? null : nid.trim();
    }

    /**
     * @return 数据字典隐藏值
     */
    public Byte getHiddenValue() {
        return hiddenValue;
    }

    /**
     * @param hiddenValue  数据字典隐藏值
     */
    public void setHiddenValue(Byte hiddenValue) {
        this.hiddenValue = hiddenValue;
    }

    /**
     * @return 显示值
     */
    public String getValue() {
        return value;
    }

    /**
     * @param value  显示值
     */
    public void setValue(String value) {
        this.value = value == null ? null : value.trim();
    }

    /**
     * @return 删除状态 0:正常,1:已删除
     */
    public Boolean getDeleted() {
        return deleted;
    }

    /**
     * @param deleted  删除状态 0:正常,1:已删除
     */
    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }

    /**
     * @return 锁定状态(禁止编辑):0:未锁定 1:锁定
     */
    public Boolean getLocked() {
        return locked;
    }

    /**
     * @param locked  锁定状态(禁止编辑):0:未锁定 1:锁定
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
     * @return 修改时间
     */
    public Date getUpdateTime() {
        return updateTime;
    }

    /**
     * @param updateTime  修改时间
     */
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    /**
     *
     * @param that
     */
    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        SystemDict other = (SystemDict) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getName() == null ? other.getName() == null : this.getName().equals(other.getName()))
            && (this.getNid() == null ? other.getNid() == null : this.getNid().equals(other.getNid()))
            && (this.getHiddenValue() == null ? other.getHiddenValue() == null : this.getHiddenValue().equals(other.getHiddenValue()))
            && (this.getValue() == null ? other.getValue() == null : this.getValue().equals(other.getValue()))
            && (this.getDeleted() == null ? other.getDeleted() == null : this.getDeleted().equals(other.getDeleted()))
            && (this.getLocked() == null ? other.getLocked() == null : this.getLocked().equals(other.getLocked()))
            && (this.getAddTime() == null ? other.getAddTime() == null : this.getAddTime().equals(other.getAddTime()))
            && (this.getUpdateTime() == null ? other.getUpdateTime() == null : this.getUpdateTime().equals(other.getUpdateTime()));
    }

    /**
     *
     */
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getName() == null) ? 0 : getName().hashCode());
        result = prime * result + ((getNid() == null) ? 0 : getNid().hashCode());
        result = prime * result + ((getHiddenValue() == null) ? 0 : getHiddenValue().hashCode());
        result = prime * result + ((getValue() == null) ? 0 : getValue().hashCode());
        result = prime * result + ((getDeleted() == null) ? 0 : getDeleted().hashCode());
        result = prime * result + ((getLocked() == null) ? 0 : getLocked().hashCode());
        result = prime * result + ((getAddTime() == null) ? 0 : getAddTime().hashCode());
        result = prime * result + ((getUpdateTime() == null) ? 0 : getUpdateTime().hashCode());
        return result;
    }

    /**
     *
     */
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", name=").append(name);
        sb.append(", nid=").append(nid);
        sb.append(", hiddenValue=").append(hiddenValue);
        sb.append(", value=").append(value);
        sb.append(", deleted=").append(deleted);
        sb.append(", locked=").append(locked);
        sb.append(", addTime=").append(addTime);
        sb.append(", updateTime=").append(updateTime);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}