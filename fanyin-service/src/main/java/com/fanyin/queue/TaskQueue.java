package com.fanyin.queue;

import com.fanyin.constants.TaskConstant;

import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * @author 二哥很猛
 * @date 2018/11/16 17:25
 */
public class TaskQueue {

    private static class TaskQueueHolder{
        /**
         * 积分奖励线程 单线程
         */
        private static final ThreadPoolExecutor POINT_AWARD = new ThreadPoolExecutor(1,1,0,TimeUnit.MILLISECONDS,
                new LinkedBlockingQueue<>(),r -> new Thread(r,TaskConstant.POINT_AWARD_THREAD));

        /**
         * 投标线程 单线程
         */
        private static final ThreadPoolExecutor TENDER = new ThreadPoolExecutor(1,1,0,TimeUnit.MILLISECONDS,
                new LinkedBlockingQueue<>(),r -> new Thread(r,TaskConstant.TENDER_THREAD));
    }

    /**
     * 积分奖励发放
     * @param task 待执行的任务
     */
    public static void executePointAward(AbstractTask task){
        TaskQueueHolder.POINT_AWARD.execute(task);
    }

    /**
     * 投标
     * @param task 任务
     */
    public static void executeTender(AbstractTask task){
        TaskQueueHolder.TENDER.execute(task);
    }

    /**
     * 投标未执行的任务
     * @return 任务数
     */
    public static int tenderSize(){
        return TaskQueueHolder.TENDER.getQueue().size();
    }

    /**
     * 获取当前待执行的任务
     * @return 任务数
     */
    public static int pointAwardSize(){
        return TaskQueueHolder.POINT_AWARD.getQueue().size();
    }

}
