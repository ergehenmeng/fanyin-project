package com.fanyin.test.io.netty.protocol;

import io.netty.buffer.ByteBuf;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.LengthFieldBasedFrameDecoder;

import java.util.HashMap;
import java.util.Map;

/**
 * @author 王艳兵
 * @date 2018/7/20 10:42
 */
public class NettyDecoder extends LengthFieldBasedFrameDecoder {

    private MarshallingDecoder marshallingDecoder;


    public NettyDecoder(int maxFrameLength, int lengthFieldOffset, int lengthFieldLength) throws Exception{
        super(maxFrameLength, lengthFieldOffset, lengthFieldLength);
        this.marshallingDecoder = new MarshallingDecoder();
    }

    @Override
    protected Object decode(ChannelHandlerContext ctx, ByteBuf in) throws Exception {
        ByteBuf decode = (ByteBuf) super.decode(ctx, in);
        if (decode == null){
            return null;
        }
        Message message = new Message();
        MessageHeader header = new MessageHeader();
        header.setCrcCode(decode.readInt());
        header.setLength(decode.readInt());
        header.setSessionID(decode.readLong());
        header.setType(decode.readByte());
        header.setPriority(decode.readByte());
        int size = decode.readInt();
        if(size > 0){
            Map<String,Object> attch = new HashMap<>(size);
            int keySize;
            String key;
            byte[] keyArray;
            for (int i = 0; i < size ;i++){
                keySize = decode.readInt();
                keyArray = new byte[keySize];
                decode.readBytes(keyArray);
                key = new String(keyArray,"UTF-8");
                attch.put(key,marshallingDecoder.decode(decode));
            }
            header.setAttachment(attch);
        }
        if (decode.readableBytes() > 4){
            message.setBody(marshallingDecoder.decode(decode));
        }
        message.setHeader(header);
        return message;
    }
}
