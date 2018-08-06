package com.fanyin.test.zookeeper;

import org.apache.curator.framework.CuratorFramework;
import org.apache.curator.framework.CuratorFrameworkFactory;
import org.apache.curator.framework.recipes.atomic.AtomicValue;
import org.apache.curator.framework.recipes.atomic.DistributedAtomicLong;
import org.apache.curator.retry.ExponentialBackoffRetry;
import org.apache.curator.retry.RetryNTimes;
import org.assertj.core.util.Lists;

import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

/**
 * long计数器
 * @author 王艳兵
 * @date 2018/8/6 13:54
 */
public class DistributedAtomicLongCurator {

    private static final String PATH = "/zk/long";

    public static void main(String[] args) throws Exception{
        List<DistributedAtomicLong> atomicLongList = Lists.newArrayList();
        CuratorFramework client = CuratorFrameworkFactory.newClient("72.127.2.8:21811",new ExponentialBackoffRetry(1000 * 3,3));
        client.start();
        ExecutorService service = Executors.newFixedThreadPool(5);
        for (int i =0 ; i < 5; i++){
            DistributedAtomicLong atomicLong = new DistributedAtomicLong(client,PATH,new RetryNTimes(10 ,10));
            atomicLongList.add(atomicLong);
            Callable<Void> callable = () -> {
                AtomicValue<Long> increment = atomicLong.increment();
                if(increment.succeeded()){
                    System.out.println("老值:" + increment.preValue() + " 新值:" + increment.postValue());
                }
                return null;
            };
            service.submit(callable);
        }
        service.shutdown();
        service.awaitTermination(10,TimeUnit.MINUTES);
        Thread.sleep(Integer.MAX_VALUE);
    }
}
