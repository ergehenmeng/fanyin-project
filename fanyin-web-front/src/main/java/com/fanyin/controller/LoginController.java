package com.fanyin.controller;

import com.fanyin.ext.Response;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author 王艳兵
 * @date 2019/7/8 16:11
 */
@RestController
public class LoginController extends AbstractController{


    @PostMapping("/login_exit")
    public Response response(Object o){

        return Response.getInstance();
    }

}
