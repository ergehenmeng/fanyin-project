package com.fanyin.mapper.user;

import com.fanyin.model.user.UserExtend;
import org.apache.ibatis.annotations.Param;

/**
 * @author 二哥很猛
 */
public interface UserExtendMapper {
    /**
     * 根据主键删除数据库的记录
     *
     * @param id 主键
     * @return 影响条数
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * 插入数据库记录
     *
     * @param record 待插入数据
     * @return 影响条数
     */
    int insert(UserExtend record);

    /**
     * 插入不为空的记录
     *
     * @param record 待插入数据
     * @return 影响条数
     */
    int insertSelective(UserExtend record);

    /**
     * 根据主键获取一条数据库记录
     *
     * @param id 主键
     * @return 查询结果
     */
    UserExtend selectByPrimaryKey(Integer id);

    /**
     * 根据主键来更新部分数据库记录
     *
     * @param record 待更新数据
     * @return 影响条数
     */
    int updateByPrimaryKeySelective(UserExtend record);

    /**
     * 根据主键来更新数据库记录
     *
     * @param record 待更新数据
     * @return 影响条数
     */
    int updateByPrimaryKey(UserExtend record);

    /**
     * 更新用户可用积分
     * @param userId 用户id
     * @param score 积分
     * @return 影响条数
     */
    int updateScore(@Param("userId") int userId, @Param("score") int score);

    /**
     * 更新用户vip等级
     * @param userId 用户id
     * @param grade 新等级
     * @return 影响条数
     */
    int updateGrade(@Param("userId")int userId,@Param("grade")byte grade);

    /**
     * 根据userId查询用户附件信息
     * @param userId 用户id
     * @return 附件信息
     */
    UserExtend getByUserId(@Param("userId")int userId);
}