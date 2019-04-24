package com.ssm.pojo;

import java.util.Date;

/**
 * 放映计划的实体类
 * @author Administrator
 *
 */
public class ShowPlan {
	
	//放映计划编号
	private Integer show_plan_id;
	
	//影片编号
	private Integer film_id;
	
	//影厅编号
	private Integer film_hall_id;
	
	//放映时间
	private Date show_time;
	
	//结束时间
	private Date end_time;
	
	//影片单价
	private float film_price;
	
	//增加FilmInfo属性
	private FilmInfo filmInfo;
	
	//增加filmHallInfo属性
	private FilmHallInfo filmHallInfo;
	
	public FilmHallInfo getFilmHallInfo() {
		return filmHallInfo;
	}

	public void setFilmHallInfo(FilmHallInfo filmHallInfo) {
		this.filmHallInfo = filmHallInfo;
	}

	public Integer getShow_plan_id() {
		return show_plan_id;
	}

	public void setShow_plan_id(Integer show_plan_id) {
		this.show_plan_id = show_plan_id;
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

	public Date getShow_time() {
		return show_time;
	}

	public void setShow_time(Date show_time) {
		this.show_time = show_time;
	}
	
	
	public Date getEnd_time() {
		return end_time;
	}

	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}

	public FilmInfo getFilmInfo() {
		return filmInfo;
	}

	public void setFilmInfo(FilmInfo filmInfo) {
		this.filmInfo = filmInfo;
	}

	public float getFilm_price() {
		return film_price;
	}

	public void setFilm_price(float film_price) {
		this.film_price = film_price;
	}
	
	
	
}
