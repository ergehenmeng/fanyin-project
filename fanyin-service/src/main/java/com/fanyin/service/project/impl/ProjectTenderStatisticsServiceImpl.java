package com.fanyin.service.project.impl;

import com.fanyin.constants.TenderConstant;
import com.fanyin.dto.project.ProjectStatistics;
import com.fanyin.dto.project.TenderStatistics;
import com.fanyin.mapper.project.ProjectTenderStatisticsMapper;
import com.fanyin.model.project.ProjectTender;
import com.fanyin.model.project.ProjectTenderStatistics;
import com.fanyin.service.project.ProjectTenderStatisticsService;
import com.fanyin.utils.StringUtil;
import com.google.common.collect.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

/**
 * 投标统计记录
 * @author 二哥很猛
 * @date 2018/11/15 15:44
 */
@Service("projectTenderStatisticsService")
public class ProjectTenderStatisticsServiceImpl implements ProjectTenderStatisticsService {

    @Autowired
    private ProjectTenderStatisticsMapper projectTenderStatisticsMapper;

    @Override
    public void addTenderStatistics(TenderStatistics tenderStatistics) {
        List<ProjectTenderStatistics> arrayList = Lists.newArrayList();
        arrayList.add(transferObject(tenderStatistics.getFirst(),TenderConstant.TENDER_FIRST));
        arrayList.add(transferObject(tenderStatistics.getMax(),TenderConstant.TENDER_MAX));
        arrayList.add(transferObject(tenderStatistics.getLast(),TenderConstant.TENDER_LAST));

        projectTenderStatisticsMapper.insertBatchStatistics(arrayList);
    }

    @Override
    public TenderStatistics calcTenderStatistics(List<ProjectTender> tenderList) {
        ProjectTender firstTender = tenderList.get(0);
        ProjectTender maxTender = getMaxTender(tenderList);
        ProjectTender lastTender = tenderList.get(tenderList.size() - 1);
        return new TenderStatistics(firstTender,maxTender,lastTender);
    }

    @Override
    public ProjectStatistics getProjectStatistics(int projectId) {
        ProjectStatistics projectStatistics = new ProjectStatistics();
        List<ProjectTenderStatistics> statisticsList = projectTenderStatisticsMapper.getByProjectId(projectId);
        if(statisticsList != null && statisticsList.size() > 0){
            statisticsList.forEach(statistics -> {
                String hiddenMobile = StringUtil.hiddenMobile(statistics.getMobile());
                if(statistics.getClassify() == TenderConstant.TENDER_FIRST){
                    projectStatistics.setFirst(hiddenMobile);
                }
                if(statistics.getClassify() == TenderConstant.TENDER_MAX){
                    projectStatistics.setMax(hiddenMobile);
                }
                if(statistics.getClassify() == TenderConstant.TENDER_LAST){
                    projectStatistics.setLast(hiddenMobile);
                }
            });
        }
        return projectStatistics;
    }

    /**
     * 对象转换,将投标信息转换为统计信息对象
     * @param tender 投标信息
     * @return 统计信息对象
     */
    private ProjectTenderStatistics transferObject(ProjectTender tender,byte type){
        ProjectTenderStatistics statistics = new ProjectTenderStatistics();
        statistics.setProjectId(tender.getProjectId());
        statistics.setTenderId(tender.getId());
        statistics.setUserId(tender.getUserId());
        statistics.setClassify(type);
        return statistics;
    }

    /**
     * 获取单个产品中投标最大的投标记录,
     * 如果最大投标有两个默认谁最先加入的为最大
     * @param tenderList 投标列表
     * @return 最大投标
     */
    private ProjectTender getMaxTender(List<ProjectTender> tenderList){
        BigDecimal max = BigDecimal.ZERO;
        int maxIndex = 0;
        for (int i = 0; i < tenderList.size() ;i++){
            ProjectTender projectTender = tenderList.get(i);
            if(max.compareTo(projectTender.getAccount()) < 0){
                max = projectTender.getAccount();
                maxIndex = i;
            }
        }
        return tenderList.get(maxIndex);
    }


}
