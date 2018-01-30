package com.fanyin.service.system;

import com.fanyin.model.system.SystemMenu;

import java.util.List;

/**
 * @author 王艳兵
 * @date 2018/1/26 16:14
 */
public interface SystemMenuService {


    /**
     * 获取用户菜单列表
     * @param userId 用户id
     * @return 菜单列表(一级菜单 内部包含二级菜单)
     */
    List<SystemMenu> getUserMenuList(Integer userId);

    /**
     * 根据主键查询菜单
     * @param id 主键
     * @return 单个菜单
     */
    SystemMenu getMenuById(Integer id);

    /**
     * 获取所有可用的菜单
     * @return 菜单列表
     */
    List<SystemMenu> getAllList();
}
