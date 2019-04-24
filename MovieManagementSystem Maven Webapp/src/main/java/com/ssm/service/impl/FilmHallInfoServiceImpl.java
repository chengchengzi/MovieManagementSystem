package com.ssm.service.impl;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.ssm.dao.FilmHallInfoDAO;
import com.ssm.pojo.FilmHallInfo;
import com.ssm.service.FilmHallInfoService;
import com.ssm.utils.Page;

/**
 * 影厅信息的服务执行类
 * @author Administrator
 *
 */
@Service("filmHallInfoService")
public class FilmHallInfoServiceImpl implements FilmHallInfoService{
	
	@Resource
	private FilmHallInfoDAO filmHallInfoDAO; 
	
	/**
	 * 不分页查询所有影厅
	 */
	public List<FilmHallInfo> queryAllFilmHall() {  
		return filmHallInfoDAO.queryAllFilmHall();
	}

	/**
	 * 分页查询所有影厅
	 */
	public void showFilmHallByPage(HttpServletRequest request, Model model) {
		String pageNow = request.getParameter("pageNow");
		
		Page page = null;
		
		List<FilmHallInfo> listFilmHallInfo = new ArrayList<FilmHallInfo>();
		
		int totalCount = (int)filmHallInfoDAO.getFilmHallCount();
		
		if(pageNow != null){
			page = new Page(totalCount, Integer.parseInt(pageNow));
			listFilmHallInfo = this.filmHallInfoDAO.selectFilmHallByPage(page.getStartPos(), page.getPageSize());
		}else{
			page = new Page(totalCount, 1);
			listFilmHallInfo = this.filmHallInfoDAO.selectFilmHallByPage(page.getStartPos(), page.getPageSize());
		}
		 model.addAttribute("listFilmHallInfo", listFilmHallInfo);  
		 model.addAttribute("page", page);  
	}
	
	/**
	 * 新增影厅
	 */
	public int addFilmHall(HttpServletRequest request, Model model){
		int film_hall_id = Integer.parseInt(request.getParameter("film_hall_id"));
		String film_hall_location = null;
		
		try {
			film_hall_location = new String(request.getParameter("film_hall_location").getBytes("ISO-8859-1"),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		 
				
		String film_hall_type = request.getParameter("film_hall_type");
		int film_hall_numbers = Integer.parseInt(request.getParameter("film_hall_numbers"));
		
		//验证输入的影厅编号是否已存在
		FilmHallInfo filmHallInfo = filmHallInfoDAO.queryFilmHallByfilmHallId(film_hall_id);
		if(filmHallInfo != null){
			return -1; //新增失败，影厅编号重名
		}else{		
			//保存新增的影厅信息
			FilmHallInfo filmHallInfoNew = new FilmHallInfo();
			filmHallInfoNew.setFilm_hall_id(film_hall_id);
			filmHallInfoNew.setFilm_hall_location(film_hall_location);
			filmHallInfoNew.setFilm_hall_type(film_hall_type);
			filmHallInfoNew.setFilm_hall_numbers(film_hall_numbers);
		
			boolean flag = filmHallInfoDAO.addFilmHall(filmHallInfoNew);
			if(flag){
				return 1; //新增成功
			}		
			return -2; //新增失败
		}
	}

	/**
	 * 单个删除影厅
	 */
	public boolean deleteFilmHall(Integer film_hall_id) {
		FilmHallInfo filmHallInfo = filmHallInfoDAO.queryFilmHallByfilmHallId(film_hall_id);
		if(filmHallInfo != null){ //删除的影厅存在
			boolean flag = filmHallInfoDAO.deleteFilmHallById(film_hall_id);
			if(flag){
				return true;
			}else{
				return false;
			}
		}
		return false;  //删除的影厅不存在，返回false
	}

	/**
	 * 批量删除影厅
	 */
	public void deleteBatchFilmHall(int[] filmHallIds) {
		filmHallInfoDAO.deleteFilmHallByBatch(filmHallIds);
	}


	/**
	 * 修改影厅信息
	 */
	public boolean updateFilmHall(FilmHallInfo filmHallInfo) {
		boolean flag = filmHallInfoDAO.updateFilmHall(filmHallInfo);
		if(flag){
			return true;
		}
		return false;
	}

	//根据id进行查找
	public boolean queryFilmHallById(Integer filmHallId,Model model) {
		FilmHallInfo filmHallInfo = filmHallInfoDAO.queryFilmHallByfilmHallId(filmHallId);
		if(filmHallInfo!=null){ //查询的影厅存在  
			model.addAttribute("listFilmHall",filmHallInfo);
			return true;
		}
		return false;
	}
}

