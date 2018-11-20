package com.fanyin.model.user;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 投资人用户信息表
 * @author 二哥很猛
 */
@Data
public class User implements Serializable {
    private static final long serialVersionUID = -606375182034919461L;
    /**
     * 主键<br>
     * 表 : user<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 手机号码<br>
     * 表 : user<br>
     * 对应字段 : mobile<br>
     */
    private String mobile;

    /**
     * 电子邮箱<br>
     * 表 : user<br>
     * 对应字段 : email<br>
     */
    private String email;

    /**
     * 存管账号<br>
     * 表 : user<br>
     * 对应字段 : deposit_no<br>
     */
    private String depositNo;

    /**
     * 登陆密码<br>
     * 表 : user<br>
     * 对应字段 : password<br>
     */
    private String password;

    /**
     * 状态 1正常 0:锁定<br>
     * 表 : user<br>
     * 对应字段 : status<br>
     */
    private Boolean status;

    /**
     * 注册渠道 pc,android,ios,h5,other<br>
     * 表 : user<br>
     * 对应字段 : channel<br>
     */
    private Byte channel;

    /**
     * 注册地址<br>
     * 表 : user<br>
     * 对应字段 : register_ip<br>
     */
    private String registerIp;

    /**
     * 注册时间<br>
     * 表 : user<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 更新时间<br>
     * 表 : user<br>
     * 对应字段 : update_time<br>
     */
    private Date updateTime;


}