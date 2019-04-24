package com.ssm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ssm.pojo.FilmInfo;

/**
 * 影片信息的对外接口
 * @author Administrator
 *
 */
public interface FilmInfoDAO {
	
	//分页查询
	public List<FilmInfo> selectFilmInfoByPage(@Param(value="startPos")Integer startPos, @Param(value="pageSize")Integer pageSize);
	
	public long getFilmInfoCount(); //取得影厅总记录数
	
	public FilmInfo queryFilmInfoById(Integer filmId);//根据影片的id查询影片信息
	
	public boolean addFilmInfo(FilmInfo filmInfo); //新增影片
	
	public boolean deleteFilmInfoById(Integer filmId); //单个删除影片
	
	public void deleteFilmInfoByBatch(int[] filmHallIds); //批量删除影片
	
	public List<FilmInfo> fuzzySelectFilmInfoByName(@Param(value="film_name")String name); //根据员工姓名模糊查询
	
	public boolean updateFilmInfo(FilmInfo filmInfo);  //修改影片信息
	
	public List<FilmInfo> queryAllFilmInfo(); //查询所有影片信息
}
