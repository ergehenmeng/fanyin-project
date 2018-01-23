package com.fanyin.model.system;

import java.io.Serializable;
import java.util.Date;

/**
 * @author 二哥很猛
 */
public class SystemOperator implements Serializable {
    /**
     * 主键<br>
     * 表 : system_operator<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 用户名称<br>
     * 表 : system_operator<br>
     * 对应字段 : name<br>
     */
    private String name;

    /**
     * 手机号码(登陆账户)<br>
     * 表 : system_operator<br>
     * 对应字段 : mobile<br>
     */
    private String mobile;

    /**
     * 用户状态:0:锁定,1:正常<br>
     * 表 : system_operator<br>
     * 对应字段 : status<br>
     */
    private Boolean status;

    /**
     * 登陆密码MD5<br>
     * 表 : system_operator<br>
     * 对应字段 : password<br>
     */
    private String password;

    /**
     * 初始密码<br>
     * 表 : system_operator<br>
     * 对应字段 : init_password<br>
     */
    private String inipassword;

    /**
     * 登陆密码随机串<br>
     * 表 : system_operator<br>
     * 对应字段 : password_random<br>
     */
    private String passwordRandom;

    /**
     * <br>
     * 表 : system_operator<br>
     * 对应字段 : department<br>
     */
    private Integer department;

    /**
     * 删除状态 0:正常,1:已删除<br>
     * 表 : system_operator<br>
     * 对应字段 : deleted<br>
     */
    private Boolean deleted;

    /**
     * 添加时间<br>
     * 表 : system_operator<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 更新时间<br>
     * 表 : system_operator<br>
     * 对应字段 : update_time<br>
     */
    private Date updateTime;

    /**
     * 备注信息<br>
     * 表 : system_operator<br>
     * 对应字段 : remark<br>
     */
    private String remark;

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
     * @return 用户名称
     */
    public String getName() {
        return name;
    }

    /**
     * @param name  用户名称
     */
    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    /**
     * @return 手机号码(登陆账户)
     */
    public String getMobile() {
        return mobile;
    }

    /**
     * @param mobile  手机号码(登陆账户)
     */
    public void setMobile(String mobile) {
        this.mobile = mobile == null ? null : mobile.trim();
    }

    /**
     * @return 用户状态:0:锁定,1:正常
     */
    public Boolean getStatus() {
        return status;
    }

    /**
     * @param status  用户状态:0:锁定,1:正常
     */
    public void setStatus(Boolean status) {
        this.status = status;
    }

    /**
     * @return 登陆密码MD5
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password  登陆密码MD5
     */
    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    /**
     * @return 初始密码
     */
    public String getInipassword() {
        return inipassword;
    }

    /**
     * @param inipassword  初始密码
     */
    public void setInipassword(String inipassword) {
        this.inipassword = inipassword == null ? null : inipassword.trim();
    }

    /**
     * @return 登陆密码随机串
     */
    public String getPasswordRandom() {
        return passwordRandom;
    }

    /**
     * @param passwordRandom  登陆密码随机串
     */
    public void setPasswordRandom(String passwordRandom) {
        this.passwordRandom = passwordRandom == null ? null : passwordRandom.trim();
    }

    /**
     * @return 
     */
    public Integer getDepartment() {
        return department;
    }

    /**
     * @param department  
     */
    public void setDepartment(Integer department) {
        this.department = department;
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
        SystemOperator other = (SystemOperator) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getName() == null ? other.getName() == null : this.getName().equals(other.getName()))
            && (this.getMobile() == null ? other.getMobile() == null : this.getMobile().equals(other.getMobile()))
            && (this.getStatus() == null ? other.getStatus() == null : this.getStatus().equals(other.getStatus()))
            && (this.getPassword() == null ? other.getPassword() == null : this.getPassword().equals(other.getPassword()))
            && (this.getInipassword() == null ? other.getInipassword() == null : this.getInipassword().equals(other.getInipassword()))
            && (this.getPasswordRandom() == null ? other.getPasswordRandom() == null : this.getPasswordRandom().equals(other.getPasswordRandom()))
            && (this.getDepartment() == null ? other.getDepartment() == null : this.getDepartment().equals(other.getDepartment()))
            && (this.getDeleted() == null ? other.getDeleted() == null : this.getDeleted().equals(other.getDeleted()))
            && (this.getAddTime() == null ? other.getAddTime() == null : this.getAddTime().equals(other.getAddTime()))
            && (this.getUpdateTime() == null ? other.getUpdateTime() == null : this.getUpdateTime().equals(other.getUpdateTime()))
            && (this.getRemark() == null ? other.getRemark() == null : this.getRemark().equals(other.getRemark()));
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
        result = prime * result + ((getMobile() == null) ? 0 : getMobile().hashCode());
        result = prime * result + ((getStatus() == null) ? 0 : getStatus().hashCode());
        result = prime * result + ((getPassword() == null) ? 0 : getPassword().hashCode());
        result = prime * result + ((getInipassword() == null) ? 0 : getInipassword().hashCode());
        result = prime * result + ((getPasswordRandom() == null) ? 0 : getPasswordRandom().hashCode());
        result = prime * result + ((getDepartment() == null) ? 0 : getDepartment().hashCode());
        result = prime * result + ((getDeleted() == null) ? 0 : getDeleted().hashCode());
        result = prime * result + ((getAddTime() == null) ? 0 : getAddTime().hashCode());
        result = prime * result + ((getUpdateTime() == null) ? 0 : getUpdateTime().hashCode());
        result = prime * result + ((getRemark() == null) ? 0 : getRemark().hashCode());
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
        sb.append(", mobile=").append(mobile);
        sb.append(", status=").append(status);
        sb.append(", password=").append(password);
        sb.append(", inipassword=").append(inipassword);
        sb.append(", passwordRandom=").append(passwordRandom);
        sb.append(", department=").append(department);
        sb.append(", deleted=").append(deleted);
        sb.append(", addTime=").append(addTime);
        sb.append(", updateTime=").append(updateTime);
        sb.append(", remark=").append(remark);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}