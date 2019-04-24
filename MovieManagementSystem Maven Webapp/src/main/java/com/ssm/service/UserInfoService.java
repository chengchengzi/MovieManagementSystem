package com.ssm.service;

import javax.servlet.http.HttpServletRequest;
import org.springframework.ui.Model;
import com.ssm.pojo.UserInfo;

/**
 * 员工信息表的服务接口
 * 
 * @author Administrator
 * 
 */
public interface UserInfoService {
	/**
	 * 新增员工
	 * 
	 * @param user
	 * @return 新增员工成功返回true，新增员工失败返回false
	 */
	public int insertUserInfo(HttpServletRequest request, Model model);

	/**
	 * 根据员工id删除员工
	 * 
	 * @param id
	 * @return 删除成功返回true，删除失败返回false
	 */
	public boolean deleteUserInfoById(Integer user_info_id); // 单个删除影厅

	/**
	 * 登陆验证
	 * 
	 * @param name
	 * @param password
	 * @return 登陆成功返回true，登陆失败返回false
	 */
	public boolean login(String name, String password);

	/**
	 * 根据员工姓名查询员工信息
	 * 
	 * @param name
	 * @return 查询到此员工所有信息，若无返回空
	 */
	public UserInfo selectByName(String name);

	public UserInfo selectById(Integer id); // 根据员工id查询

	public void showUserInfoByPage(HttpServletRequest request, Model model); // 分页查询所有员工列表

	public void deleteBatchUserInfo(int[] userInfoIds); // 批量删除

	public boolean updateUserInfo(int id, String name, String passsword,
			int grade);// 修改员工信息

	public void fuzzySelectUserInfoByName(String name,
			HttpServletRequest request, Model model); // 根据员工姓名模糊查询
}
