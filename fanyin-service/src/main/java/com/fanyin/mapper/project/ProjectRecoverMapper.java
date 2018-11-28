package com.fanyin.mapper.project;

import com.fanyin.model.project.ProjectPlan;
import com.fanyin.model.project.ProjectRecover;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author 二哥很猛
 */
public interface ProjectRecoverMapper {

    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(ProjectRecover record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    ProjectRecover selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(ProjectRecover record);


    /**
     * 批量插入回款信息 单个用户单次投资的回款列表
     * @param list 生成的回款列表
     * @param userId 用户id
     * @param projectId 产品id
     * @param tenderId  投标id
     * @return 插入条数
     */
    int insertBatchRecover(@Param("list")List<ProjectPlan> list,
                           @Param("userId")int userId,
                           @Param("projectId")int projectId,
                           @Param("tenderId")int tenderId);
}