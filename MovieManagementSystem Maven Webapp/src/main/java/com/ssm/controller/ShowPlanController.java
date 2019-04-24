package com.ssm.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import com.ssm.pojo.FilmHallInfo;
import com.ssm.pojo.FilmInfo;
import com.ssm.pojo.ShowPlan;
import com.ssm.service.FilmHallInfoService;
import com.ssm.service.FilmInfoService;
import com.ssm.service.ShowPlanService;

/**
 * 放映安排的控制层
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/ShowPlan")
public class ShowPlanController {
	@Resource
	private ShowPlanService showPlanService;
	@Resource
	private FilmHallInfoService filmHallInfoService;
	@Resource
	private FilmInfoService filmInfoService;
	
	//分页查询
	@RequestMapping("/showShowPlan")
	public String show_show_plan(HttpServletRequest request,Model model)throws Exception{
		//设置用户名的显示
		HttpSession session = request.getSession();	
		String name = (String)session.getAttribute("name");
		request.setAttribute("name", name);
		//分页查询
		this.showPlanService.showShowPlanByPage(request, model);
		return "show_plan";
	}
	
	//单个删除
	@RequestMapping("/delShowPlan")
	public String deleteShowPlanById(HttpServletRequest request) {
		String show_plan_id = request.getParameter("show_plan_id"); //从ajax取得传回的id
		Integer id = Integer.parseInt(show_plan_id);
		boolean flag = showPlanService.deleteShowPlan(id);
		if(flag){
			return "show_plan";
		}
		return "error";
	}
	
	//批量删除
	@RequestMapping("/delBatchShowPlan")
	public String deleteShowPlanByBatch(HttpServletRequest request) {
		String show_plan_del_ids = request.getParameter("show_plan_del_ids"); //接受前台ajax传回的要批量删除ids
		String[] ids = show_plan_del_ids.split(","); //，分开成String数组
		int[] del_ids = new int[ids.length];	
		for(int i = 0; i < ids.length;i++){			//将String数组转换成int数组
			del_ids[i] = Integer.parseInt(ids[i]);
		}	
		showPlanService.deleteBatchShowPlan(del_ids);
		return "show_plan";
	}
	
	//跳转到新增放映计划页面
	@RequestMapping("/JumpAddShowPlan")
	public String add_film_hall_jump(HttpServletRequest request,Model model)throws Exception{
		HttpSession session = request.getSession();
		String name = (String)session.getAttribute("name");
		request.setAttribute("name", name);
		
		//添加影片编号，影片名称数据,影厅编号数据
		List<FilmInfo> listFilmInfo = filmInfoService.queryAllFilmInfo();
		List<FilmHallInfo> listFilmHallInfo = filmHallInfoService.queryAllFilmHall();
		model.addAttribute("listFilmInfo",listFilmInfo);
		model.addAttribute("listFilmHallInfo",listFilmHallInfo);
		
		return "show_plan_add";
	}
	

	//新增放映计划
	@RequestMapping("/addShowPlan")
	public String add_film_hall(HttpServletRequest request,Model model)throws Exception{
			int show_plan_id = Integer.parseInt(request.getParameter("show_plan_id"));
			int film_id = Integer.parseInt(request.getParameter("film_id"));
			int film_hall_id = Integer.parseInt(request.getParameter("film_hall_id"));
			String time = request.getParameter("film_show_time");
			Date film_show_time = null;
			film_show_time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(time);
			
			String price = new String(request.getParameter("film_price").getBytes("ISO-8859-1"),"UTF-8");
			float film_price = Float.parseFloat(price); 
				
			ShowPlan showPlanNew = new ShowPlan();
			showPlanNew.setShow_plan_id(show_plan_id);
			showPlanNew.setFilm_id(film_id);
			showPlanNew.setFilm_hall_id(film_hall_id);
			showPlanNew.setShow_time(film_show_time);
			showPlanNew.setFilm_price(film_price);
			showPlanService.addShowPlan(request, showPlanNew);
		    return "show_plan_add";
		    
	}

	//跳转到修改放映计划页面
	@RequestMapping("/JumpEditShowPlan")
	public String edit_film_hall_jump(HttpServletRequest request,Model model)throws Exception{
		//设置用户名
		HttpSession session = request.getSession();
		String name = (String)session.getAttribute("name");
		request.setAttribute("name", name);	
		
		//添加影片编号，影片名称数据,影厅编号数据
		List<FilmInfo> listFilmInfo = filmInfoService.queryAllFilmInfo();
		List<FilmHallInfo> listFilmHallInfo = filmHallInfoService.queryAllFilmHall();
		model.addAttribute("listFilmInfo",listFilmInfo);
		model.addAttribute("listFilmHallInfo",listFilmHallInfo);
		return "show_plan_edit";
	}
	
	//修改放映计划
	@RequestMapping("/editShowPlan")
	public String edit_show_plan(HttpServletRequest request)throws Exception{
		
		int show_plan_id = Integer.parseInt(request.getParameter("show_plan_id"));
		int film_id = Integer.parseInt(request.getParameter("film_id"));
		int film_hall_id = Integer.parseInt(request.getParameter("film_hall_id"));
		String time = request.getParameter("film_show_time");
		Date film_show_time = null;
		film_show_time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(time);
				
		String price = new String(request.getParameter("film_price").getBytes("ISO-8859-1"),"UTF-8");
		float film_price = Float.parseFloat(price);
		
		ShowPlan showPlanNew = new ShowPlan();
		showPlanNew.setShow_plan_id(show_plan_id);
		showPlanNew.setFilm_id(film_id);
		showPlanNew.setFilm_hall_id(film_hall_id);
		showPlanNew.setShow_time(film_show_time);
		showPlanNew.setFilm_price(film_price);
		showPlanService.editShowPlan(request, showPlanNew);
	    return "show_plan_edit";
		}
	
	//根据输入的影片id查询并展示
	@RequestMapping("/searchShowPlan")
	public String search_show_plan(HttpServletRequest request, Model model)throws Exception{
		HttpSession session = request.getSession();
		String param = (String)session.getAttribute("param");
		String condition = (String)session.getAttribute("condition");
		Integer film_id = null;
		//先判断session中的condition是否为空
		if(condition == null){
			condition = new String();
			session.setAttribute("condition", condition);
			//如果session中的condition为空，再判断传入的参数是否为空，如果为空就跳转到user_info页面
			if(param == null || "".equals(param)){
				return "show_plan_search";
			}
		}
		//如果session不为空，且传入的搜索参数param不为空，将param赋值给condition
		if(param != null && !("".equals(param))){
			film_id = Integer.parseInt(param);
			condition = param;
			session.setAttribute("condition", condition);
		}
			
		this.showPlanService.queryShowPlanByIdPage(film_id, request, model);
		return "show_plan_search";
	}
}
