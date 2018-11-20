package com.fanyin.service.operation.impl;

import com.fanyin.dto.operation.NoticeAddRequest;
import com.fanyin.dto.operation.NoticeQueryRequest;
import com.fanyin.dto.operation.NoticeEditRequest;
import com.fanyin.mapper.operation.SystemNoticeMapper;
import com.fanyin.model.operation.SystemNotice;
import com.fanyin.service.operation.SystemNoticeService;
import com.fanyin.utils.BeanCopyUtil;
import com.fanyin.utils.DateUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 系统公告
 * @author 二哥很猛
 * @date 2018/11/20 19:11
 */
@Service("systemNoticeService")
public class SystemNoticeServiceImpl implements SystemNoticeService {

    @Autowired
    private SystemNoticeMapper systemNoticeMapper;

    @Override
    public void addNotice(NoticeAddRequest request) {
        SystemNotice systemNotice = BeanCopyUtil.copy(request, SystemNotice.class);
        //默认状态正常
        systemNotice.setDeleted(false);
        systemNotice.setAddTime(DateUtil.getNow());
        systemNoticeMapper.insertSelective(systemNotice);
    }

    @Override
    public void updateNotice(NoticeEditRequest request) {
        SystemNotice systemNotice = BeanCopyUtil.copy(request, SystemNotice.class);
        systemNotice.setUpdateTime(DateUtil.getNow());
        systemNoticeMapper.updateByPrimaryKeySelective(systemNotice);
    }

    @Override
    public void deleteNotice(NoticeEditRequest request) {
        SystemNotice notice = new SystemNotice();
        notice.setId(request.getId());
        notice.setUpdateTime(DateUtil.getNow());
        notice.setDeleted(true);
        systemNoticeMapper.updateByPrimaryKeySelective(notice);
    }

    @Override
    public PageInfo<SystemNotice> getByPage(NoticeQueryRequest request) {
        PageHelper.startPage(request.getPage(),request.getRows());
        List<SystemNotice> list = systemNoticeMapper.getList(request);
        return new PageInfo<>(list);
    }
}
