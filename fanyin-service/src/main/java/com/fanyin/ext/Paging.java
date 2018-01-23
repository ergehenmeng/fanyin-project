package com.fanyin.ext;

import com.github.pagehelper.PageInfo;

import java.io.Serializable;
import java.util.List;

/**
 * @description: 分页返回前台的对象
 * @author: 二哥很猛
 * @date: 2018/1/18
 * @time: 15:35
 */
public class Paging<T> implements Serializable{

    private static final long serialVersionUID = 9015209122071749218L;
    /**
     * 总条数
     */
    private long total;

    /**
     * 数据集
     */
    private List<T> rows;

    public Paging(int total,List<T> rows){
        this.total = total;
        this.rows = rows;
    }

    public Paging(PageInfo<T> info){
        this.total = info.getTotal();
        this.rows = info.getList();
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public List<T> getRows() {
        return rows;
    }

    public void setRows(List<T> rows) {
        this.rows = rows;
    }
}
