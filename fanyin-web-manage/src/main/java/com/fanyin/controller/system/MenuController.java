package com.fanyin.controller.system;

import com.fanyin.ext.ResultJson;
import com.fanyin.model.system.SystemMenu;
import com.fanyin.dto.system.menu.MenuAddRequest;
import com.fanyin.dto.system.menu.MenuEditRequest;
import com.fanyin.service.system.SystemMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/1/30 09:30
 */
@Controller
public class MenuController {

    @Autowired
    private SystemMenuService systemMenuService;

    /**
     * 菜单编辑页面
     * @param request 请求对象
     * @param id 菜单主键
     * @return 页面地址
     */
    @PostMapping("/public/system/menu/edit_menu_page")
    public String editMenuPage(HttpServletRequest request,Integer id){
        SystemMenu menu = systemMenuService.getMenuById(id);
        request.setAttribute("menu",menu);
        return "public/system/menu/edit_menu_page";
    }

    /**
     * 获取所有可用的菜单列表
     * @return list
     */
    @PostMapping("/system/menu/menu_list")
    @ResponseBody
    public ResultJson<List<SystemMenu>> menuList(){
        List<SystemMenu> allList = systemMenuService.getAllList();
        return ResultJson.<List<SystemMenu>>getInstance().setData(allList);
    }

    /**
     * 新增菜单
     * @param request 请求参数组装
     * @return 成功状态
     */
    @PostMapping("/system/menu/add_menu")
    @ResponseBody
    public ResultJson addMenu(MenuAddRequest request){
        systemMenuService.addMenu(request);
        return ResultJson.getInstance();
    }

    /**
     * 更新菜单信息
     * @param request 菜单信息
     * @return 成功返回值
     */
    @PostMapping("/system/menu/edit_menu")
    @ResponseBody
    public ResultJson editMenu(MenuEditRequest request){
        systemMenuService.updateMenu(request);
        return ResultJson.getInstance();
    }

    /**
     * 根据主键删除菜单
     * @param id 主键
     * @return 成功后的返回信息
     */
    @PostMapping("/system/menu/delete_menu")
    public ResultJson deleteMenu(Integer id){
        systemMenuService.deleteMenu(id);
        return ResultJson.getInstance();
    }

}
