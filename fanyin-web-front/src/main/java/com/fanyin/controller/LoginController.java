package com.fanyin.controller;

import com.fanyin.ext.RespBody;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author 王艳兵
 * @date 2019/7/8 16:11
 */
@RestController
public class LoginController extends AbstractController{


    @PostMapping("/login_exit")
    public RespBody response(Object o){

        return RespBody.getInstance();
    }

}
