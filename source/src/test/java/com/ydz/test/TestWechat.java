package com.ydz.test;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.ydz.wechat.util.SendRequestUtil;
import com.ydz.wechat.util.WechatUtil;

@RunWith(YdzJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring/ApplicationContext.xml",
		"classpath:spring/ApplicationContext-mvc.xml",
		"classpath:redis/spring-redis.xml" })
@Transactional
public class TestWechat extends AbstractJUnit4SpringContextTests{
	
	@Resource
	private WechatUtil wechatUtil;

    /**
     * 模板消息
     */
    @Test
    public void test5() throws IOException {
        String token = "3gQukoil4FO0be4MHcbZouNwr3d7lF5bmT-UYDq1bk6IxqTP7j-taVcl-d2JfSPhhuX81dA8R8R0szfLU19RuCkVvAQYj_snSMcxfGJDn1E4VHvVRhfo1XS3zej11L-8JLMjACAXZA";
//WechatConstants.NOTIFY_MESSAGE_URL+
        String url ="https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+token;
        //Token.returnToken();
        Map<String,Object> map = new HashMap<>();
        map.put("touser","osKOSw4ezKZrImfWueQB0cmVe9Mw");//jin osKOSw1Hhe7xQpa7PA0H4AcqPzAs  //pxy osKOSwy4mtrqtLE8J2RJ5uOxqIFo //quan osKOSwxByVmXmKDQDkkISo3KJpg0
        map.put("template_id","Xx4DK_iDLhTaxp1xntdPHWnh4PwIgJ0U6i66eeIwl3M");

        map.put("url","http://weixin.qq.com/download");
        //map.put("topcolor","#FF0000");

        Map<String,Object> dataMap = new HashMap<>();

        Map<String,Object> userDataMap = new HashMap<>();
        userDataMap.put("value","您有一张待收货订单未处理\n");
        dataMap.put("first",userDataMap);

        Map<String,Object> dateDataMap = new HashMap<>();
        dateDataMap.put("value","会展活动");
        /*dateDataMap.put("color","#173177");*/
        dataMap.put("keyword1",dateDataMap);

        Map<String,Object> CardNumber = new HashMap<>();
        CardNumber.put("value","上海仁石科技有限公司");
        /*CardNumber.put("color","#173177");*/
        dataMap.put("keyword2",CardNumber);

        Map<String,Object> Type = new HashMap<>();
        Type.put("value","XS201608152411239");
        /*Type.put("color","#173177");*/
        dataMap.put("keyword3",Type);

        Map<String,Object> Money = new HashMap<>();
        Money.put("value","12600.00元");
        Money.put("color","#ff0000");
        dataMap.put("keyword4",Money);

        Map<String,Object> DeadTime = new HashMap<>();
        DeadTime.put("value","2016-08-31\n");
        /*DeadTime.put("color","#173177");*/
        dataMap.put("keyword5",DeadTime);

        Map<String,Object> Left = new HashMap<>();
        Left.put("value","点击详情可以查看订单明细。收货后进行确认操作，后续就可以轻松对账啦~~");
        /*Left.put("color","#173177");*/
        dataMap.put("remark",Left);
        map.put("data",dataMap);
        String json = JSON.toJSONString(map);
        try {
            System.out.println(json);
            String result = SendRequestUtil.sendPost(url,json);
            System.out.println(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("222");
    }



    @Test
    public void test1(){
        try {
           String result =  wechatUtil.sendMsg("osKOSwy4mtrqtLE8J2RJ5uOxqIFo","欢迎关注易对账，十分荣幸成为您的生意好帮手！\n" +
                   "\n" +
                   "[可怜]我没有账号，请点击<a href=\"http://dev.yiduizhang.com/login.jsp\">这里进行账号注册。</a>\n" +
                   "\n" +
                   "[鼓掌]我有账号，请点击<a href=\"http://dev.yiduizhang.com/index.html\">这里进行账号绑定。</a>\n" +
                   "\n" +
                   "绑定账号后，您可以：\n" +
                   "\n" +
                   "1. 轻松接收和确认您的好友供应商发给您的订单， 并对供应商的对账单进行在线支付。\n" +
                   "2. 随时查看自己的生意，生成对账单，或记录收款。\n" +
                   "3. 分配工作任务。\n" +
                   "一键对账，轻松支付！");
            System.out.println(result);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    @Test
    public void test2(){
        String fStr="<?xml version='1.0' encoding='UTF-8'?>" +
                "<ROOT test='test123' cod='cod123'><Name>AAA</Name><Number>BBB</Number>" +
                "<Recording>http://10.15.57.174/wav/2008/10/29/WG37100/ext37102/10.15.57.71!1~R!10292008_064002!37102!67256479!Ext!NA!1179371583!R.wav</Recording>" +
                "<Orders>有</Orders></ROOT>";
        try {
            /*SAXReader reader = new SAXReader();
            Document doc;
            doc = DocumentHelper.parseText(fStr);

            //Document doc = reader.read(ffile); //读取一个xml的文件
            Element root = doc.getRootElement();
            Attribute testCmd= root.attribute("test");
            System.out.println(testCmd.getName()+"-***--"+testCmd.getValue());
            Element eName = root.element("Name");
            System.out.println("节点内容*--"+eName.getTextTrim());*/

            // 将解析结果存储在HashMap中
            Map<String, String> map = new HashMap<String, String>();

            // 从request中取得输入流
            //InputStream inputStream = request.getInputStream();
            // 读取输入流
            SAXReader reader = new SAXReader();
            Document document = reader.read(fStr);
            // 得到xml根元素
            Element root = document.getRootElement();
            // 得到根元素的所有子节点
            List<Element> elementList = root.elements();

            // 遍历所有子节点
            for (Element e : elementList)
                map.put(e.getName(), e.getText());

            // 释放资源
            //inputStream.close();
            //inputStream = null;
            System.out.println(map);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Test
    public void test3(){
        //StringBuffer sb = new StringBuffer();
        String fStr="<?xml version='1.0' encoding='UTF-8'?><ROOT test='test123' cod='cod123'><Name>AAA</Name><Number>BBB</Number><Recording>http://10.15.57.174/wav/2008/10/29/WG37100/ext37102/10.15.57.71!1~R!10292008_064002!37102!67256479!Ext!NA!1179371583!R.wav</Recording><Orders>有</Orders></ROOT>";
        String xml = "<xml><ToUserName><![CDATA[toUser]]></ToUserName><FromUserName><![CDATA[FromUser]]></FromUserName><CreateTime>123456789</CreateTime><MsgType><![CDATA[event]]></MsgType><Event><![CDATA[subscribe]]></Event></xml>";
        Map<String,Object> map = new HashMap<>();
        Document document = null;
        try {
            document = DocumentHelper.parseText(xml);
            List<Element> elementList = document.getRootElement().elements();
            for(Element element : elementList ){
                map.put(element.getName(),element.getData());
            }
//            System.out.println(map.toString());
        } catch (DocumentException e) {
            e.printStackTrace();
        }
    }
    
    @Test
    public void testPushSingleInfo(){
    	try {
    		String result =  wechatUtil.sendMsg("o0QGcxON9yNhgXLnhDwzmCs6qQkQ","呆逼~哈哈哈哈");
    		System.out.println(result);
    	} catch (IOException e) {
    		e.printStackTrace();
    	}
    }
}