package com.fanyin.service.business.impl;

import com.fanyin.dto.business.ImageAddRequest;
import com.fanyin.dto.business.ImageEditRequest;
import com.fanyin.dto.business.ImageQueryRequest;
import com.fanyin.mapper.business.ImageLogMapper;
import com.fanyin.model.business.ImageLog;
import com.fanyin.service.business.ImageLogService;
import com.fanyin.utils.BeanCopyUtil;
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
        imageLogMapper.insertSelective(imageLog);
    }

    @Override
    public void deleteImageLog(Integer id) {
        ImageLog log = new ImageLog();
        log.setId(id);
        log.setDeleted(true);
        imageLogMapper.updateByPrimaryKeySelective(log);
    }

    @Override
    public void updateImageLog(ImageEditRequest request) {
        ImageLog log = BeanCopyUtil.copy(request, ImageLog.class);
        imageLogMapper.updateByPrimaryKeySelective(log);
    }

    @Override
    public ImageLog getById(Integer id) {
        return imageLogMapper.selectByPrimaryKey(id);
    }
}
