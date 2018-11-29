package com.fanyin.test.thread;

import java.util.ArrayList;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.ForkJoinTask;
import java.util.concurrent.RecursiveTask;

/**
 * RecursiveTask:带返回值,
 * RecursiveAction:不带返回值
 * @author 二哥很猛
 * @date 2018/6/11 15:27
 */
public class ForkJoinPoolTest extends RecursiveTask<Long> {

    private static final long TOTAL = 10000;

    private long start;

    private long end;

    public ForkJoinPoolTest(long start,long end){
        this.start = start;
        this.end = end;
    }

    @Override
    protected Long compute() {
        long sum = 0;
        boolean canCompute = (end - start) < TOTAL;
        if(canCompute){
            for (long i = start;i <= end;i++){
                sum += i;
            }
        }else{
            long step = (start + end)/100;
            ArrayList<ForkJoinPoolTest> list = new ArrayList<>();
            long pos = start;
            for (long i = 0;i < 100;i++){
                long lastOne = pos + step;
                if(lastOne > end){
                    lastOne = end;
                }
                ForkJoinPoolTest join = new ForkJoinPoolTest(pos,lastOne);
                pos += step + 1;
                list.add(join);
                join.fork();
            }
            for (ForkJoinPoolTest fork : list){
                sum += fork.join();
            }
        }
        return sum;
    }

    public static void main(String[] args) {
        ForkJoinPool pool = new ForkJoinPool();
        ForkJoinPoolTest test = new ForkJoinPoolTest(0,200000L);
        ForkJoinTask<Long> submit = pool.submit(test);
        try {
            Long aLong = submit.get();
            System.out.println("总额度:" + aLong);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}



