package com.fanyin.service.system;


import com.fanyin.model.system.SystemConfig;
import com.fanyin.dto.system.config.ConfigInsertRequest;
import com.fanyin.dto.system.config.ConfigSelectRequest;
import com.fanyin.dto.system.config.ConfigUpdateRequest;
import com.github.pagehelper.PageInfo;


/**
 * @author 二哥很猛
 * @date 2018/1/12 09:45
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


}
