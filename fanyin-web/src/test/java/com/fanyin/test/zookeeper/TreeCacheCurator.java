package com.fanyin.test.zookeeper;

import org.apache.curator.RetryPolicy;
import org.apache.curator.framework.CuratorFramework;
import org.apache.curator.framework.CuratorFrameworkFactory;
import org.apache.curator.framework.recipes.cache.TreeCache;
import org.apache.curator.framework.recipes.cache.TreeCacheListener;
import org.apache.curator.retry.ExponentialBackoffRetry;

import java.util.concurrent.TimeUnit;

/**
 * 监控树的所有节点 类似PathCache+NodeCache结合版本
 * @author 王艳兵
 * @date 2018/8/3 16:22
 */
public class TreeCacheCurator {
    public static void main(String[] args) throws Exception{
        RetryPolicy policy = new ExponentialBackoffRetry(1000,3);
        CuratorFramework curator = CuratorFrameworkFactory.newClient("72.127.2.8:21811",30 * 1000,3 * 1000,policy);
        curator.start();
        TreeCache cache = new TreeCache(curator,"/zk");
        TreeCacheListener listener = (client, event) -> {
            System.out.println("事件类型:" + event.getType());
            //调用start方法会有INITIALIZED事件产生,而data为空
            if(event.getData() != null){
                System.out.println("路径地址:" + event.getData().getPath() + " 值:" + new String(event.getData().getData(),"UTF-8"));
            }
        };
        cache.getListenable().addListener(listener);
        cache.start();
        TimeUnit.SECONDS.sleep(1000);
        cache.close();
        curator.close();
    }
}
