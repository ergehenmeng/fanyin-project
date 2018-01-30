package com.fanyin.request.system.config;


import com.fanyin.ext.BaseRequest;

import java.io.Serializable;

/**
 * @author 二哥很猛
 * @date 2018/1/18 16:04
 */
public class ConfigSelectRequest extends BaseRequest implements Serializable {

    private static final long serialVersionUID = -2384592001035426711L;

    /**
     * 参数配置类型
     */
    private Integer type;

    /**
     * 是否锁定(禁止编辑)
     */
    private Boolean locked;

    /**
     * 备注信息
     */
    private String remark;

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Boolean getLocked() {
        return locked;
    }

    public void setLocked(Boolean locked) {
        this.locked = locked;
    }
}
