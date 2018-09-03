package com.fanyin.test.base;

import java.math.BigInteger;

/**
 * 位运行算符
 * @author 二哥很猛
 */
public class BitCalc {
	public static void main(String[] args) {
		int a = 129;
		int b = 128;
		System.out.println("a的二进制:"+Integer.toBinaryString(a));//10转2
		System.out.println("二进制转十进制:" + new BigInteger("10001001", 2));//2转10
		System.out.println("b的二进制:" + Integer.toBinaryString(b));
		//& 与运算符 只有操作的两个数中位都位1 结果才为1 否则为0
		System.out.println("a&b结果:" + (a&b));
		//| 或运算符 只要操作的两个数中位有一个是1结果即为1
		System.out.println("a|b结果:" + (a|b));
		//~ 非运算符 如果数的位为1则结果为零 如果为零则结果为1
		System.out.println("~a结果:" + (~a));
		//^异或运算符 如果两个位相同则结果为0 不同则为1
		System.out.println("a^b结果:" + (a^b));
		//移位运算符
		// << 左移运算 将运算符左边的对象向左移动右边指定的位数 x<<3 将x向左移动三位 低位补零
		// >> (有符号)右移运算 将运算符左边的对象向右移动右边指定的位数 x>>5 将x向右移动五位 注意: 正值 高位补零 负值高位补1
		// >>> (无符号)右移运算 将运算符左边的对象向右移动右边指定的位数 x>>>5 将x向右移动五位 注意:无论正负 高位都补零
		int c = -4;
		int d = 2;
		System.out.println("c的二进制:"+Integer.toBinaryString(c));//10转2
		System.out.println("d的二进制:"+Integer.toBinaryString(d));//10转2
		System.out.println("c<<d结果:" + Integer.toBinaryString(c << d));
		System.out.println("c>>d结果:" + Integer.toBinaryString(c >> d));
		System.out.println("c>>>d结果:" + Integer.toBinaryString(c >>> d));
        a &= 8;
        System.out.println("a&=8结果:" + (a));
        a |=8;
        System.out.println("a|=的结果:" + a);
        a ^= 8;
        System.out.println("a^=8的结果:" + a);

		//负数二进制 最高位1为负数 0为整数
		// -5:先取绝对值之后的数 0000 0000 0000 0000 0000 0000 0000 0101
		// 取反(反码)   1111 1111 1111 1111 1111 1111 1111 1010
		// 反码+1(补码) 1111 1111 1111 1111 1111 1111 1111 1011
		
		//一个字节长度为8位  
		// byte  占一个字节
        // char  占两个字节
		// int   占四个字节
        // short 占两个字节
		// long  占八个字节
        // double 占八个字节
		// float 占四个字节
        // boolean 1位

		
	}
}
