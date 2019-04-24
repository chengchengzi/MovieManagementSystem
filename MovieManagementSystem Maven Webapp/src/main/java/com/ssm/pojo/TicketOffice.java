package com.ssm.pojo;

import java.util.Date;

/**
 * 票房统计表的实体类
 * 
 * @author Administrator
 * 
 */
public class TicketOffice {
	// 票房统计编号
	private Integer ticket_office_id;

	// 统计时间
	private Date ticket_office_time;

	// 影片编号
	private Integer film_id;

	// 售票数量
	private Integer ticket_office_numbers;

	// 总票房
	private double ticket_office_totalprice;
	
	//影片信息
	private FilmInfo filmInfo;
	

	public FilmInfo getFilmInfo() {
		return filmInfo;
	}

	public void setFilmInfo(FilmInfo filmInfo) {
		this.filmInfo = filmInfo;
	}

	public Integer getTicket_office_id() {
		return ticket_office_id;
	}

	public void setTicket_office_id(Integer ticket_office_id) {
		this.ticket_office_id = ticket_office_id;
	}

	public Date getTicket_office_time() {
		return ticket_office_time;
	}

	public void setTicket_office_time(Date ticket_office_time) {
		this.ticket_office_time = ticket_office_time;
	}

	public Integer getFilm_id() {
		return film_id;
	}

	public void setFilm_id(Integer film_id) {
		this.film_id = film_id;
	}

	public Integer getTicket_office_numbers() {
		return ticket_office_numbers;
	}

	public void setTicket_office_numbers(Integer ticket_office_numbers) {
		this.ticket_office_numbers = ticket_office_numbers;
	}


	public double getTicket_office_totalprice() {
		return ticket_office_totalprice;
	}

	public void setTicket_office_totalprice(double ticket_office_totalprice) {
		this.ticket_office_totalprice = ticket_office_totalprice;
	}

}
