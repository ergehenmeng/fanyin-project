package com.fanyin.test.zookeeper;

import org.apache.curator.framework.CuratorFramework;
import org.apache.curator.framework.CuratorFrameworkFactory;
import org.apache.curator.framework.recipes.queue.*;
import org.apache.curator.framework.state.ConnectionState;
import org.apache.curator.retry.ExponentialBackoffRetry;
import org.apache.curator.utils.CloseableUtils;

import java.nio.charset.Charset;
import java.util.concurrent.TimeUnit;

/**
 * 带id的队列
 * @author 王艳兵
 * @date 2018/8/6 14:40
 */
public class DistributedIdQueueCurator {
    private static final String PATH = "/zk/queue";

    public static void main(String[] args) throws Exception{
        CuratorFramework  clientA = null;
        DistributedIdQueue<String> queue = null;
        try {
            clientA = CuratorFrameworkFactory.newClient("72.127.2.8:21811",new ExponentialBackoffRetry(1000 * 3,3));
            clientA.getCuratorListenable().addListener((client1, event) -> {
                System.out.println("Type A:" + event.getType().name());
            });
            clientA.start();


            QueueBuilder<String> builderA = QueueBuilder.builder(clientA,createQueueConsumer(),createQueueSerializer(),PATH);
            queue = builderA.buildIdQueue();
            queue.start();

            for (int i = 0 ;i < 100; i++){
                queue.put("test-A:" + i , "Id" + i);
                Thread.sleep((long) (15 * Math.random()));
                queue.remove("Id" + i);
            }
            TimeUnit.SECONDS.sleep(10);
        } finally {
            CloseableUtils.closeQuietly(clientA);
            CloseableUtils.closeQuietly(queue);
        }
    }

    private static QueueSerializer<String> createQueueSerializer(){
        return new QueueSerializer<String>() {
            @Override
            public byte[] serialize(String item) {
                return item.getBytes();
            }

            @Override
            public String deserialize(byte[] bytes) {
                return new String(bytes,Charset.forName("UTF-8"));
            }
        };
    }

    private static QueueConsumer<String> createQueueConsumer(){
        return new QueueConsumer<String>() {
            @Override
            public void consumeMessage(String message) throws Exception {
                System.out.println("消费队列:" + message);
            }

            @Override
            public void stateChanged(CuratorFramework client, ConnectionState newState) {
                System.out.println("消费队列状态:" + newState.name());
            }
        };
    }
}
