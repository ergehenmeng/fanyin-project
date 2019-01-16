package com.fanyin.mapper.business;

import com.fanyin.model.business.IntegralType;
import org.apache.ibatis.annotations.Param;

/**
 * @author 二哥很猛
 */
public interface IntegralTypeMapper {

    /**
     * 插入不为空的记录
     *
     * @param record 待插入的数据
     * @return 影响条数
     */
    int insertSelective(IntegralType record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id 主键
     * @return 结果数据
     */
    IntegralType selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record 待更新的数据
     * @return 影响条数
     */
    int updateByPrimaryKeySelective(IntegralType record);

    /**
     * 根据nid查询积分类型
     * @param nid nid
     * @return 影响条数
     */
    IntegralType getByNid(@Param("nid")String nid);

}