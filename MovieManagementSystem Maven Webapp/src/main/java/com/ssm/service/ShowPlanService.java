package com.ssm.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.ssm.pojo.ShowPlan;

/**
 * 放映计划的服务接口
 * 
 * @author Administrator
 * 
 */

public interface ShowPlanService {

	public void showShowPlanByPage(HttpServletRequest request, Model model); // 分页查询

	public List<ShowPlan> queryAllShowPlan(); // 查询所有放映计划

	public boolean deleteShowPlan(Integer show_plan_id); // 单个删除

	public void deleteBatchShowPlan(int[] show_plan_ids); // 批量删除

	public void addShowPlan(HttpServletRequest request, ShowPlan showPlan)
			throws Exception; // 新增放映计划

	public void editShowPlan(HttpServletRequest request, ShowPlan showPlan)
			throws Exception; // 修改放映计划信息

	public void queryShowPlanByIdPage(Integer film_id, HttpServletRequest request,
			Model model); // 根据影片id分页查询
	
	public List<ShowPlan> queryShowPlanByFilmId(Integer film_id); //根据影片id不分页查询
	
	public List<ShowPlan> queryShowPlanByShowTime(String date,Integer film_id);// 根据观影时间查询
	
	public ShowPlan queryShowPlanById(Integer show_plan_id);// 根据放映计划id查询放映计划
}
