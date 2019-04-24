package com.ssm.service.impl;

import java.util.ArrayList;
import java.util.List;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.ssm.dao.FilmInfoDAO;
import com.ssm.pojo.FilmInfo;
import com.ssm.service.FilmInfoService;
import com.ssm.utils.Page;

/**
 * 影片信息的服务执行类
 * @author Administrator
 *
 */
@Service("filmInfoService")
public class FilmInfoServiceImpl implements FilmInfoService{

	@Resource
	private FilmInfoDAO filmInfoDAO; 
	
	//分页查询影片信息
	public void showFilmInfoByPage(HttpServletRequest request, Model model) {
		String pageNow = request.getParameter("pageNow");
		
		Page page = null;
		
		List<FilmInfo> listFilmInfo = new ArrayList<FilmInfo>();
		
		int totalCount = (int)filmInfoDAO.getFilmInfoCount();
		
		if(pageNow != null){
			page = new Page(totalCount, Integer.parseInt(pageNow));
			listFilmInfo = this.filmInfoDAO.selectFilmInfoByPage(page.getStartPos(), page.getPageSize());
		}else{
			page = new Page(totalCount, 1);
			listFilmInfo = this.filmInfoDAO.selectFilmInfoByPage(page.getStartPos(), page.getPageSize());
		}
		 model.addAttribute("listFilmInfo", listFilmInfo);  
		 model.addAttribute("page", page);  
	}

	//新增影片
	public void addFilmInfo(HttpServletRequest request,FilmInfo filmInfo) throws Exception{
		HttpSession session = request.getSession();
		String result = "";
		
		int id = filmInfo.getFilm_id();
		FilmInfo filmInfoIsEmpty = filmInfoDAO.queryFilmInfoById(id);
		if(filmInfoIsEmpty != null){
			result = "repeat";
			session.setAttribute("result", result);
		}else{
			boolean flag = this.filmInfoDAO.addFilmInfo(filmInfo);
			if(flag){
				result = "success";
				session.setAttribute("result", result);
			}else{
				result = "fail";
				session.setAttribute("result", result);
			}
		}
	}

	//单个删除影片
	public boolean deleteFilmInfo(Integer film_id) {
		FilmInfo filmInfo = filmInfoDAO.queryFilmInfoById(film_id);
		if(filmInfo != null){ //删除的影厅存在
			boolean flag = filmInfoDAO.deleteFilmInfoById(film_id);
			if(flag){
				return true;
			}else{
				return false;
			}
		}
		return false;  //删除的影片不存在，返回false
	}
	
	//批量删除
	public void deleteBatchFilmInfo(int[] filmHallIds) {
		filmInfoDAO.deleteFilmInfoByBatch(filmHallIds);
	}

	//模糊查询
	public void fuzzySelectUserInfoByName(String name,HttpServletRequest request, Model model) {

		List<FilmInfo> listFilmInfo = new ArrayList<FilmInfo>();
		listFilmInfo = this.filmInfoDAO.fuzzySelectFilmInfoByName(name);
		model.addAttribute("listFilmInfo", listFilmInfo);   
	}

	//修改影片信息
	public void editFilmInfo(HttpServletRequest request, FilmInfo filmInfo)	throws Exception {
		HttpSession session = request.getSession();
		String result = "";

		boolean flag = this.filmInfoDAO.updateFilmInfo(filmInfo);
		if(flag){
			result = "success";
			session.setAttribute("result", result);
		}else{
			result = "fail";
			session.setAttribute("result", result);
		}
	}

	//查询所有影片信息
	public List<FilmInfo> queryAllFilmInfo() {
		return filmInfoDAO.queryAllFilmInfo();
	}

	//根据id查询影片信息
	public FilmInfo queryFilmInfoById(Integer film_id) {
		return filmInfoDAO.queryFilmInfoById(film_id);
	}
	
	

}
