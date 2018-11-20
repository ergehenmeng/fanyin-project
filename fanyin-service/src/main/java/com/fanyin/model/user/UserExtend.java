package com.fanyin.model.user;

import lombok.Data;

import java.io.Serializable;

/**
 * 用户附件信息表
 * @author 二哥很猛
 */
@Data
public class UserExtend implements Serializable {

    private static final long serialVersionUID = -5584145170501901878L;
    /**
     * 主键<br>
     * 表 : user_extend<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 投资人用户ID<br>
     * 表 : user_extend<br>
     * 对应字段 : user_id<br>
     */
    private Integer userId;

    /**
     * 头像地址<br>
     * 表 : user_extend<br>
     * 对应字段 : avatar<br>
     */
    private String avatar;

    /**
     * 真实姓名<br>
     * 表 : user_extend<br>
     * 对应字段 : real_name<br>
     */
    private String realName;

    /**
     * 身份证号码(前10位加密[18位身份证],前8位加密[15位身份证])<br>
     * 表 : user_extend<br>
     * 对应字段 : id_card<br>
     */
    private String idCard;

    /**
     * 可用积分总数<br>
     * 表 : user_extend<br>
     * 对应字段 : integral_num<br>
     */
    private Integer integralNum;

    /**
     * 用户等级<br>
     * 表 : user_extend<br>
     * 对应字段 : grade<br>
     */
    private Byte grade;



}