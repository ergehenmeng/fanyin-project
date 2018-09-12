package com.fanyin.test.io.nio;

import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.SocketChannel;
import java.util.Iterator;
import java.util.Set;

/**
 * @author 二哥很猛
 * @date 2018/7/18 16:59
 */
public class Client implements Runnable {

    private Selector selector;

    private SocketChannel socketChannel;

    private volatile boolean stop = false;

    private String host;

    private int port;

    public Client(String host,int port)throws Exception{
        this.selector = Selector.open();
        this.socketChannel = SocketChannel.open();
        this.socketChannel.configureBlocking(false);
        this.host = host;
        this.port = port;
    }

    @Override
    public void run() {
        try {
            connection();
            while (!stop){
                selector.select(1000);
                Set<SelectionKey> keys = selector.selectedKeys();
                Iterator<SelectionKey> iterator = keys.iterator();
                SelectionKey next;
                while (iterator.hasNext()){
                    next = iterator.next();
                    iterator.remove();
                    try {
                        handle(next);
                    }catch (Exception e){
                        e.printStackTrace();
                    }finally {
                        next.cancel();
                        if(next.channel() != null){
                            next.channel().close();
                        }
                    }
                }
            }
            if(selector != null){
                selector.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    private void handle(SelectionKey key)throws Exception{
        if (key.isValid()){
            SocketChannel channel = (SocketChannel)key.channel();
            if (key.isConnectable()){
                if (channel.finishConnect()){
                    channel.register(selector,SelectionKey.OP_READ);
                    write(channel,"我要再次获取时间");
                }
            }
            if(key.isReadable()){
                ByteBuffer buffer = ByteBuffer.allocate(1024);
                int read = channel.read(buffer);
                if(read > 0){
                    buffer.flip();
                    byte[] bytes = new byte[buffer.remaining()];
                    buffer.get(bytes);
                    System.out.println("客户端接收到:" + new String(bytes,"UTF-8"));
                }
            }
        }
    }

    private void connection()throws Exception{
        if(socketChannel.connect(new InetSocketAddress(host,port))){
            socketChannel.register(selector, SelectionKey.OP_READ);
            write(socketChannel,"我要获取时间");
        }else{
            socketChannel.register(selector,SelectionKey.OP_CONNECT);
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
        new Thread(new Client("127.0.0.1",8888)).start();
    }
}
