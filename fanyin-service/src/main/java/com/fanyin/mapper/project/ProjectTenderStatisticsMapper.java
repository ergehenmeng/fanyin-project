package com.fanyin.mapper.project;

import com.fanyin.model.project.ProjectTenderStatistics;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author 二哥很猛
 */
public interface ProjectTenderStatisticsMapper {
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
    int insert(ProjectTenderStatistics record);

    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(ProjectTenderStatistics record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    ProjectTenderStatistics selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(ProjectTenderStatistics record);

    /**
     * 根据主键来更新数据库记录
     *
     * @param record
     */
    int updateByPrimaryKey(ProjectTenderStatistics record);

    /**
     * 批量插入统计信息
     * @param statistics 统计信息列表
     * @return 插入条数
     */
    int insertBatchStatistics(List<ProjectTenderStatistics> statistics);

    /**
     * 根据产品id查询投标统计信息,包含用户手机号
     * @param projectId 产品id
     * @return 产品投标统计信息
     */
    List<ProjectTenderStatistics> getByProjectId(@Param("projectId")int projectId);
}