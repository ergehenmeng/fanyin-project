package com.fanyin.test.lambda;

import java.util.concurrent.CompletableFuture;

/**
 * @author 二哥很猛
 * @date 2018/6/27 10:32
 */
public class CompletableFutureTest {

    public static class FutureThread implements Runnable{

        private CompletableFuture<Integer> future;

        public FutureThread(CompletableFuture<Integer> future) {
            this.future = future;
        }

        @Override
        public void run() {
            try {
                Integer integer = future.get() * future.get();
                System.out.println(integer);
            }catch (Exception e){

            }
        }
    }
    public static void main(String[] args)throws Exception {
        CompletableFuture<Integer> future = new CompletableFuture<>();
        new Thread(new FutureThread(future)).start();
        Thread.sleep(1000);
        future.complete(100);
    }
}
