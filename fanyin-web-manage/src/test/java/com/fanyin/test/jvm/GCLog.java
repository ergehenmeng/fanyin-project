package com.fanyin.test.jvm;

/**
 * -verbose:gc
 * -Xms20m
 * -Xmx20m
 * -Xmn10m 新生代内存
 * -XX:+PrintGCDetails
 * -XX:SurvivorRatio=8
 * -XX:+PrintTenuringDistribution #输出每次minor GC后新的存活周期的阈值
 * -XX:+PrintGCTimeStamps #输出gc的触发时间
 * -XX:PretenureSizeThreshold=3145728 令大于这个设置值的对象直接在老年代分配.这样做的目的避免在Eden区以及两个Survivor区之间发生大量的内存复制
 *
 * @author 二哥很猛
 * @date 2018/3/22 16:59
 */
public class GCLog {
    private static final int M = 1024 * 1024;

    public static void test(){
        byte[] allocation1,allocation2,allocation3,allocation4;
        allocation1 = new byte[2 * M];
        allocation2 = new byte[2 * M];
        allocation3 = new byte[2 * M];
        //出现一次Minor GC
        allocation4 = new byte[4 * M];
    }

    /**
     * -XX:MaxTenuringThreshold=16 将对象有Survivor区移入老年代所经历的年龄阀值
     * 虚拟机不是完全按照该阀值进行判断的.如果Survivor区
     * 年龄相同的所有对象大小的总和大于Survivor空间的一半,则大于等于该
     * 年龄的对象就可以直接进入老年代无需等到-XX:MaxTenuringThreshold值即可
     * -XX:PrintGCDateStamps
     * -XX:+PrintGCApplicationStoppedTime
     */
    public static void test2(){
        byte[] allocation1,allocation2,allocation3,allocation4;
        allocation1 = new byte[M / 4];
        allocation2 = new byte[M / 4];
        allocation3 = new byte[4 * M];
        allocation4 = new byte[4 * M];
        allocation4 = null;
        allocation4 = new byte[4 * M];
    }

    public static void main(String[] args) {
        //GCLog.test();
        GCLog.test2();
    }
}
