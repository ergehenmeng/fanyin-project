package com.fanyin.test.akka;

import akka.actor.ActorRef;
import akka.actor.Props;
import akka.actor.UntypedAbstractActor;


/**
 * @author 二哥很猛
 * @date 2018/6/27 17:19
 */
public class HelloWorld extends UntypedAbstractActor {

    private ActorRef greeter;

    @Override
    public void preStart() throws Exception {
        greeter = getContext().actorOf(Props.create(Greeter.class),"greeter");
        greeter.tell(Greeter.Msg.GREET,getSelf());
    }

    @Override
    public void onReceive(Object message) throws Throwable {
        if(message == Greeter.Msg.DONE){
            greeter.tell(Greeter.Msg.GREET,getSelf());
            getContext().stop(getSelf());
        }else{
            unhandled(message);
        }
    }
}
