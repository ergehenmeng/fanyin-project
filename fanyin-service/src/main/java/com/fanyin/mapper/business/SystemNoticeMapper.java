package com.fanyin.mapper.business;

import com.fanyin.dto.business.NoticeQueryRequest;
import com.fanyin.model.business.SystemNotice;

import java.util.List;

/**
 * @author 二哥很猛
 */
public interface SystemNoticeMapper {

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
     * 根据条件查询
     * @param request 查询条件
     * @return 结果列表
     */
    List<SystemNotice> getList(NoticeQueryRequest request);
}