package com.fanyin.service.project.impl;

import com.fanyin.mapper.project.ProjectMapper;
import com.fanyin.model.project.Project;
import com.fanyin.service.project.ProjectService;
import com.fanyin.utils.DateUtil;
import com.fanyin.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 产品service
 * @author 二哥很猛
 * @date 2018/11/12 11:20
 */
@Service("projectService")
public class ProjectServiceImpl implements ProjectService {

    @Autowired
    private ProjectMapper projectMapper;

    /**
     * 起始编号
     */
    private int startPoint = 1;



    @Override
    public Project getByNid(String nid) {
        return projectMapper.getByNid(nid);
    }

    @Override
    public Project getById(int id) {
        return projectMapper.selectByPrimaryKey(id);
    }

    @Override
    public void fullAudit(int id) {

    }

    @Override
    public synchronized String createNid() {
        String yyyyMMdd = DateUtil.format(DateUtil.getNow(), "yyyyMMdd0");
        if(startPoint == 1){
            //服务器重启或者第一个标的
            String maxNid = projectMapper.getNewestProject();
            if(maxNid == null || !maxNid.startsWith(yyyyMMdd)){
                startPoint = Integer.parseInt(StringUtil.randomNumber(3));
                return yyyyMMdd + startPoint;
            }
            startPoint = Integer.parseInt(maxNid.substring(maxNid.length() - 4));
        }
        startPoint++ ;
        return yyyyMMdd + String.format("%04d",startPoint);
    }
}
