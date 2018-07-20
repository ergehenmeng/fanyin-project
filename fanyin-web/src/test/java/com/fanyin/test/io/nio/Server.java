package com.fanyin.test.io.nio;

import org.apache.commons.lang3.time.DateUtils;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.*;
import java.text.DateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Set;

/**
 * @author 王艳兵
 * @date 2018/7/18 16:28
 */
public class Server implements Runnable{

    private Selector selector;

    private ServerSocketChannel serverSocketChannel;

    private volatile boolean stop;


    public Server(int port)throws Exception{
        this.selector = Selector.open();
        this.serverSocketChannel = ServerSocketChannel.open();
        this.serverSocketChannel.configureBlocking(false);
        this.serverSocketChannel.socket().bind(new InetSocketAddress(port),1024);
        this.serverSocketChannel.register(selector, SelectionKey.OP_ACCEPT);
    }

    public void stop(){
        this.stop = true;
    }

    @Override
    public void run() {
        while (!stop){
            try {
                selector.select(1000);
                Set<SelectionKey> keys = selector.selectedKeys();
                Iterator<SelectionKey> iterator = keys.iterator();
                SelectionKey key;
                while (iterator.hasNext()){
                    key = iterator.next();
                    iterator.remove();
                    try {
                        handle(key);
                    }finally {
                        if (key != null){
                            key.cancel();
                            if (key.channel() != null){
                                key.channel().close();
                            }
                        }
                    }
                }
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        if (selector != null){
            try {
                selector.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }


    private void handle(SelectionKey key)throws Exception{
        if (key.isValid()){
            if (key.isAcceptable()){
                ServerSocketChannel channel = (ServerSocketChannel) key.channel();
                SocketChannel accept = channel.accept();
                accept.configureBlocking(false);
                accept.register(selector,SelectionKey.OP_READ);
            }
            if(key.isReadable()){
                SocketChannel channel = (SocketChannel) key.channel();
                ByteBuffer buffer = ByteBuffer.allocate(1024);
                int read = channel.read(buffer);
                if(read > 0){
                    //将指针指向开头
                    buffer.flip();
                    byte[] bytes = new byte[buffer.remaining()];
                    buffer.get(bytes);
                    System.out.println("服务端:" + new String(bytes,"utf-8"));
                    write(channel, "2018-12-12");
                }
            }
        }
    }

    public static void write(SocketChannel channel, String msg)throws Exception{
        byte[] bytes = msg.getBytes();
        ByteBuffer buffer = ByteBuffer.allocate(bytes.length);
        buffer.put(bytes);
        buffer.flip();
        channel.write(buffer);
        if (!buffer.hasRemaining()){
            System.out.println(".....");
        }
    }

    public static void main(String[] args)throws Exception {
        new Thread(new Server(8888)).start();
    }


}
