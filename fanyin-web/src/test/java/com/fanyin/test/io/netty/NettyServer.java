package com.fanyin.test.io.netty;

import io.netty.bootstrap.ServerBootstrap;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelOption;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.nio.NioServerSocketChannel;

/**
 * @author 二哥很猛
 * @date 2018/7/18 19:20
 */
public class NettyServer {

    public void bind(int port)throws Exception{
        EventLoopGroup bossGroup = new NioEventLoopGroup();
        EventLoopGroup workerGroup = new NioEventLoopGroup();
        try {
            ServerBootstrap bootstrap = new ServerBootstrap();
            bootstrap.group(bossGroup,workerGroup);
            bootstrap.channel(NioServerSocketChannel.class)
                    .option(ChannelOption.SO_BACKLOG,1024)
                    .childHandler(new ServerChannelHandler())
                    .handler(new ChannelInitializer<NioServerSocketChannel>() {
                        @Override
                        protected void initChannel(NioServerSocketChannel ch) throws Exception {
                            System.out.println("服务端启动中");
                        }
                    });

            ChannelFuture sync = bootstrap.bind(port).sync();

            sync.addListener(future -> {
               if(future.isSuccess()){
                   System.out.println("接口绑定成功");
               }
            });
            sync.channel().closeFuture().sync();
        } finally {
            bossGroup.shutdownGracefully();
            workerGroup.shutdownGracefully();
        }
    }

    public static void main(String[] args) throws Exception{
        NettyServer server = new NettyServer();
        server.bind(8888);
    }
}
