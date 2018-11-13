package com.fanyin.service.project;

import com.fanyin.model.project.ProjectAuditLog;

/**
 * @author 二哥很猛
 * @date 2018/11/12 17:32
 */
public interface ProjectAuditLogService {

    /**
     * 不为空插入产品审核记录
     * @param log 日志
     */
    void insertSelective(ProjectAuditLog log);

}

