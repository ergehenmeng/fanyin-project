package com.fanyin.service.project.impl;

import com.fanyin.constants.TenderConstant;
import com.fanyin.dto.project.ProjectAudit;
import com.fanyin.dto.project.TenderStatistics;
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
import com.fanyin.service.project.*;
import com.fanyin.service.user.IntegralLogService;
import com.fanyin.utils.DateUtil;
import com.fanyin.utils.ProjectUtil;
import com.fanyin.utils.StringUtil;
import com.google.common.collect.Maps;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 产品service
 * @author 二哥很猛
 */
@Service("projectService")
@Slf4j
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

    /**
     * 起始编号
     */
    private int startPoint = 1;

    @Override
    public Project getByNid(String nid) {
        return projectMapper.getByNid(nid);
    }

    @Override
    public Project getById(int id) {
        return projectMapper.selectByPrimaryKey(id);
    }

    @Override
    public void fullAuditSuccess(Project project) {
        this.checkProject(project);
        //查询投标信息 必须包含加息券 这样计算利息才正常
        List<ProjectTender> tenderList = projectTenderService.getByProjectIdWithCoupon(project.getId());
        //还款列表
        Map<Integer,ProjectPlan> repaymentMap = Maps.newHashMap();

        Date now = DateUtil.getNow();
        tenderList.forEach(projectTender -> {
            //生成回款列表
            List<ProjectPlan> recoverList = this.createRecoverList(projectTender, project);
            //通过回款列表生成还款列表
            ProjectUtil.repaymentList(recoverList,repaymentMap);
            //插入回款
            projectRecoverService.insertBatchRecover(recoverList,projectTender.getUserId(),project.getId(),projectTender.getId());
            //计算投标预计收益
            projectTenderService.calcTenderInterest(projectTender, project);
            projectTender.setUpdateTime(now);
            projectTender.setStatus(TenderConstant.TENDER_STATUS_1);
            //更新投标信息
            projectTenderService.updateTender(projectTender);
            //投标积分奖励
            this.awardTenderIntegral(projectTender);
        });
        //插入还款信息
        projectRepaymentService.insertBatchRepayment(repaymentMap.values(),project.getId(),project.getBorrowerId());
        //计算首投,最高投 扫尾
        TenderStatistics tenderStatistics = projectTenderStatisticsService.calcTenderStatistics(tenderList);
        //插入首投,最高投,扫尾
        projectTenderStatisticsService.insertTenderStatistics(tenderStatistics);
        //奖励积分
        this.awardFirstMaxLastIntegral(tenderStatistics);

    }


    @Override
    public void awardFirstMaxLastIntegral(TenderStatistics tenderStatistics){
        this.awardIntegral(tenderStatistics.getFirst().getUserId(),Integral.FIRST_TENDER);
        this.awardIntegral(tenderStatistics.getMax().getUserId(),Integral.MAX_TENDER);
        this.awardIntegral(tenderStatistics.getLast().getUserId(),Integral.LAST_TENDER);
    }

    /**
     * 根据类型奖励积分
     * @param userId 用户id
     * @param integral 积分类型
     */
    private void awardIntegral(int userId,Integral integral){
        int score = integralLogService.calcScore(integral);
        IntegralAward award = new IntegralAward(userId,score,integral);
        TaskQueue.pointAwardOffer(new IntegralAwardTask(award));
    }

    /**
     * 发放投标积分奖励
     * @param tender 投标
     */
    private void awardTenderIntegral(ProjectTender tender){
        int score = integralLogService.calcTenderScore(tender.getAccount().doubleValue());
        if(score == 0){
            log.debug("投标金额不足,不发积分,userId:{},account:{}",tender.getUserId(),tender.getAccount());
            return;
        }
        IntegralAward award = new IntegralAward(tender.getUserId(),score,Integral.TENDER);
        TaskQueue.pointAwardOffer(new IntegralAwardTask(award));
    }


    @Override
    public List<ProjectPlan> createRecoverList(ProjectTender tender,Project project){

        List<DiscountCoupon> couponList = tender.getCouponList();
        double couponApr = projectTenderService.getDiscountCouponApr(couponList);

        if(project.getRepaymentType() == RepaymentType.EQUAL_AMOUNT.getMode()){
            return ProjectUtil.equalAmountRecoverList(project.getPeriod(),tender.getAccount().doubleValue(),project.getApr().doubleValue(),project.getPlatformApr().doubleValue(),couponApr);
        }

        if(project.getRepaymentType() == RepaymentType.MONTHLY.getMode()){
            return ProjectUtil.monthlyRecoverList(project.getPeriod(),tender.getAccount().doubleValue(),project.getApr().doubleValue(),project.getPlatformApr().doubleValue(),couponApr);
        }

        return ProjectUtil.dailyRecoverList(project.getPeriod(),tender.getAccount().doubleValue(),project.getApr().doubleValue(),project.getPlatformApr().doubleValue(),couponApr);
    }



    @Override
    public void fullAuditFail(Project project) {
        this.checkProject(project);
    }

    @Override
    public void fullAudit(ProjectAudit audit) {
        Project project = projectMapper.selectByPrimaryKey(audit.getId());

        ProjectAuditLog log = new ProjectAuditLog();

        int passCode = ProjectAuditStatus.FULL_RECHECK_PASS.getCode();

        if(audit.getStatus() == passCode){
            this.fullAuditSuccess(project);
            log.setStatus((byte)passCode);
        }else{
            this.fullAuditFail(project);
            log.setStatus((byte)ProjectAuditStatus.REVOCATION.getCode());
        }
        log.setAddTime(DateUtil.getNow());
        log.setProjectId(audit.getId());
        log.setRemark(audit.getRemark());
        log.setOperatorId(audit.getOperatorId());
        projectAuditLogService.insertSelective(log);
    }

    /**
     * 检查产品信息是否合法
     * @param project 产品
     */
    private void checkProject(Project project){
        if(project == null){
            log.error("满标复审,产品信息未查询到");
            throw new BusinessException(ErrorCodeEnum.PROJECT_NOT_FOUND);
        }
        if(project.getStatus() != ProjectStatus.FULL.getCode()){
            throw new BusinessException(ErrorCodeEnum.PROJECT_STATUS_ERROR.getCode(),"产品状态异常:" + ProjectStatus.equalsCode(project.getStatus()).getName());
        }
    }


    @Override
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
