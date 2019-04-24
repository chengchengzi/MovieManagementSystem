package com.ssm.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.ssm.dao.SaleInfoDAO;
import com.ssm.dao.SeatShowPlanDAO;
import com.ssm.dao.ShowPlanDAO;
import com.ssm.pojo.SaleInfo;
import com.ssm.pojo.SeatShowPlan;
import com.ssm.service.SaleInfoService;
import com.ssm.utils.Page;

/**
 * 售票信息的服务接口执行类
 * @author Administrator
 *
 */
@Service("saleInfoService")
public class SaleInfoServiceImpl implements SaleInfoService{

	@Resource
	private SaleInfoDAO saleInfoDAO;
	@Resource
	private ShowPlanDAO showPlanDAO;
	@Resource
	private SeatShowPlanDAO seatShowPlanDAO;
	
	//分页查询所有的影厅信息
	public void showFilmHallByPage(HttpServletRequest request, Model model) {
		String pageNow = request.getParameter("pageNow");
		
		Page page = null;
		
		List<SaleInfo> listSaleInfo = new ArrayList<SaleInfo>();
		
		int totalCount = (int)saleInfoDAO.getSaleInfoCount();
		
		if(pageNow != null){
			page = new Page(totalCount, Integer.parseInt(pageNow));
			listSaleInfo = this.saleInfoDAO.selectSaleInfoByPage(page.getStartPos(), page.getPageSize());
		}else{
			page = new Page(totalCount, 1);
			listSaleInfo = this.saleInfoDAO.selectSaleInfoByPage(page.getStartPos(), page.getPageSize());
		}
		 model.addAttribute("listSaleInfo", listSaleInfo);  
		 model.addAttribute("page", page);  
	}

	//退票同时修改座位信息
	public boolean deleteSaleInfo(Integer sale_info_id) {
		SaleInfo saleInfo = saleInfoDAO.querySaleInfoById(sale_info_id);
		if(saleInfo != null){ //删除的电影票存在
			boolean flag = saleInfoDAO.deleteSaleInfoById(sale_info_id);
			if(flag){   //同步更新座位信息
				Integer film_id = saleInfo.getFilm_id();
				Date sale_info_showtime = saleInfo.getSale_info_showtime();
				SimpleDateFormat df= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
				String show_time = df.format(sale_info_showtime);
				Integer show_plan_id = showPlanDAO.queryShowPlanByFilmIdAndFilmShowTime(film_id, show_time);
				if(show_plan_id != null){
					String sale_info_location = saleInfo.getSale_info_location();
					String[] x = sale_info_location.split("排");
					String[] y = x[1].split("号");
					String xy = x[0] + "_" + y[0];
					SeatShowPlan seatShowPlan = seatShowPlanDAO.querySeatShowPlanByShowPlanId(show_plan_id);
					String seat = seatShowPlan.getSale_out_seat();
					String[] sale_out_seat_old = null;
					String sale_out_seat_new = "";
					if(seat != null){  //已售出座位字符串不为空
						sale_out_seat_old = seat.split(",");
						for(int i = 0; i < sale_out_seat_old.length; i++){
							if(xy.equals(sale_out_seat_old[i])){
								sale_out_seat_old[i] = "";
							}
						}
					}
					for(int i = 0;i < sale_out_seat_old.length;i++){
						sale_out_seat_new += sale_out_seat_old[i] + ",";
					}
					boolean flag_upateSeat = this.seatShowPlanDAO.saveSeat(sale_out_seat_new, show_plan_id); 	//保存更新后的座位信息
					if(flag_upateSeat)
						return true;
					else
						return false;
				}
				return true;  //删除成功
			}else{
				return false;  //删除失败
			}
		}
		return false;  //删除的电影票不存在
	}

	//批量删除
	public void deleteBatchSaleInfo(int[] sale_info_ids) {
		//saleInfoDAO.deleteSaleInfoByBatch(sale_info_ids);
		for(int i = 0; i < sale_info_ids.length;i++){
			SaleInfo saleInfo = saleInfoDAO.querySaleInfoById(sale_info_ids[i]);
			if(saleInfo != null){ //删除的电影票存在
				boolean flag = saleInfoDAO.deleteSaleInfoById(sale_info_ids[i]);
				if(flag){   //同步更新座位信息
					Integer film_id = saleInfo.getFilm_id();
					Date sale_info_showtime = saleInfo.getSale_info_showtime();
					SimpleDateFormat df= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
					String show_time = df.format(sale_info_showtime);
					Integer show_plan_id = showPlanDAO.queryShowPlanByFilmIdAndFilmShowTime(film_id, show_time);
					if(show_plan_id != null){
						String sale_info_location = saleInfo.getSale_info_location();
						String[] x = sale_info_location.split("排");
						String[] y = x[1].split("号");
						String xy = x[0] + "_" + y[0];
						SeatShowPlan seatShowPlan = seatShowPlanDAO.querySeatShowPlanByShowPlanId(show_plan_id);
						String seat = seatShowPlan.getSale_out_seat();
						String[] sale_out_seat_old = null;
						String sale_out_seat_new = "";
						if(seat != null){  //已售出座位字符串不为空
							sale_out_seat_old = seat.split(",");
							for(int j = 0; j < sale_out_seat_old.length; j++){
								if(xy.equals(sale_out_seat_old[j])){
									sale_out_seat_old[j] = "";
								}
							}
						}
						for(int k = 0;k < sale_out_seat_old.length;k++){
							sale_out_seat_new += sale_out_seat_old[k] + ",";
						}
						this.seatShowPlanDAO.saveSeat(sale_out_seat_new, show_plan_id); 	//保存更新后的座位信息
					}
				}
			}
		}
	}

	//根据id进行查找
	public boolean querySaleInfoById(Integer sale_info_id, Model model) {
		SaleInfo saleInfo = saleInfoDAO.querySaleInfoById(sale_info_id);
		if(saleInfo!=null){ //查询的影厅存在  
			model.addAttribute("listSale",saleInfo);
				return true;
			}
			return false;
	}

}
