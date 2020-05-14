/**   
 * @Title: PrintSalesOrder.java 
 * @Package com.ydz.service.report 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月15日 下午2:01:06 
 * @version  
 */
package com.ydz.service.report;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.ydz.entity.Page;
import com.ydz.entity.advert.SalesOrder;
import com.ydz.entity.common.City;
import com.ydz.entity.common.Country;
import com.ydz.entity.common.Province;
import com.ydz.entity.print.PrintSalesOrder;
import com.ydz.entity.system.PartnerVO;
import com.ydz.service.advert.SalesOrderService;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.PartnerService;
import com.ydz.util.BeanutilsCopy;
import com.ydz.util.Const;
import com.ydz.util.DateStyle;
import com.ydz.util.DateUtil;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.util.redis.RedisUtil;
import com.ydz.vo.CompanyVO;

import org.springframework.stereotype.Service;

/** 
 * @ClassName: PrintSalesOrder 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月15日 下午2:01:06 
 * 
 */
@Service
public class PrintSalesOrderService {
	
	@Resource
	private RedisUtil redisUtil;
	@Resource
	private SalesOrderService salesOrderService;
	@Resource
	private PartnerService partnerService;
	@Resource
	private CompanyService companyService;
	
	public List<PrintSalesOrder> loadSalesOrder(String dsName,String datasetName,Map<String,Object> parameters) throws Exception{
		List<PrintSalesOrder> orders = new ArrayList<PrintSalesOrder>();
		if(parameters.get("salesNo")==null
				||parameters.get("comKey")==null){
			return orders;
		}
		Page page = new Page();
		PageData pdData = new PageData();
		String salesNoIn = Tools.strSqlIn((String)parameters.get("salesNo"));
		String comKey = (String)parameters.get("comKey");
		pdData.put("comKey", comKey);
		pdData.put("salesNoIn", salesNoIn);
   	 	page.setShowCount(500);
        page.setCurrentPage(1);
        page.setPd(pdData);
		List<SalesOrder> soList = salesOrderService.listPageSalesOrder(page);
		if(soList==null||soList.size()==0){
			return null;
		}
		CompanyVO company = companyService.selectOrderDetailCompany(soList.get(0).getComKey(),null); //详情页底部信息
		PrintSalesOrder pso = null;
		for (SalesOrder salesOrder : soList) {
			pso = new PrintSalesOrder();
			BeanutilsCopy.apacheCopyProperties(pso,salesOrder);
			if (StringUtil.isNotEmpty(pso.getPurchaseNo())) {
				pso.setPurchaseNoTitle("采购订单："+pso.getPurchaseNo());
			}
			pso.setComName(company.getComName());
			pso.setSalesNoTitle("销售订单："+pso.getSalesNo());
			pdData.put("partnerKey", salesOrder.getPartnerKey());
			pdData.put("myComKey", comKey);
			PartnerVO partnerVO = partnerService.findPartnerByCPKey(pdData);
			String provinceName = null;
			String cityName = null;
			String countryName = null;
			if(StringUtil.isNotEmpty(partnerVO.getPartnerProvince())){
				provinceName = ((Province)redisUtil.get(Const.PROVINCE_REDIS+partnerVO.getPartnerProvince())).getProvinceName();
			}
			if (StringUtil.isNotEmpty(partnerVO.getPartnerCity())) {
				cityName = ((City)redisUtil.get(Const.CITY_REDIS+partnerVO.getPartnerCity())).getCityName();
			}
			if (StringUtil.isNotEmpty(partnerVO.getPartnerCountry())) {
				countryName = ((Country)redisUtil.get(Const.COUNTRY_REDIS+partnerVO.getPartnerCountry())).getCountryName();
			}
			if (StringUtil.isEmpty(provinceName)
					&&StringUtil.isEmpty(cityName)
					&&StringUtil.isEmpty(countryName)) {
				pso.setPartnerAddress("");
			}else {
				pso.setPartnerAddress("客户地址："+provinceName+cityName+countryName+partnerVO.getPartnerAddress());
			}
			
			pso.setCreateTimeFormat(DateUtil.DateToString(salesOrder.getCreateTime(), DateStyle.YYYY_MM_DD_HH_MM_SS));
			
			String provinceName2 = " -";
			String cityName2 = " -";
			String countryName2 = " - ";
			if (company==null) {
				return orders;
			}
			if(StringUtil.isNotEmpty(company.getComProvince())){
				provinceName2 = ((Province)redisUtil.get(Const.PROVINCE_REDIS+company.getComProvince())).getProvinceName();
			}
			if (StringUtil.isEmpty(company.getComCity())) {
				cityName2 = ((City)redisUtil.get(Const.CITY_REDIS+company.getComCountry())).getCityName();
			}
			if (StringUtil.isEmpty(company.getComCountry())) {
				countryName2 = ((Country)redisUtil.get(Const.COUNTRY_REDIS+company.getComCountry())).getCountryName();
			}
			String footInfo = "公司电话："+company.getComTel()+"  公司QQ："+company.getComQQ()+"  联系人："+company.getRealName()
					+"  手机："+company.getUserId()+"  通讯地址："+provinceName2+cityName2+countryName2+company.getComAddress();
			pso.setFullFootInfo(footInfo);
			orders.add(pso);
		}
		return orders;
	}

}
