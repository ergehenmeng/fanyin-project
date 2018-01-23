package com.fanyin.request.system;


import com.fanyin.ext.BaseRequest;

import java.io.Serializable;

/**
 * @description:
 * @author: 二哥很猛
 * @date: 2018/1/18
 * @time: 16:04
 */
public class SystemConfigSelectRequest extends BaseRequest implements Serializable {

    private static final long serialVersionUID = -2384592001035426711L;

    /**
     * 参数配置类型
     */
    private Integer type;

    /**
     * 是否锁定(禁止编辑)
     */
    private Boolean locked;

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
