package com.fanyin.test.akka;

import akka.actor.UntypedAbstractActor;


/**
 * @author 王艳兵
 * @date 2018/6/27 17:13
 */
public class Greeter extends UntypedAbstractActor {

    public enum Msg{
        GREET,DONE
    }

    @Override
    public void onReceive(Object message) throws Throwable {
        if(message == Msg.GREET){
            System.out.println("hello world");
            getSender().tell(Msg.DONE,getSelf());
        }else{
            unhandled(message);
        }
    }
}
