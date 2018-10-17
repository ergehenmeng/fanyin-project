package com.fanyin.service.operation.impl;

import com.fanyin.enums.Source;
import com.fanyin.enums.SourceKind;
import com.fanyin.mapper.operation.BannerMapper;
import com.fanyin.model.operation.Banner;
import com.fanyin.service.operation.BannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/10/17 9:50
 */
@Service("bannerService")
public class BannerServiceImpl implements BannerService {

    @Autowired
    private BannerMapper bannerMapper;


    @Override
    public List<Banner> getBanner(Source source, Byte type) {
        byte clientType = SourceKind.getType(source);
        return bannerMapper.getBannerList(type,clientType);
    }
}
