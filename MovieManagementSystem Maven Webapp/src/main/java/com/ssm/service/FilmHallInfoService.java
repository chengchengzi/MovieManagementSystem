package com.ssm.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.ssm.pojo.FilmHallInfo;

/**
 * 影厅信息的服务接口
 * @author Administrator
 *
 */
public interface FilmHallInfoService {
	
	public List<FilmHallInfo> queryAllFilmHall();   //不分页查询所有影厅列表
		
	public void showFilmHallByPage(HttpServletRequest request,Model model); //分页查询所有影厅列表
	
	public int addFilmHall(HttpServletRequest request, Model model); //新增影厅
	
	public boolean deleteFilmHall(Integer film_hall_id); //单个删除影厅
	
	public void deleteBatchFilmHall(int[] filmHallIds); //批量删除影厅
	
	public boolean updateFilmHall(FilmHallInfo filmHallInfo);//修改影厅信息
	
	public boolean queryFilmHallById(Integer filmHallId,Model model); //根据id查询影厅信息
}
