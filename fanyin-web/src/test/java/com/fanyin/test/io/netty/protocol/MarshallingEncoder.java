package com.fanyin.test.io.netty.protocol;

import io.netty.buffer.ByteBuf;
import org.jboss.marshalling.Marshaller;

/**
 * @author 二哥很猛
 * @date 2018/7/20 10:45
 */
public class MarshallingEncoder {

    private static final byte[] LENGTH_PLACEHOLDER = new byte[4];

    private Marshaller marshaller;

    public MarshallingEncoder()throws Exception{
        this.marshaller = MarshallingCodeCFactory.buildMarshalling();
    }

    public void encode(Object msg, ByteBuf out)throws Exception{
        try {
            int lengthPos = out.writerIndex();
            out.writeBytes(LENGTH_PLACEHOLDER);
            ChannelBufferByteOutput output = new ChannelBufferByteOutput(out);
            marshaller.start(output);
            marshaller.writeObject(msg);
            marshaller.finish();
            out.setInt(lengthPos,out.writerIndex() - lengthPos - 4);
        } finally {
            marshaller.close();
        }
    }
}
