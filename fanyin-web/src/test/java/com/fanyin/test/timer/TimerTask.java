package com.fanyin.test.timer;

/**
 * @author 王艳兵
 * @date 2018/9/11 9:19
 */
public abstract class TimerTask implements Runnable {

    private TimerTaskEntry timerTaskEntry;

    /**
     * 延迟多长时间执行 毫秒值
     */
    private long delayMs;

    /**
     * 构造方法
     * @param delayMs 延迟多长时间执行
     */
    public TimerTask(long delayMs){
        this.delayMs = delayMs;
    }

    @Override
    public void run() {
        execute();
    }

    /**
     * 执行业务信息
     */
    public abstract void execute();

    /**
     * 删除任务
     */
    public void cancel(){
        synchronized (this){
            if(timerTaskEntry != null){
                timerTaskEntry.remove();
            }
            timerTaskEntry = null;
        }
    }

    public void setTimerTaskEntry(TimerTaskEntry entry) {
        synchronized (this){
            if(this.timerTaskEntry != null && this.timerTaskEntry != entry){
                this.timerTaskEntry.remove();
            }
            this.timerTaskEntry = entry;
        }
    }

    public TimerTaskEntry getTimerTaskEntry() {
        return timerTaskEntry;
    }

    public long getDelayMs() {
        return delayMs;
    }

    public void setDelayMs(long delayMs) {
        this.delayMs = delayMs;
    }
}
