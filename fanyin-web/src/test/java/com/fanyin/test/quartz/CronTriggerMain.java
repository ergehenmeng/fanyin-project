package com.fanyin.test.quartz;

import org.quartz.*;
import org.quartz.impl.StdSchedulerFactory;

/**
 * @author 王艳兵
 * @date 2018/7/17 15:13
 */
public class CronTriggerMain {
    public static void main(String[] args) throws Exception{
        JobDetail detail = JobBuilder.newJob(SimpleJob.class).withIdentity("job_1", "group_1").build();
        CronTrigger build = TriggerBuilder.newTrigger().withSchedule(CronScheduleBuilder.cronSchedule("0/5 * * * * ?")).build();

        SchedulerFactory factory = new StdSchedulerFactory();
        Scheduler scheduler = factory.getScheduler();
        scheduler.scheduleJob(detail,build);
        scheduler.start();
    }
}
