package com.fanyin.controller.system;


import com.fanyin.controller.BaseController;
import com.fanyin.ext.ResultJson;
import com.fanyin.request.system.SystemConfigUpdateRequest;
import com.fanyin.service.system.SystemConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;


/**
 * @description:
 * @author: 二哥很猛
 * @date: 2018/1/12
 * @time: 17:40
 */
@Controller
public class SystemConfigController extends BaseController {

    @Autowired
    private SystemConfigService systemConfigService;

    @PostMapping("/system/config/update_config")
    public ResultJson updateConfig(SystemConfigUpdateRequest config){
        systemConfigService.updateConfig(null);
        return ResultJson.getInstance();
    }
}
