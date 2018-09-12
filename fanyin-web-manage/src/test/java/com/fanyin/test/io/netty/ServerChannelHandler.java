package com.fanyin.test.io.netty;

import io.netty.channel.ChannelInitializer;
import io.netty.channel.socket.SocketChannel;
import io.netty.handler.codec.FixedLengthFrameDecoder;

/**
 * @author 二哥很猛
 * @date 2018/7/18 19:34
 */
public class ServerChannelHandler extends ChannelInitializer<SocketChannel> {
    @Override
    protected void initChannel(SocketChannel ch) throws Exception {
        ch.pipeline().addLast(new FixedLengthFrameDecoder(10)).addLast(new ServerHandler());
    }
}
