package com.fanyin.utils;

import com.alibaba.fastjson.JSONObject;
import com.fanyin.ext.ResultJson;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * @description: web工具类
 * @author: 二哥很猛
 * @date: 2018/1/26
 * @time: 10:30
 */
public class WebUtils {

    /**
     * 直接返回前台json格式信息
     * @param response 响应对象
     * @param object json内容
     * @throws Exception 异常信息
     */
    public static void printJson(HttpServletResponse response, ResultJson<Object> object) throws IOException{
        response.setCharacterEncoding("UTF-8");
        PrintWriter writer = response.getWriter();
        try {
            response.setContentType("application/json;charset=utf-8");
            writer.write(JSONObject.toJSONString(object));
            writer.flush();
        }finally {
            if (writer != null){
                writer.close();
            }
        }
    }
}
