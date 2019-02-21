package com.fanyin.test.thread;

import java.util.Queue;
import java.util.concurrent.SynchronousQueue;

/**
 * @author 二哥很猛
 * @date 2019/2/21 10:41
 */
public class SyncQueue {
    public static void main(String[] args) throws Exception{
        SynchronousQueue<Integer> queue = new SynchronousQueue<>(true);
        queue.offer(1);
        queue.offer(2);
        queue.put(3);
        Integer take = queue.take();
        System.out.println(take);
        Integer take2 = queue.take();
        System.out.println(take2);
    }
}
