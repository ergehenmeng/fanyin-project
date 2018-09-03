package com.fanyin.request.system.config;

import java.io.Serializable;

/**
 * @author 二哥很猛
 * @date 2018/1/29 16:07
 */
public class ConfigInsertRequest implements Serializable{

    private static final long serialVersionUID = -5215129909970715975L;

    /**
     * 系统参数标示符
     */
    private String nid;

    /**
     * 系统参数值
     */
    private String value;

    /**
     * 参数类型
     */
    private Byte type;

    /**
     * 是否锁定 锁定即不可编辑
     */
    private Boolean locked;

    public String getNid() {
        return nid;
    }

    public void setNid(String nid) {
        this.nid = nid;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public Byte getType() {
        return type;
    }

    public void setType(Byte type) {
        this.type = type;
    }

    public Boolean getLocked() {
        return locked;
    }

    public void setLocked(Boolean locked) {
        this.locked = locked;
    }
}
