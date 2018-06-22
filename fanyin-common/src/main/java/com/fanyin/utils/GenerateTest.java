package com.fanyin.utils;

import java.net.InetAddress;
import java.util.Locale;
import java.util.concurrent.CountDownLatch;

/**
 * @author 王艳兵
 * @date 2018/4/11 10:01
 */
public class GenerateTest implements Runnable{
    private CountDownLatch count;
    private static String ip;
    static{
        try {
            ip = InetAddress.getLocalHost().getHostAddress();
        }catch (Exception e){
        }
    }

    public GenerateTest(CountDownLatch count){
        this.count = count;
    }
    public static void main(String[] args) throws Exception{

        String r = Long.toHexString(Long.parseLong(System.currentTimeMillis() + "" + Thread.currentThread().getId() +"" +193));
        System.out.println(r);


        /*
        CountDownLatch counts = new CountDownLatch(500);
        for (int i =0 ;i < 500;i++){
            new Thread(new GenerateTest(counts)).start();
            counts.countDown();
            System.out.println("第 " + i + "个");
        }
        Thread.sleep(3000);*/
    }

    @Override
    public void run() {
        try {
            count.await();
            System.out.println("insert into generator (name)values ('"+ System.currentTimeMillis() + Thread.currentThread().getId() + "'); ");
        }catch (Exception e){
        }
    }
}
