package com.ssm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ssm.pojo.SaleInfo;

/**
 * 售票信息的对外接口
 * @author Administrator
 *
 */
public interface SaleInfoDAO {
	
	//分页查询售票信息
	public List<SaleInfo> selectSaleInfoByPage(@Param(value="startPos")Integer startPos, @Param(value="pageSize")Integer pageSize);
	
	public long getSaleInfoCount(); //取得影厅总记录数
	
	public SaleInfo querySaleInfoById(Integer sale_info_id); //根据id查询售票信息
	
	public boolean deleteSaleInfoById(Integer sale_info_id); //单个删除
	
	public void deleteSaleInfoByBatch(int[] sale_info_ids); //批量删除
	
	public void insertSaleInfo(SaleInfo salInfo);   //新增售票信息
}
