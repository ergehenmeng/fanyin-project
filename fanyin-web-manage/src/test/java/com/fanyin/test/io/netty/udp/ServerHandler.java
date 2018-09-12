package com.fanyin.test.io.netty.udp;

import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.SimpleChannelInboundHandler;
import io.netty.channel.socket.DatagramPacket;
import io.netty.util.CharsetUtil;

import java.util.concurrent.ThreadLocalRandom;


/**
 * @author 二哥很猛
 * @date 2018/7/19 16:45
 */
public class ServerHandler extends SimpleChannelInboundHandler<DatagramPacket> {
    @Override
    protected void channelRead0(ChannelHandlerContext ctx, DatagramPacket msg) throws Exception {
        String req = msg.content().toString(CharsetUtil.UTF_8);
        System.out.println(req);
        ctx.writeAndFlush(new DatagramPacket(Unpooled.copiedBuffer(nextQuote(),CharsetUtil.UTF_8),msg.sender()));
    }

    private static final String[] ARRAYS = {"A","B","C","D","E","F","G","X"};

    public String nextQuote(){
        int i = ThreadLocalRandom.current().nextInt(ARRAYS.length);
        return ARRAYS[i];
    }
}
