package com.fanyin.mapper.system;


import com.fanyin.model.system.SystemDict;

import java.util.List;

/**
 * @author 二哥很猛
 */
public interface SystemDictMapper {
    /**
     * 根据主键删除数据库的记录
     *
     * @param id 主键
     * @return 删除的条数
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * 插入数据库记录
     *
     * @param record 待插入的对象
     * @return 添加的条数
     */
    int insert(SystemDict record);

    /**
     * 插入不为空的记录
     *
     * @param record 待插入的对象
     * @return 添加的条数
     */
    int insertSelective(SystemDict record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id 主键
     * @return 查询到的数据字典对象
     */
    SystemDict selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record 待更新的对象
     * @return 更新成功的条数
     */
    int updateByPrimaryKeySelective(SystemDict record);

    /**
     * 根据主键来更新数据库记录
     *
     * @param record 待更新的对象
     * @return 更新的条数
     */
    int updateByPrimaryKey(SystemDict record);

    /**
     * 根据nid查询某一类数据字典列表
     * @param nid 某类数据字典nid
     * @return 查询到的列表
     */
    List<SystemDict> getDictByNid(String nid);
}