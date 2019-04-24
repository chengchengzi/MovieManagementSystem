package com.ssm.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.ssm.dao.TicketOfficeDAO;
import com.ssm.pojo.FilmInfo;
import com.ssm.pojo.TicketOffice;
import com.ssm.service.TicketOfficeService;
import com.ssm.utils.Page;

/**
 * 票房统计的服务执行类
 * @author Administrator
 *
 */
@Service("ticketOfficeService")
public class TicketOfficeServiceImpl implements TicketOfficeService{

	@Resource
	private TicketOfficeDAO ticketOfficeDAO; 
	
	//分页查询
	public void showTicketOfficeByPage(HttpServletRequest request, Model model) {
		String pageNow = request.getParameter("pageNow");
		
		Page page = null;
		
		List<TicketOffice> listTicketOffice = new ArrayList<TicketOffice>();
		
		int totalCount = (int)ticketOfficeDAO.getCount();
		
		if(pageNow != null){
			page = new Page(totalCount, Integer.parseInt(pageNow));
			listTicketOffice = this.ticketOfficeDAO.queryAllByPage(page.getStartPos(), page.getPageSize());
		}else{
			page = new Page(totalCount, 1);
			listTicketOffice = this.ticketOfficeDAO.queryAllByPage(page.getStartPos(), page.getPageSize());
		}
		 model.addAttribute("listTicketOffice", listTicketOffice);  
		 model.addAttribute("page", page);  
	}

	//单个删除
	public boolean deleteTicketOffice(Integer ticket_office_id) {
		TicketOffice ticketOffice = ticketOfficeDAO.queryTicketOfficeById(ticket_office_id);
		if(ticketOffice != null){ //删除的统计数据存在
			boolean flag = ticketOfficeDAO.deleteTicketOfficeById(ticket_office_id);
			if(flag){
				return true;
			}else{
				return false;
			}
		}
		return false; //删除的统计数据不存在
	}

	//批量删除
	public void deleteBatchTicketOffice(int[] ticket_office_ids) {
		this.ticketOfficeDAO.deleteTicketOfficeByBatch(ticket_office_ids);
	}

	//根据影片id实时查询(当天)
	public TicketOffice queryByOnTime(Integer film_id) {
		TicketOffice ticketOffice = new TicketOffice();
		FilmInfo filmInfo = new FilmInfo();
		Date now = new Date();
		int count = (int)ticketOfficeDAO.getCountByFilmIdAndOnTime(film_id);
		double totalPrice = 0.0;
		if(count != 0){
			 totalPrice = ticketOfficeDAO.TotalPriceByFilmIdAndOnTime(film_id);
		}
		String film_name = ticketOfficeDAO.queryFilmNameByFilmId(film_id);
		filmInfo.setFilm_name(film_name);
		ticketOffice.setFilm_id(film_id);
		ticketOffice.setFilmInfo(filmInfo);
		ticketOffice.setTicket_office_time(now);
		ticketOffice.setTicket_office_numbers(count);
		ticketOffice.setTicket_office_totalprice(totalPrice);
		return ticketOffice;
	}

	//根据影片id查询本周 
	public TicketOffice queryByWeek(Integer film_id) {
		TicketOffice ticketOffice = new TicketOffice();
		FilmInfo filmInfo = new FilmInfo();
		Date now = new Date();
		int count = (int)ticketOfficeDAO.getCountByFilmIdAndWeek(film_id);
		double totalPrice = 0.0;
		if(count != 0){
			totalPrice = ticketOfficeDAO.TotalPriceByFilmIdAndWeek(film_id);
		}
		String film_name = ticketOfficeDAO.queryFilmNameByFilmId(film_id);
		filmInfo.setFilm_name(film_name);
		ticketOffice.setFilm_id(film_id);
		ticketOffice.setFilmInfo(filmInfo);
		ticketOffice.setTicket_office_time(now);
		ticketOffice.setTicket_office_numbers(count);
		ticketOffice.setTicket_office_totalprice(totalPrice);
		return ticketOffice;
	}

	//根据影片id查询本月
	public TicketOffice queryByMonth(Integer film_id) {
		TicketOffice ticketOffice = new TicketOffice();
		FilmInfo filmInfo = new FilmInfo();
		Date now = new Date();
		int count = (int)ticketOfficeDAO.getCountByFilmIdAndMonth(film_id);
		double totalPrice = 0.0;
		if(count!=0){
			totalPrice = ticketOfficeDAO.TotalPriceByFilmIdAndMonth(film_id);
		}
		String film_name = ticketOfficeDAO.queryFilmNameByFilmId(film_id);
		filmInfo.setFilm_name(film_name);
		ticketOffice.setFilm_id(film_id);
		ticketOffice.setFilmInfo(filmInfo);
		ticketOffice.setTicket_office_time(now);
		ticketOffice.setTicket_office_numbers(count);
		ticketOffice.setTicket_office_totalprice(totalPrice);
		return ticketOffice;
	}

	//根据日期范围查询
	public TicketOffice queryByRange(Integer film_id, Date from_time,
			Date to_time) {
		TicketOffice ticketOffice = new TicketOffice();
		FilmInfo filmInfo = new FilmInfo();
		Date now = new Date();
		int count = (int)ticketOfficeDAO.getCountByRange(film_id, from_time, to_time);
		double totalPrice = 0.0;
		if(count != 0){
			totalPrice = ticketOfficeDAO.TotalPriceByRange(film_id, from_time, to_time);
		}
		String film_name = ticketOfficeDAO.queryFilmNameByFilmId(film_id);
		filmInfo.setFilm_name(film_name);
		ticketOffice.setFilm_id(film_id);
		ticketOffice.setFilmInfo(filmInfo);
		ticketOffice.setTicket_office_time(now);
		ticketOffice.setTicket_office_numbers(count);
		ticketOffice.setTicket_office_totalprice(totalPrice);
		return ticketOffice;
		
	}
	
}
