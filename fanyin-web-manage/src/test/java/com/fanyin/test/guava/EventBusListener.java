package com.fanyin.test.guava;

import com.google.common.eventbus.DeadEvent;
import com.google.common.eventbus.Subscribe;

/**
 * @author 二哥很猛
 * @date 2019/2/15 17:41
 */
public class EventBusListener {

    @Subscribe
    public void save(DeadEvent event){
        System.out.println("接收到消息:" + event.getSource() + event.getEvent());
    }
}
