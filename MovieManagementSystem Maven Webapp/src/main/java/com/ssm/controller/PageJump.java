package com.ssm.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;



/**
 * 实现Jsp的页面跳转
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/pageJump")
public class PageJump {
	
	
	//跳转到管理员_影城主页页面
	@RequestMapping("/showAdminAdmin")
	public String admin_main_jump(HttpServletRequest request,Model model)throws Exception{
		HttpSession session = request.getSession();
		String name = (String)session.getAttribute("name");
		request.setAttribute("name", name);
		return "admin_main";
	}
	
	
	//跳转到管理员_影片管理页面
	@RequestMapping("/showFilmInfo")
	public String film_info_jump(HttpServletRequest request,Model model)throws Exception{
		HttpSession session = request.getSession();
		String name = (String)session.getAttribute("name");
		request.setAttribute("name", name);	
		return "film_info";
	}
	
	//跳转到票务管理页面
	@RequestMapping("/showTicketSale")
	public String ticket_sale_jump(HttpServletRequest request,Model model)throws Exception{
		HttpSession session = request.getSession();
		String name = (String)session.getAttribute("name");
		request.setAttribute("name", name);
		return "ticket_sale";
	}
	
	//跳转到报表管理页面
	@RequestMapping("/showFilmStatistic")
	public String ticket_statistic_jump(HttpServletRequest request,Model model)throws Exception{
		HttpSession session = request.getSession();
		String name = (String)session.getAttribute("name");
		request.setAttribute("name", name);
		return "film_statistic";
	}
	
	//跳转到人员管理页面
	@RequestMapping("/showUserInfo")
	public String user_info_jump(HttpServletRequest request,Model model)throws Exception{
		HttpSession session = request.getSession();
		String name = (String)session.getAttribute("name");
		request.setAttribute("name", name);
		return "user_info";
	}
	
	//跳转到售票员_影城主页面
	@RequestMapping("/showSaleMain")
	public String sale_main_jump(HttpServletRequest request,Model model)throws Exception{
		HttpSession session = request.getSession();
		String name = (String)session.getAttribute("name");
		request.setAttribute("name", name);
		return "sale_main";
	}
	
	//跳转到售票员_票务页面
		@RequestMapping("/showSaleTicketSale")
		public String sale_ticket_sale_jump(HttpServletRequest request,Model model)throws Exception{
			HttpSession session = request.getSession();
			String name = (String)session.getAttribute("name");
			request.setAttribute("name", name);
			return "sale_ticket_sale";
		}
		
	//跳转到管理员_影片信息管理页面
	@RequestMapping("/showFilmInfoManagement")
	public String admin_film_info_management_jump(HttpServletRequest request,Model model)throws Exception{
		HttpSession session = request.getSession();
		String name = (String)session.getAttribute("name");
		request.setAttribute("name", name);
		return "film_info_management";
	}
}