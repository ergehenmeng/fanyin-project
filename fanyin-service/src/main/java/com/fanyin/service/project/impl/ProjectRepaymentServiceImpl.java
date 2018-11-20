package com.fanyin.service.project.impl;

import com.fanyin.mapper.project.ProjectRepaymentMapper;
import com.fanyin.model.project.ProjectPlan;
import com.fanyin.service.project.ProjectRepaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;

/**
 * @author 二哥很猛
 * @date 2018/11/14 18:37
 */
@Service("projectRepaymentService")
public class ProjectRepaymentServiceImpl implements ProjectRepaymentService {

    @Autowired
    private ProjectRepaymentMapper projectRepaymentMapper;


    @Override
    public void addBatchRepayment(Collection<ProjectPlan> planList, int projectId, int borrowerId) {
        projectRepaymentMapper.insertBatchRepayment(planList,projectId,borrowerId);
    }
}
