package com.fanyin.service.project;


import com.fanyin.model.project.Project;
import com.fanyin.model.project.ProjectTender;
import com.fanyin.model.user.DiscountCoupon;

import java.math.BigDecimal;
import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/11/13 13:39
 */
public interface ProjectTenderService {

    /**
     * 更新投标信息 不为空更新
     * @param tenderList 投标信息
     */
    void updateTender(ProjectTender tenderList);

    /**
     * 计算投标产生的利息 基础利息,平台加息,加息券加息<br>
     * 将计算的结果放入到tender对象指定字段内
     * 注意投标信息必须关联优惠券 可通过{@link ProjectTenderService#getByIdWithCoupon(int, int)}查询
     * @param tender 投标信息
     * @param project 产品信息
     */
    void calcTenderInterest(ProjectTender tender, Project project);

    /**
     * 获取优惠券中加息券利率
     * @param couponList 投标使用的优惠券列表
     * @return 加息券利率
     */
    double getDiscountCouponApr(List<DiscountCoupon> couponList);

    /**
     * 根据产品id查询投标信息,包含加息券信息<br>
     * 非必需使用优惠券信息,请采用{@link ProjectTenderService#getByProjectId(int)}
     * @param projectId 产品id
     * @return 投标列表
     */
    List<ProjectTender> getByProjectIdWithCoupon(int projectId);

    /**
     * 根据产品id查询投标信息,包含加息券信息
     * @param projectId 产品id
     * @return 投标列表
     */
    List<ProjectTender> getByProjectId(int projectId);

    /**
     * 获取优惠券中抵扣券金额
     * @param couponList 优惠券
     * @return 抵扣券
     */
    BigDecimal getDiscountVoucher(List<DiscountCoupon> couponList);

    /**
     * 根据主键查询用户的投标信息 包含优惠券使用情况<br/>
     * 非必需使用优惠券信息,请采用{@link ProjectTenderService#getById(int, int)}
     * @param userId   用户id
     * @param tenderId 投标信息
     * @return 投标信息
     */
    ProjectTender getByIdWithCoupon(int userId,int tenderId);

    /**
     * 根据主键查询用户的投标信息,不包含关联的优惠券信息
     * @param userId 用户id
     * @param tenderId 投标id
     * @return 投标信息
     */
    ProjectTender getById(int userId,int tenderId);

    /**
     * 根据主键查询投标信息,不包含关联的优惠券信息
     * @param tenderId 投标id
     * @return 投标信息
     */
    ProjectTender selectByPrimaryKey(int tenderId);
}

