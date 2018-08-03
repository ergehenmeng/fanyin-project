package com.fanyin.test.zookeeper;

import org.apache.curator.RetryPolicy;
import org.apache.curator.framework.CuratorFramework;
import org.apache.curator.framework.CuratorFrameworkFactory;
import org.apache.curator.framework.recipes.cache.PathChildrenCache;
import org.apache.curator.framework.recipes.cache.PathChildrenCacheListener;
import org.apache.curator.framework.state.ConnectionStateListener;
import org.apache.curator.retry.ExponentialBackoffRetry;

/**
 * 子节点的变化(增删改查)
 * @author 王艳兵
 * @date 2018/8/3 15:55
 */
public class PathCacheCurator {

    public static void main(String[] args) throws Exception{

        RetryPolicy policy = new ExponentialBackoffRetry(1000,3);
        CuratorFramework curator = CuratorFrameworkFactory.newClient("72.127.2.8:21811",30 * 1000,3 * 1000,policy);

        ConnectionStateListener stateListener = (client, newState) -> {
            if(!newState.isConnected()){
                System.out.println("链接已断开");
            }
        };
        curator.getConnectionStateListenable().addListener(stateListener);
        curator.start();

        PathChildrenCache cache = new PathChildrenCache(curator,"/zk",true);
        PathChildrenCacheListener listener = (client, event) -> {
            System.out.println("事件类型:" + event.getType());
            if(event.getData() != null){
                System.out.println("节点数据:" + event.getData().getPath() + " :" + new String(event.getData().getData(),"UTF-8"));
            }
        };
        cache.getListenable().addListener(listener);
        cache.start(PathChildrenCache.StartMode.POST_INITIALIZED_EVENT);


        Thread.sleep(100000);
        cache.close();
        curator.close();
    }
}
