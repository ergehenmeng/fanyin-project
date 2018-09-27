package com.fanyin.test.cas;

import java.util.concurrent.BrokenBarrierException;
import java.util.concurrent.CyclicBarrier;

/**
 * @author 王艳兵
 * @date 2018/9/26 17:29
 */
public class CyclicBarrierTest {


    static class CyclicBarrierThread implements Runnable{
        private CyclicBarrier cyclicBarrier;

        CyclicBarrierThread(CyclicBarrier cyclicBarrier) {
            this.cyclicBarrier = cyclicBarrier;
        }

        @Override
        public void run() {
            System.out.println(Thread.currentThread().getName() + ":报道");
            try {
                cyclicBarrier.await();
            } catch (InterruptedException | BrokenBarrierException e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String[] args) {
        CyclicBarrier barrier = new CyclicBarrier(10, () -> System.out.println("开始跑步..."));
        for (int i = 0 ;i < 10; i++){
            new Thread(new CyclicBarrierThread(barrier)).start();
        }
    }
}
