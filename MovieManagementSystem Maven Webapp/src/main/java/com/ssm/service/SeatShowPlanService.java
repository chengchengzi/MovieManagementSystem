package com.ssm.service;


/**
 * 座位场次表的服务接口
 * @author Administrator
 *
 */
public interface SeatShowPlanService {
	public String[] querySeatShowPlanByShowPlanId(Integer show_plan_id); //根据放映计划编号查询当前座位字符串
	
	public boolean saveSeat(String seat_selected,String seat_removeSelected,Integer show_plan_id); //购票后保存座位信息
}
