package com.ssm.dao;

import org.apache.ibatis.annotations.Param;

import com.ssm.pojo.SeatShowPlan;

/**
 * 座位场次表的对外接口
 * 
 * @author Administrator
 * 
 */
public interface SeatShowPlanDAO {
	public SeatShowPlan querySeatShowPlanByShowPlanId(Integer show_plan_id); // 根据放映计划编号查询

	public boolean saveSeat(
			@Param(value = "sale_out_seat") String sale_out_seat,
			@Param(value = "show_plan_id") Integer show_plan_id);// 保存购票成功后已售出座位信息
	
	
}
