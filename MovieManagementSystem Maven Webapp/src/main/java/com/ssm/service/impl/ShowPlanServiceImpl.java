package com.ssm.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.ssm.dao.ShowPlanDAO;
import com.ssm.pojo.ShowPlan;
import com.ssm.service.ShowPlanService;
import com.ssm.utils.Page;

/**
 * 放映计划的服务接口的执行类
 * @author Administrator
 *
 */
@Service("showPlanService")
public class ShowPlanServiceImpl implements ShowPlanService{
	@Resource
	private ShowPlanDAO showPlanDAO;

	//分页查询
	public void showShowPlanByPage(HttpServletRequest request, Model model) {
		String pageNow = request.getParameter("pageNow");
		
		Page page = null;
		
		List<ShowPlan> listShowPlan = new ArrayList<ShowPlan>();
		
		int totalCount = (int)showPlanDAO.getShowPlanCount();
		
		if(pageNow != null){
			page = new Page(totalCount, Integer.parseInt(pageNow));
			listShowPlan = this.showPlanDAO.queryShowPlanByPage(page.getStartPos(), page.getPageSize());
		}else{
			page = new Page(totalCount, 1);
			listShowPlan = this.showPlanDAO.queryShowPlanByPage(page.getStartPos(), page.getPageSize());
		}
		 model.addAttribute("listShowPlan", listShowPlan);  
		 model.addAttribute("page", page); 
	}

	//单个删除
	public boolean deleteShowPlan(Integer show_plan_id) {
		ShowPlan showPlan = showPlanDAO.queryShowPlanById(show_plan_id);
			if(showPlan != null){ //删除的影厅存在
				boolean flag = showPlanDAO.deleteShowPlanById(show_plan_id);
				if(flag){
					this.showPlanDAO.deleteSeatShowPlanById(show_plan_id);
					return true; //删除成功
				}else{
					return false; //删除失败
				}
			}
			return false;  //删除的放映计划不存在，返回false
	}

	//批量删除
	public void deleteBatchShowPlan(int[] show_plan_ids) {
		showPlanDAO.deleteShowPlanByBatch(show_plan_ids);
		showPlanDAO.deleteSeatShowPlanByBatch(show_plan_ids);
	}

	//新增放映计划
	public void addShowPlan(HttpServletRequest request, ShowPlan showPlan)
			throws Exception {
		HttpSession session = request.getSession();
		String result = "";
		
		int id = showPlan.getShow_plan_id();
		ShowPlan showPlanIsEmpty = showPlanDAO.queryShowPlanById(id);
		if(showPlanIsEmpty != null){
			result = "repeat";
			session.setAttribute("result", result);
		}else{
			boolean flag = this.showPlanDAO.addShowPlan(showPlan);
			if(flag){
				//新增放映计划成功，更新时间
				this.showPlanDAO.updateShowPlanEndTime();
				///新增放映计划后添加相应影厅的座位字符串
				this.showPlanDAO.insertSeatShowPlanSeat(showPlan);
				result = "success";
				session.setAttribute("result", result);
			}else{
				result = "fail";
				session.setAttribute("result", result);
			}
		}
	}

	//不分页查询所有放映计划
	public List<ShowPlan> queryAllShowPlan() {
		return showPlanDAO.queryAllShowPlan();
	}

	//修改放映计划信息
	public void editShowPlan(HttpServletRequest request, ShowPlan showPlan)
			throws Exception {
		HttpSession session = request.getSession();
		String result = "";

		boolean flag = this.showPlanDAO.updateShowPlan(showPlan);
		if(flag){
			//修改座位场次表
			this.showPlanDAO.updateSeatShowPlanByFilmHallId(showPlan);
			this.showPlanDAO.updateSeatShowPlanByTempSeat(showPlan);
			result = "success";
			session.setAttribute("result", result);
		}else{
			result = "fail";
			session.setAttribute("result", result);
		}
	}

	//根据id查询
	public void queryShowPlanByIdPage(Integer film_id, HttpServletRequest request,
			Model model) {
	
			String pageNow = request.getParameter("pageNow");
			
			Page page = null;
			
			List<ShowPlan> listShowPlan = new ArrayList<ShowPlan>();
			
			int totalCount = (int)showPlanDAO.getShowPlanCountById(film_id);
			
			if(pageNow != null){
				page = new Page(totalCount, Integer.parseInt(pageNow));
				listShowPlan = this.showPlanDAO.queryShowPlanByIdPage(film_id, page.getStartPos(), page.getPageSize());
			}else{
				page = new Page(totalCount, 1);
				listShowPlan = this.showPlanDAO.queryShowPlanByIdPage(film_id, page.getStartPos(), page.getPageSize());
			}
			 model.addAttribute("listShowPlan", listShowPlan);  
			 model.addAttribute("page", page);  
	}

	//根据影片id不分页查询
	public List<ShowPlan> queryShowPlanByFilmId(Integer film_id) {
		return this.showPlanDAO.queryShowPlanByFilmId(film_id);
	}

	//根据观影时间查询
	public List<ShowPlan> queryShowPlanByShowTime(String date, Integer film_id) {
		return showPlanDAO.queryShowPlanByShowTime(date, film_id);
	}

	// 根据放映计划id查询放映计划
	public ShowPlan queryShowPlanById(Integer show_plan_id) {
		return showPlanDAO.queryShowPlanById(show_plan_id);
	}		

	
}
