package com.fanyin.service.borrower;

import com.fanyin.dto.borrower.BorrowerAccountDetailLog;
import com.fanyin.model.borrower.BorrowerAccountLog;
import com.fanyin.model.project.Project;

/**
 * @author 二哥很猛
 * @date 2018/11/20 13:51
 */
public interface BorrowerAccountLogService {

    /**
     * 满标复审放款成功
     * 可用余额增加,待还金额增加,总借款金额增加
     * @param project 产品信息
     */
    void loanSuccess(Project project);


    /**
     * 更新借款人资金账户,所有资金更新最终都会调用该接口
     * @param accountDetailLog 资金信息
     */
    void capitalOperation(BorrowerAccountDetailLog accountDetailLog);
}

