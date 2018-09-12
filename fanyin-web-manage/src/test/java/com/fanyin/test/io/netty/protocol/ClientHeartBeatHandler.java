package com.fanyin.test.io.netty.protocol;

import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;
import io.netty.util.concurrent.ScheduledFuture;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.concurrent.TimeUnit;

/**
 * 客户端心跳检测
 * @author 二哥很猛
 * @date 2018/7/20 14:23
 */
public class ClientHeartBeatHandler extends ChannelInboundHandlerAdapter {

    private volatile  ScheduledFuture<?> scheduledFuture;

    private static final Log LOG = LogFactory.getLog(ClientHeartBeatHandler.class);


    @Override
    public void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
        Message message = (Message)msg;
        if(message.getHeader() != null && message.getHeader().getType() == MessageType.LOGIN_RESPONSE.value()){
            this.scheduledFuture = ctx.executor().scheduleAtFixedRate(new HeartBeat(ctx), 0, 5000, TimeUnit.MILLISECONDS);
        }else if (message.getHeader() != null && message.getHeader().getType() == MessageType.HEART_BEAT_RESPONSE.value()){
            LOG.info("接收到服务端心跳...");
        }else{
            ctx.fireChannelRead(message);
        }
    }

    public class HeartBeat implements Runnable{

        private ChannelHandlerContext context;

        public HeartBeat(ChannelHandlerContext context){
            this.context = context;
        }

        @Override
        public void run() {
            Message message = Message.build(MessageType.HEART_BEAT_REQUEST.value());
            LOG.info("客户端发送心跳:" + message);
            context.writeAndFlush(message);
        }
    }

    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
        cause.printStackTrace();
        if (scheduledFuture != null){
            scheduledFuture.cancel(true);
            scheduledFuture = null;
        }
        ctx.fireExceptionCaught(cause);
    }
}
