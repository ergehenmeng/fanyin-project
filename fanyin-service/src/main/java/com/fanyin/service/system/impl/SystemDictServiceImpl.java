package com.fanyin.service.system.impl;


import com.fanyin.constant.RedisConstant;
import com.fanyin.mapper.system.SystemDictMapper;
import com.fanyin.model.system.SystemDict;
import com.fanyin.service.system.SystemDictService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 数据字典服务类
 * @author 二哥很猛
 * @date 2018/1/12 14:31
 */
@Service("systemDictService")
public class SystemDictServiceImpl implements SystemDictService {

    @Autowired
    private SystemDictMapper systemDictMapper;

    @Override
    @Cacheable(cacheNames = RedisConstant.SYSTEM_DICT,key = "#p0")
    public List<SystemDict> getDictByNid(String nid) {
        return systemDictMapper.getDictByNid(nid);
    }



}
