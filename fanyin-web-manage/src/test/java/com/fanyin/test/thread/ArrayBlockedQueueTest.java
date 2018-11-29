package com.fanyin.test.thread;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

/**
 * @author 二哥很猛
 * @date 2018/6/12 19:32
 */
public class ArrayBlockedQueueTest {
    public static void main(String[] args) throws Exception{
        BlockingQueue<String> queue = new ArrayBlockingQueue<>(1);
        queue.offer("");
        queue.put("adb");
        queue.poll();
        queue.take();
    }
}
