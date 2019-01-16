package com.fanyin.service.business;

import com.fanyin.enums.Integral;
import com.fanyin.model.business.IntegralType;

/**
 * @author 二哥很猛
 * @date 2018/10/11 11:18
 */
public interface IntegralTypeService {

    /**
     * 根据nid获取积分类型信息
     * @param integral 积分类型nid枚举
     * @return 积分类型信息
     */
    IntegralType getByNid(Integral integral);

}

