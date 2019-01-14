package com.fanyin.service.project.impl;

import com.fanyin.mapper.project.ProjectAuditLogMapper;
import com.fanyin.model.project.ProjectAuditLog;
import com.fanyin.service.project.ProjectAuditLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 审核记录信息
 * @author 二哥很猛
 * @date 2018/11/12 17:33
 */
@Service("projectAuditLogService")
@Transactional(rollbackFor = RuntimeException.class)
public class ProjectAuditLogServiceImpl implements ProjectAuditLogService {

    @Autowired
    private ProjectAuditLogMapper projectAuditLogMapper;

    @Override
    public void addProjectAuditLog(ProjectAuditLog log) {
        projectAuditLogMapper.insertSelective(log);
    }
}
