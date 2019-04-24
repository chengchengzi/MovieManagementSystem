package com.ssm.utils;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.ssm.dao.FilmInfoDAO;
import com.ssm.dao.TicketOfficeDAO;
import com.ssm.pojo.FilmInfo;
import com.ssm.pojo.TicketOffice;

/**
 * 票房统计表的定时器类，每天的23：58执行
 * @author Administrator
 *
 */
@Component
public class TicketOfficeTimer {
	@Resource
	private FilmInfoDAO filmInfoDAO;
	@Resource
	private TicketOfficeDAO ticketOfficeDAO;
	
	
	@Scheduled(cron="0 59 23 * * *")
	public void saveTicketOfficeByDay(){
		Date nowTime = new Date();
		List<FilmInfo> listFilmInfo = filmInfoDAO.queryAllFilmInfo();
		//String[] temp_ids = new String[1024*2];
		int[] ids = new int[1024*2];
		for(int i = 0; i < listFilmInfo.size();i++ )
			ids[i] = listFilmInfo.get(i).getFilm_id(); 
		for(int j = 0; j < ids.length; j++ ){
			if(ids[j]!=0){
				int count = (int)ticketOfficeDAO.getCountByFilmIdAndOnTime(ids[j]);
				double totalPrice = 0.0;
				TicketOffice ticketOffice = new TicketOffice();
				if( count == 0){
					ticketOffice.setTicket_office_id(null);
					ticketOffice.setTicket_office_time(nowTime);
					ticketOffice.setFilm_id(ids[j]);
					ticketOffice.setTicket_office_numbers(count);
					ticketOffice.setTicket_office_totalprice(totalPrice);
				}else{
					totalPrice = ticketOfficeDAO.TotalPriceByFilmIdAndOnTime(ids[j]);
					ticketOffice.setTicket_office_id(null);
					ticketOffice.setTicket_office_time(nowTime);
					ticketOffice.setFilm_id(ids[j]);
					ticketOffice.setTicket_office_numbers(count);
					ticketOffice.setTicket_office_totalprice(totalPrice);
				}
				this.ticketOfficeDAO.insertTicketOffice(ticketOffice);
			}
		}
	}
	
}
