package com.fanyin.test.io.netty.protocol;

import io.netty.bootstrap.Bootstrap;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelOption;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.SocketChannel;
import io.netty.channel.socket.nio.NioSocketChannel;
import io.netty.handler.timeout.ReadTimeoutHandler;

import java.net.InetSocketAddress;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

/**
 * @author 二哥很猛
 * @date 2018/7/20 14:36
 */
public class Client {

    private ExecutorService service = Executors.newScheduledThreadPool(1);
    EventLoopGroup group = new NioEventLoopGroup();

    public void connection()throws Exception{
        Bootstrap bootstrap = new Bootstrap();
        try {
            bootstrap.group(group)
                    .channel(NioSocketChannel.class)
                    .option(ChannelOption.TCP_NODELAY,true)
                    .handler(new ChannelInitializer<SocketChannel>() {
                        @Override
                        protected void initChannel(SocketChannel ch) throws Exception {
                            ch.pipeline()
                                    .addLast(new NettyDecoder(1024 * 1024, 4, 4))
                                    .addLast(new NettyEncoder())
                                    .addLast("ReadTimeoutHandler",new ReadTimeoutHandler(50))
                                    .addLast("LoginHandler",new ClientLoginHandler())
                                    .addLast("HeartBeatHandler",new ClientHeartBeatHandler());
                        }
                    });
            ChannelFuture syncFuture = bootstrap.connect(
                    new InetSocketAddress(Constant.REMOTE_IP,Constant.PORT),
                    new InetSocketAddress(Constant.LOCAL_IP, Constant.LOCAL_PORT)
            ).sync();
            System.out.println("客户端开启...");
            syncFuture.channel().closeFuture().sync();
        } finally {
            System.out.println("重新登陆");
            service.execute(() -> {
                try {
                    TimeUnit.SECONDS.sleep(1);
                    connection();
                }catch (Exception e){
                    e.printStackTrace();
                }
            });
        }
    }

    public static void main(String[] args) throws Exception{
        Client client = new Client();
        client.connection();
    }
}
