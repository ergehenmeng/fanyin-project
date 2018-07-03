package com.fanyin.test.akka;

import akka.actor.ActorRef;
import akka.actor.ActorSystem;
import akka.actor.Props;
import com.typesafe.config.ConfigFactory;

/**
 * @author 王艳兵
 * @date 2018/6/27 17:40
 */
public class Main {

    public static void main(String[] args) {
        ActorSystem actorSystem = ActorSystem.create("Hello", ConfigFactory.load("simple.conf"));
        ActorRef a = actorSystem.actorOf(Props.create(HelloWorld.class),"helloworld");
        System.out.println("actor path: " + a.path());
    }
}
