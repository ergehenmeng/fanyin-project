package com.fanyin.model.borrower;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 借款人基本信息表
 * @author 二哥很猛
 */
@Data
public class Borrower implements Serializable {
    private static final long serialVersionUID = 3840705875756203833L;
    /**
     * <br>
     * 表 : borrower<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 手机号码<br>
     * 表 : borrower<br>
     * 对应字段 : mobile<br>
     */
    private String mobile;

    /**
     * 登陆密码MD5<br>
     * 表 : borrower<br>
     * 对应字段 : password<br>
     */
    private String password;

    /**
     * 存管号<br>
     * 表 : borrower<br>
     * 对应字段 : deposit_no<br>
     */
    private String depositNo;

    /**
     * 存管状态<br>
     * 表 : borrower<br>
     * 对应字段 : deposit_status<br>
     */
    private Byte depositStatus;

    /**
     * 用户状态 0:未锁定 1:锁定(不可登陆系统)<br>
     * 表 : borrower<br>
     * 对应字段 : locked<br>
     */
    private Boolean locked;

    /**
     * 删除状态 0:正常 1:已删除(仅数据库可见)<br>
     * 表 : borrower<br>
     * 对应字段 : deleted<br>
     */
    private Boolean deleted;

    /**
     * 添加时间<br>
     * 表 : borrower<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 更新时间<br>
     * 表 : borrower<br>
     * 对应字段 : update_time<br>
     */
    private Date updateTime;


}