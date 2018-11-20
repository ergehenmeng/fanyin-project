package com.fanyin.service.project;

import com.fanyin.model.project.ProjectPlan;

import java.util.Collection;


/**
 * @author 二哥很猛
 * @date 2018/11/14 18:37
 */
public interface ProjectRepaymentService {

    /**
     * 批量添加借款人还款信息,只适用满标复审
     * @param planList 还款信息
     * @param projectId 产品id
     * @param borrowerId 用户id
     */
    void addBatchRepayment(Collection<ProjectPlan> planList, int projectId, int borrowerId);

}

