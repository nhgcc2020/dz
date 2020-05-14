package com.ydz.service.advert;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ydz.entity.common.Dict;
import com.ydz.enums.OrderEnum;
import com.ydz.service.common.CommonService;
import com.ydz.util.PageData;
import com.ydz.util.StringUtil;
import com.ydz.util.Tools;
import com.ydz.vo.BusinessTypeVO;

/** 
 * @ClassName: StatusService 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年8月12日 下午7:55:49 
 * 
 */
@Service("orderConfigService")
public class OrderConfigService {
	
	@Resource(name = "commonService")
	private CommonService commonService;
	
	/**
	 * 
	* @Title: getOrderStatus 
	* @param @param key
	* @param @return
	* @return String
	* @throws 
	* @Description: 获取订单状态值描述
	 */
	public String formatOrderStatus(String orderStatus){
		String orderStatusDesc = null;
		
		switch (orderStatus) {
		case "01":
			orderStatusDesc = OrderEnum.STATUS_DAIJIJIA.getDesc();
			break;
		case "02":
			orderStatusDesc = OrderEnum.STATUS_DAIDUIFANGSHOUHUO.getDesc();
			break;
		case "03":
			orderStatusDesc = OrderEnum.STATUS_DAISHOUHUO.getDesc();
			break;
		case "04":
			orderStatusDesc = OrderEnum.STATUS_DAIDUIZHANG.getDesc();
			break;
		case "05":
			orderStatusDesc = OrderEnum.STATUS_YIDUIZHANG.getDesc();
			break;
		case "06":
			orderStatusDesc = "无状态";
			break;
		case "07":
			orderStatusDesc = OrderEnum.STATUS_DAISHOUKUAN.getDesc();
			break;
		case "08":
			orderStatusDesc = OrderEnum.STATUS_YISHOUKUAN.getDesc();
			break;
		case "09":
			orderStatusDesc = OrderEnum.STATUS_DAIFUKUAN.getDesc();
			break;
		case "10":
			orderStatusDesc = OrderEnum.STATUS_YIFUKUAN.getDesc();
			break;
		case "CC":
			orderStatusDesc = OrderEnum.STATUS_CANCEL.getDesc();
			break;

		default:
			orderStatusDesc = "无状态";
			break;
		}
		return orderStatusDesc;
		
	}
	
	public String formatPriceWay(String priceWay){
		if (StringUtil.isEmpty(priceWay)) {
			return null;
		}
		String priceWayDesc = "";
		switch (priceWay) {
		case "01":
			priceWayDesc = OrderEnum.PRICE_WAY_AREA.getDesc();
			break;
		case "02":
			priceWayDesc = OrderEnum.PRICE_WAY_QUANTITY.getDesc();
			break;
		case "03":
			priceWayDesc = OrderEnum.PRICE_WAY_LENGTH.getDesc();
			break;
		case "04":
			priceWayDesc = OrderEnum.PRICE_WAY_WIDTH.getDesc();
			break;
		case "05":
			priceWayDesc = OrderEnum.PRICE_WAY_MAXVALUE.getDesc();
			break;
		case "06":
			priceWayDesc = OrderEnum.PRICE_WAY_MAXVALUE_SQUARE.getDesc();
			break;
		case "07":
			priceWayDesc = OrderEnum.PRICE_WAY_PERIMETER.getDesc();
			break;

		default:
			break;
		}
		
		return priceWayDesc;
	}
	
	/**
	 * 
	* @Title: listBusinessTypeVO 
	* @param @param industryId
	* @param @return
	* @return List<OrderTypeVO>
	* @throws 
	* @Description: 根据行业获取订单业务类型及对应的订单明细格式列
	 */
	public List<BusinessTypeVO> listBusinessTypeVO(String industryId){
		List<BusinessTypeVO> businessTypeVOs = new ArrayList<BusinessTypeVO>();
		String keyString = "BUSINESS_TYPE_"+industryId;
		PageData pd = new PageData();
		pd.put("pKey", keyString);
		List<Dict> dicts = commonService.selectListDictValue(pd);
		for(Dict dict : dicts){
			BusinessTypeVO btvo = new BusinessTypeVO();
			btvo.setBusinessType(dict.getDictKey().substring(dict.getDictKey().length()-2, dict.getDictKey().length()));
			btvo.setBusinessTypeDesc(dict.getDictValue());
			btvo.setBusinessTypeCols(commonService.getDictValue(dict.getDictKey()+"_COLS"));
			btvo.setBusinessTypeColsList(Tools.strArray2List(Tools.str2StrArray(commonService.getDictValue(dict.getDictKey()+"_COLS"))));
			businessTypeVOs.add(btvo);
		}
		return businessTypeVOs;
	}
	
	/**
	 * 
	* @Title: getOneBusinessTypeVO 
	* @param @param industryId
	* @param @param businessType
	* @param @return
	* @return BusinessTypeVO
	* @throws 
	* @Description: 传入行业及业务类型，构造业务类型VO
	 */
	public BusinessTypeVO getOneBusinessTypeVO(String industryId,String businessType){
		String keyString = "BUSINESS_TYPE_"+industryId+businessType;
		PageData pd = new PageData();
		pd.put("dictKey", keyString);
		
		BusinessTypeVO btvo = new BusinessTypeVO();
		btvo.setBusinessType(keyString);
		btvo.setBusinessTypeDesc(commonService.getDictValue(keyString));
		btvo.setBusinessTypeCols(commonService.getDictValue(keyString+"_COLS"));
		btvo.setBusinessTypeColsList(Tools.strArray2List(Tools.str2StrArray(commonService.getDictValue(keyString+"_COLS"))));
		return btvo;
	}
}
