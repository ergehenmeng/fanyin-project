package com.fanyin.test.lambda;

import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicLong;
import java.util.concurrent.atomic.LongAdder;

/**
 * @author 王艳兵
 * @date 2018/6/27 16:07
 */
public class AtomicLongAdd {

    private static AtomicLong aLong = new AtomicLong(0L);

    private static LongAdder longAdder = new LongAdder();

    private long count = 0;

    private static final int MAX_THREAD = 3;

    private static final int TASK_COUNT = 3;

    private static final int TARGET_COUNT = 100000000;

    static CountDownLatch atomicCount = new CountDownLatch(TASK_COUNT);
    static CountDownLatch longCount = new CountDownLatch(TASK_COUNT);
    static CountDownLatch syncCount = new CountDownLatch(TASK_COUNT);

    public synchronized long add(){
        return count ++;
    }

    public synchronized long get(){
        return count;
    }

    static class SyncThread implements Runnable{

        private AtomicLongAdd longAdd;

        private long startTime;

        public SyncThread(AtomicLongAdd longAdd, long startTime) {
            this.longAdd = longAdd;
            this.startTime = startTime;
        }

        @Override
        public void run() {
            long now = longAdd.get();
            while (now < TARGET_COUNT){
                now = longAdd.add();
            }
            long end = System.currentTimeMillis();
            System.out.println("sync耗时:" + (end - startTime));
            syncCount.countDown();
        }
    }

    static class AtomicThread implements Runnable{

        private long startTime;

        public AtomicThread(long startTime) {
            this.startTime = startTime;
        }

        @Override
        public void run() {
            long now = aLong.get();
            while (now < TARGET_COUNT){
                now = aLong.incrementAndGet();
            }
            long end = System.currentTimeMillis();
            System.out.println("atomic耗时:" +  (end - startTime));
            atomicCount.countDown();
        }
    }

    static class AddThread implements  Runnable{

        private long startTime;

        public AddThread(long startTime) {
            this.startTime = startTime;
        }

        @Override
        public void run() {
            long sum = longAdder.sum();
            while(sum < TARGET_COUNT){
                longAdder.increment();
                sum = longAdder.sum();
            }
            long end = System.currentTimeMillis();
            System.out.println("longAdd耗时:" + (end - startTime));
            longCount.countDown();
        }
    }

    public static void main(String[] args) throws Exception{
        ExecutorService service = Executors.newFixedThreadPool(MAX_THREAD);
        long startTime = System.currentTimeMillis();
        SyncThread thread = new SyncThread(new AtomicLongAdd(),startTime);
        for (int i = 0;i < TASK_COUNT;i ++){
            service.submit(thread);
        }
        syncCount.await();
        long startTime1 = System.currentTimeMillis();
        AtomicThread atomicThread = new AtomicThread(startTime1);
        for (int i = 0;i < TASK_COUNT;i ++){
            service.submit(atomicThread);
        }
        atomicCount.await();
        long startTime2 = System.currentTimeMillis();
        AddThread addThread = new AddThread(startTime2);
        for (int i = 0;i < TASK_COUNT;i ++){
            service.submit(addThread);
        }
        longCount.await();

        service.shutdown();
    }
}
