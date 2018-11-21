package com.fanyin.service.system;

import com.fanyin.dto.tender.TenderResponse;

/**
 * @author 二哥很猛
 * @date 2018/11/21 16:19
 */
public interface RedisCacheService {

    /**
     * 缓存投标异步结果
     * @param response 对象
     */
    void cacheTenderResponse(TenderResponse response);
}

