package com.fanyin.controller.system;

import com.fanyin.annotation.Mark;
import com.fanyin.annotation.RequestType;
import com.fanyin.model.system.SystemDepartment;
import com.fanyin.service.system.SystemDepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author 二哥很猛
 * @date 2019/1/17 16:27
 */
@Controller
public class DepartmentController {

    @Autowired
    private SystemDepartmentService systemDepartmentService;

    /**
     * 查询所有部门列表
     * @return list
     */
    @PostMapping("/system/department/list_page")
    @Mark(RequestType.SELECT)
    @ResponseBody
    public List<SystemDepartment> listPage(){
        return systemDepartmentService.getDepartment();
    }

    //.
    // @PostMapping("/system/department/add")

}
