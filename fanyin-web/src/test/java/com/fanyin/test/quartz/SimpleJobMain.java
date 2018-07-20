package com.fanyin.test.quartz;

import org.quartz.*;
import org.quartz.impl.StdSchedulerFactory;
import org.quartz.impl.triggers.SimpleTriggerImpl;


/**
 * @author 王艳兵
 * @date 2018/7/17 14:21
 */
public class SimpleJobMain {
    public static void main(String[] args) throws Exception{
        JobDetail detail = JobBuilder.newJob(SimpleJob.class).withIdentity("job_1","group_1").build();

        TriggerBuilder<Trigger> builder = TriggerBuilder.<SimpleTriggerImpl>newTrigger();
        SimpleTrigger build = builder.startNow().
                withSchedule(SimpleScheduleBuilder.simpleSchedule().withIntervalInSeconds(2).withRepeatCount(2))
                .forJob("job_1","group_1").build();
        SchedulerFactory factory = new StdSchedulerFactory();
        Scheduler scheduler = factory.getScheduler();
        scheduler.scheduleJob(build);
        scheduler.start();
    }
}
