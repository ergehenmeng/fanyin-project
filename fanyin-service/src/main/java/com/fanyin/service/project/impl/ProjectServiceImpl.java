package com.fanyin.service.project.impl;

import com.fanyin.constants.TenderConstant;
import com.fanyin.dto.project.ProjectAudit;
import com.fanyin.dto.project.TenderStatistics;
import com.fanyin.dto.tender.Tender;
import com.fanyin.dto.user.IntegralAward;
import com.fanyin.enums.*;
import com.fanyin.exception.BusinessException;
import com.fanyin.mapper.project.ProjectMapper;
import com.fanyin.model.project.Project;
import com.fanyin.model.project.ProjectAuditLog;
import com.fanyin.model.project.ProjectPlan;
import com.fanyin.model.project.ProjectTender;
import com.fanyin.model.user.DiscountCoupon;
import com.fanyin.queue.TaskQueue;
import com.fanyin.queue.task.IntegralAwardTask;
import com.fanyin.service.borrower.BorrowerAccountLogService;
import com.fanyin.service.project.*;
import com.fanyin.service.user.AccountDetailLogService;
import com.fanyin.service.user.IntegralLogService;
import com.fanyin.service.user.UserExtendService;
import com.fanyin.utils.DateUtil;
import com.fanyin.utils.ProjectUtil;
import com.fanyin.utils.StringUtil;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 产品service
 * @author 二哥很猛
 */
@Service("projectService")
@Slf4j
@Transactional(rollbackFor = RuntimeException.class)
public class ProjectServiceImpl implements ProjectService {

    @Autowired
    private ProjectMapper projectMapper;

    @Autowired
    private ProjectAuditLogService projectAuditLogService;

    @Autowired
    private ProjectTenderService projectTenderService;

    @Autowired
    private ProjectRecoverService projectRecoverService;

    @Autowired
    private ProjectRepaymentService projectRepaymentService;

    @Autowired
    private ProjectTenderStatisticsService projectTenderStatisticsService;

    @Autowired
    private IntegralLogService integralLogService;

    @Autowired
    private AccountDetailLogService accountDetailLogService;

    @Autowired
    private BorrowerAccountLogService borrowerAccountLogService;

    @Autowired
    private UserExtendService userExtendService;

    /**
     * 起始编号
     */
    private int startPoint = 1;

    @Override
    @Transactional(readOnly = true,rollbackFor = RuntimeException.class)
    public Project getByNid(String nid) {
        return projectMapper.getByNid(nid);
    }

    @Override
    @Transactional(readOnly = true,rollbackFor = RuntimeException.class)
    public Project getById(int id) {
        return projectMapper.selectByPrimaryKey(id);
    }

    @Override
    public void fullAuditSuccess(Project project) {
        this.verifyFullProject(project);
        //查询投标信息 必须包含加息券 这样计算利息才正常
        List<ProjectTender> tenderList = projectTenderService.getByProjectIdWithCoupon(project.getId());
        //还款列表
        Map<Integer,ProjectPlan> repaymentMap = Maps.newHashMap();

        tenderList.forEach(projectTender -> {
            //生成回款列表
            List<ProjectPlan> recoverList = this.createRecoverList(projectTender, project);
            //通过回款列表生成还款列表
            ProjectUtil.repaymentList(recoverList,repaymentMap);
            //插入回款
            projectRecoverService.addBatchRecover(recoverList,projectTender.getUserId(),project.getId(),projectTender.getId());
            //计算投标预计收益
            projectTenderService.calcTenderInterest(projectTender, recoverList);
            projectTender.setState(TenderConstant.TENDER_STATUS_1);
            //更新投标信息
            projectTenderService.updateTender(projectTender);
            //投标积分奖励
            this.awardTenderIntegral(projectTender);
            //解冻投资人资金,待收增加
            accountDetailLogService.fullAuditUnfreeze(projectTender);
        });
        //插入还款信息
        projectRepaymentService.addBatchRepayment(repaymentMap.values(),project.getId(),project.getBorrowerId());
        //放款到借款人
        borrowerAccountLogService.loanSuccess(project);
        //计算首投,最高投,扫尾
        TenderStatistics tenderStatistics = projectTenderStatisticsService.calcTenderStatistics(tenderList);
        //插入首投,最高投,扫尾
        projectTenderStatisticsService.addTenderStatistics(tenderStatistics);
        //奖励积分
        this.awardFirstMaxLastIntegral(tenderStatistics);
        //更新用户等级
        this.filterAndUpdateGrade(tenderList);
    }


    @Override
    public void awardFirstMaxLastIntegral(TenderStatistics tenderStatistics){
        this.awardIntegral(tenderStatistics.getFirst().getUserId(),Integral.FIRST_TENDER);
        this.awardIntegral(tenderStatistics.getMax().getUserId(),Integral.MAX_TENDER);
        this.awardIntegral(tenderStatistics.getLast().getUserId(),Integral.LAST_TENDER);
    }



    /**
     * 投标 校验产品信息
     * @param project 产品信息
     */
    @Override
    @Transactional(readOnly = true,rollbackFor = RuntimeException.class)
    public void verifyProject(Project project, Tender request) {
        if(project == null){
            throw new BusinessException(ErrorCodeEnum.PROJECT_FOUND_ERROR);
        }
        //预售时间
        if(project.getPreSaleTime().after(DateUtil.getNow())){
            throw new BusinessException(ErrorCodeEnum.PROJECT_PRE_SALE);
        }
        this.verifyTenderProject(project,request);
    }

