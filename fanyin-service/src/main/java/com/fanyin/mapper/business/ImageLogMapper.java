package com.fanyin.mapper.business;

import com.fanyin.dto.business.ImageQueryRequest;
import com.fanyin.model.business.ImageLog;

import java.util.List;

/**
 * @author 二哥很猛
 */
public interface ImageLogMapper {


    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(ImageLog record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    ImageLog selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(ImageLog record);


    /**
     * 根据条件查询图片列表
     * @param request 请求
     * @return 列表
     */
    List<ImageLog> getList(ImageQueryRequest request);
}