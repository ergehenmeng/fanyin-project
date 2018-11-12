package com.fanyin.mapper.project;

import com.fanyin.model.project.Project;
import org.apache.ibatis.annotations.Param;

/**
 * @author 二哥很猛
 */
public interface ProjectMapper {
    /**
     * 根据主键删除数据库的记录
     *
     * @param id 主键
     * @return 删除条数 1
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * 插入数据库记录
     *
     * @param record 项目信息
     * @return 插入条数
     */
    int insert(Project record);

    /**
     * 插入不为空的记录
     *
     * @param record 产品信息
     * @return 插入条数
     */
    int insertSelective(Project record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id 主键
     * @return 项目信息
     */
    Project selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record 产品信息
     * @return 更新影响条数
     */
    int updateByPrimaryKeySelective(Project record);

    /**
     * 根据主键来更新数据库记录
     *
     * @param record 产品信息
     * @return 更新影响条数
     */
    int updateByPrimaryKey(Project record);

    /**
     * 根据产品编号查询,无状态过滤查询
     * @param nid 产品编号
     * @return 产品信息
     */
    Project getByNid(@Param("nid") String nid);

    /**
     * 获取最新录入的产品编号信息
     * @return 产品信息
     */
    String getNewestProject();
}