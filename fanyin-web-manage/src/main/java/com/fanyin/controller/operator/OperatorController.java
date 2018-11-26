package com.fanyin.controller.operator;

import com.fanyin.controller.AbstractController;
import com.fanyin.dto.system.operator.PasswordEditRequest;
import com.fanyin.dto.system.operator.OperatorQueryRequest;
import com.fanyin.ext.Paging;
import com.fanyin.ext.ReturnJson;
import com.fanyin.model.system.SystemOperator;
import com.fanyin.service.operator.SystemOperatorService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author 二哥很猛
 * @date 2018/11/26 17:10
 */
@Controller
public class OperatorController extends AbstractController {

    @Autowired
    private SystemOperatorService systemOperatorService;


    /**
     * 修改密码
     * @param request 请求参数
     * @return 成功状态
     */
    @RequestMapping("/system/operator/change_password")
    @ResponseBody
    public ReturnJson changePassword(PasswordEditRequest request){
        SystemOperator operator = super.getRequiredOperator();
        request.setOperatorId(operator.getId());
        systemOperatorService.updateLoginPassword(request);
        return ReturnJson.getInstance();
    }

    /**
     * 分页查询系统操作人员列表
     * @param request 查询条件
     * @return 列表
     */
    @RequestMapping("/system/operator/operator_list")
    @ResponseBody
    public Paging<SystemOperator> operatorList(OperatorQueryRequest request){
        PageInfo<SystemOperator> page = systemOperatorService.getByPage(request);
        return new Paging<>(page);
    }

}
