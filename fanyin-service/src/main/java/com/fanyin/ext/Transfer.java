package com.fanyin.ext;

/**
 * @author 数据转换
 * @date 2018/11/21 10:14
 */
public interface Transfer<S,T> {

    /**
     * 格式化数据 将S转换为T
     * @param s 原始数据
     * @return 结果对象
     */
     T transfer(S s);
}

