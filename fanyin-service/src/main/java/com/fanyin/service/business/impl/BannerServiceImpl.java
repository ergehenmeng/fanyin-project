package com.fanyin.service.business.impl;

import com.fanyin.enums.Source;
import com.fanyin.enums.SourceClassify;
import com.fanyin.mapper.business.BannerMapper;
import com.fanyin.model.business.Banner;
import com.fanyin.service.business.BannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/10/17 9:50
 */
@Service("bannerService")
@Transactional(rollbackFor = RuntimeException.class)
public class BannerServiceImpl implements BannerService {

    @Autowired
    private BannerMapper bannerMapper;


    @Override
    public List<Banner> getBanner(Source source, Byte type) {
        byte clientType = SourceClassify.getType(source);
        return bannerMapper.getBannerList(type,clientType);
    }
}
