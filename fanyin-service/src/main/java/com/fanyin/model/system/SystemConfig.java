package com.fanyin.model.system;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 系统参数表
 * @author 二哥很猛
 */
@Data
public class SystemConfig implements Serializable {

    private static final long serialVersionUID = -3006821887681558075L;
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


}