    @Override
    @Transactional(readOnly = true,rollbackFor = RuntimeException.class)
    public void verifyTenderProject(Project project, Tender request) {
        //满标状态
        if(project.getState() == ProjectStatus.FULL.getCode()){
            throw new BusinessException(ErrorCodeEnum.PROJECT_FULL_ERROR);
        }
        //募集中状态
        if(project.getState() != ProjectStatus.RAISE.getCode()){
            throw new BusinessException(ErrorCodeEnum.PROJECT_STATUS_ERROR);
        }

        BigDecimal tenderAmount = BigDecimal.valueOf(request.getAmount());
        //最小投标
        if(project.getMinTender().compareTo(tenderAmount) > 0 ){
            throw new BusinessException(ErrorCodeEnum.PROJECT_MIN_TENDER);
        }
        //剩余可投
        if(project.getRaiseAmount().add(tenderAmount).compareTo(project.getAmount()) > 0){
            throw new BusinessException(ErrorCodeEnum.PROJECT_NOT_ENOUGH);
        }
    }

    @Override
    public void updateProject(Project project) {
        projectMapper.updateByPrimaryKeySelective(project);
    }

    /**
     * 过滤用户id,并更新用户vip等级,
     * 一个用户投资一个产品多次,减少无用的更新次数
     * @param tenderList 投标列表
     */
    private void filterAndUpdateGrade(List<ProjectTender> tenderList){
        Set<Integer> userIds = Sets.newHashSet();
        tenderList.forEach(tender -> userIds.add(tender.getUserId()));
        userExtendService.updateGrades(userIds);
    }

    /**
     * 根据类型奖励积分
     * @param userId 用户id
     * @param integral 积分类型
     */
    private void awardIntegral(int userId,Integral integral){
        int score = integralLogService.calcScore(integral);
        IntegralAward award = new IntegralAward(userId,score,integral);
        TaskQueue.executePointAward(new IntegralAwardTask(award));
    }

    /**
     * 发放投标积分奖励
     * @param tender 投标
     */
    private void awardTenderIntegral(ProjectTender tender){
        int score = integralLogService.calcTenderScore(tender.getAccount().doubleValue());
        if(score == 0){
            log.debug("投标金额不足,不发积分,userId:[{}],account:[{}]",tender.getUserId(),tender.getAccount());
            return;
        }
        IntegralAward award = new IntegralAward(tender.getUserId(),score,Integral.TENDER);
        TaskQueue.executePointAward(new IntegralAwardTask(award));
    }


    @Override
    public List<ProjectPlan> createRecoverList(ProjectTender tender,Project project){

        List<DiscountCoupon> couponList = tender.getCouponList();
        double couponApr = projectTenderService.getDiscountCouponApr(couponList);

        if(project.getRepaymentMode() == RepaymentType.EQUAL_AMOUNT.getMode()){
            return ProjectUtil.equalAmountRecoverList(project.getPeriod(),tender.getAccount().doubleValue(),project.getApr().doubleValue(),project.getPlatformApr().doubleValue(),couponApr);
        }

        if(project.getRepaymentMode() == RepaymentType.MONTHLY.getMode()){
            return ProjectUtil.monthlyRecoverList(project.getPeriod(),tender.getAccount().doubleValue(),project.getApr().doubleValue(),project.getPlatformApr().doubleValue(),couponApr);
        }

        return ProjectUtil.dailyRecoverList(project.getPeriod(),tender.getAccount().doubleValue(),project.getApr().doubleValue(),project.getPlatformApr().doubleValue(),couponApr);
    }



    @Override
    public void fullAuditFail(Project project) {
        //TODO 撤销投标
    }

    @Override
    public void fullAudit(ProjectAudit audit) {
        Project project = projectMapper.selectByPrimaryKey(audit.getId());

        ProjectAuditLog log = new ProjectAuditLog();

        byte passCode = ProjectAuditStatus.FULL_RECHECK_PASS.getCode();

        if(audit.getState() == passCode){
            this.fullAuditSuccess(project);
            log.setState(passCode);
        }else{
            this.fullAuditFail(project);
            log.setState(ProjectAuditStatus.REVOCATION.getCode());
        }
        log.setProjectId(audit.getId());
        log.setRemark(audit.getRemark());
        log.setOperatorId(audit.getOperatorId());
        projectAuditLogService.addProjectAuditLog(log);
    }

    /**
     * 检查产品信息是否合法
     * @param project 产品
     */
    private void verifyFullProject(Project project){
        if(project == null){
            log.error("满标复审,产品信息未查询到");
            throw new BusinessException(ErrorCodeEnum.PROJECT_FOUND_ERROR);
        }
        if(project.getState() != ProjectStatus.FULL.getCode()){
            throw new BusinessException(ErrorCodeEnum.PROJECT_STATUS_ERROR.getCode(),"产品状态异常:" + ProjectStatus.equalsCode(project.getState()).getName());
        }
    }


    @Override
    @Transactional(readOnly = true,rollbackFor = RuntimeException.class)
    public synchronized String createNid() {
        String yyyyMMdd = DateUtil.format(DateUtil.getNow(), "yyyyMMdd0");

        //服务器重启或者第一个产品
        if(startPoint == 1){
            String maxNid = projectMapper.getNewestProject();
            if(maxNid == null || !maxNid.startsWith(yyyyMMdd)){
                startPoint = Integer.parseInt(StringUtil.randomNumber(3));
                return yyyyMMdd + startPoint;
            }
            startPoint = Integer.parseInt(maxNid.substring(maxNid.length() - 4));
        }
        startPoint++ ;
        return yyyyMMdd + String.format("%04d",startPoint);
    }
}
