package com.fanyin.test.zookeeper;


import org.apache.curator.RetryPolicy;
import org.apache.curator.framework.CuratorFramework;
import org.apache.curator.framework.CuratorFrameworkFactory;
import org.apache.curator.retry.ExponentialBackoffRetry;

/**
 * @author 王艳兵
 * @date 2018/7/31 18:05
 */
public class ApacheCurator {
    public static void main(String[] args)throws Exception {
        RetryPolicy policy = new ExponentialBackoffRetry(1000,3);
        CuratorFramework curator = CuratorFrameworkFactory.newClient("72.127.2.112:21811",30 * 1000,3 * 1000,policy);
        curator.start();
        curator.create().forPath("/curator2","hello world".getBytes());
    }
}
