package com.fanyin.dto.tender;

import com.fanyin.dto.task.Key;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

/**
 * @author 二哥很猛
 * @date 2018/11/21 14:11
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Tender extends Key implements Serializable {
    
    private static final long serialVersionUID = -2909565449620879009L;
    
    /**
     * 用户id
     */
    private Integer userId;
    
    /**
     * 产品id
     */
    private Integer projectId;
    
    /**
     * 优惠券id
     */
    private Integer couponId;

    /**
     * 投标金额
     */
    private Double amount;


}
