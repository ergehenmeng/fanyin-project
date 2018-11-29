package com.fanyin.utils;

import com.fanyin.ext.Paging;
import com.fanyin.ext.Transfer;
import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;

import java.util.List;

/**
 * 主要针对移动端或前后端分离 数据格式化
 * @author 二哥很猛
 * @date 2018/11/21 10:10
 */
public class DataUtil {

    /**
     * 分页数据格式转换
     * @param pageInfo pageHelper对象
     * @param transfer 转换对象
     * @return 结果
     */
    public static <S,T> Paging<T> swith(PageInfo<S> pageInfo,Transfer<S,T> transfer){

        Paging<T> paging = new Paging<>();

        List<S> list = pageInfo.getList();

        List<T> formatList = Lists.newArrayList();
        list.forEach(s -> {
            T format = transfer.transfer(s);
            formatList.add(format);
        });

        paging.setRows(formatList);
        paging.setTotal(pageInfo.getTotal());
        paging.setPage(pageInfo.getPageNum());
        paging.setPageSize(pageInfo.getPageSize());

        return paging;
    }

    /**
     * 列表数据转换
     * @param sourceList 原列表数据
     * @param transfer 转换方式
     * @param <S> 原数据类型
     * @param <T> 目标数据类型
     * @return 结果数据列表
     */
    public static <S,T> List<T> swith(List<S> sourceList,Transfer<S,T> transfer){
        List<T> resultList = Lists.newArrayList();
        sourceList.forEach(s -> resultList.add(transfer.transfer(s)));
        return resultList;
    }
}
