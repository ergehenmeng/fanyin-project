package com.fanyin.controller.system;

import com.fanyin.annotation.Mark;
import com.fanyin.annotation.RequestType;
import com.fanyin.dto.common.CheckBox;
import com.fanyin.dto.system.role.RoleAddRequest;
import com.fanyin.dto.system.role.RoleEditRequest;
import com.fanyin.dto.system.role.RoleQueryRequest;
import com.fanyin.ext.Paging;
import com.fanyin.ext.RespBody;
import com.fanyin.model.system.SystemRole;
import com.fanyin.service.system.SystemRoleService;
import com.fanyin.utils.DataUtil;
import com.github.pagehelper.PageInfo;
import com.google.common.base.Joiner;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
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
    @PostMapping("/system/role/role_list_page")
    @ResponseBody
    @Mark(RequestType.SELECT)
    public RespBody roleListPage(RoleQueryRequest request){
        PageInfo<SystemRole> page = systemRoleService.getByPage(request);
        return RespBody.<Paging<SystemRole>>getInstance().setData(new Paging<>(page));
    }

    /**
     * 获取所有可用的角色列表
     * @return 角色列表
     */
    @PostMapping("/system/role/role_list")
    @ResponseBody
    @Mark(RequestType.SELECT)
    public RespBody<List<CheckBox>> roleList(){
        List<SystemRole> list = systemRoleService.getList();
        //将角色列表转换为checkBox所能识别的列表同时封装为ReturnJson对象
        return RespBody.<List<CheckBox>>getInstance().setData(DataUtil.transform(list, systemRole -> new CheckBox(systemRole.getId(), systemRole.getRoleName())));
    }

    /**
     * 编辑角色信息
     * @param id 角色id
     * @return 角色编辑信息
     */
    @PostMapping("/public/system/role/edit_role_page")
    @Mark(RequestType.PAGE)
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
    @PostMapping("/system/role/edit_role")
    @ResponseBody
    @Mark(RequestType.UPDATE)
    public RespBody editRole(RoleEditRequest request){
        systemRoleService.updateRole(request);
        return RespBody.getInstance();
    }

    /**
     * 删除角色信息
     * @param id 主键
     * @return 成功
     */
    @PostMapping("/system/role/delete_role")
    @ResponseBody
    @Mark(RequestType.DELETE)
    public RespBody deleteRole(Integer id){
        systemRoleService.deleteRole(id);
        return RespBody.getInstance();
    }

    /**
     * 添加角色信息
     * @param request 前台参数
     * @return 成功
     */
    @PostMapping("/system/role/add_role")
    @ResponseBody
    @Mark(RequestType.INSERT)
    public RespBody addRole(RoleAddRequest request){
        systemRoleService.addRole(request);
        return RespBody.getInstance();
    }

    /**
     * 角色授权页面
     * @param model model
     * @param id 角色id
     * @return 角色编辑信息
     */
    @PostMapping("/public/system/role/auth_role_page")
    @Mark(RequestType.PAGE)
    public String authRolePage(Model model, Integer id){
        List<Integer> role = systemRoleService.getRoleMenu(id);
        String menuIds = Joiner.on(",").join(role);
        model.addAttribute("menuIds",menuIds);
        model.addAttribute("roleId",id);
        return "public/system/role/auth_role_page";
    }

    /**
     * 保存角色菜单关联信息
     * @param roleId 角色id
     * @param menuIds 菜单
     * @return 响应
     */
    @PostMapping("/system/role/auth_role")
    @ResponseBody
    @Mark(RequestType.ALL)
    public RespBody authRole(Integer roleId, String menuIds){
        systemRoleService.authMenu(roleId,menuIds);
        return RespBody.getInstance();
    }
}
