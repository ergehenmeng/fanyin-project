package com.fanyin.service.system;

import com.fanyin.model.system.SystemDict;


import java.util.List;

/**
 * 数据字典服务类
 * @author 二哥很猛
 * @date 2018/1/12 14:31
 */
public interface SystemDictService {


    /**
     * 根据nid查询某一类数据字典列表
     * @param nid 某一类数据字典key
     * @return 属于该nid的列表
     */
    List<SystemDict> getDictByNid(String nid);

}
