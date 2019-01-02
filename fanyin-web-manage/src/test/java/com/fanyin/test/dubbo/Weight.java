package com.fanyin.test.dubbo;

/**
 * @author 二哥很猛
 * @date 2018/12/29 11:37
 */
public class Weight {

    private String name;

    private long weight;

    private long current = 0;

    private long add;

    public Weight(String name, long weight) {
        this.name = name;
        this.weight = weight;
    }

    public Weight() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public long getWeight() {
        return weight;
    }

    public void setWeight(long weight) {
        this.weight = weight;
    }

    public long getCurrent() {
        return current;
    }

    public void setCurrent(long current) {
        this.current = current;
    }
}
