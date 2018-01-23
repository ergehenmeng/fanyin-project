package com.fanyin.controller.system;

import com.fanyin.controller.BaseController;
import com.fanyin.ext.ResultJson;
import com.fanyin.model.system.SystemOperator;
import com.fanyin.request.system.LoginRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * @description: 首页及登陆
 * @author: 二哥很猛
 * @date: 2018/1/8
 * @time: 14:41
 */
@Controller
public class LoginController extends BaseController {

    @GetMapping("/")
    public String index(HttpSession session){
        SystemOperator operator = this.getOperator(session);
        if(operator != null){
            return "redirect:/home";
        }
        return "index";
    }

    /**
     * 系统管理员登陆
     * @return
     */
    @PostMapping("/login")
    @ResponseBody
    public ResultJson login(LoginRequest request){

        return null;
    }
}
