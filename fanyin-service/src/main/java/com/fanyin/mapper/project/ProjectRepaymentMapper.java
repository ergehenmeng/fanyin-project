package com.fanyin.mapper.project;

import com.fanyin.model.project.ProjectPlan;
import com.fanyin.model.project.ProjectRepayment;
import org.apache.ibatis.annotations.Param;

import java.util.Collection;

/**
 * @author 二哥很猛
 */
public interface ProjectRepaymentMapper {
    /**
     * 根据主键删除数据库的记录
     *
     * @param id
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * 插入数据库记录
     *
     * @param record
     */
    int insert(ProjectRepayment record);

    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(ProjectRepayment record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    ProjectRepayment selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(ProjectRepayment record);

    /**
     * 根据主键来更新数据库记录
     *
     * @param record
     */
    int updateByPrimaryKey(ProjectRepayment record);

    /**
     * 批量插入还款信息
     * @param planList 还款信息
     * @param projectId 产品id
     * @param borrowerId 借款人id
     * @return 插入条数
     */
    int insertBatchRepayment(@Param("list")Collection<ProjectPlan> planList, @Param("projectId")int projectId, @Param("borrowerId")int borrowerId);
}