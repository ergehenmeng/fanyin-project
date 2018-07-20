package com.fanyin.test.io.netty.protocol;

import io.netty.bootstrap.ServerBootstrap;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelOption;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.SocketChannel;
import io.netty.channel.socket.nio.NioServerSocketChannel;
import io.netty.handler.logging.LogLevel;
import io.netty.handler.logging.LoggingHandler;
import io.netty.handler.timeout.ReadTimeoutHandler;

/**
 * @author 王艳兵
 * @date 2018/7/20 14:51
 */
public class Server {

    public void run()throws Exception{
        EventLoopGroup group = new NioEventLoopGroup();
        EventLoopGroup worker = new NioEventLoopGroup();

        ServerBootstrap bootstrap = new ServerBootstrap();
        bootstrap.group(group,worker)
                .channel(NioServerSocketChannel.class)
                .option(ChannelOption.SO_BACKLOG,100)
                .handler(new LoggingHandler(LogLevel.INFO))
                .childHandler(new ChannelInitializer<SocketChannel>() {
                    @Override
                    protected void initChannel(SocketChannel ch) throws Exception {
                        ch.pipeline()
                                .addLast(new NettyDecoder(1024 * 1024, 4, 4))
                                .addLast(new NettyEncoder())
                                .addLast("ReadTimeoutHandler",new ReadTimeoutHandler(50))
                                .addLast(new ServerLoginAuthHandler())
                                .addLast("HeartBeatHandler",new ServerHeartBeatHandler());
                    }
                });
        bootstrap.bind(Constant.REMOTE_IP,Constant.PORT).sync();
        System.out.println("开启服务器..." + Constant.REMOTE_IP + ":" + Constant.PORT);
    }

    public static void main(String[] args)throws Exception {
        Server server =  new Server();
        server.run();
    }
}
