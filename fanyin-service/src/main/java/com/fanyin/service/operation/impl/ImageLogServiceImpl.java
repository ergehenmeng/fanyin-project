package com.fanyin.service.operation.impl;

import com.fanyin.dto.operation.ImageAddRequest;
import com.fanyin.dto.operation.ImageEditRequest;
import com.fanyin.dto.operation.ImageQueryRequest;
import com.fanyin.mapper.operation.ImageLogMapper;
import com.fanyin.model.operation.ImageLog;
import com.fanyin.service.operation.ImageLogService;
import com.fanyin.utils.BeanCopyUtil;
import com.fanyin.utils.DateUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/11/27 17:11
 */
@Service("imageLogService")
@Transactional(rollbackFor = RuntimeException.class)
public class ImageLogServiceImpl implements ImageLogService {

    @Autowired
    private ImageLogMapper imageLogMapper;

    @Override
    public PageInfo<ImageLog> getByPage(ImageQueryRequest request) {
        PageHelper.startPage(request.getPage(),request.getRows());
        List<ImageLog> list = imageLogMapper.getList(request);
        return new PageInfo<>(list);
    }

    @Override
    public void addImageLog(ImageAddRequest request) {
        ImageLog imageLog = BeanCopyUtil.copy(request, ImageLog.class);
        imageLog.setDeleted(false);
        imageLog.setAddTime(DateUtil.getNow());
        imageLogMapper.insertSelective(imageLog);
    }

    @Override
    public void deleteImageLog(Integer id) {
        ImageLog log = new ImageLog();
        log.setId(id);
        log.setUpdateTime(DateUtil.getNow());
        log.setDeleted(true);
        imageLogMapper.updateByPrimaryKeySelective(log);
    }

    @Override
    public void updateImageLog(ImageEditRequest request) {
        ImageLog log = BeanCopyUtil.copy(request, ImageLog.class);
        log.setUpdateTime(DateUtil.getNow());
        imageLogMapper.updateByPrimaryKeySelective(log);
    }

    @Override
    public ImageLog getById(Integer id) {
        return imageLogMapper.selectByPrimaryKey(id);
    }
}
