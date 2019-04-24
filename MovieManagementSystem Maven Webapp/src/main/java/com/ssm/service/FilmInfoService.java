package com.ssm.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.ssm.pojo.FilmInfo;

/**
 * 影片信息的服务接口
 * @author Administrator
 *
 */
public interface FilmInfoService {
	
	public void showFilmInfoByPage(HttpServletRequest request,Model model); //分页查询影片信息
	
	public void addFilmInfo(HttpServletRequest request,FilmInfo filmInfo) throws Exception; //新增影片
	
	public boolean deleteFilmInfo(Integer film_id); //单个删除影片
	
	public void deleteBatchFilmInfo(int[] filmInfoIds); //批量删除影片
	
	public void fuzzySelectUserInfoByName(String name,HttpServletRequest request,Model model); //根据影片名称模糊查询
	
	public void editFilmInfo(HttpServletRequest request,FilmInfo filmInfo) throws Exception; //修改影片信息

	public List<FilmInfo> queryAllFilmInfo();//查询所有影片信息
	
	public FilmInfo queryFilmInfoById(Integer film_id); //根据id查询影片信息
}
