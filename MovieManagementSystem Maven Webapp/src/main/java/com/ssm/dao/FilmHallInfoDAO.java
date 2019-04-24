package com.ssm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ssm.pojo.FilmHallInfo;

/**
 * 影厅信息的对外接口
 * @author Administrator
 *
 */
public interface FilmHallInfoDAO {
	
	public boolean addFilmHall(FilmHallInfo filmHallInfo); //新增影厅
	
	public boolean deleteFilmHallById(Integer filmHallId); //单个删除影厅
	
	public void deleteFilmHallByBatch(int[] filmHallIds); //批量删除影厅
	
	public FilmHallInfo queryFilmHallByfilmHallId(Integer filmHallId);//根据影厅的id查询影厅信息
	
	public List<FilmHallInfo> queryAllFilmHall(); //查询所有影厅列表
	
	public boolean updateFilmHall(FilmHallInfo filmHallInfo);  //修改影厅信息
	
	/**
	 * 使用注解方式传入多个参数,分页查询影厅
	 * @return
	 */
	public List<FilmHallInfo> selectFilmHallByPage(@Param(value="startPos")Integer startPos, @Param(value="pageSize")Integer pageSize);
	
	public long getFilmHallCount(); //取得影厅总记录数
}
