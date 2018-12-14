package com.fanyin.mapper.system;

import com.fanyin.model.system.Department;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author 二哥很猛
 */
public interface DepartmentMapper {

    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(Department record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    Department selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(Department record);

    /**
     * 获取部门下的子级部门
     * @param code 部门编号
     * @return 子部门列表
     */
    List<Department> getChildList(@Param("code") String code);
}