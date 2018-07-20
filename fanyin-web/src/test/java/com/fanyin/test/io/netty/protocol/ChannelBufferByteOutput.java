package com.fanyin.test.io.netty.protocol;

import io.netty.buffer.ByteBuf;
import org.jboss.marshalling.ByteOutput;

import java.io.IOException;

/**
 * @author 王艳兵
 * @date 2018/7/20 10:48
 */
public class ChannelBufferByteOutput implements ByteOutput {

    private final ByteBuf byteBuf;

    public ChannelBufferByteOutput(ByteBuf buf){
        this.byteBuf = buf;
    }

    @Override
    public void write(int b) throws IOException {
        byteBuf.writeByte(b);
    }

    @Override
    public void write(byte[] b) throws IOException {
        byteBuf.writeBytes(b);
    }

    @Override
    public void write(byte[] b, int off, int len) throws IOException {
        byteBuf.writeBytes(b,off,len);
    }

    @Override
    public void close() throws IOException {

    }

    @Override
    public void flush() throws IOException {

    }

    public ByteBuf getByteBuf() {
        return byteBuf;
    }
}
