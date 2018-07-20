package com.fanyin.test.io.netty.protocol;

import org.jboss.marshalling.*;

/**
 * @author 王艳兵
 * @date 2018/7/20 10:29
 */
public class MarshallingCodeCFactory {

    public static Marshaller buildMarshalling()throws Exception{
        MarshallerFactory factory = Marshalling.getProvidedMarshallerFactory("serial");
        MarshallingConfiguration configuration = new MarshallingConfiguration();
        configuration.setVersion(5);
        return factory.createMarshaller(configuration);
    }

    public static Unmarshaller buildUnmarshaller()throws Exception{
        MarshallerFactory factory = Marshalling.getProvidedMarshallerFactory("serial");
        MarshallingConfiguration configuration = new MarshallingConfiguration();
        configuration.setVersion(5);
        return factory.createUnmarshaller(configuration);
    }
}
