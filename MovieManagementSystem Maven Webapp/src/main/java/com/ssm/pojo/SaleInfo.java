package com.ssm.pojo;

import java.util.Date;

/**
 * 售票信息表的实体类
 * 
 * @author Administrator
 * 
 */
public class SaleInfo {
	// 电影票编号
	private Integer sale_info_id;

	// 售票时间
	private Date sale_info_time;

	// 影票编号
	private Integer film_id;

	// 影厅编号
	private Integer film_hall_id;

	//座位号
	private String sale_info_location;

	// 放映时间
	private Date sale_info_showtime;

	// 电影票类型
	private String sale_info_type;

	// 电影票单价
	private float sale_info_price;
	
	//影片信息
	//private FilmInfo filmInfo;

	public Integer getSale_info_id() {
		return sale_info_id;
	}

	public void setSale_info_id(Integer sale_info_id) {
		this.sale_info_id = sale_info_id;
	}

	public Date getSale_info_time() {
		return sale_info_time;
	}

	public void setSale_info_time(Date sale_info_time) {
		this.sale_info_time = sale_info_time;
	}

	public Integer getFilm_id() {
		return film_id;
	}

	public void setFilm_id(Integer film_id) {
		this.film_id = film_id;
	}

	public Integer getFilm_hall_id() {
		return film_hall_id;
	}

	public void setFilm_hall_id(Integer film_hall_id) {
		this.film_hall_id = film_hall_id;
	}

	public String getSale_info_location() {
		return sale_info_location;
	}

	public void setSale_info_location(String sale_info_location) {
		this.sale_info_location = sale_info_location;
	}

	public Date getSale_info_showtime() {
		return sale_info_showtime;
	}

	public void setSale_info_showtime(Date sale_info_showtime) {
		this.sale_info_showtime = sale_info_showtime;
	}

	public String getSale_info_type() {
		return sale_info_type;
	}

	public void setSale_info_type(String sale_info_type) {
		this.sale_info_type = sale_info_type;
	}

	public float getSale_info_price() {
		return sale_info_price;
	}

	public void setSale_info_price(float sale_info_price) {
		this.sale_info_price = sale_info_price;
	}
}
