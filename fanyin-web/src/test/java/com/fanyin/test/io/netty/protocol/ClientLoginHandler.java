package com.fanyin.test.io.netty.protocol;

import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * @author 王艳兵
 * @date 2018/7/20 14:57
 */
public class ClientLoginHandler extends ChannelInboundHandlerAdapter {

    private static final Log LOG = LogFactory.getLog(ClientLoginHandler.class);

    @Override
    public void channelActive(ChannelHandlerContext ctx) throws Exception {
        ctx.writeAndFlush(Message.build(MessageType.LOGIN_REQUEST.value()));
    }

    @Override
    public void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
        Message message = (Message)msg;
        if(message.getHeader() != null && message.getHeader().getType() == MessageType.LOGIN_RESPONSE.value()){
            byte loginBody = (byte)message.getBody();
            if(loginBody != (byte)1){
                LOG.error("登录失败:" + message);
                ctx.close();
            }else{
                LOG.info("登录成功:" + message);
                ctx.fireChannelRead(message);
            }
        }else{
            ctx.fireChannelRead(message);
        }
    }

    @Override
    public void channelReadComplete(ChannelHandlerContext ctx) throws Exception {
        super.channelReadComplete(ctx);
    }

    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
        ctx.fireExceptionCaught(cause);
    }
}
