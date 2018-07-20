package com.fanyin.test.io.netty.protocol;

import io.netty.buffer.ByteBuf;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.MessageToByteEncoder;

import java.util.Map;

/**
 * @author 王艳兵
 * @date 2018/7/20 9:27
 */
public class NettyEncoder extends MessageToByteEncoder<Message> {

    private MarshallingEncoder marshallingEncoder;

    public NettyEncoder()throws Exception{
        this.marshallingEncoder = new MarshallingEncoder();
    }

    @Override
    protected void encode(ChannelHandlerContext ctx, Message msg, ByteBuf out) throws Exception {
        if (msg == null || msg.getHeader() == null){
            throw new Exception("编码为空");
        }
        out.writeInt(msg.getHeader().getCrcCode());
        out.writeInt(msg.getHeader().getLength());
        out.writeLong(msg.getHeader().getSessionID());
        out.writeByte(msg.getHeader().getType());
        out.writeByte(msg.getHeader().getPriority());
        out.writeInt(msg.getHeader().getAttachment().size());
        Map<String, Object> attachment = msg.getHeader().getAttachment();

        byte[] keyByte;
        Object value;
        for (String key :attachment.keySet()){
            keyByte = key.getBytes("UTF-8");
            out.writeInt(keyByte.length);
            out.writeBytes(keyByte);
            value = attachment.get(key);
            marshallingEncoder.encode(value,out);
        }
        if (msg.getBody() != null){
            marshallingEncoder.encode(msg.getBody(),out);
        }else{
            out.writeInt(0);
        }
        out.setInt(4,out.readableBytes() - 8);
    }

    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
        cause.printStackTrace();
    }
}
