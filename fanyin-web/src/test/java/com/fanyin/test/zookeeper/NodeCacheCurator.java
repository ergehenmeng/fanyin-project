package com.fanyin.test.zookeeper;

import org.apache.curator.RetryPolicy;
import org.apache.curator.framework.CuratorFramework;
import org.apache.curator.framework.CuratorFrameworkFactory;
import org.apache.curator.framework.recipes.cache.ChildData;
import org.apache.curator.framework.recipes.cache.NodeCache;
import org.apache.curator.framework.recipes.cache.NodeCacheListener;
import org.apache.curator.retry.ExponentialBackoffRetry;

import java.util.concurrent.TimeUnit;

/**
 * 监听某一个节点的变化
 * @author 王艳兵
 * @date 2018/8/3 15:54
 */
public class NodeCacheCurator {
    public static void main(String[] args)throws Exception{
        RetryPolicy policy = new ExponentialBackoffRetry(1000,3);
        CuratorFramework curator = CuratorFrameworkFactory.newClient("72.127.2.8:21811",30 * 1000,3 * 1000,policy);
        curator.start();
        NodeCache cache = new NodeCache(curator,"/zk");
        cache.start();
        NodeCacheListener listener = () -> {
            ChildData currentData = cache.getCurrentData();
            if(currentData == null){
                System.out.println("节点被删除");
            }else{
                System.out.println("节点数据:" + new String(currentData.getData(),"UTF-8"));
            }
        };
        cache.getListenable().addListener(listener);


        TimeUnit.SECONDS.sleep(1000);

        cache.close();
        curator.close();
    }
}
