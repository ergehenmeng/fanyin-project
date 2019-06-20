package com.fanyin.test.io.nio;

import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.SocketChannel;
import java.nio.charset.Charset;
import java.util.Iterator;
import java.util.Scanner;

/**
 * @author 二哥很猛
 * @date 2018/7/18 16:59
 */
public class Client implements Runnable {

    private Selector selector;

    private String host;

    private SocketChannel socketChannel;

    private int port;

    public Client(String host,int port)throws Exception{
        this.selector = Selector.open();
        this.host = host;
        this.port = port;
    }

    @Override
    public void run() {
        try {
            socketChannel = SocketChannel.open();
            socketChannel.configureBlocking(false);
            socketChannel.connect(new InetSocketAddress(host,port));
            socketChannel.register(selector,SelectionKey.OP_CONNECT);

            Scanner scanner = new Scanner(System.in);
            while (true){
                selector.select();
                Iterator<SelectionKey> iterator = selector.selectedKeys().iterator();
                while (iterator.hasNext()){
                    SelectionKey selectionKey = iterator.next();
                    iterator.remove();
                    if(selectionKey.isValid()){
                        if(selectionKey.isConnectable()){
                            socketChannel.finishConnect();
                            socketChannel.register(selector,SelectionKey.OP_WRITE);
                            System.out.println("client success");
                            break;
                        }else if(selectionKey.isWritable()){
                            System.out.print("enter word : ");
                            String line = scanner.nextLine();
                            ByteBuffer buffer = ByteBuffer.wrap(line.getBytes(Charset.forName("UTF-8")));
                            socketChannel.write(buffer);
                            socketChannel.register(selector,SelectionKey.OP_READ);
                        }else if(selectionKey.isReadable()){
                            SocketChannel channel = (SocketChannel)selectionKey.channel();
                            ByteBuffer buffer = ByteBuffer.allocate(1024);
                            int read = channel.read(buffer);
                            if(read > 0){
                                buffer.flip();
                                byte[] bytes = new byte[buffer.remaining()];
                                buffer.get(bytes);
                                System.out.println("客户端接收到:" + new String(bytes, Charset.forName("UTF-8")));
                                channel.register(selector,SelectionKey.OP_WRITE);
                            }
                        }
                    }
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public static void main(String[] args)throws Exception {
        new Thread(new Client("127.0.0.1",8888)).start();
    }
}
