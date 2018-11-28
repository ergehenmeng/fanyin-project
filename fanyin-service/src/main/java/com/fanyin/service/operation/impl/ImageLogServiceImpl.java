package com.fanyin.service.operation.impl;

import com.fanyin.dto.operation.ImageLogQueryRequest;
import com.fanyin.mapper.operation.ImageLogMapper;
import com.fanyin.model.operation.ImageLog;
import com.fanyin.service.operation.ImageLogService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/11/27 17:11
 */
@Service("imageLogService")
public class ImageLogServiceImpl implements ImageLogService {

    @Autowired
    private ImageLogMapper imageLogMapper;

    @Override
    public PageInfo<ImageLog> getByPage(ImageLogQueryRequest request) {
        PageHelper.startPage(request.getPage(),request.getRows());
        List<ImageLog> list = imageLogMapper.getList(request);
        return new PageInfo<>(list);
    }
}
