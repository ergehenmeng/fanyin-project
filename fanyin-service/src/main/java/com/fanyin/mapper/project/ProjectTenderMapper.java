package com.fanyin.mapper.project;

import com.fanyin.model.project.ProjectTender;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

/**
 * @author 二哥很猛
 */
public interface ProjectTenderMapper {
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
    int insert(ProjectTender record);

    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(ProjectTender record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    ProjectTender selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(ProjectTender record);

    /**
     * 根据主键来更新数据库记录
     *
     * @param record
     */
    int updateByPrimaryKey(ProjectTender record);

    /**
     * 查询产品的投标列表,包含加息券信息
     * @param projectId  产品id
     * @return 投标列表
     */
    List<ProjectTender> getByProjectIdWithCoupon(@Param("projectId") int projectId);

    /**
     * 查询产品的投标列表,不包含加息券信息
     * @param projectId  产品id
     * @return 投标列表
     */
    List<ProjectTender> getByProjectId(@Param("projectId") int projectId);

    /**
     * 根据用户查询某一次投标信息 包含优惠券
     * @param userId 用户id
     * @param id     投标id
     * @return 投标信息
     */
    ProjectTender getByIdWithCoupon(@Param("userId")int userId,@Param("id")int id);

    /**
     * 根据用户查询某一次投标信息 不包含优惠券
     * @param userId 用户id
     * @param id 投标id
     * @return 投标信息
     */
    ProjectTender getById(@Param("userId")int userId,@Param("id")int id);


    /**
     * 用户总投资本息
     * @param userId 用户id
     * @return 投资本息
     */
    BigDecimal getTotalTender(@Param("userId")int userId);

}