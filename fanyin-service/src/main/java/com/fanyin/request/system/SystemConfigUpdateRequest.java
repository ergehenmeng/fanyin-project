package com.fanyin.request.system;

/**
 * @description: 更新系统配置信息的请求参数类
 * @author: 二哥很猛
 * @date: 2018/1/12
 * @time: 17:37
 */
public class SystemConfigUpdateRequest {

    /**
     * 参数类型 system_dict#system_config_type所配置
     */
    private Integer type;

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

    public String getNid() {
        return nid;
    }

    public void setNid(String nid) {
        this.nid = nid;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }


    @Override
    public String toString() {
        return "SystemConfigUpdateRequest{" +
                "type=" + type +
                ", value='" + value + '\'' +
                ", remark='" + remark + '\'' +
                '}';
    }
}
