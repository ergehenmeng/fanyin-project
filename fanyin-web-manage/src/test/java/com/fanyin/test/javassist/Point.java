package com.fanyin.test.javassist;

/**
 * @author 王艳兵
 * @date 2018/11/19 10:06
 */
public class Point {
    int x,y;
    void move(int dx,int dy){
        x += dx;
        y += dy;
    }
}
