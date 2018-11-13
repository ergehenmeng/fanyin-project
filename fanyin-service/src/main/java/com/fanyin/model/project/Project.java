package com.fanyin.model.project;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 项目信息表
 * @author 二哥很猛
 */
public class Project implements Serializable {
    /**
     * 主键产品ID<br>
     * 表 : project<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 借款人ID<br>
     * 表 : project<br>
     * 对应字段 : borrower_id<br>
     */
    private Integer borrowerId;

    /**
     * 产品编号<br>
     * 表 : project<br>
     * 对应字段 : nid<br>
     */
    private String nid;

    /**
     * 产品状态:-2:废弃-1:产品撤回,0待初审,1:待复审,2:募集中,3:满标待复审,4:还款中,5:还款完成,6:逾期结清<br>
     * 表 : project<br>
     * 对应字段 : status<br>
     */
    private Byte status;

    /**
     * 产品类型 0:个人贷,1:企业贷<br>
     * 表 : project<br>
     * 对应字段 : type<br>
     */
    private Byte type;

    /**
     * 产品名称<br>
     * 表 : project<br>
     * 对应字段 : name<br>
     */
    private String name;

    /**
     * 计划募集金额<br>
     * 表 : project<br>
     * 对应字段 : amount<br>
     */
    private BigDecimal amount;

    /**
     * 已募集金额<br>
     * 表 : project<br>
     * 对应字段 : raise_amount<br>
     */
    private BigDecimal raiseAmount;

    /**
     * 单次最小投标金额<br>
     * 表 : project<br>
     * 对应字段 : min_tender<br>
     */
    private BigDecimal minTender;

    /**
     * 产品基础利息 单位%<br>
     * 表 : project<br>
     * 对应字段 : apr<br>
     */
    private BigDecimal apr;

    /**
     * 平台加息利息 单位%<br>
     * 表 : project<br>
     * 对应字段 : platform_apr<br>
     */
    private BigDecimal platformApr;

    /**
     * 期限(月)<br>
     * 表 : project<br>
     * 对应字段 : period<br>
     */
    private Byte period;

    /**
     * 还款方式,0:等额本息,1:按月付息,到期还本,2:按天计息<br>
     * 表 : project<br>
     * 对应字段 : repayment_type<br>
     */
    private Byte repaymentType;

    /**
     * 产品信息录入时间<br>
     * 表 : project<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 预售时间(默认产品发布时间)<br>
     * 表 : project<br>
     * 对应字段 : presell_time<br>
     */
    private Date presellTime;

    /**
     * 产品发布时间(复审通过时间)<br>
     * 表 : project<br>
     * 对应字段 : publish_time<br>
     */
    private Date publishTime;

    /**
     * 满标复审时间<br>
     * 表 : project<br>
     * 对应字段 : recheck_time<br>
     */
    private Date recheckTime;

    /**
     * 产品完结时间(废弃,撤标,还款完成,逾期结清)等<br>
     * 表 : project<br>
     * 对应字段 : end_time<br>
     */
    private Date endTime;

    private static final long serialVersionUID = 1L;

    /**
     * @return 主键产品ID
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id  主键产品ID
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * @return 借款人ID
     */
    public Integer getBorrowerId() {
        return borrowerId;
    }

    /**
     * @param borrowerId  借款人ID
     */
    public void setBorrowerId(Integer borrowerId) {
        this.borrowerId = borrowerId;
    }

    /**
     * @return 产品编号
     */
    public String getNid() {
        return nid;
    }

    /**
     * @param nid  产品编号
     */
    public void setNid(String nid) {
        this.nid = nid == null ? null : nid.trim();
    }

    /**
     * @return 产品状态:-2:废弃-1:产品撤回,0待初审,1:待复审,2:募集中,3:满标待复审,4:还款中,5:还款完成,6:逾期结清
     */
    public Byte getStatus() {
        return status;
    }

    /**
     * @param status  产品状态:-2:废弃-1:产品撤回,0待初审,1:待复审,2:募集中,3:满标待复审,4:还款中,5:还款完成,6:逾期结清
     */
    public void setStatus(Byte status) {
        this.status = status;
    }

