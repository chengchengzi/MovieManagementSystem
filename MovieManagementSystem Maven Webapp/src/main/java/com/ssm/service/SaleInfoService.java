package com.ssm.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

/**
 * 售票信息的服务接口
 * @author Administrator
 *
 */
public interface SaleInfoService {
	
	public void showFilmHallByPage(HttpServletRequest request,Model model);//分页查询
	
	public boolean deleteSaleInfo(Integer sale_info_id); //单个删除
	
	public void deleteBatchSaleInfo(int[] sale_info_ids); //批量删除
	
	public boolean querySaleInfoById(Integer sale_info_id,Model model); //根据id查询售票信息

}
