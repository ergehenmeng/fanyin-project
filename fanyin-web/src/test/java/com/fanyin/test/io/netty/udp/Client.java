package com.fanyin.test.io.netty.udp;

import io.netty.bootstrap.Bootstrap;
import io.netty.buffer.Unpooled;
import io.netty.channel.Channel;
import io.netty.channel.ChannelOption;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.DatagramPacket;
import io.netty.channel.socket.nio.NioDatagramChannel;
import io.netty.util.CharsetUtil;

import java.net.InetSocketAddress;

/**
 * @author 二哥很猛
 * @date 2018/7/19 16:59
 */
public class Client {

    public void run(int port)throws Exception{
        EventLoopGroup group = new NioEventLoopGroup();
        try {
            Bootstrap bootstrap = new Bootstrap();
            bootstrap.group(group).channel(NioDatagramChannel.class)
                    .option(ChannelOption.SO_BROADCAST,true)
                    .handler(new UdpClientHandler());
            Channel channel = bootstrap.bind(0).sync().channel();
            channel.writeAndFlush(
                    new DatagramPacket(
                            Unpooled.copiedBuffer("查询", CharsetUtil.UTF_8),
                            new InetSocketAddress("255.255.255.255",port)
                    )
            ).sync();
        } finally {
            group.shutdownGracefully();
        }
    }

    public static void main(String[] args)throws Exception {
        Client client = new Client();
        client.run(9999);
    }
}
