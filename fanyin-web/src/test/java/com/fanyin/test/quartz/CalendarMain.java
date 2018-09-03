package com.fanyin.test.quartz;

import org.assertj.core.util.Lists;
import org.quartz.*;
import org.quartz.impl.StdSchedulerFactory;
import org.quartz.impl.calendar.AnnualCalendar;
import org.quartz.impl.triggers.SimpleTriggerImpl;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * @author 二哥很猛
 * @date 2018/7/17 15:27
 */
public class CalendarMain {
    public static void main(String[] args) throws Exception{
        AnnualCalendar holiday = new AnnualCalendar();
        //排除10月1
        Calendar calendar = new GregorianCalendar();
        calendar.add(Calendar.MONTH,10);
        calendar.add(Calendar.DATE,1);
        holiday.setDaysExcluded(Lists.newArrayList(calendar));

        SchedulerFactory factory = new StdSchedulerFactory();
        Scheduler scheduler = factory.getScheduler();
        scheduler.addCalendar("holiday",holiday,false,false);
        Date runDate = Date.from(LocalDate.of(2018,4,1).atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());

        JobDetail detail = JobBuilder.newJob(SimpleJob.class).withIdentity("job_1","group_1").build();
        SimpleTrigger trigger = TriggerBuilder.<SimpleTriggerImpl>newTrigger().startAt(runDate).modifiedByCalendar("holiday").
                withSchedule(
                        SimpleScheduleBuilder
                                .simpleSchedule()
                                .withIntervalInSeconds(24 * 60 * 60 )
                                .withRepeatCount(SimpleTrigger.REPEAT_INDEFINITELY)
                )
                .forJob("job_1","group_1").build();
        scheduler.scheduleJob(detail,trigger);
        scheduler.start();
    }
}
