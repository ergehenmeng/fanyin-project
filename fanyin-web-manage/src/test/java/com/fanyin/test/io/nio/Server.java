package com.fanyin.test.io.nio;

import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;
import java.nio.charset.Charset;
import java.util.Iterator;
import java.util.Scanner;
import java.util.Set;

/**
 * @author 二哥很猛
 * @date 2018/7/18 16:28
 */
public class Server implements Runnable{

    private Selector selector;

    private ServerSocketChannel serverSocketChannel;

    private int port;

    public Server(int port)throws Exception{
        this.selector = Selector.open();
        this.port = port;
    }

    @Override
    public void run() {

        try {
            serverSocketChannel = ServerSocketChannel.open();
            serverSocketChannel.configureBlocking(false);
            serverSocketChannel.socket().bind(new InetSocketAddress(port),1024);
            serverSocketChannel.register(selector, SelectionKey.OP_ACCEPT);
            Scanner scanner = new Scanner(System.in);
            while (true){
                try {
                    selector.select(1000);
                    Set<SelectionKey> keys = selector.selectedKeys();
                    Iterator<SelectionKey> iterator = keys.iterator();
                    SelectionKey key;
                    while (iterator.hasNext()){
                        key = iterator.next();
                        iterator.remove();
                        this.handle(key,scanner);
                    }
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    private void handle(SelectionKey key,Scanner scanner)throws Exception{
        if (key.isValid()){
            if (key.isAcceptable()){
                this.accept(key);
            }else if(key.isReadable()){
                this.read(key);
            }else if(key.isConnectable()){
                this.connect(key);
            }else if(key.isWritable()){
                this.write(key,scanner);
            }
        }
    }

    private void write(SelectionKey key,Scanner scanner)throws Exception{
        SocketChannel socketChannel = (SocketChannel) key.channel();
        System.out.print("回复: ");
        String nextLine = scanner.nextLine();
        ByteBuffer buffer = ByteBuffer.wrap(nextLine.getBytes(Charset.forName("UTF-8")));
        socketChannel.write(buffer);
        socketChannel.register(selector,SelectionKey.OP_READ);
    }

    private void connect(SelectionKey key) {
        System.out.println("客户端已连接");
    }

    private void read(SelectionKey key) throws Exception{
        SocketChannel channel = (SocketChannel)key.channel();
        ByteBuffer buffer = ByteBuffer.allocate(1024);
        int read = channel.read(buffer);
        if(read > 0){
            buffer.flip();
            byte[] bytes = new byte[buffer.remaining()];
            buffer.get(bytes);
            System.out.println("服务端接收到:" + new String(bytes, Charset.forName("UTF-8")));
            channel.register(selector,SelectionKey.OP_WRITE);
        }
    }

    private void accept(SelectionKey key)throws Exception{
        ServerSocketChannel channel = (ServerSocketChannel) key.channel();
        SocketChannel clientChannel = channel.accept();
        clientChannel.configureBlocking(false);
        clientChannel.register(selector,SelectionKey.OP_READ);
        System.out.println("finish to accept a new client ");
    }


    public static void main(String[] args)throws Exception {
        new Thread(new Server(8888)).start();
    }


}
