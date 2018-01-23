package com.fanyin.controller.system;

import com.fanyin.constant.CommonConstant;
import com.fanyin.controller.BaseController;
import com.google.code.kaptcha.Producer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;

/**
 * @description: 图形验证码controller
 * @author: 二哥很猛
 * @date: 2018/1/19
 * @time: 11:50
 */
@Controller
public class CaptchaController extends BaseController {

    @Autowired
    private Producer producer;

    /**
     * 图形验证码
     * @return
     */
    @GetMapping("/captcha")
    @ResponseBody
    public String captcha(HttpSession session, HttpServletResponse response)throws Exception{
        response.setDateHeader("Expires", 0);
        response.setHeader("CacheCreate-Control", "no-store");
        response.setHeader("Pragma", "no-cache");
        response.setContentType("image/jpeg");

        String capText = producer.createText();
        System.out.println("******************验证码是: " + capText + "******************");
        this.putSession(session, CommonConstant.AUTH_CODE, capText);
        BufferedImage bi = producer.createImage(capText);
        ServletOutputStream out = response.getOutputStream();
        ImageIO.write(bi, "jpg", out);
        out.flush();
        out.close();
        return null;
    }
}
