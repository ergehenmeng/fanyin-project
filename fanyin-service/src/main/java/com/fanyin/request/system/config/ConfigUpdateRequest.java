package com.fanyin.request.system.config;

import lombok.Data;

/**
 * 更新系统配置信息的请求参数类
 * @author 二哥很猛
 * @date 2018/1/12 17:37
 */
@Data
public class ConfigUpdateRequest {

    /**
     * 参数名称
     */
    private String name;
    /**
     * 参数类型 system_dict#system_config_type所配置
     */
    private Byte type;

    /**
     * 参数值
     */
    private String value;

    /**
     * 备注信息
     */
    private String remark;

    /**
     * 系统参数nid
     */
    private String nid;

    /**
     * 锁定状态 false未锁定 true锁定无法编辑
     */
    private Boolean locked;

}
