package com.fanyin.mapper.operation;

import com.fanyin.dto.operation.NoticeQueryRequest;
import com.fanyin.model.operation.SystemNotice;

import java.util.List;

/**
 * @author 二哥很猛
 */
public interface SystemNoticeMapper {
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
    int insert(SystemNotice record);

    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(SystemNotice record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    SystemNotice selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(SystemNotice record);

    /**
     *
     * @param record
     */
    int updateByPrimaryKeyWithBLOBs(SystemNotice record);

    /**
     * 根据主键来更新数据库记录
     *
     * @param record
     */
    int updateByPrimaryKey(SystemNotice record);

    /**
     * 根据条件查询
     * @param request 查询条件
     * @return 结果列表
     */
    List<SystemNotice> getList(NoticeQueryRequest request);
}