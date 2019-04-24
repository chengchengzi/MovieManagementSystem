package com.ssm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ssm.pojo.UserInfo;

/**
 * 员工信息表的对外接口
 * 
 * @author Administrator
 * 
 */
public interface UserInfoDAO {
	/**
	 * 新增员工
	 * 
	 * @param user
	 * @return 新增员工成功返回true，新增员工失败返回false
	 */
	public boolean insertUserInfo(UserInfo user);
	
	/**
	 * 根据员工id删除员工
	 * 
	 * @param id
	 * @return 删除成功返回true，删除失败返回false
	 */
	public boolean deleteById(Integer id);

	/**
	 * 修改员工信息
	 * 
	 * @param user
	 * @return 修改成功返回true，修改失败返回false
	 */
	public boolean updateUserInfo(UserInfo user);
	
	/**
	 * 根据员工姓名查询员工信息
	 * 
	 * @param name
	 * @return 查询到此员工所有信息，若无返回空
	 */
	public UserInfo selectByName(String name);
	
	/**
	 * 根据员工id查询员工信息
	 * 
	 * @param name
	 * @return 查询到此员工所有信息，若无返回空
	 */
	public UserInfo selectById(Integer Id);
	
	/**
	 * 使用注解方式传入多个参数,分页查询员工信息
	 * @return
	 */
	public List<UserInfo> selectUserInfoByPage(@Param(value="startPos")Integer startPos, @Param(value="pageSize")Integer pageSize);
	
	public long getUserInfoCount(); //取得员工信息表总记录数
	
	public void deleteUserInfoByBatch(int[] filmHallIds); //批量删除
	
	public List<UserInfo> fuzzySelectUserInfoByName(@Param(value="user_name")String name,@Param(value="startPos")Integer startPos, @Param(value="pageSize")Integer pageSize); //根据员工姓名模糊查询

	public long getUserInfoCountByFuzzy(String name); //取得模糊查询时的总记录数
}
