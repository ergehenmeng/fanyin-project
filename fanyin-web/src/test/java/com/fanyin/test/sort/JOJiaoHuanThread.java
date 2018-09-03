package com.fanyin.test.sort;

import java.util.Random;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;


/**
 * @author 二哥很猛
 * @date 2018/6/22 10:10
 */
public class JOJiaoHuanThread {

    public static void main(String[] args) throws Exception{
        Random random = new Random(5000);
        int[] arr = new int[5000];
        int i = 0;
        while (i < 5000){
            arr[i] = random.nextInt();
            i++;
        }
        long start = System.currentTimeMillis();
        sort(arr);
        long end = System.currentTimeMillis();
        System.out.println(end - start);
    }

    //static ExecutorService executor = Executors.newCachedThreadPool();

    static int execFlagValue = 1;

    static synchronized void setExecFlag(int execFlag){
        execFlagValue = execFlag;
    }

    static synchronized int getExecFlag(){
        return execFlagValue;
    }

    public static class SortTask implements Runnable{

        private int i;

        private CountDownLatch latch;

        private int[] arr;

        public SortTask(int i, CountDownLatch latch,int[] arr) {
            this.i = i;
            this.latch = latch;
            this.arr = arr;
        }

        @Override
        public void run() {
            if (arr[i] > arr[i+1]){
                int temp = arr[i];
                arr[i] = arr[i+1];
                arr[i+1] = temp;
                setExecFlag(1);
            }
            latch.countDown();
        }
    }
    public static void sort(int[] arr)throws Exception{
        ExecutorService service = Executors.newFixedThreadPool(100);
        int start = 0;
        int length = arr.length;
        while (getExecFlag() == 1 || start == 0){
            setExecFlag(0);
            CountDownLatch latch = new CountDownLatch(length/2 - (length%2 == 0 ? start : 0));
            for (int i = start;i < length -1 ; i += 2){
                service.submit(new SortTask(i,latch,arr));
            }
            latch.await();
            if(start == 0){
                start = 1;
            }else{
                start = 0;
            }
        }
        service.shutdown();
    }
}
