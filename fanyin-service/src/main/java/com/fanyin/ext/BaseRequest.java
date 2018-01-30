package com.fanyin.ext;

import java.io.Serializable;

/**
 * 基础类请求参数 如需分页操作需要继承该方法
 * @author 二哥很猛
 * @date 2018/1/12 17:29
 */
public class BaseRequest implements Serializable{

    private static final long serialVersionUID = 9015209122071749218L;

    /**
     * 第几页
     */
    private int page = 1;

    /**
     * 页容量
     */
    private int rows = 20;

    /**
     * 基础查询字段
     */
    private String queryName;

    public String getQueryName() {
        return queryName;
    }

    public void setQueryName(String queryName) {
        this.queryName = queryName;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getRows() {
        return rows;
    }

    public void setRows(int rows) {
        this.rows = rows;
    }
}
