package com.fanyin.test.io.netty.protocol;

/**
 * @author 二哥很猛
 * @date 2018/7/20 13:53
 */
public enum  MessageType {

    LOGIN_REQUEST((byte)0),LOGIN_RESPONSE((byte)1),HEART_BEAT_REQUEST((byte)2),HEART_BEAT_RESPONSE((byte)3);

    private byte value;

    MessageType(byte value) {
        this.value = value;
    }

    public byte value() {
        return value;
    }


}
