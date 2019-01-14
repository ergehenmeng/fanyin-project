package com.fanyin.service.system.impl;

import com.fanyin.dto.system.department.DepartmentAddRequest;
import com.fanyin.mapper.system.DepartmentMapper;
import com.fanyin.model.system.Department;
import com.fanyin.service.system.DepartmentService;
import com.fanyin.utils.BeanCopyUtil;
import com.fanyin.utils.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/12/13 16:49
 */
@Service("departmentService")
@Transactional(rollbackFor = RuntimeException.class)
public class DepartmentServiceImpl implements DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Override
    public void addDepartment(DepartmentAddRequest request) {
        Department department = BeanCopyUtil.copy(request, Department.class);
        String code = this.getNextCode(request.getParentCode());
        department.setCode(code);
        department.setDeleted(false);
        department.setAddTime(DateUtil.getNow());
        departmentMapper.insertSelective(department);
    }

    @Override
    public String getNextCode(String code) {
        List<Department> childList = departmentMapper.getChildList(code);
        if(childList == null || childList.isEmpty()){
            return code + "101";
        }
        Department department = childList.get(0);
        return String.valueOf(Long.parseLong(department.getCode()) + 1);
    }

}
