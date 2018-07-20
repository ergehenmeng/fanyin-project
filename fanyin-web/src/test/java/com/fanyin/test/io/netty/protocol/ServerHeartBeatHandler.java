package com.fanyin.test.io.netty.protocol;

import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * @author 王艳兵
 * @date 2018/7/20 14:10
 */
public class ServerHeartBeatHandler extends ChannelInboundHandlerAdapter {

    private static final Log LOG = LogFactory.getLog(ServerHeartBeatHandler.class);

    @Override
    public void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
        Message message = (Message)msg;
        if(message.getHeader() != null && message.getHeader().getType() == MessageType.HEART_BEAT_REQUEST.value()){
            LOG.info("服务端接受到心跳...");
            Message response = Message.build(MessageType.HEART_BEAT_RESPONSE.value());
            ctx.writeAndFlush(response);
            LOG.info("服务器端发送心跳:" + response);
        }else {
            ctx.fireChannelRead(msg);
        }
    }

    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
        ctx.close();
    }
}
