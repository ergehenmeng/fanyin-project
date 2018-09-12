package com.fanyin.test.chain;

import java.util.LinkedList;
import java.util.List;

/**
 * 责任链模式
 * @author 二哥很猛
 * @date 2018/9/3 10:22
 */
public class ChainHandler {

    private List<Handler> list = new LinkedList<>();

    private int index = 0;

    public void process(){
        if(index < list.size()){
            list.get(index++).doHandler(this);
        }
    }

    public List<Handler> getList() {
        return list;
    }

    public void setList(List<Handler> list) {
        this.list = list;
    }

    public int getIndex() {
        return index;
    }

    public void setIndex(int index) {
        this.index = index;
    }

    public void addHandler(Handler handler){
        list.add(handler);
    }



}
