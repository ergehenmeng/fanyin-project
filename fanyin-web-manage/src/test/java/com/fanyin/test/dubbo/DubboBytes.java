package com.fanyin.test.dubbo;


import com.alibaba.dubbo.common.io.Bytes;

/**
 * @author 二哥很猛
 * @date 2018/10/16 14:41
 */
public class DubboBytes {
    public static void main(String[] args) {
        short a = (short) 0xdabb;
        byte[] bytes = Bytes.short2bytes(a);
    }
}
