package com.fanyin.test.io.netty;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;

/**
 * @author 二哥很猛
 * @date 2018/7/21 13:54
 */
public class ByteBufMain {

    public static void main(String[] args) throws Exception{
        ByteBuf byteBuf = Unpooled.buffer(100);
        byteBuf.writeBytes("fanyin".getBytes());
        ByteBuf buf = Unpooled.buffer(100);
        buf.writeBytes("erge".getBytes());
        byteBuf.readBytes(buf,0,6);
        System.out.println(buf);
        int i = buf.readableBytes();
        byte[] bytes = new byte[i];
        buf.readBytes(bytes);
        System.out.println(new String(bytes,"UTF-8"));

        ByteBuf slice = Unpooled.buffer(100);
        slice.writeBytes("abcdefghijklmnoprstuvwxyz".getBytes());
        byte[] read = new byte[6];
        slice.readBytes(read);
        System.out.println("读取的:"+ new String(read,"utf-8"));
        ByteBuf slice1 = slice.slice();
        byte[] read2 = new byte[slice1.readableBytes()];
        slice1.readBytes(read2);
        System.out.println("slice:" + new String(read2,"utf-8"));

        ByteBuf writerBuf = Unpooled.buffer(100);
        writerBuf.writeBytes("abcdef".getBytes());
        ByteBuf readBuf = Unpooled.buffer(100);
        readBuf.writeBytes("xxggg".getBytes());
        writerBuf.writeBytes(readBuf,2,3);
        byte[] strByte = new byte[writerBuf.readableBytes()];
        writerBuf.readBytes(strByte);
        System.out.println("read:" + new String (strByte,"UTF-8"));
    }
}
