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
        // populateBean这一句特别的关键，它需要给A的属性赋值，所以此处会去实例化B~~
        // 而B我们从上可以看到它就是个普通的Bean（并不需要创建代理对象），实例化完成之后，继续给他的属性A赋值，而此时它会去拿到A的早期引用
        // 也就在此处在给B的属性a赋值的时候，会执行到上面放进去的Bean A流程中的getEarlyBeanReference()方法  从而拿到A的早期引用~~
        // 执行A的getEarlyBeanReference()方法的时候，会执行自动代理创建器，但是由于A没有标注事务，所以最终不会创建代理，so B合格属性引用会是A的**原始对象**
        // 需要注意的是：@Async的代理对象不是在getEarlyBeanReference()中创建的，是在postProcessAfterInitialization创建的代理
        // 从这我们也可以看出@Async的代理它默认并不支持你去循环引用，因为它并没有把代理对象的早期引用提供出来~~~（注意这点和自动代理创建器的区别~）
        // 结论：此处给A的依赖属性字段B赋值为了B的实例(因为B不需要创建代理，所以就是原始对象)
        // 而此处实例B里面依赖的A注入的仍旧为Bean A的普通实例对象（注意  是原始对象非代理对象）  注：此时exposedObject也依旧为原始对象
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
