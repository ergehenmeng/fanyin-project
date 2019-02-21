package com.fanyin.test.guava;

import com.google.common.eventbus.DeadEvent;
import com.google.common.eventbus.EventBus;

/**
 * @author 二哥很猛
 * @date 2019/2/15 17:40
 */
public class EventBusTest {
    public static void main(String[] args) {
        EventBus bus = new EventBus();
        EventBusListener listener = new EventBusListener();
        bus.register(listener);
        DeadEvent event = new DeadEvent("我","牛");
        bus.post(event);
    }
}
