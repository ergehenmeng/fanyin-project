package com.fanyin.model.system;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class SystemMenu implements Serializable {
    /**
     * 主键<br>
     * 表 : system_menu<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 菜单名称<br>
     * 表 : system_menu<br>
     * 对应字段 : name<br>
     */
    private String name;

    /**
     * 菜单标示符 唯一<br>
     * 表 : system_menu<br>
     * 对应字段 : nid<br>
     */
    private String nid;

    /**
     * 父节点ID,一级菜单默认为0<br>
     * 表 : system_menu<br>
     * 对应字段 : pid<br>
     */
    private Integer pid;

    /**
     * 菜单地址<br>
     * 表 : system_menu<br>
     * 对应字段 : url<br>
     */
    private String url;

    /**
     * 是否为左侧主菜单 0:不是,1:是<br>
     * 表 : system_menu<br>
     * 对应字段 : main_menu<br>
     */
    private Boolean mainMenu;

    /**
     * 排序规则 小的排在前面<br>
     * 表 : system_menu<br>
     * 对应字段 : sort<br>
     */
    private Integer sort;

    /**
     * 状态:0:正常,1:已删除<br>
     * 表 : system_menu<br>
     * 对应字段 : deleted<br>
     */
    private Boolean deleted;

    /**
     * 备注信息<br>
     * 表 : system_menu<br>
     * 对应字段 : remark<br>
     */
    private String remark;

    /**
     * 添加时间<br>
     * 表 : system_menu<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 更新时间<br>
     * 表 : system_menu<br>
     * 对应字段 : update_time<br>
     */
    private Date updateTime;

    /**
     * 子菜单列表
     */
    private List<SystemMenu> subList;


    public List<SystemMenu> getSubList() {
        return subList;
    }

    public void setSubList(List<SystemMenu> subList) {
        this.subList = subList;
    }

    private static final long serialVersionUID = 1L;

    /**
     * @return 主键
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id  主键
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * @return 菜单名称
     */
    public String getName() {
        return name;
    }

    /**
     * @param name  菜单名称
     */
    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    /**
     * @return 菜单标示符 唯一
     */
    public String getNid() {
        return nid;
    }

    /**
     * @param nid  菜单标示符 唯一
     */
    public void setNid(String nid) {
        this.nid = nid == null ? null : nid.trim();
    }

    /**
     * @return 父节点ID,一级菜单默认为0
     */
    public Integer getPid() {
        return pid;
    }

    /**
     * @param pid  父节点ID,一级菜单默认为0
     */
    public void setPid(Integer pid) {
        this.pid = pid;
    }

    /**
     * @return 菜单地址
     */
    public String getUrl() {
        return url;
    }

    /**
     * @param url  菜单地址
     */
    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    /**
     * @return 是否为左侧主菜单 0:不是,1:是
     */
    public Boolean getMainMenu() {
        return mainMenu;
    }

    /**
     * @param mainMenu  是否为左侧主菜单 0:不是,1:是
     */
    public void setMainMenu(Boolean mainMenu) {
        this.mainMenu = mainMenu;
    }

    /**
     * @return 排序规则 小的排在前面
     */
    public Integer getSort() {
        return sort;
    }

    /**
     * @param sort  排序规则 小的排在前面
     */
    public void setSort(Integer sort) {
        this.sort = sort;
    }

    /**
     * @return 状态:0:正常,1:已删除
     */
    public Boolean getDeleted() {
        return deleted;
    }

    /**
     * @param deleted  状态:0:正常,1:已删除
     */
    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }

    /**
     * @return 备注信息
     */
    public String getRemark() {
        return remark;
    }

    /**
     * @param remark  备注信息
     */
    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    /**
     * @return 添加时间
     */
    public Date getAddTime() {
        return addTime;
    }

    /**
     * @param addTime  添加时间
     */
    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    /**
     * @return 更新时间
     */
    public Date getUpdateTime() {
        return updateTime;
    }

    /**
     * @param updateTime  更新时间
     */
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    /**
     *
     * @param that
     */
    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        SystemMenu other = (SystemMenu) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getName() == null ? other.getName() == null : this.getName().equals(other.getName()))
            && (this.getNid() == null ? other.getNid() == null : this.getNid().equals(other.getNid()))
            && (this.getPid() == null ? other.getPid() == null : this.getPid().equals(other.getPid()))
            && (this.getUrl() == null ? other.getUrl() == null : this.getUrl().equals(other.getUrl()))
            && (this.getMainMenu() == null ? other.getMainMenu() == null : this.getMainMenu().equals(other.getMainMenu()))
            && (this.getSort() == null ? other.getSort() == null : this.getSort().equals(other.getSort()))
            && (this.getDeleted() == null ? other.getDeleted() == null : this.getDeleted().equals(other.getDeleted()))
            && (this.getRemark() == null ? other.getRemark() == null : this.getRemark().equals(other.getRemark()))
            && (this.getAddTime() == null ? other.getAddTime() == null : this.getAddTime().equals(other.getAddTime()))
            && (this.getUpdateTime() == null ? other.getUpdateTime() == null : this.getUpdateTime().equals(other.getUpdateTime()));
    }

    /**
     *
     */
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getName() == null) ? 0 : getName().hashCode());
        result = prime * result + ((getNid() == null) ? 0 : getNid().hashCode());
        result = prime * result + ((getPid() == null) ? 0 : getPid().hashCode());
        result = prime * result + ((getUrl() == null) ? 0 : getUrl().hashCode());
        result = prime * result + ((getMainMenu() == null) ? 0 : getMainMenu().hashCode());
        result = prime * result + ((getSort() == null) ? 0 : getSort().hashCode());
        result = prime * result + ((getDeleted() == null) ? 0 : getDeleted().hashCode());
        result = prime * result + ((getRemark() == null) ? 0 : getRemark().hashCode());
        result = prime * result + ((getAddTime() == null) ? 0 : getAddTime().hashCode());
        result = prime * result + ((getUpdateTime() == null) ? 0 : getUpdateTime().hashCode());
        return result;
    }

    /**
     *
     */
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", name=").append(name);
        sb.append(", nid=").append(nid);
        sb.append(", pid=").append(pid);
        sb.append(", url=").append(url);
        sb.append(", mainMenu=").append(mainMenu);
        sb.append(", sort=").append(sort);
        sb.append(", deleted=").append(deleted);
        sb.append(", remark=").append(remark);
        sb.append(", addTime=").append(addTime);
        sb.append(", updateTime=").append(updateTime);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}