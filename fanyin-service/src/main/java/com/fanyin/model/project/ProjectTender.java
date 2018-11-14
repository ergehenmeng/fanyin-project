package com.fanyin.model.project;

import com.fanyin.model.user.DiscountCoupon;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 投标信息表
 * @author 二哥很猛
 */
public class ProjectTender implements Serializable {
    /**
     * 主键<br>
     * 表 : project_tender<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 用户ID<br>
     * 表 : project_tender<br>
     * 对应字段 : user_id<br>
     */
    private Integer userId;

    /**
     * 标的id<br>
     * 表 : project_tender<br>
     * 对应字段 : project_id<br>
     */
    private Integer projectId;

    /**
     * 投标金额(元)<br>
     * 表 : project_tender<br>
     * 对应字段 : account<br>
     */
    private BigDecimal account;

    /**
     * 基础收益(预计收益)<br>
     * 表 : project_tender<br>
     * 对应字段 : base_interest<br>
     */
    private BigDecimal baseInterest;

    /**
     * 平台加息收益(预计收益)<br>
     * 表 : project_tender<br>
     * 对应字段 : platform_interest<br>
     */
    private BigDecimal platformInterest;

    /**
     * 加息券收益(预计收益)<br>
     * 表 : project_tender<br>
     * 对应字段 : coupon_interest<br>
     */
    private BigDecimal couponInterest;

    /**
     * 抵扣券收益
     */
    private BigDecimal voucherInterest;

    /**
     * 投标状态:-3标的撤销,-2:已转让,-1:转让申请中,0:投标加入,1:回款中,2:还款完成<br>
     * 表 : project_tender<br>
     * 对应字段 : status<br>
     */
    private Byte status;

    /**
     * 投标渠道 pc,android,ios,h5,other<br>
     * 表 : project_tender<br>
     * 对应字段 : channel<br>
     */
    private String channel;

    /**
     * 投标ip<br>
     * 表 : project_tender<br>
     * 对应字段 : ip<br>
     */
    private String ip;

    /**
     * 投标时间<br>
     * 表 : project_tender<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 更新时间<br>
     * 表 : project_tender<br>
     * 对应字段 : update_time<br>
     */
    private Date updateTime;

    /**
     * 投标使用的优惠券
     */
    private List<DiscountCoupon> couponList;

    private static final long serialVersionUID = 1L;

    public BigDecimal getVoucherInterest() {
        return voucherInterest;
    }

    public void setVoucherInterest(BigDecimal voucherInterest) {
        this.voucherInterest = voucherInterest;
    }

    public List<DiscountCoupon> getCouponList() {
        return couponList;
    }

    public void setCouponList(List<DiscountCoupon> couponList) {
        this.couponList = couponList;
    }

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
     * @return 用户ID
     */
    public Integer getUserId() {
        return userId;
    }

    /**
     * @param userId  用户ID
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    /**
     * @return 标的id
     */
    public Integer getProjectId() {
        return projectId;
    }

    /**
     * @param projectId  标的id
     */
    public void setProjectId(Integer projectId) {
        this.projectId = projectId;
    }

    /**
     * @return 投标金额(元)
     */
    public BigDecimal getAccount() {
        return account;
    }

    /**
     * @param account  投标金额(元)
     */
    public void setAccount(BigDecimal account) {
        this.account = account;
    }

    /**
     * @return 基础收益(预计收益)
     */
    public BigDecimal getBaseInterest() {
        return baseInterest;
    }

    /**
     * @param baseInterest  基础收益(预计收益)
     */
    public void setBaseInterest(BigDecimal baseInterest) {
        this.baseInterest = baseInterest;
    }

    /**
     * @return 平台加息收益(预计收益)
     */
    public BigDecimal getPlatformInterest() {
        return platformInterest;
    }

    /**
     * @param platformInterest  平台加息收益(预计收益)
     */
    public void setPlatformInterest(BigDecimal platformInterest) {
        this.platformInterest = platformInterest;
    }

