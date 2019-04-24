package com.ssm.service;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.ssm.pojo.TicketOffice;

/**
 * 票房统计的服务接口
 * 
 * @author Administrator
 * 
 */
public interface TicketOfficeService {
	public void showTicketOfficeByPage(HttpServletRequest request, Model model); // 分页查询
	
	public boolean deleteTicketOffice(Integer ticket_office_id); //单个删除
	
	public void deleteBatchTicketOffice(int[] ticket_office_ids); //批量删除
	
	public TicketOffice queryByOnTime(Integer film_id); //根据影片id实时查询
	
	public TicketOffice queryByWeek(Integer film_id); //根据影片id查询本周 
	
	public TicketOffice queryByMonth(Integer film_id); //根据影片id查询本月
	
	public TicketOffice queryByRange(Integer film_id,Date from_time,Date to_time);//根据日期范围查询
}
