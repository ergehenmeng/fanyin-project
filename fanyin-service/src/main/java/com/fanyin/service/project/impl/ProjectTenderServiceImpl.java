package com.fanyin.service.project.impl;

import com.fanyin.constants.CouponConstant;
import com.fanyin.constants.TenderConstant;
import com.fanyin.dto.tender.Tender;
import com.fanyin.dto.tender.TenderResponse;
import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.enums.ProjectStatus;
import com.fanyin.enums.RepaymentType;
import com.fanyin.exception.BusinessException;
import com.fanyin.mapper.project.ProjectTenderMapper;
import com.fanyin.model.project.Project;
import com.fanyin.model.project.ProjectPlan;
import com.fanyin.model.project.ProjectTender;
import com.fanyin.model.user.Account;
import com.fanyin.model.user.DiscountCoupon;
import com.fanyin.model.user.DiscountCouponTender;
import com.fanyin.queue.TaskQueue;
import com.fanyin.queue.task.TenderTask;
import com.fanyin.service.project.ProjectService;
import com.fanyin.service.project.ProjectTenderService;
import com.fanyin.service.system.RedisCacheService;
import com.fanyin.service.user.AccountDetailLogService;
import com.fanyin.service.user.AccountService;
import com.fanyin.service.user.DiscountCouponService;
import com.fanyin.utils.DateUtil;
import com.fanyin.utils.ProjectUtil;
import com.google.common.collect.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * 投标
 * @author 二哥很猛
 * @date 2018/11/13 13:39
 */
@Service("projectTenderService")
public class ProjectTenderServiceImpl implements ProjectTenderService {

    @Autowired
    private ProjectTenderMapper projectTenderMapper;

    @Autowired
    private DiscountCouponService discountCouponService;

    @Autowired
    private ProjectService projectService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private RedisCacheService redisCacheService;

    @Autowired
    private AccountDetailLogService accountDetailLogService;


    @Override
    public List<ProjectTender> getByProjectIdWithCoupon(int projectId) {
        return projectTenderMapper.getByProjectIdWithCoupon(projectId);
    }

    @Override
    public List<ProjectTender> getByProjectId(int projectId) {
        return projectTenderMapper.getByProjectId(projectId);
    }

    @Override
    public void updateTender(ProjectTender tender) {
        projectTenderMapper.updateByPrimaryKeySelective(tender);
    }

    @Override
    public void calcTenderInterest(ProjectTender tender, Project project) {
        double couponApr = this.getDiscountCouponApr(tender.getCouponList());

        double baseInterest;
        double platformInterest;
        double couponInterest;

        if(project.getRepaymentType() == RepaymentType.EQUAL_AMOUNT.getMode()){
            //等额本息
            baseInterest = ProjectUtil.equalAmountOfInterest(tender.getAccount().doubleValue(), project.getPeriod(), project.getApr().doubleValue());
            platformInterest = ProjectUtil.equalAmountOfInterest(tender.getAccount().doubleValue(), project.getPeriod(), project.getPlatformApr().doubleValue());
            couponInterest = ProjectUtil.equalAmountOfInterest(tender.getAccount().doubleValue(), project.getPeriod(), couponApr);

        }else if (project.getRepaymentType() == RepaymentType.MONTHLY.getMode()){
            //按月付息
            baseInterest = ProjectUtil.monthlyInterest(tender.getAccount().doubleValue(), project.getPeriod(), project.getApr().doubleValue());
            platformInterest = ProjectUtil.monthlyInterest(tender.getAccount().doubleValue(), project.getPeriod(), project.getPlatformApr().doubleValue());
            couponInterest = ProjectUtil.monthlyInterest(tender.getAccount().doubleValue(), project.getPeriod(), couponApr);

        }else{
            //按天计息
            baseInterest = ProjectUtil.dailyInterest(tender.getAccount().doubleValue(), project.getPeriod(), project.getApr().doubleValue());
            platformInterest = ProjectUtil.dailyInterest(tender.getAccount().doubleValue(), project.getPeriod(), project.getPlatformApr().doubleValue());
            couponInterest = ProjectUtil.dailyInterest(tender.getAccount().doubleValue(), project.getPeriod(), couponApr);
        }
        BigDecimal voucher = this.getDiscountVoucher(tender.getCouponList());
        tender.setVoucherInterest(voucher);
        tender.setBaseInterest(BigDecimal.valueOf(baseInterest));
        tender.setPlatformInterest(BigDecimal.valueOf(platformInterest));
        tender.setCouponInterest(BigDecimal.valueOf(couponInterest));
    }

