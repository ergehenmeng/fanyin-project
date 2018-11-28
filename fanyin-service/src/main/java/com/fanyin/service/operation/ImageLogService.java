package com.fanyin.service.operation;

import com.fanyin.dto.operation.ImageLogQueryRequest;
import com.fanyin.model.operation.ImageLog;
import com.github.pagehelper.PageInfo;

/**
 * @author 二哥很猛
 * @date 2018/11/27 17:11
 */
public interface ImageLogService {

    /**
     * 分页查询图片上传列表
     * @param request 查询条件
     * @return 结果
     */
    PageInfo<ImageLog> getByPage(ImageLogQueryRequest request);
}

