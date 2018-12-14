package com.fanyin.dto.system.department;

import lombok.Data;

import java.io.Serializable;

/**
 * @author 二哥很猛
 * @date 2018/12/14 14:11
 */
@Data
public class DepartmentAddRequest implements Serializable {

    private static final long serialVersionUID = -4129318805129787627L;

    /**
     * 父编码
     */
    private String parentCode;


    /**
     * 部门名称
     */
    private String name;


}
