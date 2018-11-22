package com.fanyin.mapper.recharge;

import com.fanyin.dto.recharge.RechargeLogRequest;
import com.fanyin.model.recharge.RechargeLog;

import java.util.List;

/**
 * @author 二哥很猛
 */
public interface RechargeLogMapper {
    /**
     * 根据主键删除数据库的记录
     *
     * @param id
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * 插入数据库记录
     *
     * @param record
     */
    int insert(RechargeLog record);

    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(RechargeLog record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    RechargeLog selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(RechargeLog record);

    /**
     * 根据主键来更新数据库记录
     *
     * @param record
     */
    int updateByPrimaryKey(RechargeLog record);

    /**
     * 根据订单号查询充值记录
     * @param orderNo 订单号
     * @return 充值记录
     */
    RechargeLog getByOrderNo(String orderNo);

    /**
     * 根据条件查询充值记录
     * @param request 查询条件
     * @return 列表
     */
    List<RechargeLog> getList(RechargeLogRequest request);
}