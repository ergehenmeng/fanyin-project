package com.fanyin.utils;

/**
 * @author 王艳兵
 * @date 2018/4/11 9:56
 */
public class Main {

    private static int index = 10;

    public synchronized static String get(){
        if(index == 99){
            index = 10;
        }else{
            index++;
        }
        return index + "";
    }
}
