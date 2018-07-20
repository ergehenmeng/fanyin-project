package com.fanyin.test.io.netty.websocket;

import com.fanyin.exception.BusinessException;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.SimpleChannelInboundHandler;
import io.netty.handler.codec.http.FullHttpRequest;
import io.netty.handler.codec.http.HttpRequest;
import io.netty.handler.codec.http.websocketx.*;

import java.util.Date;

/**
 * @author 王艳兵
 * @date 2018/7/19 16:20
 */
public class WebSocketHandler extends SimpleChannelInboundHandler<Object> {

    private WebSocketServerHandshaker handshaker;

    @Override
    protected void channelRead0(ChannelHandlerContext ctx, Object msg) throws Exception {
        if(msg instanceof FullHttpRequest){
            handlerHttpRequest(ctx,(FullHttpRequest)msg);
        }else{
            handleWebSocket(ctx,(WebSocketFrame)msg);
        }
    }

    private void handlerHttpRequest(ChannelHandlerContext ctx, FullHttpRequest msg) throws Exception{
        WebSocketServerHandshakerFactory factory = new WebSocketServerHandshakerFactory("ws://localhost:8888/websocket",null,false);
        this.handshaker = factory.newHandshaker(msg);
        if (handshaker != null){
            handshaker.handshake(ctx.channel(),msg);
        }else{
            WebSocketServerHandshakerFactory.sendUnsupportedVersionResponse(ctx.channel());
        }
    }

    private void handleWebSocket(ChannelHandlerContext ctx, WebSocketFrame msg) {
        if(msg instanceof CloseWebSocketFrame){
            handshaker.close(ctx.channel(),(CloseWebSocketFrame)msg.retain());
        }
        if(msg instanceof PingWebSocketFrame){
            ctx.channel().write(new PingWebSocketFrame(msg.content().retain()));
        }
        if(!(msg instanceof TextWebSocketFrame)){
            throw new UnsupportedOperationException("不支持的类型");
        }
        TextWebSocketFrame frame = (TextWebSocketFrame)msg;
        String text = frame.text();
        ctx.channel().write(new TextWebSocketFrame(text + " 欢迎进入聊天室,时间:" + new Date().toString()));

    }
}
