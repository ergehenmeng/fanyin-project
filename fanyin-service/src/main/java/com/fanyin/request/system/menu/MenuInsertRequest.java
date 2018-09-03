package com.fanyin.request.system.menu;

import java.io.Serializable;

/**
 * 菜单添加
 * @author 二哥很猛
 * @date  2018/1/30 11:36
 */
public class MenuInsertRequest implements Serializable {

    private static final long serialVersionUID = 8515421119279590820L;

    /**
     * 名称
     */
    private String name;

    /**
     * 标示符
     */
    private String nid;

    /**
     * 菜单url
     */
    private String url;

    /**
     * 子url
     */
    private String subUrl;

    /**
     * 父id
     */
    private Integer pid;

    /**
     * 排序
     */
    private Integer sort;

    /**
     * 备注信息
     */
    private String remark;

    /**
     * 是否为主菜单
     */
    private Boolean mainMenu;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNid() {
        return nid;
    }

    public void setNid(String nid) {
        this.nid = nid;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getSubUrl() {
        return subUrl;
    }

    public void setSubUrl(String subUrl) {
        this.subUrl = subUrl;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Boolean getMainMenu() {
        return mainMenu;
    }

    public void setMainMenu(Boolean mainMenu) {
        this.mainMenu = mainMenu;
    }
}
