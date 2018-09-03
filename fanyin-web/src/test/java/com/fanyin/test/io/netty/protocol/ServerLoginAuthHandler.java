package com.fanyin.test.io.netty.protocol;

import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;

import java.net.InetSocketAddress;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author 二哥很猛
 * @date 2018/7/20 13:51
 */
public class ServerLoginAuthHandler extends ChannelInboundHandlerAdapter {

    private Map<String,Boolean> map = new ConcurrentHashMap<>();

    private String[] whiteList = {"127.0.0.1"};


    @Override
    public void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
        Message message = (Message)msg;
        if (message.getHeader() != null && message.getHeader().getType() == MessageType.LOGIN_REQUEST.value()){
            String ipInfo = ctx.channel().remoteAddress().toString();
            Message response;
            //重复登录
            if (map.containsKey(ipInfo)){
                response = buildResponse((byte)-1);
            }else{
                InetSocketAddress socketAddress = (InetSocketAddress)ctx.channel().remoteAddress();
                String ip = socketAddress.getAddress().getHostAddress();
                boolean flag = inWhiteList(ip);
                if (flag){
                    response = buildResponse((byte)1);
                    map.put(ipInfo,true);
                }else {
                    response = buildResponse((byte)-1);
                }
            }
            ctx.writeAndFlush(response);
        }else{
            ctx.fireChannelRead(msg);
        }
    }

    private boolean inWhiteList(String ip){
        for (String key :whiteList){
            if(key.equals(ip)){
                return true;
            }
        }
        return false;
    }

    private Message buildResponse(byte body){
        Message message = new Message();
        MessageHeader header = new MessageHeader();
        header.setType(MessageType.LOGIN_RESPONSE.value());
        message.setHeader(header);
        message.setBody(body);
        return message;
    }

    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
        String ipInfo = ctx.channel().remoteAddress().toString();
        map.remove(ipInfo);
        ctx.close();
        ctx.fireExceptionCaught(cause);
    }
}
