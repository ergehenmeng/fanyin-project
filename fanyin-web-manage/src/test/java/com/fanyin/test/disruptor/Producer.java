package com.fanyin.test.disruptor;

import com.lmax.disruptor.BlockingWaitStrategy;
import com.lmax.disruptor.RingBuffer;
import com.lmax.disruptor.dsl.Disruptor;
import com.lmax.disruptor.dsl.ProducerType;

import java.nio.ByteBuffer;
import java.util.concurrent.ThreadFactory;

/**
 * @author 二哥很猛
 * @date 2018/6/21 10:59
 */
public class Producer {

    private final RingBuffer<Data> ringBuffer;

    public Producer(RingBuffer<Data> ringBuffer){
        this.ringBuffer = ringBuffer;
    }

    public void push(ByteBuffer buffer){
        long next = ringBuffer.next();
        try{
            Data data = ringBuffer.get(next);
            data.setValue(buffer.getLong(0));
        }finally {
            ringBuffer.publish(next);
        }
    }

    public static void main(String[] args) throws Exception{
        ThreadFactory executor = r -> new Thread(r);
        final DataFactory factory = new DataFactory();
        final int bufferSize = 1024;
        Disruptor<Data> disruptor = new Disruptor<>(factory,bufferSize,executor, ProducerType.MULTI,new BlockingWaitStrategy());
        disruptor.handleEventsWithWorkerPool(new Consumer(),new Consumer(),new Consumer(),new Consumer());
        disruptor.start();

        RingBuffer<Data> dataRingBuffer = disruptor.getRingBuffer();
        Producer producer = new Producer(dataRingBuffer);
        ByteBuffer byteBuffer = ByteBuffer.allocate(8);
        for (long i = 0; i < 2;i++){
            byteBuffer.putLong(0,i);
            producer.push(byteBuffer);
            System.out.println("已添加:" + i);
            Thread.sleep(100);
        }
    }
}
