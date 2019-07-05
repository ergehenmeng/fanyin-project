package com.fanyin.test.leetcode.geektime;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.UUID;

/**
 * @author 王艳兵
 * @date 2019/7/5 14:05
 */
public class 田忌赛马排列组合 {

    public static void main(String[] args) {

        ArrayList<String> horses = new	ArrayList<>(Arrays.asList("t1", "t2", "t3"));

        calc(horses,new ArrayList<>());

        System.out.println(UUID.randomUUID().toString());

    }


    // 设置齐王的马跑完所需时间
    private static HashMap<String, Double> QWH = new HashMap<String, Double>(){
        {
            put("q1", 1.0);
            put("q2", 2.0);
            put("q3", 3.0);
        }
    };

    // 设置田忌的马跑完所需时间
    private static HashMap<String, Double> TJH = new HashMap<String, Double>(){
        {
            put("t1", 1.5);
            put("t2", 2.5);
            put("t3", 3.5);
        }
    };

    private	static ArrayList<String> QW = new ArrayList<>(Arrays.asList("q1", "q2", "q3"));

    /**
     * 	使用函数的递归（嵌套）调用，找出所有可能的马匹出战顺序
     * @param horses 目前还剩多少马没有出战，
     * @param result 保存当前已经出战的马匹及顺序
     */

    private static void calc(ArrayList<String> horses, ArrayList<String> result) {

        // 所有马匹都已经出战，判断哪方获胜，输出结果
        if (horses.size() == 0) {
            compare(result, QW);
            return;
        }

        for (int i = 0; i < horses.size(); i++) {
            // 从剩下的未出战马匹中，选择一匹，加入结果
            ArrayList<String> new_result = (ArrayList<String>)(result.clone());
            new_result.add(horses.get(i));

            // 将已选择的马匹从未出战的列表中移出
            ArrayList<String> rest_horses = ((ArrayList<String>)horses.clone());
            rest_horses.remove(i);

            // 递归调用，对于剩余的马匹继续生成排列
            calc(rest_horses, new_result);
        }

    }

    private static void compare(ArrayList<String> t, ArrayList<String> q) {
        int winTime = 0;
        for (int i = 0; i < t.size(); i++) {
            System.out.println(TJH.get(t.get(i)) + " " +  QWH.get(q.get(i)));
            if (TJH.get(t.get(i)) < QWH.get(q.get(i))){
                winTime ++;
            }
        }

        if (winTime > (t.size() / 2)){
            System.out.println(" 田忌获胜！");
        }else {
            System.out.println(" 齐王获胜！");
        }
    }



}
