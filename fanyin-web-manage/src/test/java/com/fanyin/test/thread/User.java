package com.fanyin.test.thread;

import java.io.Serializable;

/**
 * @author 二哥很猛
 * @date 2018/10/8 18:03
 */
public class User implements Serializable {

    private static final long serialVersionUID = -2151604635660783654L;

    private int id;

    public User(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