    @Override
    public void calcTenderInterest(ProjectTender tender, List<ProjectPlan> recoverList) {
        BigDecimal voucher = this.getDiscountVoucher(tender.getCouponList());
        tender.setVoucherInterest(voucher);
        BigDecimal baseInterest = BigDecimal.ZERO;
        BigDecimal platformInterest = BigDecimal.ZERO;
        BigDecimal couponInterest = BigDecimal.ZERO;
        for (ProjectPlan projectPlan : recoverList) {
            baseInterest = baseInterest.add(projectPlan.getBaseInterest());
            platformInterest = platformInterest.add(projectPlan.getPlatformInterest());
            couponInterest = couponInterest.add(projectPlan.getCouponInterest());
        }
        tender.setBaseInterest(baseInterest);
        tender.setPlatformInterest(platformInterest);
        tender.setCouponInterest(couponInterest);
    }

    /**
     * 获取优惠券中加息券利率
     * @param couponList 投标使用的优惠券列表
     * @return 加息券利率
     */
    @Override
    public double getDiscountCouponApr(List<DiscountCoupon> couponList){
        if(couponList == null || couponList.size() == 0){
            return 0D;
        }
        for (DiscountCoupon coupon : couponList) {
            if(coupon.getClassify() == CouponConstant.CLASSIFY_INTEREST){
                return coupon.getFaceValue().doubleValue();
            }
        }
        return 0D;
    }

    @Override
    public BigDecimal getDiscountVoucher(List<DiscountCoupon> couponList) {
        if(couponList == null || couponList.size() == 0){
            return BigDecimal.ZERO;
        }
        for (DiscountCoupon coupon : couponList) {
            if(coupon.getClassify() == CouponConstant.CLASSIFY_DEDUCTION){
                return coupon.getFaceValue();
            }
        }
        return BigDecimal.ZERO;
    }

    @Override
    public ProjectTender getByIdWithCoupon(int userId, int tenderId) {
        return projectTenderMapper.getByIdWithCoupon(userId,tenderId);
    }

    @Override
    public ProjectTender getById(int userId, int tenderId) {
        return projectTenderMapper.getById(userId,tenderId);
    }

    @Override
    public ProjectTender selectByPrimaryKey(int tenderId) {
        return projectTenderMapper.selectByPrimaryKey(tenderId);
    }

    @Override
    public BigDecimal getTotalTender(int userId) {
        return projectTenderMapper.getTotalTender(userId);
    }


    @Override
    public String invest(Tender request) {
        Project project = projectService.getById(request.getProjectId());
        //产品校验
        projectService.verifyProject(project,request);
        //实际冻结金额
        BigDecimal realAmount = BigDecimal.valueOf(request.getAmount());
        if(request.getCouponId() != null){
            DiscountCoupon coupon = discountCouponService.getById(request.getCouponId(), request.getUserId());
            //优惠券校验
            discountCouponService.verifyDiscountCoupon(coupon,request.getAmount(),project.getPeriod());
            if(coupon.getClassify() == CouponConstant.CLASSIFY_DEDUCTION){
                realAmount = realAmount.subtract(coupon.getFaceValue());
            }
        }
        Account account = accountService.getByUserId(request.getUserId());
        if(account.getAvailableBalance().compareTo(realAmount) < 0){
            throw new BusinessException(ErrorCodeEnum.ACCOUNT_NOT_ENOUGH);
        }
        String key = UUID.randomUUID().toString();
        request.setKey(key);
        TaskQueue.executePointAward(new TenderTask(request));
        return key;
    }

