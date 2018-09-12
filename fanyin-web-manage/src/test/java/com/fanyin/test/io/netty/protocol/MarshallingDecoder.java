package com.fanyin.test.io.netty.protocol;

import io.netty.buffer.ByteBuf;
import org.jboss.marshalling.ByteInput;
import org.jboss.marshalling.Unmarshaller;

/**
 * @author 二哥很猛
 * @date 2018/7/20 11:10
 */
public class MarshallingDecoder {

    private Unmarshaller unmarshaller;

    public MarshallingDecoder()throws Exception{
        this.unmarshaller = MarshallingCodeCFactory.buildUnmarshaller();
    }

    public Object decode(ByteBuf in)throws Exception{
        int size = in.readInt();
        ByteBuf slice = in.slice(in.readerIndex(), size);
        ByteInput input = new ChannelBufferByteInput(slice);
        try{
            unmarshaller.start(input);
            Object o = unmarshaller.readObject();
            unmarshaller.finish();
            in.readerIndex(in.readerIndex() + size);
            return o;
        }finally {
            unmarshaller.close();
        }
    }

}
