package com.fanyin.model.project;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 投标统计信息表
 * @author 二哥很猛
 */
@Data
public class ProjectTenderStatistics implements Serializable {
    private static final long serialVersionUID = -4485546434573116039L;
    /**
     * 主键<br>
     * 表 : project_tender_statistics<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 产品id<br>
     * 表 : project_tender_statistics<br>
     * 对应字段 : project_id<br>
     */
    private Integer projectId;

    /**
     * 用户id<br>
     * 表 : project_tender_statistics<br>
     * 对应字段 : user_id<br>
     */
    private Integer userId;

    /**
     * 投标id<br>
     * 表 : project_tender_statistics<br>
     * 对应字段 : tender_id<br>
     */
    private Integer tenderId;

    /**
     * 类型 0:首投 1:最高 2:扫尾<br>
     * 表 : project_tender_statistics<br>
     * 对应字段 : type<br>
     */
    private Byte type;

    /**
     * 添加时间<br>
     * 表 : project_tender_statistics<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 用户手机号
     */
    private String mobile;

}