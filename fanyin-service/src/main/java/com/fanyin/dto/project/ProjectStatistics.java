package com.fanyin.dto.project;

import lombok.Data;

import java.io.Serializable;

/**
 * 产品首投,最高投,扫尾
 * @author 二哥很猛
 * @date 2018/11/20 16:23
 */
@Data
public class ProjectStatistics implements Serializable {

    private static final long serialVersionUID = 4680521390102082076L;

    private String first;

    private String max;

    private String last;
}
