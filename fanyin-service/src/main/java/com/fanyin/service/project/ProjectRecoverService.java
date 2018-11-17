package com.fanyin.service.project;

import com.fanyin.model.project.ProjectPlan;

import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/11/14 16:46
 */
public interface ProjectRecoverService {

    /**
     * 批量插入回款计划,只适用满标复审
     * @param list 回款列表
     * @param userId 用户id
     * @param projectId 产品id
     * @param tenderId 投标id
     */
    void insertBatchRecover(List<ProjectPlan> list,
                            int userId,
                            int projectId,
                            int tenderId);

}

