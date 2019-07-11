package com.fanyin.service.system.impl;

import com.fanyin.dto.system.department.DepartmentAddRequest;
import com.fanyin.mapper.system.SystemDepartmentMapper;
import com.fanyin.model.system.SystemDepartment;
import com.fanyin.service.system.SystemDepartmentService;
import com.fanyin.utils.BeanCopyUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/12/13 16:49
 */
@Service("systemDepartmentService")
@Transactional(rollbackFor = RuntimeException.class)
public class SystemDepartmentServiceImpl implements SystemDepartmentService {

    @Autowired
    private SystemDepartmentMapper systemDepartmentMapper;

    @Override
    public List<SystemDepartment> getDepartment() {
        return systemDepartmentMapper.getList();
    }

    @Override
    public void addDepartment(DepartmentAddRequest request) {
        SystemDepartment department = BeanCopyUtil.copy(request, SystemDepartment.class);
        String code = this.getNextCode(request.getParentCode());
        department.setCode(code);
        department.setDeleted(false);
        systemDepartmentMapper.insertSelective(department);
    }

    @Override
    public String getNextCode(String code) {
        SystemDepartment child = systemDepartmentMapper.getMaxCodeChild(code);
        if(child == null){
            return code + "101";
        }
        return String.valueOf(Long.parseLong(child.getCode()) + 1);
    }

}
