package com.fanyin.test.thread;

import java.util.concurrent.Callable;
import java.util.concurrent.FutureTask;
import java.util.concurrent.TimeUnit;

/**
 * @author 二哥很猛
 * @date 2018/10/9 15:58
 */
public class CallableTest {

    static class Call implements Callable<Integer>{

        @Override
        public Integer call() throws Exception {
            TimeUnit.SECONDS.sleep(40);
            return 1000;
        }
    }

    public static void main(String[] args) throws Exception{
        Call call = new Call();
        FutureTask<Integer> task = new FutureTask<>(call);
        new Thread(task).start();
        Integer integer = task.get();
        System.out.println(integer);
    }
}
