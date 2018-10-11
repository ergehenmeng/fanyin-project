package com.fanyin.test.leetcode;

import java.util.HashMap;
import java.util.Map;
import java.util.Stack;


/**
 * @author 二哥很猛
 * @date 2018/10/8 15:48
 */
public class Valid {

    public static void main(String[] args) {
        System.out.println(isValid("]"));;
    }

    private static final Map<Character,Character> MAP = new HashMap<>();

    static {
        MAP.put(')','(');
        MAP.put(']','[');
        MAP.put('}','{');
    }

    private static boolean isValid(String s) {
        Stack<Character> stack = new Stack<>();
        for (int i = 0,length = s.length(); i < length; i++ ){
            char c = s.charAt(i);
            Character character = MAP.get(c);
            if(character != null){
                if(stack.isEmpty()){
                    return false;
                }
                Character pop = stack.pop();
                if(!pop.equals(character)){
                    return false;
                }
            }else{
                stack.push(c);
            }
        }
        return stack.isEmpty();
    }
}
