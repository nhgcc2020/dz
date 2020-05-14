/**
 * 
 */
package com.ydz.util.sys;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;
import java.util.regex.Pattern;

import com.ydz.util.StringUtil;

/** 
 * @ClassName: CodeBuilderUtil 
 * @author Bruce 赵石磊 4stones@yiduizhang.com
 * @date 2016年5月29日 下午6:31:52 
 * @Description: 用于生成系统中所需要的各种编码
 *  
 */
public class CodeBuilderUtil {
	private static CodeBuilderUtil codeUtil = new CodeBuilderUtil();
	private CodeBuilderUtil(){}
	
	public static CodeBuilderUtil getInstance(){
		return codeUtil;
	}
	
	/**
	 * 
	* @Title: getAnyId 
	* @param @param length
	* @param @return
	* @return String
	* @throws 
	* @Description: 根据传入的长度生成随机ID码，返回字符串型编码，最大不超过10位
	*
	 */
    public String getAnyId(int length){
    	return Long.toString(this.getRandomNum(length));
    }
    
    /**
     * 
    * @Title: getRandomNum 
    * @param @param length
    * @param @return
    * @return int
    * @throws 
    * @Description: 根据指定长度生成随机数最大不超过10位
    *
     */
    private long getRandomNum(int length){
    	return (long)((Math.random()*9+1)*Math.pow(10, length-1));
    }
	
	/**
	 * 
	* @Title: getCompanyCode
	* @param @return
	* @return String
	* @throws 
	* @Description: 生成企业对账号
	* 1）6位数 必须带有字母和数字 字母大写  
	* 2）剔除掉数字中的3和4  以及英文字母O和I，避免o和0相像,I和1相像
    * 3）首位符号不能为0
    * 4）剔除 2B SB
	*
	 */
	public String getCompanyCode(){
		String companyCode = "";
		boolean flag = false;
		while(!flag){
			companyCode = this.getStringRandom(6,false).toUpperCase();
			if(companyCode.indexOf("2B") == -1 && companyCode.indexOf("SB") == -1){
				flag = true;
			}
		}
		return companyCode;
	}
	
	/**
	 * 
	* @Title: getCompanyInvitationCode 
	* @param @return
	* @return String
	* @throws 
	* @Description: 生成公司内部邀请码 10位
	*
	 */
	public String getCompanyInvitationCode(){
		return this.getStringRandom(10,true).toUpperCase();
	}
	
	/**
	 * 
	* @Title: smsRandonCode 
	* @param @param length 短信验证码长度
	* @param @return
	* @return String
	* @throws 
	* @Description: 根据传入的长度参数，生成指定长度的随机短信验证码，最大不超过10位
	*
	 */
	public long getSmsRandomCode(int length){
		return this.getRandomNum(length);
	}
	
	/**
	 * 
	* @Title: getCouponCode 
	* @param @param length 验证码长度
	* @param @return
	* @return String
	* @throws 
	* @Description: 根据传入的长度参数，生成指定长度的优惠码,默认生成10位
	*
	 */
	public String getVoucherCode(int length){
		String voucherCode = this.getStringRandom(length<=0?20:length,true);
		return voucherCode.toUpperCase();
	}
	
	public String getShortUrlCode(int length){
		return this.getStringRandom(length<=0?8:length,true);
	}
	
