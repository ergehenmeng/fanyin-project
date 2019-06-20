package com.fanyin.test;

import lombok.Builder;
import lombok.Data;

/**
 * @author 王艳兵
 * @date 2019/6/13 17:21
 */
@Data
@Builder
public class Load {

    private int current;

    private int weight;

    private String name;
}
