package com.fanyin.service.system.impl;

import com.fanyin.mapper.system.SystemMenuMapper;
import com.fanyin.model.system.SystemMenu;
import com.fanyin.service.system.SystemMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

/**
 * @author 王艳兵
 * @date 2018/1/26 16:15
 */
@Service
public class SystemMenuServiceImpl implements SystemMenuService {

    @Autowired
    private SystemMenuMapper systemMenuMapper;

    private static final Comparator<SystemMenu> COMPARATOR = Comparator.comparing(SystemMenu::getSort);

    @Override
    public List<SystemMenu> getUserMenuList(Integer userId) {
        List<SystemMenu> list = systemMenuMapper.getUserMenuList(userId,false);
        List<SystemMenu> parentList = new ArrayList<>();

        for (SystemMenu parent : list) {
            if (parent.getPid() == 0) {
                setChild(parent,list);
                parentList.add(parent);
            }
        }
        parentList.sort(COMPARATOR);
        return parentList;
    }

    @Override
    public SystemMenu getMenuById(Integer id) {
        return systemMenuMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<SystemMenu> getAllList() {
        return systemMenuMapper.getAllList();
    }


    /**
     * 设置子菜单列表
     * @param parent 当前菜单
     * @param list 所有用户可操作的菜单
     */
    private void setChild(SystemMenu parent,List<SystemMenu> list){
        List<SystemMenu> childList = getChild(parent.getId(),list);
        if(!childList.isEmpty()){
            for(SystemMenu child : childList){
                setChild(child,list);
            }
            childList.sort(COMPARATOR);
            parent.setSubList(childList);
        }
    }

    /**
     * 根据ID查看是否存在子元素
     * @param id 相当于子元素的pid
     * @param list 所有菜单列表
     * @return 子菜单列表
     */
    private List<SystemMenu> getChild(int id,List<SystemMenu> list){
        List<SystemMenu> childList = new ArrayList<>();
        for(SystemMenu menu : list){
            if(menu.getPid() == id){
                childList.add(menu);
            }
        }
        return childList;
    }
}
