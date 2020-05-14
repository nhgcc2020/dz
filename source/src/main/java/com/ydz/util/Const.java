package com.ydz.util;

import org.springframework.context.ApplicationContext;

import com.opensymphony.oscache.extra.StatisticListenerImpl;
/**
 * 项目名称：
 * @author yiduizhang
 * 
*/
public class Const {
	public static final String SESSION_WECHAT_SIGN = "sessionWechatSign";//
	public static final String SESSION_WECHAT = "sessionWechat";//
	public static final String SESSION_INVITE = "sessionInvite";//

	public static final String SESSION_VERIFICATION_CODE = "sessionVerCode";//
	public static final String SESSION_VERIFICATION_CODE_NEW = "sessionVerCodeNew";//
	
	public static final String SESSION_APP_USER = "sessionAppUser";

	public static final String SESSION_SECURITY_CODE = "sessionSecCode";
	public static final String SESSION_USER = "sessionUser";
	public static final String SESSION_ROLE_RIGHTS = "sessionRoleRights";
	public static final String SESSION_menuList = "menuList";			//当前菜单
	public static final String SESSION_allmenuList = "allmenuList";		//全部菜单
	public static final String SESSION_QX = "QX";
	public static final String SESSION_userpds = "userpds";			
	public static final String SESSION_USERROL = "USERROL";				//用户对象
	public static final String SESSION_USERNAME = "USERNAME";			//用户名
	public static final String TRUE = "T";
	public static final String FALSE = "F";
	public static final String LOGIN = "/login_toLogin.do";				//登录地址
	public static final String SYSNAME = "admin/config/SYSNAME.txt";	//系统名称路径
	public static final String PAGE	= "admin/config/PAGE.txt";			//分页条数配置路径
	public static final String EMAIL = "admin/config/EMAIL.txt";		//邮箱服务器配置路径
	public static final String SMS1 = "admin/config/SMS1.txt";			//短信账户配置路径1
	public static final String SMS2 = "admin/config/SMS2.txt";			//短信账户配置路径2
	public static final String FWATERM = "admin/config/FWATERM.txt";	//文字水印配置路径
	public static final String IWATERM = "admin/config/IWATERM.txt";	//图片水印配置路径
	public static final String WEIXIN	= "admin/config/WEIXIN.txt";	//微信配置路径
	public static final String FILEPATHIMG = "uploadFiles/uploadImgs/";	//图片上传路径
	public static final String FILEPATHFILE = "uploadFiles/file/";		//文件上传路径
	public static final String FILEPATHTWODIMENSIONCODE = "uploadFiles/twoDimensionCode/"; //二维码存放路径
	public static final String NO_INTERCEPTOR_PATH = ".*/((login)|(logout)|(code)|(app)|(weixin)|(static)|(main)|(websocket)).*";	//不对匹配该值的访问路径拦截（正则）
	
	public final static String ALGORITHMNAME = "SHA-256"; 
	public final static int HASHITERATIONS = 1024;
	
	public final static int SUCCESS_CODE = 1;
	public final static int ERROR_CODE = 0;
	
	public static ApplicationContext WEB_APP_CONTEXT = null; //该值会在web容器启动时由WebAppContextListener初始化
	
	/** 分页记录数 **/
	public static int PAGE_SIZE = 30;
	public static int PAGE_SIZE_DETAIL = 1000;
	
	/**
	 * APP Constants
	 */
	//app注册接口_请求协议参数)
	public static final String[] APP_REGISTERED_PARAM_ARRAY = new String[]{"countries","uname","passwd","title","full_name","company_name","countries_code","area_code","telephone","mobile"};
	public static final String[] APP_REGISTERED_VALUE_ARRAY = new String[]{"国籍","邮箱帐号","密码","称谓","名称","公司名称","国家编号","区号","电话","手机号"};
	
	//app根据用户名获取会员信息接口_请求协议中的参数
	public static final String[] APP_GETAPPUSER_PARAM_ARRAY = new String[]{"USERNAME"};
	public static final String[] APP_GETAPPUSER_VALUE_ARRAY = new String[]{"用户名"};
	
