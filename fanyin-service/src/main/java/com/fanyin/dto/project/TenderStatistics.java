package com.fanyin.dto.project;

import com.fanyin.model.project.ProjectTender;
import lombok.Data;

/**
 * 投标统计信息
 * @author 二哥很猛
 * @date 2018/11/16 14:40
 */
@Data
public class TenderStatistics {

    /**
     * 首投
     */
    private ProjectTender first;

    /**
     * 最大
     */
    private ProjectTender max;

    /**
     * 扫尾
     */
    private ProjectTender last;

    public TenderStatistics(ProjectTender first, ProjectTender max, ProjectTender last) {
        this.first = first;
        this.max = max;
        this.last = last;
    }
}
