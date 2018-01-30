package com.fanyin.controller.system;

import com.fanyin.ext.ResultJson;
import com.fanyin.model.system.SystemMenu;
import com.fanyin.service.system.SystemMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author 王艳兵
 * @date 2018/1/30 09:30
 */
@Controller
public class MenuController {

    @Autowired
    private SystemMenuService systemMenuService;

    @PostMapping("/public/system/menu/edit_menu_page")
    public String editMenuPage(HttpServletRequest request,Integer id){
        SystemMenu menu = systemMenuService.getMenuById(id);
        request.setAttribute("menu",menu);
        return "public/system/menu/edit_menu_page";
    }

    @PostMapping("/system/menu/menu_list")
    @ResponseBody
    public ResultJson<List<SystemMenu>> menuList(){
        List<SystemMenu> allList = systemMenuService.getAllList();
        return ResultJson.<List<SystemMenu>>getInstance().setData(allList);
    }
}
