package com.fanyin.controller.system;

import com.fanyin.dto.common.CheckBox;
import com.fanyin.dto.system.role.RoleAddRequest;
import com.fanyin.dto.system.role.RoleEditRequest;
import com.fanyin.dto.system.role.RoleQueryRequest;
import com.fanyin.ext.Paging;
import com.fanyin.ext.Response;
import com.fanyin.model.system.SystemRole;
import com.fanyin.service.system.SystemRoleService;
import com.fanyin.utils.DataUtil;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/11/26 15:21
 */
@Controller
public class RoleController {

    @Autowired
    private SystemRoleService systemRoleService;

    /**
     * 根据条件分页查询角色列表
     * @param request 查询条件
     * @return 列表
     */
    @RequestMapping("/system/role/role_list_page")
    @ResponseBody
    public Paging<SystemRole> roleListPage(RoleQueryRequest request){
        PageInfo<SystemRole> page = systemRoleService.getByPage(request);
        return new Paging<>(page);
    }

    /**
     * 获取所有可用的角色列表
     * @return 角色列表
     */
    @RequestMapping("/system/role/role_list")
    @ResponseBody
    public Response<List<CheckBox>> roleList(){
        List<SystemRole> list = systemRoleService.getList();
        //将角色列表转换为checkBox所能识别的列表同时封装为ReturnJson对象
        return Response.<List<CheckBox>>getInstance().setData(
                DataUtil.transform(list,
                    systemRole -> new CheckBox(systemRole.getId(), systemRole.getRoleName())
                )
        );
    }

    /**
     * 编辑角色信息
     * @param id 角色id
     * @return 角色编辑信息
     */
    @RequestMapping("/public/system/role/edit_role_page")
    public String editRolePage(Model model, Integer id){
        SystemRole role = systemRoleService.getById(id);
        model.addAttribute("role",role);
        return "public/system/role/edit_role_page";
    }

    /**
     * 更新角色信息
     * @param request 前台请求参数
     * @return 成功
     */
    @RequestMapping("/system/role/edit_role")
    @ResponseBody
    public Response editRole(RoleEditRequest request){
        systemRoleService.updateRole(request);
        return Response.getInstance();
    }

    /**
     * 删除角色信息
     * @param id 主键
     * @return 成功
     */
    @RequestMapping("/system/role/delete_role")
    @ResponseBody
    public Response deleteRole(Integer id){
        systemRoleService.deleteRole(id);
        return Response.getInstance();
    }

    /**
     * 添加角色信息
     * @param request 前台参数
     * @return 成功
     */
    @RequestMapping("/system/role/add_role")
    @ResponseBody
    public Response addRole(RoleAddRequest request){
        systemRoleService.addRole(request);
        return Response.getInstance();
    }
}
