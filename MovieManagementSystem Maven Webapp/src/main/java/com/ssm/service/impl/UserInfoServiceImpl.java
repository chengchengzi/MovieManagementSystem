package com.ssm.service.impl;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.ssm.dao.UserInfoDAO;
import com.ssm.pojo.UserInfo;
import com.ssm.service.UserInfoService;
import com.ssm.utils.Page;

/**
 * 员工信息表的服务接口的执行类
 * @author Administrator
 *
 */
@Service("userInfoService")
public class UserInfoServiceImpl implements UserInfoService{
	@Resource
	private UserInfoDAO userInfoDAO;
	
	//登陆验证
	public boolean login(String name, String password) {
		UserInfo userInfo = userInfoDAO.selectByName(name);
		if(userInfo != null){
			if((userInfo.getUser_name().equals(name)) && userInfo.getUser_password().equals(password)){
				return true;
			}
		}
		return false;
	}

	//根据员工姓名进行查询
	public UserInfo selectByName(String name) {
		return this.userInfoDAO.selectByName(name);
	}

	//分页查询员工信息
	public void showUserInfoByPage(HttpServletRequest request, Model model) {
		String pageNow = request.getParameter("pageNow");
		
		Page page = null;
		
		List<UserInfo> listUserInfo = new ArrayList<UserInfo>();
		
		int totalCount = (int)userInfoDAO.getUserInfoCount();
		
		if(pageNow != null){
			page = new Page(totalCount, Integer.parseInt(pageNow));
			listUserInfo = this.userInfoDAO.selectUserInfoByPage(page.getStartPos(), page.getPageSize());
		}else{
			page = new Page(totalCount, 1);
			listUserInfo = this.userInfoDAO.selectUserInfoByPage(page.getStartPos(), page.getPageSize());
		}
		 model.addAttribute("listUserInfo", listUserInfo);  
		 model.addAttribute("page", page);  
	}

	//批量删除
	public void deleteBatchUserInfo(int[] userInfoIds) {
		userInfoDAO.deleteUserInfoByBatch(userInfoIds);
	}

	//单个删除
	public boolean deleteUserInfoById(Integer user_info_id) {
		UserInfo userInfo = userInfoDAO.selectById(user_info_id);
		if(userInfo != null){ //删除的员工信息存在
			boolean flag = userInfoDAO.deleteById(user_info_id);
			if(flag){
				return true;
			}else{
				return false;
			}
		}
		return false;  //删除的影厅不存在，返回false
	}

	/**
	 * 新增员工
	 */
	public int insertUserInfo(HttpServletRequest request, Model model) {
		int user_info_id = Integer.parseInt(request.getParameter("user_info_id"));
		String user_info_name = null;
		String user_info_password = null;
			
		try {
			user_info_name = new String(request.getParameter("user_info_name").getBytes("ISO-8859-1"),"UTF-8");
			user_info_password = new String(request.getParameter("user_info_password").getBytes("ISO-8859-1"),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		 
					
		int user_info_grade = Integer.parseInt(request.getParameter("user_info_grade"));
			
		//验证输入的影厅编号是否已存在
		UserInfo userInfo = userInfoDAO.selectById(user_info_id);
		if(userInfo != null){
			return -1; //新增失败，员工编号重名
			}else{		
				//保存新增的影厅信息
				UserInfo userInfoNew = new UserInfo();
				userInfoNew.setUser_id(user_info_id);
				userInfoNew.setUser_name(user_info_name);
				userInfoNew.setUser_password(user_info_password);
				userInfoNew.setUser_grade(user_info_grade);
	
				boolean flag = userInfoDAO.insertUserInfo(userInfoNew);
				if(flag){
					return 1; //新增成功
				}		
				return -2; //新增失败
			}
		}

	//修改员工信息
	public boolean updateUserInfo(int id, String name, String passsword,int grade) {
			UserInfo userInfo = new UserInfo();
			userInfo.setUser_id(id);
			userInfo.setUser_name(name);
			userInfo.setUser_password(passsword);
			userInfo.setUser_grade(grade);
			
			boolean flag = userInfoDAO.updateUserInfo(userInfo);
			if(flag){
				return true;
			}
			return false;
	}

	//根据员工姓名模糊查询
	public void fuzzySelectUserInfoByName(String name,HttpServletRequest request,Model model) {
		String pageNow = request.getParameter("pageNow");
		
		Page page = null;
		
		List<UserInfo> listUserInfo = new ArrayList<UserInfo>();
		
		int totalCount = (int)userInfoDAO.getUserInfoCountByFuzzy(name);
		
		if(pageNow != null){
			page = new Page(totalCount, Integer.parseInt(pageNow));
			listUserInfo = this.userInfoDAO.fuzzySelectUserInfoByName(name,page.getStartPos(), page.getPageSize());
		}else{
			page = new Page(totalCount, 1);
			listUserInfo = this.userInfoDAO.fuzzySelectUserInfoByName(name,page.getStartPos(), page.getPageSize());
		}
		 model.addAttribute("listUserInfo", listUserInfo);  
		 model.addAttribute("page", page);  
	}

	//根据员工id查询
	public UserInfo selectById(Integer id) {
		return this.userInfoDAO.selectById(id);
	}		
}
