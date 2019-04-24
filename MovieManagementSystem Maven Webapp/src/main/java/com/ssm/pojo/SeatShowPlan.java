package com.ssm.pojo;

/**
 * 座位场次表的实体类
 * 
 * @author Administrator
 * 
 */
public class SeatShowPlan {
	// 放映编号
	private Integer show_plan_id;

	// 影厅编号
	private Integer film_hall_id;

	// 初始化的座位字符串
	private String temp_seat;

	//已售出座位字符串
	private String sale_out_seat;
	
	public Integer getShow_plan_id() {
		return show_plan_id;
	}

	public void setShow_plan_id(Integer show_plan_id) {
		this.show_plan_id = show_plan_id;
	}

	public Integer getFilm_hall_id() {
		return film_hall_id;
	}

	public void setFilm_hall_id(Integer film_hall_id) {
		this.film_hall_id = film_hall_id;
	}

	public String getTemp_seat() {
		return temp_seat;
	}

	public void setTemp_seat(String temp_seat) {
		this.temp_seat = temp_seat;
	}

	public String getSale_out_seat() {
		return sale_out_seat;
	}

	public void setSale_out_seat(String sale_out_seat) {
		this.sale_out_seat = sale_out_seat;
	}
	
}
