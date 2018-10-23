package com.fanyin.test.zookeeper;


import org.apache.curator.RetryPolicy;
import org.apache.curator.framework.CuratorFramework;
import org.apache.curator.framework.CuratorFrameworkFactory;
import org.apache.curator.retry.ExponentialBackoffRetry;
import org.apache.zookeeper.CreateMode;
import org.apache.zookeeper.WatchedEvent;
import org.apache.zookeeper.Watcher;
import org.apache.zookeeper.data.Stat;

import java.util.List;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

/**
 * @author 二哥很猛
 * @date 2018/7/31 18:05
 */
public class ApacheCurator {
    public static void main(String[] args)throws Exception {
        RetryPolicy policy = new ExponentialBackoffRetry(1000,3);
        CuratorFramework curator = CuratorFrameworkFactory.newClient("127.0.0.1:21811",30 * 1000,3 * 1000,policy);
        curator.start();
        //curator.create().forPath("/curator2","hello world".getBytes());
        //curator.create().withMode(CreateMode.EPHEMERAL).forPath("/curator3","hello".getBytes());
        //方法第二次调用会报已存在的错误
        //curator.create().creatingParentsIfNeeded().forPath("/node1/curator","deep".getBytes());
        //curator.setData().withVersion(1000).forPath("/curator3","v".getBytes());
        Stat stat = new Stat();
        curator.getData().storingStatIn(stat).forPath("/curator2");
        System.out.println("version:" + stat.getVersion());
        System.out.println("ctime:" + stat.getCtime());

        List<String> strings = curator.getChildren().forPath("/zk");
        System.out.println("子节点:" + strings.get(0));
        Executor executor = Executors.newFixedThreadPool(2);
        curator.getChildren().inBackground((client, event) -> {
            List<String> children = event.getChildren();
            System.out.println("异步结果:" + children.get(0));
        },executor).forPath("/zk");
        Stat returnStat = curator.checkExists().usingWatcher(new Watcher() {
            @Override
            public void process(WatchedEvent event) {
                System.out.println("监控已执行");
            }
        }).forPath("/zk");
        System.out.println("是否存在该节点:" + returnStat);

        curator.inTransaction().check().forPath("/zk/transactions")
                .and()
                .create().withMode(CreateMode.EPHEMERAL).forPath("/zk/transactions","tt".getBytes())
                .and()
                //.setData().withVersion(10086).forPath("/transaction","dd2".getBytes())
                //.and()
                .commit();
    }
}
