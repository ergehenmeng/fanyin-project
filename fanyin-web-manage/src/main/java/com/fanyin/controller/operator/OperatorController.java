package com.fanyin.controller.operator;

import com.fanyin.configuration.security.SecurityOperator;
import com.fanyin.controller.AbstractController;
import com.fanyin.dto.operator.OperatorAddRequest;
import com.fanyin.dto.operator.OperatorEditRequest;
import com.fanyin.dto.system.operator.OperatorQueryRequest;
import com.fanyin.dto.system.operator.PasswordEditRequest;
import com.fanyin.ext.Paging;
import com.fanyin.ext.ReturnJson;
import com.fanyin.model.system.SystemOperator;
import com.fanyin.model.system.SystemOperatorRole;
import com.fanyin.service.operator.SystemOperatorService;
import com.fanyin.service.system.SystemRoleService;
import com.github.pagehelper.PageInfo;
import com.google.common.base.Joiner;
import com.google.common.base.Splitter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/11/26 17:10
 */
@Controller
public class OperatorController extends AbstractController {

    @Autowired
    private SystemOperatorService systemOperatorService;

    @Autowired
    private SystemRoleService systemRoleService;

    /**
     * 修改密码
     * @param request 请求参数
     * @return 成功状态
     */
    @RequestMapping("/system/operator/change_password")
    @ResponseBody
    public ReturnJson changePassword(HttpSession session, PasswordEditRequest request){
        SecurityOperator operator = super.getRequiredOperator();
        request.setOperatorId(operator.getId());
        String newPassword = systemOperatorService.updateLoginPassword(request);
        operator.setPwd(newPassword);
        //更新用户权限
        SecurityContext context = (SecurityContext)session.getAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY);
        Authentication authentication = context.getAuthentication();
        UsernamePasswordAuthenticationToken token =  new UsernamePasswordAuthenticationToken(operator,authentication,operator.getAuthorities());
        token.setDetails(authentication.getDetails());
        context.setAuthentication(token);

        return ReturnJson.getInstance();
    }

    /**
     * 分页查询系统操作人员列表
     * @param request 查询条件
     * @return 列表
     */
    @RequestMapping("/system/operator/operator_list_page")
    @ResponseBody
    public Paging<SystemOperator> operatorListPage(OperatorQueryRequest request){
        PageInfo<SystemOperator> page = systemOperatorService.getByPage(request);
        return new Paging<>(page);
    }


    /**
     * 添加管理人员
     * @return 成功
     */
    @RequestMapping("/system/operator/add_operator")
    @ResponseBody
    public ReturnJson addOperator(OperatorAddRequest request){
        systemOperatorService.addOperator(request);
        return ReturnJson.getInstance();
    }

    /**
     * 管理人员编辑页面
     * @param id 管理人员id
     * @return 页面
     */
    @RequestMapping("/public/system/operator/edit_operator_page")
    public String editOperatorPage(Model model, Integer id){
        SystemOperator operator = systemOperatorService.getById(id);
        model.addAttribute("operator",operator);
        List<Integer> roleList = systemRoleService.getByOperatorId(id);
        if(roleList != null && roleList.size() > 0){
            String roleIds = Joiner.on(",").join(roleList);
            model.addAttribute("roleIds",roleIds);
        }
        return "public/system/operator/edit_operator_page";
    }

    /**
     * 更新管理人员信息
     * @param request 前台参数
     * @return 成功
     */
    @RequestMapping("/system/operator/edit_operator")
    @ResponseBody
    public ReturnJson editOperator(OperatorEditRequest request){

        return ReturnJson.getInstance();
    }

}
