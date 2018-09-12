package com.fanyin.test.zookeeper;

import org.apache.curator.framework.CuratorFramework;
import org.apache.curator.framework.CuratorFrameworkFactory;
import org.apache.curator.framework.recipes.shared.SharedCount;
import org.apache.curator.framework.recipes.shared.SharedCountListener;
import org.apache.curator.framework.recipes.shared.SharedCountReader;
import org.apache.curator.framework.state.ConnectionState;
import org.apache.curator.retry.ExponentialBackoffRetry;
import org.assertj.core.util.Lists;

import java.util.List;
import java.util.Random;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;


/**
 * int 分布式计数器
 * @author 二哥很猛
 * @date 2018/8/6 9:32
 */
public class SharedCountCurator implements SharedCountListener {

    private static final String PATH = "/zk/count";

    public static void main(String[] args)throws Exception {
        Random random = new Random();
        CuratorFramework curator = CuratorFrameworkFactory.newClient("72.127.2.8:21811",new ExponentialBackoffRetry(1000,3));
        curator.start();
        SharedCountCurator listener = new SharedCountCurator();
        SharedCount count = new SharedCount(curator,PATH,0);
        count.start();
        count.addListener(listener);

        ExecutorService service = Executors.newFixedThreadPool(5);
        List<SharedCount> countList = Lists.newArrayList();
        for (int i = 0;i < 5 ; i ++){
            final SharedCount sharedCount = new SharedCount(curator, PATH, 0);
            countList.add(sharedCount);
            Callable<Void> callable = () -> {
                sharedCount.start();
                Thread.sleep(random.nextInt(10000));
                System.out.println("增加的值:" + sharedCount.trySetCount(count.getVersionedValue(),
                        count.getCount() + random.nextInt(10)));
                return null;
            };
            service.submit(callable);
        }
        service.shutdown();
        service.awaitTermination(10,TimeUnit.MINUTES);
        for (SharedCount sharedCount : countList){
            sharedCount.close();
        }
        count.close();
    }

    @Override
    public void countHasChanged(SharedCountReader sharedCount, int newCount) throws Exception {
        System.out.println("新值:" + newCount);
    }

    @Override
    public void stateChanged(CuratorFramework client, ConnectionState newState) {
        System.out.println("状态:" + newState.toString());
    }
}
