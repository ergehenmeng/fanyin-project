package com.fanyin.model.user;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 优惠券表
 * @author 二哥很猛
 */
public class DiscountCoupon implements Serializable {
    /**
     * 主键<br>
     * 表 : discount_coupon<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 用户id<br>
     * 表 : discount_coupon<br>
     * 对应字段 : user_id<br>
     */
    private Integer userId;

    /**
     *  优惠券类型 0:抵扣券 1:加息券
     *  表 : discount_coupon<br>
     *  对应字段 : type<br>
     */
    private Byte type;

    /**
     * 优惠券名称<br>
     * 表 : discount_coupon<br>
     * 对应字段 : name<br>
     */
    private String name;

    /**
     * 优惠券状态 0:未使用 1:已使用 2:已冻结,3已过期<br>
     * 表 : discount_coupon<br>
     * 对应字段 : status<br>
     */
    private Byte status;

    /**
     * 优惠券金额 抵扣券时表示元,加息券时表示%<br>
     * 表 : discount_coupon<br>
     * 对应字段 : face_value<br>
     */
    private BigDecimal faceValue;

    /**
     * 有效开始时间<br>
     * 表 : discount_coupon<br>
     * 对应字段 : start_time<br>
     */
    private Date startTime;

    /**
     * 失效时间 如果为空则永久有效<br>
     * 表 : discount_coupon<br>
     * 对应字段 : end_time<br>
     */
    private Date endTime;

    /**
     * 期限限制(月)<br>
     * 表 : discount_coupon<br>
     * 对应字段 : period_limit<br>
     */
    private Byte periodLimit;

    /**
     * 起投金额限制<br>
     * 表 : discount_coupon<br>
     * 对应字段 : amount_limit<br>
     */
    private BigDecimal amountLimit;

    /**
     * 发放时间<br>
     * 表 : discount_coupon<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    private static final long serialVersionUID = 1L;

    public Byte getType() {
        return type;
    }

    public void setType(Byte type) {
        this.type = type;
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
     * @return 用户id
     */
    public Integer getUserId() {
        return userId;
    }

    /**
     * @param userId  用户id
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    /**
     * @return 优惠券名称
     */
    public String getName() {
        return name;
    }

    /**
     * @param name  优惠券名称
     */
    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    /**
     * @return 优惠券状态 0:未使用 1:已使用 2:已冻结,3已过期
     */
    public Byte getStatus() {
        return status;
    }

    /**
     * @param status  优惠券状态 0:未使用 1:已使用 2:已冻结,3已过期
     */
    public void setStatus(Byte status) {
        this.status = status;
    }

    /**
     * @return 优惠券金额 抵扣券时表示元,加息券时表示%
     */
    public BigDecimal getFaceValue() {
        return faceValue;
    }

    /**
     * @param faceValue  优惠券金额 抵扣券时表示元,加息券时表示%
     */
    public void setFaceValue(BigDecimal faceValue) {
        this.faceValue = faceValue;
    }

    /**
     * @return 有效开始时间
     */
    public Date getStartTime() {
        return startTime;
    }

    /**
     * @param startTime  有效开始时间
     */
    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    /**
     * @return 失效时间 如果为空则永久有效
     */
    public Date getEndTime() {
        return endTime;
    }

    /**
     * @param endTime  失效时间 如果为空则永久有效
     */
    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    /**
     * @return 期限限制(月)
     */
    public Byte getPeriodLimit() {
        return periodLimit;
    }

    /**
     * @param periodLimit  期限限制(月)
     */
    public void setPeriodLimit(Byte periodLimit) {
        this.periodLimit = periodLimit;
    }

    /**
     * @return 起投金额限制
     */
    public BigDecimal getAmountLimit() {
        return amountLimit;
    }

    /**
     * @param amountLimit  起投金额限制
     */
    public void setAmountLimit(BigDecimal amountLimit) {
        this.amountLimit = amountLimit;
    }

    /**
     * @return 发放时间
     */
    public Date getAddTime() {
        return addTime;
    }

    /**
     * @param addTime  发放时间
     */
    public void setAddTime(Date addTime) {
        this.addTime = addTime;
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
        DiscountCoupon other = (DiscountCoupon) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getUserId() == null ? other.getUserId() == null : this.getUserId().equals(other.getUserId()))
            && (this.getName() == null ? other.getName() == null : this.getName().equals(other.getName()))
            && (this.getStatus() == null ? other.getStatus() == null : this.getStatus().equals(other.getStatus()))
            && (this.getFaceValue() == null ? other.getFaceValue() == null : this.getFaceValue().equals(other.getFaceValue()))
            && (this.getStartTime() == null ? other.getStartTime() == null : this.getStartTime().equals(other.getStartTime()))
            && (this.getEndTime() == null ? other.getEndTime() == null : this.getEndTime().equals(other.getEndTime()))
            && (this.getPeriodLimit() == null ? other.getPeriodLimit() == null : this.getPeriodLimit().equals(other.getPeriodLimit()))
            && (this.getAmountLimit() == null ? other.getAmountLimit() == null : this.getAmountLimit().equals(other.getAmountLimit()))
            && (this.getAddTime() == null ? other.getAddTime() == null : this.getAddTime().equals(other.getAddTime()));
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
        result = prime * result + ((getName() == null) ? 0 : getName().hashCode());
        result = prime * result + ((getStatus() == null) ? 0 : getStatus().hashCode());
        result = prime * result + ((getFaceValue() == null) ? 0 : getFaceValue().hashCode());
        result = prime * result + ((getStartTime() == null) ? 0 : getStartTime().hashCode());
        result = prime * result + ((getEndTime() == null) ? 0 : getEndTime().hashCode());
        result = prime * result + ((getPeriodLimit() == null) ? 0 : getPeriodLimit().hashCode());
        result = prime * result + ((getAmountLimit() == null) ? 0 : getAmountLimit().hashCode());
        result = prime * result + ((getAddTime() == null) ? 0 : getAddTime().hashCode());
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
        sb.append(", name=").append(name);
        sb.append(", status=").append(status);
        sb.append(", faceValue=").append(faceValue);
        sb.append(", startTime=").append(startTime);
        sb.append(", endTime=").append(endTime);
        sb.append(", periodLimit=").append(periodLimit);
        sb.append(", amountLimit=").append(amountLimit);
        sb.append(", addTime=").append(addTime);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}