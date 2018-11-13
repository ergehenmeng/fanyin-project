package com.fanyin.request.project;

import lombok.Data;

import java.io.Serializable;

/**
 * @author 二哥很猛
 * @date 2018/11/12 16:24
 */
@Data
public class ProjectAudit implements Serializable {

    private static final long serialVersionUID = -6402740559026961204L;

    /**
     * 产品id
     */
    private Integer id;

    /**
     * 产品状态
     */
    private Integer status;

    /**
     * 审核信息
     */
    private String remark;

    /**
     * 操作人员
     */
    private Integer operatorId;
}
