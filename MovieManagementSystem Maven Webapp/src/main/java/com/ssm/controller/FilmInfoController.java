package com.ssm.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.ssm.pojo.FilmInfo;
import com.ssm.service.FilmInfoService;

/**
 * 影片信息的控制层
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/FilmInfo")
public class FilmInfoController {
	
	@Resource
	private FilmInfoService filmInfoService;
	
	//跳转到设置影厅页面,一跳转这个页面就做查询，列表出所有的影片信息
	@RequestMapping("/showFilmInfo")
	public String show_film_hall(HttpServletRequest request,Model model)throws Exception{
		//设置用户名的显示
		HttpSession session = request.getSession();	
		String name = (String)session.getAttribute("name");
		request.setAttribute("name", name);				
		//分页查询
		this.filmInfoService.showFilmInfoByPage(request, model);
		return "film_info_management";
	}
			
	//跳转到新增影片页面
	@RequestMapping("/JumpAddFilmInfo")
	public String add_film_info_jump(HttpServletRequest request,Model model)throws Exception{
		HttpSession session = request.getSession();
		String name = (String)session.getAttribute("name");
		request.setAttribute("name", name);
		return "film_info_add";
	}
	
	//新增影片
	@RequestMapping("/addFilmInfo")
	public String add_film_hall(HttpServletRequest request,MultipartFile file, ModelMap map)throws Exception{		
		
		request.setCharacterEncoding("UTF-8");
		int film_id = Integer.parseInt(request.getParameter("film_id"));
		String film_name = null;
		String film_dirctor = null;
		String film_major = null;
		String film_type = null;
		String time = request.getParameter("film_show_time");
		Date film_show_time = null;
		film_show_time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(time);
		String film_duration = null;
		String film_brife = null;
		
		
		film_name = request.getParameter("film_name");
		film_dirctor = request.getParameter("film_dirctor");
		film_major = request.getParameter("film_major");
		film_type = request.getParameter("film_type");
		film_duration = request.getParameter("film_duration");
   	    film_brife = request.getParameter("film_brife");
		
		//处理上传影片宣传图片
		  //图片上传成功后，将图片的地址写到数据库
        String filePath = "E:\\upload";//保存图片的路径
        //获取原始图片的拓展名
        //String originalFilename = file.getOriginalFilename();
        String contentType = file.getContentType();
        String suffixName =  contentType.substring(contentType.indexOf("/")+1);
        //新的文件名字
        //String newFileName = UUID.randomUUID().toString().replaceAll("-","")+originalFilename;
        String newFileName = UUID.randomUUID().toString().replaceAll("-","") + suffixName;
        //封装上传文件位置的全路径
        File targetFile = new File(filePath,newFileName); 
        //把本地文件上传到封装上传文件位置的全路径
        file.transferTo(targetFile);
        
        String sqlPicPath = "/images/" + newFileName; 
       		
	    FilmInfo filmInfoNew = new FilmInfo();
		filmInfoNew.setFilm_id(film_id);
		filmInfoNew.setFilm_name(film_name);
		filmInfoNew.setFilm_dirctor(film_dirctor);
		filmInfoNew.setFilm_major(film_major);
		filmInfoNew.setFilm_type(film_type);
		filmInfoNew.setFilm_show_time(film_show_time);
		filmInfoNew.setFilm_duration(film_duration);
		filmInfoNew.setFilm_brife(film_brife);
		filmInfoNew.setFilm_pic(sqlPicPath);
		filmInfoService.addFilmInfo(request, filmInfoNew);
	    return "film_info_add";
	    
	}
	
	//单个删除影片
	@RequestMapping("/delFilmInfo")
	public String deleteFilmInfoById(HttpServletRequest request) {
		String id = request.getParameter("film_id"); //从ajax取得传回的id
		Integer film_id = Integer.parseInt(id);
		boolean flag = filmInfoService.deleteFilmInfo(film_id);
		if(flag){
			return "film_info_management";
		}
		return "error";
	}

	//批量删除
	@RequestMapping("/delBatchFilmInfo")
	public String deleteFilmHallByBatch(HttpServletRequest request) {
		String fiml_info_del_ids = request.getParameter("film_info_del_ids"); //接受前台ajax传回的要批量删除ids
		String[] ids = fiml_info_del_ids.split(","); //，分开成String数组
		int[] del_ids = new int[ids.length];	
		for(int i = 0; i < ids.length;i++){			//将String数组转换成int数组
			del_ids[i] = Integer.parseInt(ids[i]);
		}	
		filmInfoService.deleteBatchFilmInfo(del_ids);
		return "film_info_management";
	}

	//根据影片名称模糊查询并展示
	@RequestMapping("/searchFilmInfo")
	public String search_film_info(HttpServletRequest request, Model model)throws Exception{
		HttpSession session = request.getSession();
		String param = (String)session.getAttribute("param");
		String condition = (String)session.getAttribute("condition");
		//先判断session中的condition是否为空
		if(condition == null){
			condition = new String();
			session.setAttribute("condition", condition);
			//如果session中的condition为空，再判断传入的参数是否为空，如果为空就跳转到film_info_search页面
			if(param == null || "".equals(param)){
				return "film_info_search";
			}
		}
		//如果session不为空，且传入的搜索参数param不为空，将param赋值给condition
		if(param != null && !("".equals(param))){
			condition = new String(param.getBytes("ISO-8859-1"),"UTF-8");
			session.setAttribute("condition", condition);
		}
		//传值查询
		this.filmInfoService.fuzzySelectUserInfoByName(condition, request, model);
		return "film_info_search";
	}
	
	//跳转到修改影片信息页面
	@RequestMapping("/JumpEditFilmInfo")
	public String edit_film_info_jump(HttpServletRequest request,Model model)throws Exception{
		HttpSession session = request.getSession();
		String name = (String)session.getAttribute("name");
		request.setAttribute("name", name);
		return "film_info_edit";
	}
	
	//修改影片信息
	@RequestMapping("/editFilmInfo")
	public String edit_film_hall(HttpServletRequest request,MultipartFile file, ModelMap map)throws Exception{
		
		request.setCharacterEncoding("UTF-8");
		
		int film_id = Integer.parseInt(request.getParameter("film_id"));
		String film_name = "";
		String film_dirctor = "";
		String film_major = "";
		String film_type = "";
		String time = request.getParameter("film_show_time");
		Date film_show_time = null;
		film_show_time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(time);
		String film_duration = "";
		String film_brife = "";
		
	
		film_name = request.getParameter("film_name");
		film_dirctor = request.getParameter("film_dirctor");
		film_major = request.getParameter("film_major");
		film_type = request.getParameter("film_type");
		film_duration = request.getParameter("film_duration");
   	    film_brife = request.getParameter("film_brife");
		
		//处理上传影片宣传图片
		  //图片上传成功后，将图片的地址写到数据库
        String filePath = "E:\\upload";//保存图片的路径
        //获取原始图片的拓展名
        //String originalFilename = file.getOriginalFilename();
        String contentType = file.getContentType();
        String suffixName =  contentType.substring(contentType.indexOf("/")+1);
        //新的文件名字
        //String newFileName = UUID.randomUUID().toString().replaceAll("-","")+originalFilename;
        String newFileName = UUID.randomUUID().toString().replaceAll("-","") + suffixName;
        //封装上传文件位置的全路径
        File targetFile = new File(filePath,newFileName); 
        //把本地文件上传到封装上传文件位置的全路径
        file.transferTo(targetFile);
        
        String sqlPicPath = "/images/" + newFileName; 
       		
	    FilmInfo filmInfoNew = new FilmInfo();
		filmInfoNew.setFilm_id(film_id);
		filmInfoNew.setFilm_name(film_name);
		filmInfoNew.setFilm_dirctor(film_dirctor);
		filmInfoNew.setFilm_major(film_major);
		filmInfoNew.setFilm_type(film_type);
		filmInfoNew.setFilm_show_time(film_show_time);
		filmInfoNew.setFilm_duration(film_duration);
		filmInfoNew.setFilm_brife(film_brife);
		filmInfoNew.setFilm_pic(sqlPicPath);
		filmInfoService.editFilmInfo(request, filmInfoNew);
	    return "film_info_edit";
	}
}
