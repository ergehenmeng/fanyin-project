package com.fanyin.test.chain;

/**
 * @author 二哥很猛
 * @date 2018/9/3 10:23
 */
public interface Handler  {

    /**
     * 执行逻辑
     */
    void doHandler(ChainHandler chainHandler);

}
