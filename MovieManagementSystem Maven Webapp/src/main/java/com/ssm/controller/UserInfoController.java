package com.ssm.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssm.pojo.UserInfo;
import com.ssm.service.UserInfoService;

/**
 * 员工信息的控制类
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/UserInfo")
public class UserInfoController {
	@Resource
	private UserInfoService userInfoService;
	
	//跳转到员工管理页面,一跳转这个页面就做查询，列表出所有的员工信息
	@RequestMapping("/showUserInfo")
	public String show_film_hall(HttpServletRequest request,Model model)throws Exception{	
		//分页查询
		this.userInfoService.showUserInfoByPage(request, model);
		return "user_info";
	}
	
	//单个删除
	@RequestMapping("/delUserInfo")
	public String deleteFilmHallById(HttpServletRequest request) {
		String user_info_id = request.getParameter("content_user_info_id"); //从ajax取得传回的id
		Integer id = Integer.parseInt(user_info_id);
		boolean flag = userInfoService.deleteUserInfoById(id);
		if(flag){
			return "user_info";
		}
		return "error";
	}
	
	//批量删除
	@RequestMapping("/delBatchUserInfo")
	public String deleteUserInfoByBatch(HttpServletRequest request) {
		String user_info_del_ids = request.getParameter("user_info_del_ids"); //接受前台ajax传回的要批量删除ids
		String[] ids = user_info_del_ids.split(","); //，分开成String数组
		int[] del_ids = new int[ids.length];	
		for(int i = 0; i < ids.length;i++){			//将String数组转换成int数组
			del_ids[i] = Integer.parseInt(ids[i]);
		}
		userInfoService.deleteBatchUserInfo(del_ids);
		return "user_info";
	}
		
	//跳转到新增员工页面
	@RequestMapping("/JumpAddUserInfo")
	public String add_user_info_jump(HttpServletRequest request,Model model)throws Exception{
		HttpSession session = request.getSession();
		String name = (String)session.getAttribute("name");
		request.setAttribute("name", name);
		return "user_info_add";
	}
	
	//新增员工
		@RequestMapping("/addUserInfo")
		public String add_user_info(HttpServletRequest request,Model model)throws Exception{
			HttpSession session = request.getSession();
			String data = "";
			int flag = userInfoService.insertUserInfo(request, model);			
			if(flag == 1){
				data = "success";
				session.setAttribute("data", data);
				return "user_info_add";
			}else if(flag == -1){
				data = "repeat";
				session.setAttribute("data", data);
				return "user_info_add";
			}
			else if(flag == -2){
				data = "fail";
				session.setAttribute("data", data);
				return "user_info_add";
			}
			return "error";
		}
		
		//跳转到修改员工信息
		@RequestMapping("/JumpEditUserInfo")
		public String edit_film_hall_jump(HttpServletRequest request,Model model)throws Exception{
			HttpSession session = request.getSession();
			String name = (String)session.getAttribute("name");
			request.setAttribute("name", name);
			return "user_info_edit";
		}
		
		//修改员工信息
		@RequestMapping("/editUserInfo")
		public String edit_user_info(HttpServletRequest request){
			String user_info_id = request.getParameter("user_info_id");
			String user_info_name = "";
			String user_info_password = "";
			try{
				user_info_name = new String(request.getParameter("user_info_name").getBytes("ISO-8859-1"),"UTF-8");
				user_info_password = new String(request.getParameter("user_info_password").getBytes("ISO-8859-1"),"UTF-8");
			}catch (Exception e) {
				e.printStackTrace();
			}
			String user_info_grade = request.getParameter("user_info_grade");
				
			Integer user_edit_id = Integer.parseInt(user_info_id);
			Integer user_edit_grade = Integer.parseInt(user_info_grade);
			
			HttpSession session = request.getSession();
			String data = "";
									
			boolean flag = userInfoService.updateUserInfo(user_edit_id, user_info_name, user_info_password, user_edit_grade);
			if(flag){
				data = "update_success";
				session.setAttribute("data", data);
				return "user_info_edit";
				}
				return "error";
			}
		
		//根据员工姓名模糊查询并展示
		@RequestMapping("/searchUserInfo")
		public String search_user_info(HttpServletRequest request, Model model)throws Exception{
			HttpSession session = request.getSession();
			String param = (String)session.getAttribute("param");
			String condition = (String)session.getAttribute("condition");
			//先判断session中的condition是否为空
			if(condition == null){
				condition = new String();
				session.setAttribute("condition", condition);
				//如果session中的condition为空，再判断传入的参数是否为空，如果为空就跳转到user_info页面
				if(param == null || "".equals(param)){
					return "user_info_search";
				}
			}
			//如果session不为空，且传入的搜索参数param不为空，将param赋值给condition
			if(param != null && !("".equals(param))){
				condition = new String(param.getBytes("ISO-8859-1"),"UTF-8");
				session.setAttribute("condition", condition);
			}
			
			//传值查询
			this.userInfoService.fuzzySelectUserInfoByName(condition, request, model);
//			session.removeAttribute(condition);
//			session.removeAttribute(param);
			return "user_info_search";
		}
		
		
		//跳转到售票员修改密码
		@RequestMapping("/JumpTicketSellerEditPassword")
		public String jump_ticket_seller_edit_password(){
			return "ticket_seller_worker_info";
		}
		
		//售票员修改密码
		@RequestMapping("/TicketSellerEditPassword")
		public String ticket_seller_edit_password(HttpServletRequest request){
			HttpSession session = request.getSession();
			String result = "";
			
			String temp_user_id = request.getParameter("user_id");
			Integer user_id = Integer.parseInt(temp_user_id);
			String user_password = request.getParameter("user_password");
			String user_edit_password = request.getParameter("user_edit_password");
			UserInfo userInfo = userInfoService.selectById(user_id);
			String old_user_password = userInfo.getUser_password();
			if(old_user_password.equals(user_password)){
				boolean flag = userInfoService.updateUserInfo(user_id, userInfo.getUser_name(), user_edit_password, userInfo.getUser_grade());
				if(flag){
					result = "success";
					session.setAttribute("result", result);
					return "ticket_seller_worker_info";
				}
				else{
					return "error";
				}
			}else{
				result = "notSame";
				session.setAttribute("result", result);
				return "ticket_seller_worker_info";
			}
			
		}
}