	/**
	 * 
	* @Title: getStringRandom 
	* @param @param length 生成长度
	* @param @param isInitialNum 是否允许首字母为数字
	* @param @return
	* @return String
	* @throws 
	* @Description: 根据指定长度生成包含字母数字的随机码。
	*
	 */
    private String getStringRandom(int length, boolean isInitialNum) {  
        String code = "";  
        String val = "";
        length = length==0?6:length;
        Random random = new Random();  
          
        //参数length，表示生成几位随机数  
        for(int i = 0; i < length; i++) {  
              
            String charOrNum = random.nextInt(2) % 2 == 0 ? "char" : "num";  
            //输出字母还是数字  
            if( "char".equalsIgnoreCase(charOrNum) ) {  
                //输出是大写字母还是小写字母  
                int temp = random.nextInt(2) % 2 == 0 ? 65 : 97;  
                val = (char)(random.nextInt(26) + temp)+"";
                if(val.equalsIgnoreCase("O")||val.equalsIgnoreCase("I")){
                	i = i-1;
                	continue;
                }
                
            } else if( "num".equalsIgnoreCase(charOrNum) ) {  
            	val = String.valueOf(random.nextInt(10));
            	if(val.equalsIgnoreCase("3")||val.equalsIgnoreCase("4")){
                	i = i-1;
                	continue;
                }
            }
            code += val;
            	
            if(!isInitialNum){
	            Pattern pattern = Pattern.compile("[0-9]*"); 
	            if( pattern.matcher(String.valueOf(code.charAt(0))).matches()){
	            	code = "";
	            	i = i-1;
	            	continue;
	            }
            }
        }  
        return code;  
    }
    
    /**
     * 
    * @Title: getOrderId 
    * @param @param type X 销售订单  C 采购订单 D 对账单
    * @param @return
    * @return String
    * @throws 
    * @Description: 根据type生成订单号 
    *
     */
    public String getOrderId(String type){
    	synchronized (this) {
    		type = StringUtil.isNotEmpty(type)?type:"00";
        	Calendar cal = Calendar.getInstance();
        	String year = Integer.toString(cal.get(Calendar.YEAR)).substring(2, 4);
        	String month = Integer.toString(cal.get(Calendar.MONTH)+1);
        	month = month.length()==2?month:"0"+month;
        	String day = Integer.toString(cal.get(Calendar.DATE));
        	day = day.length()==2?day:"0"+day;
        	StringBuffer sb = new StringBuffer(type);
        	sb.append(year).append(month).append(day).append(this.getSmsRandomCode(9));
        	return sb.toString();
		}	
    } 
    public String getOrderId(String type,int length){
    	synchronized (this) {
    		type = StringUtil.isNotEmpty(type)?type:"00";
    		Calendar cal = Calendar.getInstance();
    		String year = Integer.toString(cal.get(Calendar.YEAR)).substring(2, 4);
    		String month = Integer.toString(cal.get(Calendar.MONTH)+1);
    		month = month.length()==2?month:"0"+month;
    		String day = Integer.toString(cal.get(Calendar.DATE));
    		day = day.length()==2?day:"0"+day;
    		StringBuffer sb = new StringBuffer(type);
    		sb.append(year).append(month).append(day).append(this.getSmsRandomCode(length));
    		return sb.toString();
    	}	
    } 
    
    /**
     * 
    * @Title: getSalesNo 
    * @param @return
    * @return String
    * @throws 
    * @Description: 获取销售订单编号
     */
    public String getSalesNo(){
    	return this.getOrderId("X");
    }
    
    /**
     * 
    * @Title: getPurchaseNo 
    * @param @return
    * @return String
    * @throws 
    * @Description: 获取采购订单编号
     */
    public String getPurchaseNo(){
    	return this.getOrderId("C");
    }
    
    /**
     * 
    * @Title: getCheckingNo 
    * @param @return
    * @return String
    * @throws 
    * @Description: 获取对账单编号
     */
    public String getCheckingNo(){
    	return this.getOrderId("D");
    }

	/**
	 * 根据系统时间获取流水单号。
	 * 规则：年月日+时分秒+毫秒+四位随机数+随机大写字母。
	 * 例：201607291708220585691A
	 * @return
	 */
	public String getPaySerial(){
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String serialnumber = sdf.format(date);
		String letter[] = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
		for (int i = 1; i < 5; i++) {
			serialnumber += (int) Math.floor(Math.random() * 10);
		}
		serialnumber += letter[new Random().nextInt(26)];
		return serialnumber;
	}
	
	public String getSerialAll(int length){
		return this.getStringRandom(length, true);
	}


    public static void main(String[] args) {
    	for(int i = 0;i<20;i++){
    		System.out.println(CodeBuilderUtil.getInstance().getSerialAll(32).toLowerCase());
    	}
	}
}
