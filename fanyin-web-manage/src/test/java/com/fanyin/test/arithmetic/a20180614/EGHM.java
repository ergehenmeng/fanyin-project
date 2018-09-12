package com.fanyin.test.arithmetic.a20180614;

import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Maps;

import java.util.Map;

/**
 * @author 二哥很猛
 * @date 2018/6/14 16:59

 */
public class EGHM {
    public static void main(String[] args) {
        System.out.println(JSONObject.toJSONString(map(new String[]{"salt","tea","soda","toast"})));
        int[] pi = pi(5);
        for (int i : pi){
            System.out.print(i + ",");
        }
    }

    /**
     * firstChar(["salt","tea","soda","toast"])	    {"t":"teatoast","s":"saltsoda"}
     * firstChar(["aa","bb","cc","aAA","cCC","d"])	{"d":"d","b":"bb","c":"cccCC","a":"aaaAA"}
     * firstChar([])	{}
     */
    private static Map<String,String> map(String[] strList){
        Map<String,String> map = Maps.newHashMap();
        if(strList != null){
            for (String s : strList){
                char c = s.charAt(0);
                String key = String.valueOf(c);
                map.merge(key, s,(old, s1) -> old + s1);
            }
        }
        return map;
    }

    /**
     *返回一个包含pi(参考Math.PI)的前n位数字的整数数组长度，n为方法接收的参数。
     * makePi(1)	[3]
     * makePi(2)	[3,1]
     * makePi(3)	[3,1,4]
     */
    private static int[] pi(int length){
        String pi = String.valueOf(Math.PI).replace(".","");
        int[] result = new int[length];
        for (int i = 0; i < length; i++){
            String now = String.valueOf(pi.charAt(i));
            result[i] = Integer.parseInt(now);
        }
        return result;
    }
    private static int[] pi2(int length){
        int[] result = new int[length];
        for(int i=0;i<length;i++){
            result[i] = (int) (Math.PI*(Math.pow(10, i))%10);
        }
        return result;
    }

    /**
     *有两个任意长度的整型数组， 返回有多少个数组有1作为他们的第一个元素。
     * start1([1,2,3],[1,3])	2
     * start1([7,2,3],[1])	1
     * start1([1,2],[])	1
     */
    private static int start1(int[] first ,int[] second){
        return start(first) + start(second);
    }

    private static int start(int[] arr){
        if(arr == null || arr.length == 0 || arr[0] != 1){
            return 0;
        }
        return 1;
    }
}
