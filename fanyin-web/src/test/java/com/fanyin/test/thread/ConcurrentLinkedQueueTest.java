package com.fanyin.test.thread;

import java.util.Queue;
import java.util.concurrent.ConcurrentLinkedQueue;

/**
 * @author 王艳兵
 * @date 2018/6/12 15:20
 */
public class ConcurrentLinkedQueueTest {

    public static void main(String[] args) {
        Queue<String> queue = new ConcurrentLinkedQueue<>();
        queue.offer("张三");
        queue.offer("李四");
    }
}
