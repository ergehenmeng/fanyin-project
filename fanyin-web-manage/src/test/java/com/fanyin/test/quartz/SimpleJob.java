package com.fanyin.test.quartz;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import java.util.Date;

/**
 * @author 二哥很猛
 * @date 2018/7/17 14:25
 */
public class SimpleJob implements Job {

    @Override
    public void execute(JobExecutionContext context) throws JobExecutionException {
        System.out.println(context.getTrigger().getKey().getName() + " trigger .... " + new Date());
    }
}
