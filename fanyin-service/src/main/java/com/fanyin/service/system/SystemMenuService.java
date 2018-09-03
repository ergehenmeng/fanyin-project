package com.fanyin.service.system;

import com.fanyin.model.system.SystemMenu;
import com.fanyin.request.system.menu.MenuInsertRequest;
import com.fanyin.request.system.menu.MenuUpdateRequest;

import java.util.List;

/**
 * @author 二哥很猛
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

    /**
     * 添加菜单
     * @param request 要添加的菜单信息
     */
    void addMenu(MenuInsertRequest request);

    /**
     * 更新菜单信息
     * @param request 要更新的菜单信息
     */
    void updateMenu(MenuUpdateRequest request);

    /**
     * 根据主键删除菜单
     * @param id 主键
     */
    void deleteMenu(Integer id);
}
