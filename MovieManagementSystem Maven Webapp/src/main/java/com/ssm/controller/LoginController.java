package com.ssm.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssm.pojo.FilmInfo;
import com.ssm.pojo.UserInfo;
import com.ssm.service.FilmInfoService;
import com.ssm.service.UserInfoService;

/**
 * 员工信息表的控制层
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/Login")
public class LoginController {
	@Resource
	private UserInfoService userInfoService;
	@Resource
	private FilmInfoService filmInfoService;
	
	@RequestMapping("/showLogin")
	public String login(HttpServletRequest request,Model model)throws Exception{
		//获取name和password，解决jsp页面之间中文传值乱码问题
		request.setCharacterEncoding("UTF-8");
		String user_name = request.getParameter("name");
		String user_password = request.getParameter("password");
		boolean loginType = userInfoService.login(user_name, user_password);
		if(loginType) //如果通过验证
		{
			UserInfo userInfo = userInfoService.selectByName(user_name);
			String name = userInfo.getUser_name();
			Integer uid = userInfo.getUser_id();
			//session存放用户名
			HttpSession session = request.getSession();
			session.setAttribute("name",name); //用户姓名存到session
			session.setAttribute("uid",uid); //用户姓名存到session
			
			if(userInfo.getUser_grade()==1)
			{
				List<FilmInfo> listFilmInfo = filmInfoService.queryAllFilmInfo();
				model.addAttribute("listFilmInfo",listFilmInfo);
				return "admin_main";
			}else{
				List<FilmInfo> listFilmInfo = filmInfoService.queryAllFilmInfo();
				model.addAttribute("listFilmInfo",listFilmInfo);
				return "ticket_seller_main";
			}
				
			
		}
		else{
			request.setAttribute("failure_message", "账号或密码错误");
			return "login";
		}
	}
	
	
	
	
}
