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
    }
}
