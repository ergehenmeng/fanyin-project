package com.fanyin.test.leetcode;

/**
 * @author 王艳兵
 * @date 2019/5/28 15:52
 */
public class MiCiFang {
    /**
     * 幂次方
     * @param n 3的多少次方
     * @return
     */
    public static int pow(int n){
        int sum = 1;
        int tmp = 3;
        while(n != 0){
            if((n & 1) == 1){
                sum *= tmp;
            }
            tmp *= tmp;
            n = n >> 1;
        }
        return sum;
    }

    public static void main(String[] args) {
        System.out.println(pow(3));
        System.out.println(titleToNumber("AB"));
    }

    /**
     * Excel单元格转数字
     * 相当于将26进制转10进制 最后一位是26的0次方+自己本身 倒数第二位是 相当于26的一次方 * 本身数字所26个字母的第几位 依次类推
     * 最后将所有的数加在一起即可
     * @param s
     * @return
     */
    public static int titleToNumber(String s) {
        char[] chars = s.toCharArray();
        int result = 0;
        for (int count = chars.length - 1; count >= 0; count--) {
            result += Math.pow(26, chars.length - count - 1) * (chars[count] - 'A' + 1);
        }
        return result;
    }
}
