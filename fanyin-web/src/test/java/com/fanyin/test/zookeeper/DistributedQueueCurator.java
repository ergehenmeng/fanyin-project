package com.fanyin.test.zookeeper;

import org.apache.curator.framework.CuratorFramework;
import org.apache.curator.framework.CuratorFrameworkFactory;
import org.apache.curator.framework.recipes.queue.DistributedQueue;
import org.apache.curator.framework.recipes.queue.QueueBuilder;
import org.apache.curator.framework.recipes.queue.QueueConsumer;
import org.apache.curator.framework.recipes.queue.QueueSerializer;
import org.apache.curator.framework.state.ConnectionState;
import org.apache.curator.retry.ExponentialBackoffRetry;

import java.nio.charset.Charset;
import java.util.concurrent.TimeUnit;

/**
 * 队列
 * @author 王艳兵
 * @date 2018/8/6 14:11
 */
public class DistributedQueueCurator {

    private static final String PATH = "/zk/queue";

    public static void main(String[] args) throws Exception{
        CuratorFramework clientA = CuratorFrameworkFactory.newClient("72.127.2.8:21811",new ExponentialBackoffRetry(1000 * 3,3));
        clientA.getCuratorListenable().addListener((client1, event) -> {
            System.out.println("Type A:" + event.getType().name());
        });
        clientA.start();

        CuratorFramework clientB = CuratorFrameworkFactory.newClient("72.127.2.8:21811",new ExponentialBackoffRetry(1000 * 3,3));
        clientB.getCuratorListenable().addListener((client1, event) -> {
            System.out.println("Type B:" + event.getType().name());
        });
        clientB.start();


        QueueBuilder<String> builderA = QueueBuilder.builder(clientA,createQueueConsumer("A"),createQueueSerializer(),PATH);
        DistributedQueue<String> queueA = builderA.buildQueue();
        queueA.start();

        QueueBuilder<String> builderB = QueueBuilder.builder(clientB,createQueueConsumer("B"),createQueueSerializer(),PATH);
        DistributedQueue<String> queueB = builderB.buildQueue();
        queueB.start();
        for (int i = 0 ;i < 100; i++){
            queueA.put("test-A:" + i);
            Thread.sleep(10);
            queueB.put("test-B:" + i);
        }
        TimeUnit.SECONDS.sleep(10);
        queueA.close();
        queueB.close();
        clientA.close();
        clientB.close();
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

    private static QueueConsumer<String> createQueueConsumer(final String name){
        return new QueueConsumer<String>() {
            @Override
            public void consumeMessage(String message) throws Exception {
                System.out.println("消费队列("+ name + "):" + message);
            }

            @Override
            public void stateChanged(CuratorFramework client, ConnectionState newState) {
                System.out.println("消费队列状态:" + newState.name());
            }
        };
    }
}
