package com.fanyin.test.io.netty.protocol;

import io.netty.buffer.ByteBuf;
import org.jboss.marshalling.ByteInput;

import java.io.IOException;

/**
 * @author 二哥很猛
 * @date 2018/7/20 11:21
 */
public class ChannelBufferByteInput implements ByteInput {

    private ByteBuf buf;

    public ChannelBufferByteInput(ByteBuf buf){
        this.buf = buf;
    }

    @Override
    public int read() throws IOException {
        if(buf.isReadable()){
            return  buf.readByte() & 0xff;
        }
        return -1;
    }

    @Override
    public int read(byte[] b) throws IOException {
        return read(b, 0, b.length);
    }

    @Override
    public int read(byte[] b, int off, int length) throws IOException {
        int available = available();
        if (available == 0) {
            return -1;
        }
        length = Math.min(available, length);
        buf.readBytes(b, off, length);
        return length;
    }

    @Override
    public int available() throws IOException {
        return buf.readableBytes();
    }

    @Override
    public long skip(long bytes) throws IOException {
        int readable = buf.readableBytes();
        if (readable < bytes) {
            bytes = readable;
        }
        buf.readerIndex((int) (buf.readerIndex() + bytes));
        return bytes;
    }

    @Override
    public void close() throws IOException {

    }
}
