package com.fanyin.test.io.netty;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;

import java.util.Date;

/**
 * @author 二哥很猛
 * @date 2018/7/18 20:02
 */
public class ClientHandler extends ChannelInboundHandlerAdapter{


    @Override
    public void channelActive(ChannelHandlerContext ctx) throws Exception {
        byte[] bytes = "我是客户端".getBytes();
        ByteBuf buffer = Unpooled.buffer(bytes.length);
        buffer.writeBytes(bytes);
        ctx.writeAndFlush(buffer);
    }

    @Override
    public void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
        ByteBuf byteBuf = (ByteBuf)msg;
        byte[] req = new byte[byteBuf.readableBytes()];
        byteBuf.readBytes(req);
        System.out.println("客户端接收:" + new String(req,"UTF-8"));
        ByteBuf resp = Unpooled.copiedBuffer(new Date().toString().getBytes());
        ctx.write(resp);
    }


    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
        ctx.close();
    }
}
