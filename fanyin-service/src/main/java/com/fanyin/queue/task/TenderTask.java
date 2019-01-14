package com.fanyin.queue.task;

import com.fanyin.dto.tender.Tender;
import com.fanyin.dto.tender.TenderResponse;
import com.fanyin.enums.ErrorCodeEnum;
import com.fanyin.queue.AbstractAsyncTask;
import com.fanyin.service.project.ProjectTenderService;
import com.fanyin.utils.SpringContextUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * 投标任务
 * @author 二哥很猛
 * @date 2018/11/21 15:50
 */
@Slf4j
public class TenderTask extends AbstractAsyncTask<Tender> {

    public TenderTask(Tender data) {
        super(data);
    }

    @Override
    protected void execute(Tender data) {
        try {
            ProjectTenderService projectTenderService = (ProjectTenderService)SpringContextUtil.getBean("projectTenderService");
            projectTenderService.doInvest(data);
        }catch (Exception e){
            log.error("投标任务处理异常",e);
            TenderResponse response = new TenderResponse();
            super.parseCacheException(e,ErrorCodeEnum.TENDER_SYSTEM_ERROR,response);

        }
    }
}
