package com.fanyin.controller.system;


import com.fanyin.controller.AbstractController;
import com.fanyin.ext.Paging;
import com.fanyin.ext.ResultJson;
import com.fanyin.model.system.SystemConfig;
import com.fanyin.request.system.config.ConfigInsertRequest;
import com.fanyin.request.system.config.ConfigSelectRequest;
import com.fanyin.request.system.config.ConfigUpdateRequest;
import com.fanyin.service.system.SystemConfigService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;


/**
 * @author 二哥很猛
 * @date 2018/1/12 17:40
 */
@Controller
public class ConfigController extends AbstractController {

    @Autowired
    private SystemConfigService systemConfigService;

    @PostMapping("/system/config/edit_config")
    @ResponseBody
    public ResultJson editConfig(ConfigUpdateRequest request){
        systemConfigService.updateConfig(request);
        return ResultJson.getInstance();
    }

    /**
     * 参数编辑页面
     * @param request 请求对象
     * @param id 主键
     * @return 页面
     */
    @PostMapping("/public/system/config/edit_config_page")
    public String editConfigPage(HttpServletRequest request,Integer id){
        SystemConfig config = systemConfigService.getConfigById(id);
        request.setAttribute("config",config);
        return "public/system/config/edit_config_page";
    }

    /**
     * 分页获取系统参数配置
     * @param request 查询
     * @return 分页列表
     */
    @PostMapping("/system/config/config_list")
    @ResponseBody
    public Paging<SystemConfig> systemConfigList(ConfigSelectRequest request){
        PageInfo<SystemConfig> listByPage = systemConfigService.getListByPage(request);
        return new Paging<>(listByPage);
    }

    /**
     * 添加系统参数
     * @return 成功或失败的结果集
     */
    @PostMapping("/system/config/add_config")
    @ResponseBody
    public ResultJson<String> addConfig(ConfigInsertRequest request){
        systemConfigService.addConfig(request);
        return ResultJson.getInstance();
    }
}
