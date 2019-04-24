package com.ssm.pojo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

/**
 * 影片信息实体类
 * 
 * @author Administrator
 * 
 */
public class FilmInfo {
	// 影片编号
	private Integer film_id;

	// 影片名称
	private String film_name;

	// 导演
	private String film_dirctor;

	// 主演
	private String film_major;

	// 影片类型
	private String film_type;

	// 上映时间
	private Date film_show_time;

	// 影片时长
	private String film_duration;

	// 影片简介
	private String film_brife;

	// 宣传海报
	private String film_pic;
	
	//上传图片用
	private MultipartFile file;  
	
	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public Integer getFilm_id() {
		return film_id;
	}

	public void setFilm_id(Integer film_id) {
		this.film_id = film_id;
	}

	public String getFilm_name() {
		return film_name;
	}

	public void setFilm_name(String film_name) {
		this.film_name = film_name;
	}

	public String getFilm_dirctor() {
		return film_dirctor;
	}

	public void setFilm_dirctor(String film_dirctor) {
		this.film_dirctor = film_dirctor;
	}

	public String getFilm_major() {
		return film_major;
	}

	public void setFilm_major(String film_major) {
		this.film_major = film_major;
	}

	public String getFilm_type() {
		return film_type;
	}

	public void setFilm_type(String film_type) {
		this.film_type = film_type;
	}

	public Date getFilm_show_time() {
		return film_show_time;
	}

	public void setFilm_show_time(Date film_show_time) {
		this.film_show_time = film_show_time;
	}

	public String getFilm_duration() {
		return film_duration;
	}

	public void setFilm_duration(String film_duration) {
		this.film_duration = film_duration;
	}

	public String getFilm_brife() {
		return film_brife;
	}

	public void setFilm_brife(String film_brife) {
		this.film_brife = film_brife;
	}

	public String getFilm_pic() {
		return film_pic;
	}

	public void setFilm_pic(String film_pic) {
		this.film_pic = film_pic;
	}

}
