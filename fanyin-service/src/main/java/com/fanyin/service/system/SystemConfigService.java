package com.fanyin.service.system;


import com.alibaba.fastjson.JSONObject;
import com.fanyin.model.system.SystemConfig;
import com.fanyin.request.system.config.ConfigInsertRequest;
import com.fanyin.request.system.config.ConfigSelectRequest;
import com.fanyin.request.system.config.ConfigUpdateRequest;
import com.github.pagehelper.PageInfo;


/**
 * @author: 二哥很猛
 * @date: 2018/1/12
 * @time: 09:45
 */
public interface SystemConfigService {

    /**
     * 更新系统参数
     * @param request 待更新的参数对象
     */
    void updateConfig(ConfigUpdateRequest request);

    /**
     * 分页查询系统配置信息
     * @param request 查询条件
     * @return 分页结果集
     */
    PageInfo<SystemConfig> getListByPage(ConfigSelectRequest request);

    /**
     * 根据nid获取系统配置信息
     * @param nid 唯一nid
     * @return 参数配置独享
     */
    SystemConfig getConfigByNid(String nid);

    /**
     * 根据主键获取系统参数
     * @param id 主键
     * @return 系统参数信息
     */
    SystemConfig getConfigById(Integer id);

    /**
     * 新增系统参数
     * @param request 必填选项
     */
    void addConfig(ConfigInsertRequest request);

    /**
     * 根据nid获取系统参数配置信息的值
     * @param nid 唯一nid
     * @return 系统参数结果值string
     */
    String getStringByNid(String nid);

    /**
     * 根据nid获取系统参数配置信息的值,支持以下类型(yes,true,on,y,t,n,f,no,off,false)
     * @param nid 唯一nid
     * @return 系统参数结果值boolean
     */
    boolean getBooleanByNid(String nid);

    /**
     * 根据nid获取系统参数配置信息的值
     * @param nid 唯一nid
     * @return 系统参数结果值int 如果转换失败为0
     */
    int getIntByNid(String nid);

    /**
     * 根据nid获取系统参数配置信息的值
     * @param nid 唯一nid
     * @return 系统参数结果值json,如果异常则抛出
     */
    JSONObject getJsonByNid(String nid);

    /**
     * 根据nid获取系统参数配置信息的值
     * @param nid 唯一nid
     * @param cls 要转换的类型
     * @return 系统参数结果值class,如果异常则抛出
     */
     <T> T getClassByNid(String nid, Class<T> cls);
}
