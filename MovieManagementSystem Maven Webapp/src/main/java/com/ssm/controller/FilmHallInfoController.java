package com.ssm.controller;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssm.pojo.FilmHallInfo;
import com.ssm.service.FilmHallInfoService;

/**
 * 影厅信息的控制类
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/FilmHall")
public class FilmHallInfoController {
	
	@Resource
	private FilmHallInfoService filmHallInfoService;
	
	//跳转到设置影厅页面,一跳转这个页面就做查询，列表出所有的影厅信息
		@RequestMapping("/showFilmHall")
		public String show_film_hall(HttpServletRequest request,Model model)throws Exception{
			//设置用户名的显示
			HttpSession session = request.getSession();	
			String name = (String)session.getAttribute("name");
			request.setAttribute("name", name);
			
//			//不分页查询所有的影厅信息并显示
//			List<FilmHallInfo> listFilmHall = filmHallInfoService.queryAllFilmHall();
//			model.addAttribute("listFilmHall", listFilmHall);
//			return "film_hall";
			
			//分页查询
			this.filmHallInfoService.showFilmHallByPage(request, model);
			return "film_hall";
		}
		
		//跳转到新增影厅页面
		@RequestMapping("/JumpAddFilmHall")
		public String add_film_hall_jump(HttpServletRequest request,Model model)throws Exception{
			HttpSession session = request.getSession();
			String name = (String)session.getAttribute("name");
			request.setAttribute("name", name);
			return "film_hall_add";
		}
		
		
		//新增影厅
		@RequestMapping("/addFilmHall")
		public String add_film_hall(HttpServletRequest request,Model model)throws Exception{
			HttpSession session = request.getSession();
			String data = "";
			int flag = filmHallInfoService.addFilmHall(request, model);			
			if(flag == 1){
				data = "success";
				session.setAttribute("data", data);
				return "film_hall_add";
			}else if(flag == -1){
				data = "repeat";
				session.setAttribute("data", data);
				return "film_hall_add";
			}
			else if(flag == -2){
				data = "fail";
				session.setAttribute("data", data);
				return "film_hall_add";
			}
			return "error";
		}
		
		
		/**
		 * 根据影厅id单个删除影厅
		 * @param id
		 * @return
		 */
		@RequestMapping("/delFilmHall")
		public String deleteFilmHallById(HttpServletRequest request) {
			String fiml_hall_ids = request.getParameter("film_hall_id"); //从ajax取得传回的id
			Integer id = Integer.parseInt(fiml_hall_ids);
			boolean flag = filmHallInfoService.deleteFilmHall(id);
			if(flag){
				return "film_hall";
			}
			return "error";
		}
		
		/**
		 * 根据影厅id批量删除影厅
		 * @param id
		 * @return
		 */
		@RequestMapping("/delBatchFilmHall")
		public String deleteFilmHallByBatch(HttpServletRequest request) {
			String fiml_hall_del_ids = request.getParameter("film_hall_del_ids"); //接受前台ajax传回的要批量删除ids
			String[] ids = fiml_hall_del_ids.split(","); //，分开成String数组
			int[] del_ids = new int[ids.length];	
			for(int i = 0; i < ids.length;i++){			//将String数组转换成int数组
				del_ids[i] = Integer.parseInt(ids[i]);
			}	
			filmHallInfoService.deleteBatchFilmHall(del_ids);
			return "film_hall";
		}
		
		//跳转到修改影厅信息页面
		@RequestMapping("/JumpEditFilmHall")
		public String edit_film_hall_jump(HttpServletRequest request,Model model)throws Exception{
			HttpSession session = request.getSession();
			String name = (String)session.getAttribute("name");
			request.setAttribute("name", name);
			return "film_hall_edit";
		}
		
		
		//修改影厅信息
		@RequestMapping("/editFilmHall")
		public String edit_film_hall(HttpServletRequest request){
			String film_hall_id = request.getParameter("film_hall_id");
			String film_hall_location = "";
			String film_hall_type = "";
			try{
				film_hall_location = new String(request.getParameter("film_hall_location").getBytes("ISO-8859-1"),"UTF-8");
			    film_hall_type = new String(request.getParameter("film_hall_type").getBytes("ISO-8859-1"),"UTF-8");
			}catch (Exception e) {
				e.printStackTrace();
			}
			String film_hall_numbers = request.getParameter("film_hall_numbers");
			
			Integer film_edit_id = Integer.parseInt(film_hall_id);
			Integer film_edit_numbers = Integer.parseInt(film_hall_numbers);
	
			HttpSession session = request.getSession();
			String data = "";
			
			FilmHallInfo filmHallInfoNew = new FilmHallInfo();
			filmHallInfoNew.setFilm_hall_id(film_edit_id);
			filmHallInfoNew.setFilm_hall_location(film_hall_location);
			filmHallInfoNew.setFilm_hall_type(film_hall_type);
			filmHallInfoNew.setFilm_hall_numbers(film_edit_numbers);
			filmHallInfoNew.setFilm_hall_seat(null);
			
			boolean flag = filmHallInfoService.updateFilmHall(filmHallInfoNew);
			if(flag){
				data = "update_success";
				session.setAttribute("data", data);
				return "film_hall_edit";
			}
			return "error";
		}
		
		//根据id进行搜索并展示
		@RequestMapping("/searchFilmHall")
		public String search_film_hal(HttpServletRequest request, Model model)throws Exception{
			HttpSession session = request.getSession();
			String name = (String)session.getAttribute("name");
			request.setAttribute("name", name);
			
			String data = "";

			String Id = request.getParameter("searchFimlHallId");
			if(Id!=""){
				Integer searchId = Integer.parseInt(Id);
				boolean flag = filmHallInfoService.queryFilmHallById(searchId,model);
				if(flag == true){ //查询成功
					data = "search_success";
					session.setAttribute("data", data);
					return "film_hall_search";
				}else if(flag == false){
					data = "search_fail";
					session.setAttribute("data", data);
					return "film_hall_search";
				}else{
					return "error";
				}
			}else
			{	
				data = "search_empty";
				session.setAttribute("data", data);
				return "film_hall_search";
			}
		}
		
	//跳转到排座页面并显示参数
	@RequestMapping("/JumpSeatSort")
	public String seat_sort_jump(HttpServletRequest request,Model model){
		String id = request.getParameter("film_hall_id");
		Integer film_hall_id = Integer.parseInt(id);
		model.addAttribute("film_hall_id",film_hall_id);
		return "film_hall_seat_sort";
	}
		
	//排座
	@RequestMapping("/saveSeat")
	public String seat_save(HttpServletRequest request,Model model){
		HttpSession session = request.getSession();
		String data = "";
				
		String id = request.getParameter("film_hall_id");
		String seats = request.getParameter("str");
		
		Integer film_hall_id = Integer.parseInt(id);
		
		FilmHallInfo filmHallInfoNew = new FilmHallInfo();
		filmHallInfoNew.setFilm_hall_id(film_hall_id);
		filmHallInfoNew.setFilm_hall_location(null);
		filmHallInfoNew.setFilm_hall_type(null);
		filmHallInfoNew.setFilm_hall_numbers(null);
		filmHallInfoNew.setFilm_hall_seat(seats);
		boolean flag = filmHallInfoService.updateFilmHall(filmHallInfoNew);
		if(flag){
			data = "update_success";
			session.setAttribute("data", data);
			return "film_hall_seat_sort";
		}
		return "error";
	}
}
