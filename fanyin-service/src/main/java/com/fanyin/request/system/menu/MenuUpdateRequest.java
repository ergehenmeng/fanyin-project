package com.fanyin.request.system.menu;

import java.io.Serializable;

/**
 * @author 二哥很猛
 */
public class MenuUpdateRequest implements Serializable {

    private static final long serialVersionUID = 6714241304584747778L;

    /**
     * 主键
     */
    private Integer id;

    /**
     * 菜单名称
     */
    private String name;

    /**
     * 菜单标示符
     */
    private String nid;

    /**
     * 菜单父id
     */
    private String pid;

    /**
     * 菜单url
     */
    private String url;

    /**
     * 子url
     */
    private String subUrl;

    /**
     * 是否为左侧主菜单
     */
    private Boolean mainMenu;

    /**
     * 排序
     */
    private Integer sort;

    /**
     * 备注
     */
    private String remark;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

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

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
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

    public Boolean getMainMenu() {
        return mainMenu;
    }

    public void setMainMenu(Boolean mainMenu) {
        this.mainMenu = mainMenu;
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
}
