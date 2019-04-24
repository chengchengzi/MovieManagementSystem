package com.ssm.service.impl;


import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ssm.dao.FilmHallInfoDAO;
import com.ssm.dao.SaleInfoDAO;
import com.ssm.dao.SeatShowPlanDAO;
import com.ssm.dao.ShowPlanDAO;
import com.ssm.pojo.FilmHallInfo;
import com.ssm.pojo.SaleInfo;
import com.ssm.pojo.SeatShowPlan;
import com.ssm.pojo.ShowPlan;
import com.ssm.service.SeatShowPlanService;

/**
 * 座位场次表的服务执行类
 * @author Administrator
 *
 */
@Service("seatShowPlanService")
public class SeatShowPlanServiceImpl implements SeatShowPlanService{

	@Resource
	private SeatShowPlanDAO seatShowPlanDAO;
	@Resource
	private SaleInfoDAO saleInfoDAO;
	@Resource
	private ShowPlanDAO showPlanDAO;
	@Resource
	private FilmHallInfoDAO filmHallInfoDAO;
	
	//根据放映计划编号查询 座位号
	public String[] querySeatShowPlanByShowPlanId(Integer show_plan_id) {
		
		String seatInit = "";  //初始座位字符串
		String seatOut = "";  //已售出字符串
		
		SeatShowPlan seatShowPlan= seatShowPlanDAO.querySeatShowPlanByShowPlanId(show_plan_id);
		String temp_seat = seatShowPlan.getTemp_seat();
		String sale_out_seat = seatShowPlan.getSale_out_seat();
		if(temp_seat != null){
			String[] s = temp_seat.split(",");  //处理座位字符串
			for(int i = 0; i < s.length;i++){	
				seatInit  += "'" + s[i] + "'" + ","; 
			}
			seatInit = seatInit.substring(0, seatInit.length()-1);
		}
		if(sale_out_seat!=null){
			String[] s = sale_out_seat.split(",");
			for(int i = 0; i < s.length;i++){	
				seatOut  += "'" + s[i] + "'" + ","; 
			}
			//seatOut = seatOut.substring(0, seatOut.length()-1);
		}
		
		String[] seatNew = {seatInit,seatOut};
		return seatNew;
	}

	//购票后保存座位信息
	public boolean saveSeat(String seat_selected,String seat_removeSelected,Integer show_plan_id) {
		String[] selected = seat_selected.split(",");
		String[] removeSelected = seat_removeSelected.split(",");
		
		String sale_out_seat_new = "";
		
		for(int i = 0; i < selected.length;i++){  //座位字符串去重
			for(int j = 0; j < removeSelected.length;j++){
				if(removeSelected[j].equals(selected[i])){
					selected[i] = "";
				}
			}
		}
		//去重后的selected[]就是最终要售出的座位字符串
		//检查拿到的最终要售出的座位字符串，如果数据库中已存在，则座位锁定失败且售出失败
		SeatShowPlan seatShowPlan = seatShowPlanDAO.querySeatShowPlanByShowPlanId(show_plan_id);
		String seat = seatShowPlan.getSale_out_seat();
		String[] sale_out_seat_old;
		if(seat != null){  //已售出座位字符串不为空
			sale_out_seat_old = seat.split(",");
			for(int i = 0;i < sale_out_seat_old.length;i++){
				for(int j = 0; j <selected.length;j++){
					if(selected[j].equals(sale_out_seat_old[i])){  //座位之前就已被售出，锁定失败
						return false;
					}
				}
			}
			//座位未被售出,拼接座位字符串
			for(int i = 0;i < sale_out_seat_old.length;i++){
				sale_out_seat_new += sale_out_seat_old[i] + ",";
			}
			for(int i = 0; i < selected.length;i++){  //最新售出的座位字符串
				sale_out_seat_new += selected[i] + ",";
			}
		}else{ //已售出座位字符串为空
			for(int i = 0; i < selected.length;i++){  //最新售出的座位字符串
				sale_out_seat_new += selected[i] + ",";
			}
		}
		boolean flag = this.seatShowPlanDAO.saveSeat(sale_out_seat_new, show_plan_id); 	//保存
		if(flag){  //保存成功
			//新增售票信息
			ShowPlan showPlan = showPlanDAO.queryShowPlanById(show_plan_id);
			
			Integer film_id = showPlan.getFilm_id();
			Date now = new Date(); //当前售票时间
			Integer film_hall_id = showPlan.getFilm_hall_id();
			Date sale_info_showtime = showPlan.getShow_time();
			float sale_info_price = showPlan.getFilm_price();
			
			FilmHallInfo filmHallInfo = filmHallInfoDAO.queryFilmHallByfilmHallId(film_hall_id); 
			String sale_info_type = filmHallInfo.getFilm_hall_type();
			
			for(int i = 0; i < selected.length;i++){
				if(selected[i]!=""){
					String[] xy = selected[i].split("_");
					String row = xy[0];  //座位行号
					String column = xy[1]; //座位列号
					String sale_info_location = row + "排" + column + "号" ;
					SaleInfo saleInfoNew = new SaleInfo();
					//int number = (int)saleInfoDAO.getSaleInfoCount();   //当前已存在的售票信息
					saleInfoNew.setSale_info_id(null);
					saleInfoNew.setSale_info_time(now);
					saleInfoNew.setFilm_id(film_id);
					saleInfoNew.setFilm_hall_id(film_hall_id);
					saleInfoNew.setSale_info_location(sale_info_location);
					saleInfoNew.setSale_info_showtime(sale_info_showtime);
					saleInfoNew.setSale_info_type(sale_info_type);
					saleInfoNew.setSale_info_price(sale_info_price);
					this.saleInfoDAO.insertSaleInfo(saleInfoNew);  //新增售票信息
			    }
			}
			return true;
		} 
		else{
			return false;
		}
	}

}
