package com.fanyin.service.operation.impl;

import com.fanyin.dto.operation.HelpAddRequest;
import com.fanyin.dto.operation.HelpEditRequest;
import com.fanyin.dto.operation.HelpQueryRequest;
import com.fanyin.mapper.operation.HelpInstructionMapper;
import com.fanyin.model.operation.HelpInstruction;
import com.fanyin.service.operation.HelpInstructionService;
import com.fanyin.utils.BeanCopyUtil;
import com.fanyin.utils.DateUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author 二哥很猛
 * @date 2018/11/20 20:20
 */
@Service("helpInstructionService")
@Transactional(rollbackFor = RuntimeException.class)
public class HelpInstructionServiceImpl implements HelpInstructionService {

    @Autowired
    private HelpInstructionMapper helpInstructionMapper;


    @Override
    public void addHelpInstruction(HelpAddRequest request) {
        HelpInstruction instruction = BeanCopyUtil.copy(request, HelpInstruction.class);
        instruction.setAddTime(DateUtil.getNow());
        //默认正常
        instruction.setDeleted(false);
        helpInstructionMapper.insertSelective(instruction);
    }

    @Override
    public void updateHelpInstruction(HelpEditRequest request) {
        HelpInstruction instruction = BeanCopyUtil.copy(request, HelpInstruction.class);
        instruction.setUpdateTime(DateUtil.getNow());
        helpInstructionMapper.updateByPrimaryKeySelective(instruction);
    }

    @Override
    public void deleteHelpInstruction(HelpEditRequest request) {
        HelpInstruction instruction = new HelpInstruction();
        instruction.setId(request.getId());
        instruction.setDeleted(true);
        instruction.setUpdateTime(DateUtil.getNow());
        helpInstructionMapper.updateByPrimaryKeySelective(instruction);
    }

    @Override
    public PageInfo<HelpInstruction> getByPage(HelpQueryRequest request) {
        PageHelper.startPage(request.getPage(),request.getRows());
        List<HelpInstruction> list = helpInstructionMapper.getList(request);
        return new PageInfo<>(list);
    }
}
