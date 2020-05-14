package com.ydz.util;

/**
 * 字符串相关方法
 *
 */
public class StringUtil {

	/**
	 * 将以逗号分隔的字符串转换成字符串数组
	 * @param valStr
	 * @return String[]
	 */
	public static String[] StrList(String valStr){
	    int i = 0;
	    String TempStr = valStr;
	    String[] returnStr = new String[valStr.length() + 1 - TempStr.replace(",", "").length()];
	    valStr = valStr + ",";
	    while (valStr.indexOf(',') > 0)
	    {
	        returnStr[i] = valStr.substring(0, valStr.indexOf(','));
	        valStr = valStr.substring(valStr.indexOf(',')+1 , valStr.length());
	        
	        i++;
	    }
	    return returnStr;
	}
	
	public static boolean isEmpty(String str){
		if(null == str || "".equals(str)){
			return true;
		}else{
			return false;
		}
	}
	
	public static boolean isNotEmpty(String str){
		if(null != str && !"".equals(str)){
			return true;
		}else{
			return false;
		}
	}
	
	/** 字符串填充 0 **/
	public static String fillZero(String str,int zeroCount){
		if(StringUtil.isNotEmpty(str)){
			for (int i = 0; i < zeroCount; i++) {
				str="0"+str;
			}
		}
		return str;
	}
	
	/**
	 * 判断是否被SQL注入攻击
	 * @param str
	 * @return
	 */
	public static boolean sql_inj(String str){ 
		String inj_str = "'|and|exec|insert|select|delete|update|count|*|%|chr|mid|master|truncate|char|declare|;|or|-|+|,";//这里的东西还可以自己添加 
		String[] inj_stra=inj_str.split("\\|"); 
		for (int i=0 ; i < inj_stra.length ; i++ ){ 
			if (str.indexOf(inj_stra[i])>=0){ 
				return true; 
			} 
		}
		return false; 
	} 
	
	/**
	 * 
	* @Title: formatMenuUrl 
	* @param menuUrl
	* @return
	* @return String
	* @throws 
	* @Description: 处理菜单的url，返回所需要的页面值
	 */
	public static String formatMenuUrl(String menuUrl){
		return StringUtil.isNotEmpty(menuUrl)?menuUrl.substring(0, menuUrl.indexOf("_"))+"/"+menuUrl.substring(menuUrl.indexOf("_")+1,menuUrl.length()):null;
	}
	
	/**
	 * 
	 * @Title: StrListByPattern 
	 * @param valStr 需要处理的字符串
	 * @param pattern 字符串中的符号
	 * @return
	 * @return String[]
	 * @throws 
	 * @Description: 将指定符号分隔的字符串转为字符串数组
	 */
	public static String[] StrListByPattern(String valStr,String pattern){
	    int i = 0;
	    String TempStr = valStr;
	    String[] returnStr = new String[valStr.length() + 1 - TempStr.replace(pattern, "").length()];
	    valStr = valStr + pattern;
	    while (valStr.indexOf(pattern) > 0)
	    {
	        returnStr[i] = valStr.substring(0, valStr.indexOf(pattern));
	        valStr = valStr.substring(valStr.indexOf(pattern)+1 , valStr.length());
	        
	        i++;
	    }
	    return returnStr;
	}
	
	public static void main(String[] args) {
		String str = "234,345345,234234";
		System.out.println(StringUtil.StrListByPattern(str,",")[0]);
	}
}
