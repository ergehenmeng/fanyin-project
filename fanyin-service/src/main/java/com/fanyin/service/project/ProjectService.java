package com.fanyin.service.project;

import com.fanyin.dto.project.ProjectAudit;
import com.fanyin.dto.project.TenderStatistics;
import com.fanyin.dto.tender.Tender;
import com.fanyin.model.project.Project;
import com.fanyin.model.project.ProjectPlan;
import com.fanyin.model.project.ProjectTender;

import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/11/12 11:20
 */
public interface ProjectService {

    /**
     * 根据编号查询产品信息,不过滤任何状态
     * @param nid 产品编号
     * @return 产品信息
     */
    Project getByNid(String nid);

    /**
     * 根据id查询产品编号
     * @param id 产品id
     * @return 产品信息
     */
    Project getById(int id);

    /**
     * 产品满标审核接口,由以下步骤:<br>
     * 校验产品信息<br>
     * 生成回款信息<br>
     * 生成还款信息<br>
     * 投资用户资金解冻<br>
     * 将资金打入到借款人账户<br>
     * 投资用户积分奖励
     * @param project 产品信息
     */
    void fullAuditSuccess(Project project);

    /**
     * 产品审核失败 撤销投标
     * 1.产品状态变更
     * 2.解冻用户资金<br>
     * 3.解冻用户优惠券
     * @param project 产品信息
     */
    void fullAuditFail(Project project);

    /**
     * 满标审核
     * @param audit 审核信息
     */
    void fullAudit(ProjectAudit audit);

    /**
     * 生成产品编号 yyyyMMdd + 0 + 027 每日最大发布产品最大为900个
     * @return 产品编号
     */
    String createNid();

    /**
     * 生成投资人回款计划
     * @param tender 投资记录
     * @param project 产品信息
     * @return 回款列表
     */
    List<ProjectPlan> createRecoverList(ProjectTender tender, Project project);

    /**
     * 发放首投,最高投,扫尾积分奖励
     * @param tenderStatistics 首投,最高投,扫尾
     */
    void awardFirstMaxLastIntegral(TenderStatistics tenderStatistics);


    /**
     * 投标 产品信息校验
     * @param project 产品信息
     * @param request 投标信息
     */
    void verifyProject(Project project, Tender request);

    /**
     * 投标 产品信息校验
     *
     * @param project 产品信息
     * @param request 投标信息
     */
    void verifyTenderProject(Project project, Tender request);


    /**
     * 更新产品信息
     * @param project 产品信息
     */
    void updateProject(Project project);
}

