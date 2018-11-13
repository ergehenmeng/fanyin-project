package com.fanyin.mapper.project;

import com.fanyin.model.project.ProjectAuditLog;

/**
 * @author 二哥很猛
 */
public interface ProjectAuditLogMapper {

    /**
     * 插入不为空的记录
     * @param record 记录信息
     * @return 插入条数
     */
    int insertSelective(ProjectAuditLog record);


}