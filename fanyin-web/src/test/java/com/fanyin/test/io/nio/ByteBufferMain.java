package com.fanyin.test.io.nio;

import java.nio.ByteBuffer;

/**
 * ByteBuffer说明
 * @author 二哥很猛
 * @date 2018/7/20 17:29
 */
public class ByteBufferMain {

    public static void main(String[] args) throws Exception{
        ByteBuffer buffer = ByteBuffer.allocate(100);
        String str = "fanyin";
        buffer.put(str.getBytes());
        //将总容量设置为当前位置,将当前位置设置0
        buffer.flip();
        //实际占用的长度
        byte[] bytes = new byte[buffer.remaining()];
        buffer.get(bytes);
        System.out.println(new String(bytes,"UTF-8"));
        //相当于重新读取 position=0 limit=6 capacity=100
        buffer.rewind();
        buffer.get(bytes);
        System.out.println(new String(bytes,"UTF-8"));
    }
}
