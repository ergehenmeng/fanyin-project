package com.fanyin.test.zookeeper;

import org.apache.curator.RetryPolicy;
import org.apache.curator.framework.CuratorFramework;
import org.apache.curator.framework.CuratorFrameworkFactory;
import org.apache.curator.framework.imps.CuratorFrameworkState;
import org.apache.curator.framework.recipes.leader.LeaderLatch;
import org.apache.curator.framework.recipes.leader.LeaderLatchListener;
import org.apache.curator.framework.state.ConnectionState;
import org.apache.curator.framework.state.ConnectionStateListener;
import org.apache.curator.retry.ExponentialBackoffRetry;
import org.apache.curator.utils.CloseableUtils;
import org.assertj.core.util.Lists;

import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * @author 王艳兵
 * @date 2018/8/3 16:38
 */
public class LeaderLatchCurator {
    public static void main(String[] args) throws Exception{
        List<CuratorFramework> frameworkList = Lists.newArrayList();
        List<LeaderLatch> latchList = Lists.newArrayList();
        try {
            for (int i = 0 ;i < 10;i++){
                RetryPolicy policy = new ExponentialBackoffRetry(1000,3);
                CuratorFramework framework = CuratorFrameworkFactory.newClient("72.127.2.8:21811",policy);
                ConnectionStateListener stateListener = (client, newState) -> {
                    if(newState == ConnectionState.LOST){
                        System.out.println("链接已断开");
                    }
                };
                framework.getConnectionStateListenable().addListener(stateListener);
                frameworkList.add(framework);
                LeaderLatch latch = new LeaderLatch(framework,"/zk","client:" + i);
                latch.addListener(new LeaderLatchListener() {
                    @Override
                    public void isLeader() {
                        System.out.println("我是领导");
                    }

                    @Override
                    public void notLeader() {
                        System.out.println("我是小兵");
                    }
                });
                latchList.add(latch);
                framework.start();
                latch.start();
            }
            TimeUnit.SECONDS.sleep(10);
            LeaderLatch leader = LeaderLatchCurator.getLeader(latchList);
            if(leader != null){
                System.out.println("当前leader:" + leader.getId());
                leader.close();
            }else{
                System.out.println("没有选举出leader");
            }
            TimeUnit.SECONDS.sleep(10);
            leader = LeaderLatchCurator.getLeader(latchList);
            if(leader != null){
                System.out.println("当前新leader:" + leader.getId());
            }else{
                System.out.println("没有选举出新leader");
            }
        } finally {
            for (LeaderLatch latch :latchList){
                if(latch.getState() != null && latch.getState() != LeaderLatch.State.CLOSED){
                    CloseableUtils.closeQuietly(latch);
                }
            }
            for (CuratorFramework framework :frameworkList){
                if(framework.getState() != null && framework.getState() != CuratorFrameworkState.STOPPED){
                    CloseableUtils.closeQuietly(framework);
                }
            }
        }
    }

    private static LeaderLatch getLeader(List<LeaderLatch> latchList){
        LeaderLatch leader = null;
        for (LeaderLatch latch : latchList){
            if(latch.hasLeadership()){
                leader =latch;
            }
        }
        return leader;
    }

}