    @Override
    public void doInvest(Tender request) {
        Project project = projectService.getById(request.getProjectId());
        //产品额度校验
        projectService.verifyTenderProject(project,request);
        //实际付款金额
        BigDecimal realAmount = BigDecimal.valueOf(request.getAmount());
        //优惠券
        DiscountCoupon coupon = null;
        //抵扣金额
        BigDecimal voucherValue = BigDecimal.ZERO;
        if(request.getCouponId() != null){
            //再次校验
            coupon = discountCouponService.getById(request.getCouponId(), request.getUserId());
            discountCouponService.verifyDiscountCoupon(coupon,request.getAmount(),project.getPeriod());
            if(coupon.getClassify() == CouponConstant.CLASSIFY_DEDUCTION){
                realAmount = realAmount.subtract(coupon.getFaceValue());
                voucherValue = coupon.getFaceValue();
            }
        }
        //可用余额校验
        Account account = accountService.getByUserId(request.getUserId());
        if(account.getAvailableBalance().compareTo(realAmount) < 0){
            throw new BusinessException(ErrorCodeEnum.ACCOUNT_NOT_ENOUGH);
        }

        //投标金额
        BigDecimal tenderAmount = BigDecimal.valueOf(request.getAmount());
        Date now = DateUtil.getNow();
        //插入投标信息
        ProjectTender tender = new ProjectTender();
        tender.setState(TenderConstant.TENDER_STATUS_0);
        tender.setUserId(request.getUserId());
        tender.setAddTime(now);
        tender.setAccount(tenderAmount);
        tender.setProjectId(request.getProjectId());
        tender.setIp(request.getIp());
        tender.setChannel(request.getChannel());
        projectTenderMapper.insertSelective(tender);

        if(coupon != null){
            coupon.setState(CouponConstant.COUPON_STATUS_1);
            //更新优惠券状态
            discountCouponService.updateDiscountCoupon(coupon);
            DiscountCouponTender couponTender = new DiscountCouponTender();
            couponTender.setAddTime(now);
            couponTender.setDiscountCouponId(coupon.getId());
            couponTender.setTenderId(tender.getId());
            //插入优惠券关联信息
            discountCouponService.addDiscountCouponTender(couponTender);

            tender.setCouponList(Lists.newArrayList(coupon));
        }

        project.setRaiseAmount(project.getRaiseAmount().add(tenderAmount));
        if(project.getAmount().compareTo(project.getRaiseAmount()) == 0){
            project.setState(ProjectStatus.FULL.getCode());
        }
        projectService.updateProject(project);
        //此处设置抵扣券金额,在实际冻结金额时使用,
        tender.setVoucherInterest(voucherValue);
        //冻结资金
        accountDetailLogService.tenderFreeze(tender);
        this.packageResponse(project,tender,request.getKey());
    }

    /**
     * 将投标结果组装并保存在缓存中,以便于前台查询获取结果
     * @param project 产品信息
     * @param tender 投标信息
     * @param key 结果唯一key
     */
    private void packageResponse(Project project,ProjectTender tender,String key){
        TenderResponse response = new TenderResponse();
        response.setKey(key);
        response.setCode(200);
        response.setAmount(tender.getAccount().doubleValue());
        response.setDiscountCoupon(tender.getCouponList());
        response.setUserId(tender.getUserId());
        response.setProjectId(project.getId());
        response.setRealAmount(tender.getAccount().subtract(tender.getVoucherInterest()).doubleValue());
        redisCacheService.cacheAsyncResponse(response);
    }

}
