package com.ssm.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssm.pojo.TicketOffice;
import com.ssm.service.TicketOfficeService;

/**
 * 票房统计的控制层
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/TicketOffice")
public class TicketOfficeController {
	
	@Resource
	private TicketOfficeService ticketOfficeService;
	
	//跳转到设置影厅页面,一跳转这个页面就做查询，列表出所有的统计信息
	@RequestMapping("/showTicketOffice")
	public String show_film_hall(HttpServletRequest request,Model model)throws Exception{
		//设置用户名的显示
		HttpSession session = request.getSession();	
		String name = (String)session.getAttribute("name");
		request.setAttribute("name", name);
				
		//分页查询
		this.ticketOfficeService.showTicketOfficeByPage(request, model);
		return "film_statistic";
	}
	
	//单个删除
	@RequestMapping("/delTicketOffice")
	public String deleteTicketOfficeById(HttpServletRequest request) {
		String id = request.getParameter("ticket_office_id"); //从ajax取得传回的id
		Integer ticket_office_id = Integer.parseInt(id);
		boolean flag = ticketOfficeService.deleteTicketOffice(ticket_office_id);
		if(flag){
			return "film_statistic";
		}
		return "error";
	}
	
	//批量删除
	@RequestMapping("delBatchTicketOffice")
	public String deleteTicketOfficeByBatch(HttpServletRequest request) {
		String ticket_office_del_ids = request.getParameter("ticket_office_del_ids"); //接受前台ajax传回的要批量删除ids
		String[] ids = ticket_office_del_ids.split(","); //，分开成String数组
		int[] del_ids = new int[ids.length];	
		for(int i = 0; i < ids.length;i++){			//将String数组转换成int数组
			del_ids[i] = Integer.parseInt(ids[i]);
		}	
		ticketOfficeService.deleteBatchTicketOffice(del_ids);
		return "film_statistic";
	}
	
	//根据影片id实时查询
	@RequestMapping("/QueryByOnTime")
	public String queryByOnTime(HttpServletRequest request,Model model){
		String id = request.getParameter("film_id");
		Integer film_id = Integer.parseInt(id);
		TicketOffice ticketOffice = ticketOfficeService.queryByOnTime(film_id);
		model.addAttribute("listTicketOffice",ticketOffice);
		return "film_statistic_search";
	}
	
	//根据影片id查询本周
	@RequestMapping("/QueryByWeek")
	public String queryByWeek(HttpServletRequest request,Model model){
		String id = request.getParameter("film_id");
		Integer film_id = Integer.parseInt(id);
		TicketOffice ticketOffice = ticketOfficeService.queryByWeek(film_id);
		model.addAttribute("listTicketOffice",ticketOffice);
		return "film_statistic_search";
	}
	
	//根据影片id查询本周
	@RequestMapping("/QueryByMonth")
	public String queryByMonth(HttpServletRequest request,Model model){
		String id = request.getParameter("film_id");
		Integer film_id = Integer.parseInt(id);
		TicketOffice ticketOffice = ticketOfficeService.queryByMonth(film_id);
		model.addAttribute("listTicketOffice",ticketOffice);
		return "film_statistic_search";
	}
	
	//日期区域范围查询
	@RequestMapping("/QueryByRange")
	public String queryByRange(HttpServletRequest request,Model model) throws ParseException{
		String id = request.getParameter("film_id");
		Integer film_id = Integer.parseInt(id);
		String temp_from_time = request.getParameter("from_time");
		String temp_to_time = request.getParameter("from_time");
		Date from_time = new SimpleDateFormat("yyyy-MM-dd").parse(temp_from_time);
		Date to_time = new SimpleDateFormat("yyyy-MM-dd").parse(temp_to_time);
		TicketOffice ticketOffice = ticketOfficeService.queryByRange(film_id, from_time, to_time);
		model.addAttribute("listTicketOffice",ticketOffice);
		return "film_statistic_search";
	}
	
	
}
