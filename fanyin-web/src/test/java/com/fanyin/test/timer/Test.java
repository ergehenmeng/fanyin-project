package com.fanyin.test.timer;

/**
 * @author 王艳兵
 * @date 2018/9/11 12:00
 */
public class Test {
    public static void main(String[] args) {
        SystemTimer timer = new SystemTimer("timer",1L,20);
        for (long i = 0; i < 100L; i++ ){
            timer.add(new TimerTaskOperation(500 + i * 100 ));
        }
        System.out.println(System.nanoTime());
        while (true){
            timer.advanceClock(200);
        }

    }
}
