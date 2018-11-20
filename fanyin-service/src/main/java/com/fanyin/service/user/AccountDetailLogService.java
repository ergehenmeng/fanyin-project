package com.fanyin.service.user;

import com.fanyin.model.project.ProjectTender;
import com.fanyin.model.user.AccountDetailLog;

/**
 * @author 二哥很猛
 * @date 2018/11/19 16:48
 */
public interface AccountDetailLogService {

    /**
     * 满标复审解冻资金<br>
     * 投标冻结减少,待收本金,待收利息增加
     * @param tender 投标信息
     */
    void fullAuditUnfreeze(ProjectTender tender);

    /**
     * 操作资金,所有投资人关于资金操作均以该接口为入口
     * @param detailLog 资金信息
     */
    void capitalOperation(AccountDetailLog detailLog);

    /**
     * 投标冻结资金
     * 总金额减少,可用余额减少,冻结增加
     * @param tender 投标信息
     */
    void tenderFreeze(ProjectTender tender);
}

