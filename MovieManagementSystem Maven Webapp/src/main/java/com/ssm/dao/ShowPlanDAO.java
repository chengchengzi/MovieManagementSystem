package com.ssm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ssm.pojo.ShowPlan;

/**
 * 放映计划的对外接口
 * 
 * @author Administrator
 * 
 */
public interface ShowPlanDAO {

	public long getShowPlanCount(); // 取得放映计划的总记录数

	public List<ShowPlan> queryShowPlanByPage(
			@Param(value = "startPos") Integer startPos,
			@Param(value = "pageSize") Integer pageSize);// 分页查询

	public List<ShowPlan> queryAllShowPlan(); // 查询所有放映计划

	public ShowPlan queryShowPlanById(Integer show_plan_id);// 根据放映计划id查询放映计划

	public boolean deleteShowPlanById(Integer show_plan_id); // 单个删除

	public void deleteShowPlanByBatch(int[] show_plan_ids); // 批量删除

	public boolean addShowPlan(ShowPlan showPlan); // 新增放映计划

	public boolean updateShowPlan(ShowPlan showPlan); // 修改放映计划

	public long getShowPlanCountById(Integer film_id); // 取得符合id条件查询时的总记录数

	public List<ShowPlan> queryShowPlanByIdPage(
			@Param(value = "film_id") Integer film_id,
			@Param(value = "startPos") Integer startPos,
			@Param(value = "pageSize") Integer pageSize); // 分页根据id查询

	public List<ShowPlan> queryShowPlanByFilmId(Integer film_id);// 根据影片id不分页查询

	public List<ShowPlan> queryShowPlanByShowTime(
			@Param(value = "date") String date,
			@Param(value = "film_id") Integer film_id);  //根据放映时间模糊查询多个放映计划

	public void updateShowPlanEndTime();// 更新结束时间

	public void insertSeatShowPlanSeat(ShowPlan showPlan);// 新增放映计划后添加相应影厅的座位字符串

	public void deleteSeatShowPlanById(Integer show_plan_id); // 单个删除座位场次表

	public void deleteSeatShowPlanByBatch(int[] show_plan_ids); // 批量删除座位场次表

	public void updateSeatShowPlanByFilmHallId(ShowPlan showPlan);// 更新座位场次表的影厅号

	public void updateSeatShowPlanByTempSeat(ShowPlan showPlan);// 更新座位字符串

	public Integer queryShowPlanByFilmIdAndFilmShowTime(
			@Param(value = "film_id") Integer film_id,
			@Param(value = "show_time") String show_time); // 根据电影id、放映时间查询放映计划编号
}
