package com.ssm.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssm.service.SaleInfoService;

/**
 * 售票信息的控制层
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/SaleInfo")
public class SaleInfoController {
	
	@Resource
	private SaleInfoService saleInfoService;
	
	//跳转到设置影厅页面,一跳转这个页面就做查询，列表出所有的影厅信息
	@RequestMapping("/showSaleInfo")
	public String show_film_hall(HttpServletRequest request,Model model)throws Exception{
		//设置用户名的显示
		HttpSession session = request.getSession();	
		String name = (String)session.getAttribute("name");
		request.setAttribute("name", name);
			
		//分页查询
		this.saleInfoService.showFilmHallByPage(request, model);
		return "sale_info";
	}
	
	//单个删除售票信息
	@RequestMapping("/delSaleInfo")
	public String deleteSaleInfoById(HttpServletRequest request) {
		String sale_info_id = request.getParameter("sale_info_id"); //从ajax取得传回的id
		Integer id = Integer.parseInt(sale_info_id);
		boolean flag = saleInfoService.deleteSaleInfo(id);
		if(flag){
			return "sale_info";
		}
		return "error";
	}
	
	//批量删除
	@RequestMapping("/delBatchSaleInfo")
		public String deleteSaleInfoByBatch(HttpServletRequest request) {
			String sale_info_del_ids = request.getParameter("sale_info_del_ids"); //接受前台ajax传回的要批量删除ids
			String[] ids = sale_info_del_ids.split(","); //，分开成String数组
			int[] del_ids = new int[ids.length];	
			for(int i = 0; i < ids.length;i++){			//将String数组转换成int数组
				del_ids[i] = Integer.parseInt(ids[i]);
			}	
			saleInfoService.deleteBatchSaleInfo(del_ids);
			return "sale_info";
		}
	
	//根据id进行搜索并展示
	@RequestMapping("/searchSaleInfo")
	public String search_sale_info(HttpServletRequest request, Model model)throws Exception{
		HttpSession session = request.getSession();
		String name = (String)session.getAttribute("name");
		request.setAttribute("name", name);
				
		String data = "";

		String Id = request.getParameter("searchSaleInfoById");
		if(Id!=""){
			Integer searchId = Integer.parseInt(Id);
			boolean flag = saleInfoService.querySaleInfoById(searchId, model);
			if(flag == true){ //查询成功
				return "sale_info_search";
			}else if(flag == false){
				data = "search_fail";
				session.setAttribute("data", data);
				return "sale_info_search";
			}else{
				return "error";
			}
		}else{	
			data = "search_empty";
			session.setAttribute("data", data);
			return "sale_info_search";
		}
	}
}