    /**
     * @return 产品类型 0:个人贷,1:企业贷
     */
    public Byte getType() {
        return type;
    }

    /**
     * @param type  产品类型 0:个人贷,1:企业贷
     */
    public void setType(Byte type) {
        this.type = type;
    }

    /**
     * @return 产品名称
     */
    public String getName() {
        return name;
    }

    /**
     * @param name  产品名称
     */
    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    /**
     * @return 计划募集金额
     */
    public BigDecimal getAmount() {
        return amount;
    }

    /**
     * @param amount  计划募集金额
     */
    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    /**
     * @return 已募集金额
     */
    public BigDecimal getRaiseAmount() {
        return raiseAmount;
    }

    /**
     * @param raiseAmount  已募集金额
     */
    public void setRaiseAmount(BigDecimal raiseAmount) {
        this.raiseAmount = raiseAmount;
    }

    /**
     * @return 单次最小投标金额
     */
    public BigDecimal getMinTender() {
        return minTender;
    }

    /**
     * @param minTender  单次最小投标金额
     */
    public void setMinTender(BigDecimal minTender) {
        this.minTender = minTender;
    }

    /**
     * @return 产品基础利息 单位%
     */
    public BigDecimal getApr() {
        return apr;
    }

    /**
     * @param apr  产品基础利息 单位%
     */
    public void setApr(BigDecimal apr) {
        this.apr = apr;
    }

    /**
     * @return 平台加息利息 单位%
     */
    public BigDecimal getPlatformApr() {
        return platformApr;
    }

    /**
     * @param platformApr  平台加息利息 单位%
     */
    public void setPlatformApr(BigDecimal platformApr) {
        this.platformApr = platformApr;
    }

    /**
     * @return 期限(月)
     */
    public Byte getPeriod() {
        return period;
    }

    /**
     * @param period  期限(月)
     */
    public void setPeriod(Byte period) {
        this.period = period;
    }

    /**
     * @return 还款方式,0:等额本息,1:按月付息,到期还本,2:按天计息
     */
    public Byte getRepaymentType() {
        return repaymentType;
    }

    /**
     * @param repaymentType  还款方式,0:等额本息,1:按月付息,到期还本,2:按天计息
     */
    public void setRepaymentType(Byte repaymentType) {
        this.repaymentType = repaymentType;
    }

    /**
     * @return 产品信息录入时间
     */
    public Date getAddTime() {
        return addTime;
    }

    /**
     * @param addTime  产品信息录入时间
     */
    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    /**
     * @return 预售时间(默认产品发布时间)
     */
    public Date getPresellTime() {
        return presellTime;
    }

    /**
     * @param presellTime  预售时间(默认产品发布时间)
     */
    public void setPresellTime(Date presellTime) {
        this.presellTime = presellTime;
    }

    /**
     * @return 产品发布时间(复审通过时间)
     */
    public Date getPublishTime() {
        return publishTime;
    }

    /**
     * @param publishTime  产品发布时间(复审通过时间)
     */
    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    /**
     * @return 满标复审时间
     */
    public Date getRecheckTime() {
        return recheckTime;
    }

    /**
     * @param recheckTime  满标复审时间
     */
    public void setRecheckTime(Date recheckTime) {
        this.recheckTime = recheckTime;
    }

    /**
     * @return 产品完结时间(废弃,撤标,还款完成,逾期结清)等
     */
    public Date getEndTime() {
        return endTime;
    }

