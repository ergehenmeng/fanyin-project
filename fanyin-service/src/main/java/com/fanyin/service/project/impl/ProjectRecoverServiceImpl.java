package com.fanyin.service.project.impl;

import com.fanyin.mapper.project.ProjectRecoverMapper;
import com.fanyin.model.project.ProjectPlan;
import com.fanyin.service.project.ProjectRecoverService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/11/14 16:46
 */
@Service("projectRecoverService")
public class ProjectRecoverServiceImpl implements ProjectRecoverService {

    @Autowired
    private ProjectRecoverMapper projectRecoverMapper;

    @Override
    public void insertBatchRecover(List<ProjectPlan> list, int userId, int projectId, int tenderId) {
        projectRecoverMapper.insertBatchRecover(list, userId, projectId, tenderId);
    }
}
