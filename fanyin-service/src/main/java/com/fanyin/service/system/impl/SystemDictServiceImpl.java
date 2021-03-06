package com.fanyin.service.system.impl;


import com.fanyin.constant.RedisConstant;
import com.fanyin.dto.system.dict.DictAddRequest;
import com.fanyin.dto.system.dict.DictEditRequest;
import com.fanyin.dto.system.dict.DictQueryRequest;
import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.exception.BusinessException;
import com.fanyin.mapper.system.SystemDictMapper;
import com.fanyin.model.system.SystemDict;
import com.fanyin.service.system.SystemDictService;
import com.fanyin.utils.BeanCopyUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 数据字典服务类
 * @author 二哥很猛
 * @date 2018/1/12 14:31
 */
@Service("systemDictService")
@Transactional(rollbackFor = RuntimeException.class)
public class SystemDictServiceImpl implements SystemDictService {

    @Autowired
    private SystemDictMapper systemDictMapper;

    @Override
    @Cacheable(cacheNames = RedisConstant.SYSTEM_DICT,key = "#p0")
    public List<SystemDict> getDictByNid(String nid) {
        return systemDictMapper.getDictByNid(nid);
    }

    @Override
    public PageInfo<SystemDict> getByPage(DictQueryRequest request) {
        PageHelper.startPage(request.getPage(),request.getPageSize());
        List<SystemDict> list = systemDictMapper.getList(request);
        return new PageInfo<>(list);
    }

    @Override
    public void addDict(DictAddRequest request) {
        SystemDict systemDict = BeanCopyUtil.copy(request, SystemDict.class);
        systemDict.setDeleted(false);
        systemDictMapper.insertSelective(systemDict);
    }

    @Override
    public void updateDict(DictEditRequest request) {
        SystemDict systemDict = BeanCopyUtil.copy(request, SystemDict.class);
        systemDictMapper.updateByPrimaryKeySelective(systemDict);
    }

    @Override
    public void deleteDict(Integer id) {
        SystemDict dict = new SystemDict();
        dict.setDeleted(true);
        dict.setId(id);
        int i = systemDictMapper.updateByIdSelective(dict);
        if(i != 1){
            throw new BusinessException(ErrorCodeEnum.DICT_LOCKED_ERROR);
        }
    }

    @Override
    public SystemDict getById(Integer id) {
        return systemDictMapper.selectByPrimaryKey(id);
    }

}
