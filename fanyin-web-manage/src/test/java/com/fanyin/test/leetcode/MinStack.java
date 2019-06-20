package com.fanyin.test.leetcode;

import java.util.ArrayList;
import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/11/5 9:34
 */
public class MinStack {

    /**
     *
     */
    private List<Integer> list = new ArrayList<>();

    private int min = Integer.MAX_VALUE;

    public MinStack() {
    }

    public void push(int x) {
        if(min >= x){
            list.add(min);
            min = x;
        }
        list.add(x);
    }

    public void pop() {
        int index = list.size() - 1;
        if(index < 1){
            return;
        }
        Integer remove = list.remove(index);
        if(remove == min){
            min = list.remove(index - 1);
        }
    }

    public int top() {
        int index = list.size() - 1;
        if(index >= 0){
            return list.get(index);
        }
        return 0;
    }

    public int getMin() {
        return min;
    }

    public static void main(String[] args) {
        MinStack stack = new MinStack();
        stack.push(0);
        stack.push(1);
        stack.push(0);
        stack.pop();
        int min = stack.getMin();
        System.out.println(min);

        System.out.println(findN(1073741825L));
    }

    /**
     * 查找比n小的2的幂指数
     * @param n
     * @return
     */
    public static long findN(long n){
        n |= n >> 1;
        n |= n >> 2;
        n |= n >> 4;
        n |= n >> 8; // 整型一般是 32 位，上面我是假设 8 位。
        n |= n >> 16;

        return (n + 1) >> 1;
    }


}
