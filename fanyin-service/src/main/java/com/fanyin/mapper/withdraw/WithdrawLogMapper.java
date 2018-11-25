package com.fanyin.mapper.withdraw;

import com.fanyin.model.withdraw.WithdrawLog;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author 二哥很猛
 */
public interface WithdrawLogMapper {
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
    int insert(WithdrawLog record);

    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(WithdrawLog record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    WithdrawLog selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(WithdrawLog record);

    /**
     * 根据主键来更新数据库记录
     *
     * @param record
     */
    int updateByPrimaryKey(WithdrawLog record);

    /**
     * 统计投资人 指定时间内已经免费提现的次数
     * 注意借款人会过滤掉
     * @param userId 用户id
     * @param startTime 开始时间
     * @param endTime 结束时间
     * @return 次数
     */
    int countFreeWithdraw(@Param("userId") int userId,
                          @Param("starTime")Date startTime,
                          @Param("endTime")Date endTime);

    /**
     * 投资人用户总提现金额,申请中+提现成功
     * @param userId 用户id
     * @return 提现总额 元
     */
    BigDecimal getTotalWithdraw(@Param("userId") int userId);
}