    /**
     * @return 加息券收益(预计收益)
     */
    public BigDecimal getCouponInterest() {
        return couponInterest;
    }

    /**
     * @param couponInterest  加息券收益(预计收益)
     */
    public void setCouponInterest(BigDecimal couponInterest) {
        this.couponInterest = couponInterest;
    }

    /**
     * @return 投标状态:-3标的撤销,-2:已转让,-1:转让申请中,0:投标加入,1:回款中,2:还款完成
     */
    public Byte getStatus() {
        return status;
    }

    /**
     * @param status  投标状态:-3标的撤销,-2:已转让,-1:转让申请中,0:投标加入,1:回款中,2:还款完成
     */
    public void setStatus(Byte status) {
        this.status = status;
    }

    /**
     * @return 投标渠道 pc,android,ios,h5,other
     */
    public String getChannel() {
        return channel;
    }

    /**
     * @param channel  投标渠道 pc,android,ios,h5,other
     */
    public void setChannel(String channel) {
        this.channel = channel == null ? null : channel.trim();
    }

    /**
     * @return 投标ip
     */
    public String getIp() {
        return ip;
    }

    /**
     * @param ip  投标ip
     */
    public void setIp(String ip) {
        this.ip = ip == null ? null : ip.trim();
    }

    /**
     * @return 投标时间
     */
    public Date getAddTime() {
        return addTime;
    }

    /**
     * @param addTime  投标时间
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
        ProjectTender other = (ProjectTender) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getUserId() == null ? other.getUserId() == null : this.getUserId().equals(other.getUserId()))
            && (this.getProjectId() == null ? other.getProjectId() == null : this.getProjectId().equals(other.getProjectId()))
            && (this.getAccount() == null ? other.getAccount() == null : this.getAccount().equals(other.getAccount()))
            && (this.getBaseInterest() == null ? other.getBaseInterest() == null : this.getBaseInterest().equals(other.getBaseInterest()))
            && (this.getPlatformInterest() == null ? other.getPlatformInterest() == null : this.getPlatformInterest().equals(other.getPlatformInterest()))
            && (this.getCouponInterest() == null ? other.getCouponInterest() == null : this.getCouponInterest().equals(other.getCouponInterest()))
            && (this.getStatus() == null ? other.getStatus() == null : this.getStatus().equals(other.getStatus()))
            && (this.getChannel() == null ? other.getChannel() == null : this.getChannel().equals(other.getChannel()))
            && (this.getIp() == null ? other.getIp() == null : this.getIp().equals(other.getIp()))
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
        result = prime * result + ((getUserId() == null) ? 0 : getUserId().hashCode());
        result = prime * result + ((getProjectId() == null) ? 0 : getProjectId().hashCode());
        result = prime * result + ((getAccount() == null) ? 0 : getAccount().hashCode());
        result = prime * result + ((getBaseInterest() == null) ? 0 : getBaseInterest().hashCode());
        result = prime * result + ((getPlatformInterest() == null) ? 0 : getPlatformInterest().hashCode());
        result = prime * result + ((getCouponInterest() == null) ? 0 : getCouponInterest().hashCode());
        result = prime * result + ((getStatus() == null) ? 0 : getStatus().hashCode());
        result = prime * result + ((getChannel() == null) ? 0 : getChannel().hashCode());
        result = prime * result + ((getIp() == null) ? 0 : getIp().hashCode());
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
        sb.append(", userId=").append(userId);
        sb.append(", projectId=").append(projectId);
        sb.append(", account=").append(account);
        sb.append(", baseInterest=").append(baseInterest);
        sb.append(", platformInterest=").append(platformInterest);
        sb.append(", couponInterest=").append(couponInterest);
        sb.append(", status=").append(status);
        sb.append(", channel=").append(channel);
        sb.append(", ip=").append(ip);
        sb.append(", addTime=").append(addTime);
        sb.append(", updateTime=").append(updateTime);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}