    /**
     * @param endTime  产品完结时间(废弃,撤标,还款完成,逾期结清)等
     */
    public void setEndTime(Date endTime) {
        this.endTime = endTime;
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
        Project other = (Project) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getBorrowerId() == null ? other.getBorrowerId() == null : this.getBorrowerId().equals(other.getBorrowerId()))
            && (this.getNid() == null ? other.getNid() == null : this.getNid().equals(other.getNid()))
            && (this.getStatus() == null ? other.getStatus() == null : this.getStatus().equals(other.getStatus()))
            && (this.getType() == null ? other.getType() == null : this.getType().equals(other.getType()))
            && (this.getName() == null ? other.getName() == null : this.getName().equals(other.getName()))
            && (this.getAmount() == null ? other.getAmount() == null : this.getAmount().equals(other.getAmount()))
            && (this.getRaiseAmount() == null ? other.getRaiseAmount() == null : this.getRaiseAmount().equals(other.getRaiseAmount()))
            && (this.getMinTender() == null ? other.getMinTender() == null : this.getMinTender().equals(other.getMinTender()))
            && (this.getApr() == null ? other.getApr() == null : this.getApr().equals(other.getApr()))
            && (this.getPlatformApr() == null ? other.getPlatformApr() == null : this.getPlatformApr().equals(other.getPlatformApr()))
            && (this.getPeriod() == null ? other.getPeriod() == null : this.getPeriod().equals(other.getPeriod()))
            && (this.getRepaymentType() == null ? other.getRepaymentType() == null : this.getRepaymentType().equals(other.getRepaymentType()))
            && (this.getAddTime() == null ? other.getAddTime() == null : this.getAddTime().equals(other.getAddTime()))
            && (this.getPresellTime() == null ? other.getPresellTime() == null : this.getPresellTime().equals(other.getPresellTime()))
            && (this.getPublishTime() == null ? other.getPublishTime() == null : this.getPublishTime().equals(other.getPublishTime()))
            && (this.getRecheckTime() == null ? other.getRecheckTime() == null : this.getRecheckTime().equals(other.getRecheckTime()))
            && (this.getEndTime() == null ? other.getEndTime() == null : this.getEndTime().equals(other.getEndTime()));
    }

    /**
     *
     */
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getBorrowerId() == null) ? 0 : getBorrowerId().hashCode());
        result = prime * result + ((getNid() == null) ? 0 : getNid().hashCode());
        result = prime * result + ((getStatus() == null) ? 0 : getStatus().hashCode());
        result = prime * result + ((getType() == null) ? 0 : getType().hashCode());
        result = prime * result + ((getName() == null) ? 0 : getName().hashCode());
        result = prime * result + ((getAmount() == null) ? 0 : getAmount().hashCode());
        result = prime * result + ((getRaiseAmount() == null) ? 0 : getRaiseAmount().hashCode());
        result = prime * result + ((getMinTender() == null) ? 0 : getMinTender().hashCode());
        result = prime * result + ((getApr() == null) ? 0 : getApr().hashCode());
        result = prime * result + ((getPlatformApr() == null) ? 0 : getPlatformApr().hashCode());
        result = prime * result + ((getPeriod() == null) ? 0 : getPeriod().hashCode());
        result = prime * result + ((getRepaymentType() == null) ? 0 : getRepaymentType().hashCode());
        result = prime * result + ((getAddTime() == null) ? 0 : getAddTime().hashCode());
        result = prime * result + ((getPresellTime() == null) ? 0 : getPresellTime().hashCode());
        result = prime * result + ((getPublishTime() == null) ? 0 : getPublishTime().hashCode());
        result = prime * result + ((getRecheckTime() == null) ? 0 : getRecheckTime().hashCode());
        result = prime * result + ((getEndTime() == null) ? 0 : getEndTime().hashCode());
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
        sb.append(", borrowerId=").append(borrowerId);
        sb.append(", nid=").append(nid);
        sb.append(", status=").append(status);
        sb.append(", type=").append(type);
        sb.append(", name=").append(name);
        sb.append(", amount=").append(amount);
        sb.append(", raiseAmount=").append(raiseAmount);
        sb.append(", minTender=").append(minTender);
        sb.append(", apr=").append(apr);
        sb.append(", platformApr=").append(platformApr);
        sb.append(", period=").append(period);
        sb.append(", repaymentType=").append(repaymentType);
        sb.append(", addTime=").append(addTime);
        sb.append(", presellTime=").append(presellTime);
        sb.append(", publishTime=").append(publishTime);
        sb.append(", recheckTime=").append(recheckTime);
        sb.append(", endTime=").append(endTime);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}