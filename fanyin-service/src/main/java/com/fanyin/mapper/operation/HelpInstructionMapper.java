package com.fanyin.mapper.operation;

import com.fanyin.dto.operation.HelpQueryRequest;
import com.fanyin.model.operation.HelpInstruction;

import java.util.List;

/**
 * @author 二哥很猛
 */
public interface HelpInstructionMapper {


    /**
     * 插入不为空的记录
     *
     * @param record
     */
    int insertSelective(HelpInstruction record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id
     */
    HelpInstruction selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record
     */
    int updateByPrimaryKeySelective(HelpInstruction record);

    /**
     * 根据条件查询帮助说明
     * @param request 查询条件
     * @return 列表
     */
    List<HelpInstruction> getList(HelpQueryRequest request);
}