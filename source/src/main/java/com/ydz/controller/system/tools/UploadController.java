package com.ydz.controller.system.tools;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.ydz.config.DZConfig;
import com.ydz.controller.base.BaseController;
import com.ydz.entity.system.Company;
import com.ydz.entity.system.User;
import com.ydz.service.system.CompanyService;
import com.ydz.service.system.UserService;
import com.ydz.util.Const;
import com.ydz.vo.UserVo;

import org.apache.commons.codec.binary.Base64;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import java.awt.image.BufferedImage;
import java.io.*;
import java.util.*;

@Controller
@RequestMapping("/file")
public class UploadController extends BaseController{

    @Resource(name = "userService")
    UserService userService;
    @Resource(name="companyService")
    private CompanyService companyService;
    @Resource
    private DZConfig dzConfig;

    @RequestMapping("/upload")
    @ResponseBody
    public String upload2(HttpServletRequest request) throws IllegalStateException, IOException {
        UserVo userVo = getSessionUservo();
        Map<String,Object> map = new HashMap<>();
        int res = 0;
        //参数 获取x ,y,height,width
        String parameter = request.getParameter("avatar_data");
        JSONObject jsonObject = JSON.parseObject(parameter);

        int x = jsonObject.getInteger("x")>0 ? jsonObject.getInteger("x"):0;
        int y = jsonObject.getInteger("y")>0 ? jsonObject.getInteger("y"):0;


        int height = jsonObject.getInteger("height");
        int width = jsonObject.getInteger("width");
        int pre = 0;
        try {
	        //创建一个通用的多部分解析器
	        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getServletContext());
	        //判断 request 是否有文件上传,即多部分请求
	        if (multipartResolver.isMultipart(request)) {
	            //转换成多部分request
	            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
	            //取得request中的所有文件名
	            Iterator<String> iter = multiRequest.getFileNames();
	            while (iter.hasNext()) {
	                //记录上传过程起始时的时间，用来计算上传时间
	                pre = (int) System.currentTimeMillis();
	                //取得上传文件
	                MultipartFile file = multiRequest.getFile(iter.next());
	                if (file != null) {
	                    //将文件流转为 字符串
	                    InputStream inputStream = file.getInputStream();

	                    String fileName = (((CommonsMultipartFile) file).getFileItem()).getName();
	                    String prefix = fileName.substring(fileName.lastIndexOf(".")+1);
	
	                    BufferedImage image = ImageIO.read(inputStream);
	                    width = width<image.getWidth()?width:image.getWidth();
	                    height = height<image.getHeight()?height:image.getHeight();
	                    BufferedImage subImage = image.getSubimage(x,y,width,height);


//                        String path = request.getSession().getServletContext().getRealPath("/");
                        String path = dzConfig.filePathLogo;
                        String url = "upload/logo/"+userVo.getUserKey()+"."+prefix;
                        String imgUrl = path+url;
                        File outFile = new File(imgUrl);
                        ImageIO.write(subImage,prefix,outFile);

	                    User userParam = new User();
	                    userParam.setAvatarPath("/"+url);
	                    userParam.setUserKey(userVo.getUserKey());
	                    res = userService.updateUser(userParam);

                        //修改session
                        userVo.setAvatarPath(userParam.getAvatarPath());
                        getCurrentSession().setAttribute(Const.SESSION_USER,userVo);
	                }
	                //记录上传该文件后的时间
	                int finaltime = (int) System.currentTimeMillis();
	            }
	        }
	        if(res >= 1){
	            map.put("result",userVo.getAvatarPath()+"?time="+new Date().getTime());
	            map.put("message","上传成功");
	        }else{
	            map.put("message","上传失败");
	        }
        } catch(javax.imageio.IIOException iioException){
        	map.put("message","抱歉，不支持CMYK模式的图片，请使用RGB模式的图片。");
        	iioException.printStackTrace();
        } catch (Exception e) {
            map.put("message","上传失败");
            e.printStackTrace();
        }
        return JSON.toJSONString(map);
    }


    @RequestMapping("/upload-com")
    @ResponseBody
    public String uploadCom(HttpServletRequest request) throws IllegalStateException, IOException {
        UserVo userVo = (UserVo) request.getSession().getAttribute(Const.SESSION_USER);
        Map<String,Object> map = new HashMap<>();
        int res = 0;
        //参数 获取x ,y,height,width
        String parameter = request.getParameter("avatar_data");
        JSONObject jsonObject = JSON.parseObject(parameter);
        int x = jsonObject.getInteger("x")>0 ? jsonObject.getInteger("x"):0;
        int y = jsonObject.getInteger("y")>0 ? jsonObject.getInteger("y"):0;

        int height = jsonObject.getInteger("height");
        int width = jsonObject.getInteger("width");
        int pre = 0;
        try {
	       
	        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getServletContext());  //创建一个通用的多部分解析器
	       
	        if (multipartResolver.isMultipart(request)) {  //判断 request 是否有文件上传,即多部分请求
	            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request; //转换成多部分request
	            Iterator<String> iter = multiRequest.getFileNames(); //取得request中的所有文件名
	            while (iter.hasNext()) {
	                pre = (int) System.currentTimeMillis(); //记录上传过程起始时的时间，用来计算上传时间
	                MultipartFile file = multiRequest.getFile(iter.next()); //取得上传文件
	                if (file != null) {
	                    //将文件流转为 字符串
	                    InputStream inputStream = file.getInputStream();
	                    String fileName = (((CommonsMultipartFile) file).getFileItem()).getName();
	                    String prefix = fileName.substring(fileName.lastIndexOf(".")+1);
	
	                    BufferedImage image = ImageIO.read(inputStream);
	                    width = width<image.getWidth()?width:image.getWidth();
	                    height = height<image.getHeight()?height:image.getHeight();
	                    BufferedImage subImage = image.getSubimage(x,y,width,height);


//                        String path = request.getSession().getServletContext().getRealPath("/");
	                    String path = dzConfig.filePathLogo;
                        String url = "upload/logo/"+userVo.getComKey()+"."+prefix;
                        String imgUrl = path+url;
                        File outFile = new File(imgUrl);
                        ImageIO.write(subImage,prefix,outFile);

	                    Company company = new Company();
	                    company.setComLogoPath("/"+url);
	                    company.setComKey(userVo.getComKey());

                  
                        res = companyService.updateCompany(company);
                        //修改session
                        userVo.setComLogoPath(company.getComLogoPath());
                        getCurrentSession().setAttribute(Const.SESSION_USER,userVo);
                    }
	            }
             }
            //记录上传该文件后的时间
            int finaltime = (int) System.currentTimeMillis();
            
	        if(res >= 1){
	            map.put("result",userVo.getComLogoPath()+"?time="+new Date().getTime());
	            map.put("message","上传成功");
	        }else{
	            map.put("message","上传失败");
	        }
        } catch(javax.imageio.IIOException iioException){
        	map.put("message","抱歉，不支持CMYK模式的图片，请使用RGB模式的图片。");
        	iioException.printStackTrace();
        } catch (Exception e) {
            map.put("message","上传失败");
            e.printStackTrace();
        }
        return JSON.toJSONString(map);
    }




    @RequestMapping("/toUpload"	)
    public String toUpload() {
        return "/upload";
    }

    /**
     * 功能：Java读取txt文件的内容
     * 步骤：1：先获得文件句柄
     * 2：获得文件句柄当做是输入一个字节码流，需要对这个输入流进行读取
     * 3：读取到输入流后，需要读取生成字节流
     * 4：一行一行的输出。readline()。
     * 备注：需要考虑的是异常情况
     * @param filePath
     */
    public static String readTxtFile(String filePath){
        try {
            //String encoding="utf-8";
            File file=new File(filePath);
            if(file.isFile() && file.exists()){ //判断文件是否存在
                InputStreamReader read = new InputStreamReader(
                        new FileInputStream(file));//考虑到编码格式
                BufferedReader bufferedReader = new BufferedReader(read);
                String text = "";
                String lineTxt = "";
                while((lineTxt = bufferedReader.readLine()) != null){

                    text+=lineTxt;
                    System.out.println(lineTxt);
                }
                read.close();
                return text;
            }else{
                System.out.println("找不到指定的文件");
                return "找不到指定的文件";
            }
        } catch (Exception e) {
            System.out.println("读取文件内容出错");
            e.printStackTrace();
            return "读取文件内容出错";
        }
    }

    /**
     * 判断文件的编码格式
     *
     * @param fileName
     *            :file
     * @return 文件编码格式
     * @throws Exception
     */
    public static String codeString(String fileName) throws Exception {
        BufferedInputStream bin = new BufferedInputStream(new FileInputStream(
                fileName));
        int p = (bin.read() << 8) + bin.read();
        String code = null;

        switch (p) {
            case 0xefbb:
                code = "UTF-8";
                break;
            case 0xfffe:
                code = "Unicode";
                break;
            case 0xfeff:
                code = "UTF-16BE";
                break;
            default:
                code = "GBK";
        }

        return code;
    }

}
