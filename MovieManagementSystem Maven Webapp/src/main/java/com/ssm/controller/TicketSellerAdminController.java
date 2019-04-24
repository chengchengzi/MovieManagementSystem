package com.ssm.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssm.pojo.FilmInfo;
import com.ssm.pojo.ShowPlan;
import com.ssm.service.FilmInfoService;
import com.ssm.service.SeatShowPlanService;
import com.ssm.service.ShowPlanService;

/**
 * 售票员页面的控制层
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/TicketSeller")
public class TicketSellerAdminController {
	@Resource
	private FilmInfoService filmInfoService;
	@Resource
	private ShowPlanService showPlanService;
	@Resource
	private SeatShowPlanService seatShowPlanService;
	
	@RequestMapping("/showFilmInfo")
	public String show_film(HttpServletRequest request, Model model){
		List<FilmInfo> listFilmInfo = filmInfoService.queryAllFilmInfo();
		model.addAttribute("listFilmInfo",listFilmInfo);
		return "ticket_seller_main";
	}
	
	//影片场次
		@RequestMapping("/selectShowPlan")
		public String select_show_plan(HttpServletRequest request, Model model){
			String id = request.getParameter("film_id"); //获取传递的电影编号
			Integer film_id = Integer.parseInt(id);
			
			//向前台传递电影信息
			FilmInfo listFilmInfo = filmInfoService.queryFilmInfoById(film_id); //根据id查询并放入model的视图中
			model.addAttribute("listFilmInfo",listFilmInfo);
			
			//设置观影时间
			List<ShowPlan> listShowPlanFilmTime = new ArrayList<ShowPlan>();
			listShowPlanFilmTime = showPlanService.queryShowPlanByFilmId(film_id);
			if(listShowPlanFilmTime.size() != 0 && listShowPlanFilmTime != null){
				for(int i = 0; i < listShowPlanFilmTime.size()-1;i++){  //观影时间去重
					for(int j = listShowPlanFilmTime.size()-1;j>i;j--){
						DateFormat df = DateFormat.getDateInstance();
						Date date1 = listShowPlanFilmTime.get(j).getShow_time();
						String date1New = df.format(date1);
						Date date2 = listShowPlanFilmTime.get(i).getShow_time();
						String date2New = df.format(date2);
						if(date1New.equals(date2New))
							listShowPlanFilmTime.remove(j);
					}
				}
				model.addAttribute("listShowPlanFilmTime",listShowPlanFilmTime);
			}
			
			//取今天的观影时间，根据今天的观影时间显示在场次页面上
			SimpleDateFormat myFmt=new SimpleDateFormat("yyyy-MM-dd");
			
			if(listShowPlanFilmTime.size() != 0 && listShowPlanFilmTime != null){
				Date date = listShowPlanFilmTime.get(0).getShow_time();
				String dateNew = myFmt.format(date);
				List<ShowPlan> listShowPlanInfo = new ArrayList<ShowPlan>();
				listShowPlanInfo = showPlanService.queryShowPlanByShowTime(dateNew, film_id);
				model.addAttribute("listShowPlanInfo",listShowPlanInfo);
			}
			return "ticket_seller_sale_select_show_plan";
		}
		
		//影片场次
		@RequestMapping("/selectShowPlanByA")
		public String select_show_plan_A(HttpServletRequest request, Model model) throws ParseException{
			String id = request.getParameter("film_id"); //获取传递的电影编号
			Integer film_id = Integer.parseInt(id);
			
			//向前台传递电影信息
			FilmInfo listFilmInfo = filmInfoService.queryFilmInfoById(film_id); //根据id查询并放入model的视图中
			model.addAttribute("listFilmInfo",listFilmInfo);
			
			//设置观影时间
			List<ShowPlan> listShowPlanFilmTime = new ArrayList<ShowPlan>();
			listShowPlanFilmTime = showPlanService.queryShowPlanByFilmId(film_id);
			
			for(int i = 0; i < listShowPlanFilmTime.size()-1;i++){  //观影时间去重
				for(int j = listShowPlanFilmTime.size()-1;j>i;j--){
					DateFormat df = DateFormat.getDateInstance();
					Date date1 = listShowPlanFilmTime.get(j).getShow_time();
					String date1New = df.format(date1);
					Date date2 = listShowPlanFilmTime.get(i).getShow_time();
					String date2New = df.format(date2);
					if(date1New.equals(date2New))
						listShowPlanFilmTime.remove(j);
				}
			}
			model.addAttribute("listShowPlanFilmTime",listShowPlanFilmTime);
			
			//取今天的观影时间，根据今天的观影时间显示在场次页面上
			String time = request.getParameter("date");
			Date film_show_time =new SimpleDateFormat("EEE MMM dd HH:mm:ss Z yyyy", Locale.UK).parse(time);
			SimpleDateFormat myFmt=new SimpleDateFormat("yyyy-MM-dd"); //格式化时间
			String dateNew = myFmt.format(film_show_time);
			List<ShowPlan> listShowPlanInfo = new ArrayList<ShowPlan>();
			listShowPlanInfo = showPlanService.queryShowPlanByShowTime(dateNew, film_id); //查询
			model.addAttribute("listShowPlanInfo",listShowPlanInfo); //放入试图显示
			
			return "ticket_seller_sale_select_show_plan";
		}
		
		//选座
		@RequestMapping("/selectSeat")
		public String select_Seat(HttpServletRequest request, Model model){
			//取参
			String id = request.getParameter("film_id"); //获取传递的电影编号
			String id2 = request.getParameter("show_plan_id");//获取传递的放映计划编号
			
			if(id != null){
				Integer film_id = Integer.parseInt(id);
				FilmInfo filmInfo = filmInfoService.queryFilmInfoById(film_id);
				model.addAttribute("filmInfo",filmInfo);
			}
			
			if(id2 != null){
				Integer show_plan_id = Integer.parseInt(id2);
				ShowPlan showPlan = showPlanService.queryShowPlanById(show_plan_id); //查询放映计划信息
				model.addAttribute("showPlan",showPlan);
				
				String[] seatNew = seatShowPlanService.querySeatShowPlanByShowPlanId(show_plan_id); //查询座位场表信息
				String seatInit = seatNew [0];  //最初的座位字符串
				String seatOut = seatNew [1];  //已售出的座位字符串
				model.addAttribute("seatInit",seatInit);
				model.addAttribute("seatOut",seatOut);
				
			}
			return "ticket_seller_sale_select_seat";
		}
		
		//保存选座信息
		@RequestMapping("/saveSeat")
		public String save_seat(HttpServletRequest request, Model model){
			HttpSession session = request.getSession();
			String result = "";
			
			String seat_selected = request.getParameter("seat_selected");   //接收座位信息
			String seat_removeSelected = request.getParameter("seat_removeSelected");
			
			String id = request.getParameter("show_plan_id");//获取传递的放映计划编号
			Integer show_plan_id = Integer.parseInt(id);
			
			boolean flag = seatShowPlanService.saveSeat(seat_selected,seat_removeSelected,show_plan_id); //保存选座信息
			if(flag){  //选座成功，保存电影票信息
				result = "success";
				session.setAttribute("sale_result", result);
				return "ticket_seller_sale_select_seat";
			}
			else{
				result = "fail";
				session.setAttribute("sale_result", result);
				return "ticket_seller_sale_select_seat";
			}
		}
		
		
}
