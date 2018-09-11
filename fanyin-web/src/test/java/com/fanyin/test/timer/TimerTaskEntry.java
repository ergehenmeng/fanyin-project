package com.fanyin.test.timer;

import javax.annotation.Nonnull;

/**
 * @author 王艳兵
 * @date 2018/9/11 9:15
 */
public class TimerTaskEntry implements Comparable<TimerTaskEntry> {

    private volatile TimerTaskList timerTaskList;

    public TimerTaskEntry next;

    public TimerTaskEntry prev;

    private TimerTask timerTask;

    private long expirationMs;

    /**
     * 构造方法
     * @param timerTask 定时任务
     * @param expirationMs  到期时间
     */
    public TimerTaskEntry(TimerTask timerTask,long expirationMs){
        if(timerTask != null){
            timerTask.setTimerTaskEntry(this);
        }
        this.timerTask = timerTask;
        this.expirationMs = expirationMs;
    }

    public boolean cancelled(){
        return timerTask.getTimerTaskEntry() != this;
    }

    public void remove(){
        TimerTaskList currentList = timerTaskList;
        while (currentList != null){
            currentList.remove(this);
            currentList = timerTaskList;
        }
    }

    @Override
    public int compareTo(@Nonnull TimerTaskEntry o) {
        Long expirationMs1 = this.getExpirationMs();
        Long expirationMs2 = o.getExpirationMs();
        if (expirationMs1 < expirationMs2) {
            return -1;
        }
        if (expirationMs1 > expirationMs2) {
            return 1;
        }
        return 0;
    }

    public TimerTask getTimerTask() {
        return timerTask;
    }

    public long getExpirationMs() {
        return expirationMs;
    }

    public TimerTaskList getTimerTaskList() {
        return timerTaskList;
    }

    public void setTimerTaskList(TimerTaskList timerTaskList) {
        this.timerTaskList = timerTaskList;
    }
}
