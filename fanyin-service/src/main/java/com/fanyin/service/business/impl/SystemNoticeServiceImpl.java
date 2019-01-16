package com.fanyin.service.business.impl;

import com.fanyin.dto.business.NoticeAddRequest;
import com.fanyin.dto.business.NoticeEditRequest;
import com.fanyin.dto.business.NoticeQueryRequest;
import com.fanyin.mapper.business.SystemNoticeMapper;
import com.fanyin.model.business.SystemNotice;
import com.fanyin.service.business.SystemNoticeService;
import com.fanyin.utils.BeanCopyUtil;
import com.fanyin.utils.DateUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 系统公告
 * @author 二哥很猛
 * @date 2018/11/20 19:11
 */
@Service("systemNoticeService")
@Transactional(rollbackFor = RuntimeException.class)
public class SystemNoticeServiceImpl implements SystemNoticeService {

    @Autowired
    private SystemNoticeMapper systemNoticeMapper;

    @Override
    public void addNotice(NoticeAddRequest request) {
        SystemNotice systemNotice = BeanCopyUtil.copy(request, SystemNotice.class);
        //默认正常
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
        //删除
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
