package com.fanyin.service.operator;

import com.fanyin.dto.system.operator.PasswordEditRequest;
import com.fanyin.dto.system.operator.OperatorQueryRequest;
import com.fanyin.model.system.SystemOperator;
import com.github.pagehelper.PageInfo;

/**
 * @author 二哥很猛
 * @date 2018/11/26 10:24
 */
public interface SystemOperatorService {

    /**
     * 根据手机号码查询管理员信息
     * @param mobile 手机号码
     * @return 系统管理人员
     */
    SystemOperator getByMobile(String mobile);

    /**
     * 更新登陆密码
     * @param request 前台参数
     * @return 新加密过的密码
     */
    String updateLoginPassword(PasswordEditRequest request);

    /**
     * 分页查询系统人员信息
     * @param request 请求参数
     * @return 系统人员信息
     */
    PageInfo<SystemOperator> getByPage(OperatorQueryRequest request);
}

