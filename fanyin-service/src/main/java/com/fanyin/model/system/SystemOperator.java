
package com.fanyin.model.system;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Date;

/**
 * @author 二哥很猛
 */
@Getter
@Setter
public class SystemOperator implements Serializable {

    private static final long serialVersionUID = -4647762860063174639L;
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
    private String department;

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


}