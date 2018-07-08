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
    private String initPassword;


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

    public String getInitPassword() {
        return initPassword;
    }

    public void setInitPassword(String initPassword) {
        this.initPassword = initPassword;
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


}