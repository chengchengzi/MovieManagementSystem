package com.ssm.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ssm.pojo.TicketOffice;

/**
 * 票房统计的对外接口
 * 
 * @author Administrator
 * 
 */
public interface TicketOfficeDAO {
	public List<TicketOffice> queryAllByPage(
			@Param(value = "startPos") Integer startPos,
			@Param(value = "pageSize") Integer pageSize); // 分页查询

	public long getCount(); // 取得总记录数

	public TicketOffice queryTicketOfficeById(Integer ticket_office_id);// 根据id查询

	public boolean deleteTicketOfficeById(Integer ticket_office_id); // 单个删除

	public void deleteTicketOfficeByBatch(int[] ticket_office_ids); // 批量删除

	public long getCountByFilmIdAndOnTime(
			@Param(value = "film_id") Integer film_id); // 根据影片编号查询取得售票信息表当天的售票数量

	public double TotalPriceByFilmIdAndOnTime(
			@Param(value = "film_id") Integer film_id);// 根据影片编号查询取得售票信息表当天的总票房

	public String queryFilmNameByFilmId(
			@Param(value = "film_id") Integer film_id); // 根据影片编号查询影片名称

	public long getCountByFilmIdAndWeek(
			@Param(value = "film_id") Integer film_id); // 根据影片编号查询取得售票信息表本周的售票数量

	public double TotalPriceByFilmIdAndWeek(
			@Param(value = "film_id") Integer film_id);// 根据影片编号查询取得售票信息表本周的总票房

	public long getCountByFilmIdAndMonth(
			@Param(value = "film_id") Integer film_id); // 根据影片编号查询取得售票信息表本月的售票数量

	public double TotalPriceByFilmIdAndMonth(
			@Param(value = "film_id") Integer film_id);// 根据影片编号查询取得售票信息表本月的总票房

	public void insertTicketOffice(TicketOffice ticketOffice);// 新增一条统计数据

	public long getCountByRange(@Param(value = "film_id") Integer film_id,
			@Param(value = "from_time") Date from_time,
			@Param(value = "to_time") Date to_time);// 根据日期范围查询售票信息表的记录数
	
	public double TotalPriceByRange(@Param(value = "film_id") Integer film_id,
			@Param(value = "from_time") Date from_time,
			@Param(value = "to_time") Date to_time);// 根据日期范围查询售票信息表的总票房

}
