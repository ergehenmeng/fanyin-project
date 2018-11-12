package com.fanyin.service.project;

import com.fanyin.model.project.Project;

/**
 * @author 二哥很猛
 * @date 2018/11/12 11:20
 */
public interface ProjectService {

    /**
     * 根据编号查询产品信息,不过滤任何状态
     * @param nid 产品编号
     * @return 产品信息
     */
    Project getByNid(String nid);

    /**
     * 根据id查询产品编号
     * @param id 产品id
     * @return 产品信息
     */
    Project getById(int id);

    /**
     * 产品满标审核<br>
     * 1.产品信息校验<br>
     * 2.生成回款信息<br>
     * 3.生成还款信息<br>
     * 4.用户资金解冻
     * @param id 产品id
     */
    void fullAudit(int id);

    /**
     * 生成产品编号 yyyyMMdd + 0 + 027 每日最大发布产品最大为900个
     * @return 产品编号
     */
    String createNid();

}

