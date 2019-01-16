package com.fanyin.controller.system;

import com.fanyin.dto.system.log.OperationQueryRequest;
import com.fanyin.ext.Paging;
import com.fanyin.model.system.SystemOperationLog;
import com.fanyin.service.system.OperationLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author 二哥很猛
 * @date 2019/1/16 10:37
 */
@Controller
public class OperationLogController {

    @Autowired
    private OperationLogService operationLogService;

    /**
     * 操作日期查询请求
     * @param request 查询条件
     * @return 分页
     */
    @PostMapping("/system/operation/operation_log_list_page")
    @ResponseBody
    public Paging<SystemOperationLog> operationLogListPage(OperationQueryRequest request){
        return new Paging<>(operationLogService.getByPage(request));
    }

}
