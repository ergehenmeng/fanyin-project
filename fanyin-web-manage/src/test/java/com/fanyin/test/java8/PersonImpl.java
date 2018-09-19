package com.fanyin.test.java8;

import com.google.common.base.Supplier;

/**
 * @author 二哥很猛
 * @date 2018/9/18 16:02
 */
public class PersonImpl implements Person {
    @Override
    public Object create(Factory factory) {
        InvokerMain create = factory::create;
        return create.invoker();
    }
}
