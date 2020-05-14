package com.ydz.util;

import sun.tools.tree.ThisExpression;

import com.ydz.entity.ResultMap;
import com.ydz.enums.SystemEnum;

/** 
 * @ClassName: ResultUtil 
 * @Description: 统计返回结果的工具类
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2017年6月11日 下午1:00:37 
 * 
 */
public class ResultUtil {
	
	private static ResultMap successApp(String msg,Object object,String token,String code){
		ResultMap result = new ResultMap();
		result.setMsg(msg);
		result.setData(object);
		result.setToken(token);
		result.setCode(new Integer(code));
		return result;
	}
	public static ResultMap success(String msg,Object object,String code){
		ResultMap result = new ResultMap();
		result.setData(object);
		result.setCode(new Integer(code));
		if (StringUtil.isEmpty(msg)) {
			switch (code) {
			case "1":
				msg = SystemEnum.RETURN_INFO_SUCCESS_EXECUTE.getDesc();
				break;
			case "2":
				msg = SystemEnum.RETURN_INFO_SUCCESS_SAVE.getDesc();
				break;
			case "3":
				msg = SystemEnum.RETURN_INFO_SUCCESS_UPDATE.getDesc();
				break;
			case "4":
				msg = SystemEnum.RETURN_INFO_SUCCESS_DELETE.getDesc();
				break;
			case "T":
				msg = SystemEnum.RETURN_INFO_SUCCESS_LOGOUT.getDesc();
				break;
			default:
				break;
			}
		}
		result.setMsg(msg);
		return result;
	}
	
	public static ResultMap successMsg(String msg){
		return success(msg, null,"1");
	}
	
	public static ResultMap appLogin(String msg,String token){
		return successApp(msg, null, token,SystemEnum.RETURN_INFO_SUCCESS_LOGIN.getCode());
	}
	public static ResultMap appLogout(String msg,String token){
		return successApp(msg, null, token,SystemEnum.RETURN_INFO_SUCCESS_LOGOUT.getCode());
	}
	
	
	public static ResultMap successQuery(Object data){
		return success(SystemEnum.RETURN_INFO_SUCCESS_QUERY.getDesc(), data, SystemEnum.RETURN_INFO_SUCCESS_QUERY.getCode());
	}
	
	public static ResultMap successSave(){
		return success(SystemEnum.RETURN_INFO_SUCCESS_SAVE.getDesc(), null, SystemEnum.RETURN_INFO_SUCCESS_SAVE.getCode());
	}
	public static ResultMap successUpdate(){
		return success(SystemEnum.RETURN_INFO_SUCCESS_UPDATE.getDesc(), null, SystemEnum.RETURN_INFO_SUCCESS_UPDATE.getCode());
	}
	public static ResultMap successDelete(){
		return success(SystemEnum.RETURN_INFO_SUCCESS_DELETE.getDesc(), null, SystemEnum.RETURN_INFO_SUCCESS_DELETE.getCode());
	}
	public static ResultMap successExec(){
		return success(SystemEnum.RETURN_INFO_SUCCESS_EXECUTE.getDesc(), null, SystemEnum.RETURN_INFO_SUCCESS_EXECUTE.getCode());
	}
	
	public static ResultMap error(int code,String msg){
		ResultMap result = new ResultMap();
		result.setCode(code);
		result.setMsg(msg);
		return result;
	}
	public static ResultMap error(String code,String msg){
		ResultMap result = new ResultMap();
		result.setCode(new Integer(code));
		result.setMsg(msg);
		return result;
	}
	
	public static ResultMap error(String msg){
		ResultMap result = ResultUtil.error(SystemEnum.RETURN_INFO_ERROR.getCode(), msg);
		return result;
	}
	
	public static ResultMap getResultMap(){
		return new ResultMap();
	}
}