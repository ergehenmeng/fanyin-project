package com.fanyin.model.user;

import java.io.Serializable;

/**
 * 用户附件信息表
 * @author 二哥很猛
 */
public class UserExtend implements Serializable {
    /**
     * 主键<br>
     * 表 : user_extend<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 投资人用户ID<br>
     * 表 : user_extend<br>
     * 对应字段 : user_id<br>
     */
    private Integer userId;

    /**
     * 头像地址<br>
     * 表 : user_extend<br>
     * 对应字段 : avatar<br>
     */
    private String avatar;

    /**
     * 真实姓名<br>
     * 表 : user_extend<br>
     * 对应字段 : real_name<br>
     */
    private String realName;

    /**
     * 身份证号码(前10位加密[18位身份证],前8位加密[15位身份证])<br>
     * 表 : user_extend<br>
     * 对应字段 : id_card<br>
     */
    private String idCard;

    /**
     * 可用积分总数<br>
     * 表 : user_extend<br>
     * 对应字段 : integral_num<br>
     */
    private Integer integralNum;

    /**
     * 免费提现次数<br>
     * 表 : user_extend<br>
     * 对应字段 : cash_num<br>
     */
    private Short cashNum;

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
     * @return 投资人用户ID
     */
    public Integer getUserId() {
        return userId;
    }

    /**
     * @param userId  投资人用户ID
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    /**
     * @return 头像地址
     */
    public String getAvatar() {
        return avatar;
    }

    /**
     * @param avatar  头像地址
     */
    public void setAvatar(String avatar) {
        this.avatar = avatar == null ? null : avatar.trim();
    }

    /**
     * @return 真实姓名
     */
    public String getRealName() {
        return realName;
    }

    /**
     * @param realName  真实姓名
     */
    public void setRealName(String realName) {
        this.realName = realName == null ? null : realName.trim();
    }

    /**
     * @return 身份证号码(前10位加密[18位身份证],前8位加密[15位身份证])
     */
    public String getIdCard() {
        return idCard;
    }

    /**
     * @param idCard  身份证号码(前10位加密[18位身份证],前8位加密[15位身份证])
     */
    public void setIdCard(String idCard) {
        this.idCard = idCard == null ? null : idCard.trim();
    }

    /**
     * @return 可用积分总数
     */
    public Integer getIntegralNum() {
        return integralNum;
    }

    /**
     * @param integralNum  可用积分总数
     */
    public void setIntegralNum(Integer integralNum) {
        this.integralNum = integralNum;
    }

    /**
     * @return 免费提现次数
     */
    public Short getCashNum() {
        return cashNum;
    }

    /**
     * @param cashNum  免费提现次数
     */
    public void setCashNum(Short cashNum) {
        this.cashNum = cashNum;
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
        UserExtend other = (UserExtend) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getUserId() == null ? other.getUserId() == null : this.getUserId().equals(other.getUserId()))
            && (this.getAvatar() == null ? other.getAvatar() == null : this.getAvatar().equals(other.getAvatar()))
            && (this.getRealName() == null ? other.getRealName() == null : this.getRealName().equals(other.getRealName()))
            && (this.getIdCard() == null ? other.getIdCard() == null : this.getIdCard().equals(other.getIdCard()))
            && (this.getIntegralNum() == null ? other.getIntegralNum() == null : this.getIntegralNum().equals(other.getIntegralNum()))
            && (this.getCashNum() == null ? other.getCashNum() == null : this.getCashNum().equals(other.getCashNum()));
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
        result = prime * result + ((getAvatar() == null) ? 0 : getAvatar().hashCode());
        result = prime * result + ((getRealName() == null) ? 0 : getRealName().hashCode());
        result = prime * result + ((getIdCard() == null) ? 0 : getIdCard().hashCode());
        result = prime * result + ((getIntegralNum() == null) ? 0 : getIntegralNum().hashCode());
        result = prime * result + ((getCashNum() == null) ? 0 : getCashNum().hashCode());
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
        sb.append(", avatar=").append(avatar);
        sb.append(", realName=").append(realName);
        sb.append(", idCard=").append(idCard);
        sb.append(", integralNum=").append(integralNum);
        sb.append(", cashNum=").append(cashNum);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}