package com.fanyin.test.loader;



/**
 * @author 二哥很猛
 * @date 2018/3/30 14:23
 */
public class HotSwapClassLoader extends ClassLoader {

    public HotSwapClassLoader(){
        super(HotSwapClassLoader.class.getClassLoader());
    }

    public Class<?> loadByte(byte[] classByte){
        return defineClass(null,classByte,0,classByte.length);
    }
}
