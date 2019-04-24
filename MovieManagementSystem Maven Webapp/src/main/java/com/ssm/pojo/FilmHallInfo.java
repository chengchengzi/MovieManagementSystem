package com.ssm.pojo;

/**
 * 影厅信息表的实体类
 * @author Administrator
 *
 */
public class FilmHallInfo {
	
	//影厅编号
	private Integer film_hall_id;
	
	//影厅位置
	private String film_hall_location;
	
	//影厅类型
	private String film_hall_type;
	
	//影厅总座位数
	private Integer film_hall_numbers;
	
	//影厅座位分布字符串
	private String film_hall_seat;

	public Integer getFilm_hall_id() {
		return film_hall_id;
	}

	public void setFilm_hall_id(Integer film_hall_id) {
		this.film_hall_id = film_hall_id;
	}

	public String getFilm_hall_location() {
		return film_hall_location;
	}

	public void setFilm_hall_location(String film_hall_location) {
		this.film_hall_location = film_hall_location;
	}

	public String getFilm_hall_type() {
		return film_hall_type;
	}

	public void setFilm_hall_type(String film_hall_type) {
		this.film_hall_type = film_hall_type;
	}

	public Integer getFilm_hall_numbers() {
		return film_hall_numbers;
	}

	public void setFilm_hall_numbers(Integer film_hall_numbers) {
		this.film_hall_numbers = film_hall_numbers;
	}

	public String getFilm_hall_seat() {
		return film_hall_seat;
	}

	public void setFilm_hall_seat(String film_hall_seat) {
		this.film_hall_seat = film_hall_seat;
	}
	
	
}
