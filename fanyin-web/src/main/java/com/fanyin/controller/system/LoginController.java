package com.fanyin.controller.system;

import com.fanyin.controller.BaseController;
import com.fanyin.model.system.SystemMenu;
import com.fanyin.model.system.SystemOperator;
import com.fanyin.service.system.SystemMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @description: 首页及登陆
 * @author: 二哥很猛
 * @date: 2018/1/8
 * @time: 14:41
 */
@Controller
public class LoginController extends BaseController {

    @Autowired
    private SystemMenuService systemMenuService;

    /**
     * 未登录的首页
     * @return
     */
    @GetMapping("/")
    public String index(){
        return "index";
    }

    /**
     * 登陆后的首页
     * @return home页面
     */
    @GetMapping("/home")
    public String home(HttpServletRequest request){
        SystemOperator operator = getOperator();
        List<SystemMenu> list = systemMenuService.getUserMenuList(operator.getId());
        request.setAttribute("menuList", list);
        return "home";
    }
}
