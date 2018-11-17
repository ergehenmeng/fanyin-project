package com.fanyin.service.project;

import com.fanyin.dto.project.TenderStatistics;
import com.fanyin.model.project.ProjectTender;

import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/11/15 15:44
 */
public interface ProjectTenderStatisticsService  {

    /**
     * 插入投标统计信息
     * @param tenderStatistics 插入统计信息
     */
    void insertTenderStatistics(TenderStatistics tenderStatistics);

    /**
     * 获取投标的首投 最大投 扫尾等
     * @param tenderList 投标列表 id正序排序
     * @return 结果
     */
    TenderStatistics calcTenderStatistics(List<ProjectTender> tenderList);
}