	/** 通用行业 **/
	public static final String INDUSTRY_GENERAL = "00";
	

	/**
	 * 系统状态
	 */
	

//======================== 角色权限相关
	
	/** 角色值  ADMIN 管理员 **/
	public static final String ROLE_ADMIN = "ADMIN";
	/** 角色值  001 老板 **/
	public static final String ROLE_BOSS = "001";
	/** 角色值  002 合伙人 **/
	public static final String ROLE_PARTNER = "002";
	
	public static final String ROLE_MENU_EXCLUDE = "ROLE_MENU_EXCLUDE_";
	
	public static final String MENU_ID_INIT = "MENU_ID_INIT_";
	
//======================== redis缓存相关	
	
	public static final String REDIS_APPTOKEN = "APP_TOKEN_";
	
	/** 公司角色权限，在角色权限设置中 **/
	public static final String REDIS_ROLEPREMISSION = "COM_ROLE_PERMISSION_";
	/** 角色菜单主页面查看 **/
	public static final String REDIS_ROLE_MENU_V = "ROLE_MENU_V";
	/** 角色菜单权限设置页面 **/
	public static final String REDIS_ROLE_MENU_P = "ROLE_MENU_P";
	/** 公司角色列表 **/
	public static final String REDIS_ROLE_COM = "ROLE_COM_";
	/** 行业角色的权限初始化 **/
	public static final String REDIS_INIT_PERMISSION = "PERMISSION_INIT_";
	/** 行业版本菜单初始化 **/
	public static final String REDIS_INIT_MENU = "MENU_INIT_";
	/** 行业角色初始化 **/
	public static final String REDIS_INIT_ROLE = "ROLE_INIT_";
	/** 行业部门初始化 **/
	public static final String REDIS_INIT_DEPT = "DEPT_INIT_";
	/** 产品服务定价初始化 **/
	public static final String REDIS_INIT_PRODUCTSERVICE_PRICING = "PROSERVICE_PRICING_INIT_";
	/** 公司产品服务定价 **/
	public static final String REDIS_PRODUCTSERVICE_PRICING = "PROSERVICE_PRICING_";
	/** 公司产品服务定价下拉框 **/
	public static final String REDIS_PRODUCTSERVICE_DROPDOWN = "PROSERVICE_PRICING_DROPDOWN_";
	
	/** 服务定价的计价方式 **/
	public static final String REDIS_GLOBALCONFIG_PRICEWAY = "PRICEWAY_";
	/** 服务定价的计价单位 **/
	public static final String REDIS_GLOBALCONFIG_PRICEUNIT = "PRICEUNIT_";
	
	/** redis小时缓存 默认5小时**/
	public static final int REDIS_INTERVAL_HOUR = 5;
	/** redis日缓存 默认3天**/
	public static final int REDIS_INTERVAL_DAY = 3;
	/** redis月缓存 默认1个月**/
	public static final int REDIS_INTERVAL_MONTH = 1;
	
	public static final String PROVINCE_REDIS = "PROVINCE_";
	public static final String CITY_REDIS = "CITY_";
	public static final String COUNTRY_REDIS = "COUNTRY_";
	
	public static final String BIND_WECHAT = "1";
	public static final String BIND_QQ = "2";
	public static final String BIND_ALIPAY = "3";

	// 系统信息
	
	public static final String SYS_AUTO_MESSAGE = "自动生成";
	
	//公司配置
	public static final String COMPANY_CONFIG_ASSIGN_DESIGN = "ASSIGN_DESIGN";
	public static final String COMPANY_CONFIG_ASSIGN_WORKING = "ASSIGN_WORKING";
	public static final String COMPANY_CONFIG_WORKING_PROCEDURE = "WORKING_PROCEDURE";
	public static final String COMPANY_CONFIG_RECHARGE = "RECHARGE"; 
	
	public static final String COMPANY_SETTING_CLASS_PREFIX_STRING = "EXPENSE_";
	

	
}
