package com.fanyin.mapper.operation;

import com.fanyin.enums.OrderType;
import com.fanyin.model.operation.VipConfig;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author 二哥很猛
 */
public interface VipConfigMapper {

    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(VipConfig record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    VipConfig selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(VipConfig record);

    /**
     * 根据等级获取配置信息,不过滤状态
     * @param level 等级
     * @return 配置信息
     */
    VipConfig getByLevel(@Param("level") byte level);

    /**
     * 获取所有vip配置信息,过滤掉关闭的配置
     * @param orderType 排序规则
     * @return 列表
     */
    List<VipConfig> getConfigs(@Param("orderType")OrderType orderType);
}