package com.fanyin.test.io.netty.protocol;

/**
 * 自定义协议
 * @author 王艳兵
 * @date 2018/7/20 9:26
 */
public final class Message {

    private MessageHeader header;

    private Object body;

    public MessageHeader getHeader() {
        return header;
    }

    public void setHeader(MessageHeader header) {
        this.header = header;
    }

    public Object getBody() {
        return body;
    }

    public void setBody(Object body) {
        this.body = body;
    }

    public static Message build(byte type){
        Message message = new Message();
        MessageHeader header = new MessageHeader();
        header.setType(type);
        message.setHeader(header);
        return message;
    }

    @Override
    public String toString() {
        return "Message{" +
                "header=" + header +
                ", body=" + body +
                '}';
    }
}
