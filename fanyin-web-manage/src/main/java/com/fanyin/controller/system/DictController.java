package com.fanyin.controller.system;

import com.fanyin.dto.system.dict.DictAddRequest;
import com.fanyin.dto.system.dict.DictEditRequest;
import com.fanyin.dto.system.dict.DictQueryRequest;
import com.fanyin.ext.Paging;
import com.fanyin.ext.Response;
import com.fanyin.model.system.SystemDict;
import com.fanyin.service.system.SystemDictService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author 二哥很猛
 * @date 2019/1/14 11:10
 */
@Controller
public class DictController {

    @Autowired
    private SystemDictService systemDictService;

    /**
     * 分页查询数据字典列表
     * @param request 前台参数
     * @return 分页列表
     */
    @PostMapping("/system/dict/dict_list_page")
    @ResponseBody
    public Paging<SystemDict> dictListPage(DictQueryRequest request){
        return new Paging<>(systemDictService.getByPage(request));
    }

    /**
     * 编辑数据字典页面
     * @param id id
     * @return 页面地址
     */
    @GetMapping("/system/dict/edit_dict_page")
    public String editDictPage(Model model,Integer id){
        SystemDict dict = systemDictService.getById(id);
        model.addAttribute("dict",dict);
        return "system/dict/edit_dict_page";
    }

    /**
     * 添加数据字典
     * @param request 前台参数
     * @return 成功响应
     */
    @PostMapping("/system/dict/add_dict")
    @ResponseBody
    public Response addDict(DictAddRequest request){
        systemDictService.addDict(request);
        return Response.getInstance();
    }

    /**
     * 编辑数据字典
     * @param request 前台参数
     * @return 结果
     */
    @PostMapping("/system/dict/edit_dict")
    @ResponseBody
    public Response editDict(DictEditRequest request){
        systemDictService.updateDict(request);
        return Response.getInstance();
    }


    /**
     * 删除数据字典项
     * @param id 主键
     * @return 成功响应
     */
    @PostMapping("/system/dict/delete_dict")
    @ResponseBody
    public Response deleteDict(Integer id){
        systemDictService.deleteDict(id);
        return Response.getInstance();
    }

}
