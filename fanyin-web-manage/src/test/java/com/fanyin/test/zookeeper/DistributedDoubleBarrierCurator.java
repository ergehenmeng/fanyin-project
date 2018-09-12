package com.fanyin.test.zookeeper;

import org.apache.curator.framework.CuratorFramework;
import org.apache.curator.framework.CuratorFrameworkFactory;
import org.apache.curator.framework.recipes.barriers.DistributedDoubleBarrier;
import org.apache.curator.retry.ExponentialBackoffRetry;

import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

/**
 * @author 二哥很猛
 * @date 2018/8/6 15:02
 */
public class DistributedDoubleBarrierCurator {

    private static final int QTY = 5;
    private static final String PATH = "/zk/barrier";

    public static void main(String[] args) throws Exception {
        CuratorFramework client = CuratorFrameworkFactory.newClient("72.127.2.8:21811", new ExponentialBackoffRetry(1000, 3));
        client.start();
        ExecutorService service = Executors.newFixedThreadPool(QTY);
        for (int i = 0; i < QTY; ++i) {
            final DistributedDoubleBarrier barrier = new DistributedDoubleBarrier(client, PATH, QTY);
            final int index = i;
            Callable<Void> task = () -> {

                Thread.sleep((long) (3 * Math.random()));
                System.out.println("Client #" + index + " enters");
                barrier.enter();
                System.out.println("Client #" + index + " begins");
                Thread.sleep((long) (3000 * Math.random()));
                barrier.leave();
                System.out.println("Client #" + index + " left");
                return null;
            };
            service.submit(task);
        }

        service.shutdown();
        service.awaitTermination(10, TimeUnit.MINUTES);
        Thread.sleep(Integer.MAX_VALUE);
    }
}
