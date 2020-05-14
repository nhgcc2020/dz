<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: pxy
  Date: 2016/5/22
  Time: 12:42
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>易对账注册</title>
    <!--针对移动设备,网站显示宽度等于设备屏幕显示宽度,内容缩放比例为1:1-->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!--将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面：-->
    <meta name="renderer" content="webkit">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <!-- css引入和样式定义区域 -->
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <script type="text/javascript" src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script type="text/javascript" src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
    <script type="text/javascript" src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
    <script type="text/javascript" src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
    <script type="text/javascript" src="/resources/cola-ui/i18n/zh-CN/cola.js?v=40433415fd"></script>
    <link rel="stylesheet" type="text/css" href="/resources/business/global.css?v=76321dbcfe">
    <!--加载公共js-->
    <!--<script type="text/javascript" src="js/public.js"></script>-->
    <script src="/common/growingio.js"></script>
    <style>

        @media only screen and (min-width: 1441px) {
            .reg_logo_margin {
                margin-top: 1rem;
                margin-right: 1rem;
                margin-bottom: 5rem;
            }
            .reg_input {
                margin: 2.5rem 0;
                text-align: left;
            }

            .reg_rcon_padding{
                padding: 1rem 7rem
            }
            .reg_bnt_mt{
                text-align: center;
                margin-top: 3.9rem;

            }
            .reg_info_mt{
                margin-top: 6rem;text-align: left;
            }
            .reg_log_width{
                width: 180px;
            }
            .reg_bnt{
                width: 145px;
                line-height: 35px !important;
                font-size: 1.2rem;
            }

            *{
                font-size: 1.1rem;
            }

            .grad {
                background: -webkit-linear-gradient(red, blue); /* Safari 5.1 - 6.0 */
                background: -o-linear-gradient(red, blue); /* Opera 11.1 - 12.0 */
                background: -moz-linear-gradient(red, blue); /* Firefox 3.6 - 15 */
                background: linear-gradient(red, blue); /* 标准的语法 */
            }
        }

        @media only screen and (max-width: 1441px) {
            .reg_input {
                margin: 1.5rem 0;
                text-align: left;
            }
            .reg_rcon_padding{
                padding: 1rem 3.5rem;
            }
            .reg_bnt_mt{
                text-align: center;
                margin-top: 2rem;
            }
            .reg_info_mt{
                margin-top: 3rem;
                text-align: left;
            }
            .reg_log_width{
                width: 180px;
            }
            .reg_logo_margin {
                margin-top: 1rem;
                margin-right: 1rem;
            }
        }
    </style>
</head>

<body>
<div id="content" style="height: 100%;">
    <!--左边 start-->
    <div id="leftcon" style='display: inline-block;background-color:#5795cc ;width:64.5%;height: 100%'>
        <div style="text-align: center;">
            <div style="margin-top: 14rem">
                <img src="<c:url value='/images/welcome/1_title.png'/>" style="width:60%"/>
            </div>
            <img src="<c:url value="/images/welcome/1_image.png"/>" style="margin-top: 10rem;width: 35%;">
        </div>
    </div>


    <div style="width: 35%;display: inline-block;background-color: white;float: right;height: 100%;text-align: center;" >
        <div style="text-align: right;" class="reg_logo_margin">
            <div class="logo">
                <a href="#"><img src="/images/login/logo.png" alt="易对账" /></a>
                <i class="iconfont logo_font">&#xe667;</i>
            </div>
            <%--<img class="reg_log_width" src="<c:url value="/images/u0.jpg"/>"/>--%>
        </div>
        <div class="reg_rcon_padding">
            <!--form表单 start-->
            <form id="userInfo">
            <div class="reg_input" style="border-bottom: 1px solid #2E94E1;text-align: left;padding-bottom: 1rem;">
                <input name="avatarPath" value=" ${sessionScope.sessionUser.avatarPath}" type="hidden" />
                <img width="70px" src="${sessionScope.sessionUser.avatarPath}" style="vertical-align: bottom;" /> &nbsp;&nbsp;&nbsp;
					<span style="display: inline-block;line-height: 70px;margin-left: 1rem;">
						<label name="nickName" style="border-bottom: 1px solid gray;padding: 4px;">${sessionScope.sessionUser.nickName}</label>
					</span><!--margin-bottom: 3px;vertical-align: bottom;-->
            </div>

            <div class="reg_input">
                <div style="margin-bottom: 0.5rem;">登录帐号</div>
                <div c-widget="Input;placeholder: 输入手机号码（以后登录系统的唯一识别号);name:userId" style="width: 100%;"></div>
            </div>
            <div class="ui form">
                <div class="fields">
                    <div class="field eight wide" style="margin: 0;">
                        <div c-widget="Input;placeholder:输入短信验证码;name:code"></div>
                    </div>
                    <div class="field eight wide" style="margin: 0;">
                        <div id="but" c-widget="button; class:basic;color:blue;width:100%;height:38px" style="font-weight: 500;min-width: 115px;">获取验证码</div>
                    </div>
                </div>
            </div>
            <div class="reg_input">
                <div style="margin-bottom: 0.5rem;">真实姓名</div>
                <div c-widget="Input;placeholder: 输入真实姓名(用于真实的业务对账识别);name:realName" style="width: 100%;"></div>
            </div>
            <div class="reg_input">
                <div style="margin-bottom: 0.5rem;">登录密码</div>
                <div c-widget="Input;inputType:password;placeholder: 输入密码(6-20位，必须含字母+数字，区分大小写);name:password" style="width: 100%;"></div>
            </div>
            <div class="reg_info_mt" >
                <input type="checkbox" checked="checked" style="margin: 3px 5px 0 0;" />同意<span style="color: #2185d0;font-size: 0.89rem;"><a href="http://www.yiduizhang.com/privacy.html">《用户隐私保护》</a> 与 <a href="http://www.yiduizhang.com/service.html">《服务条款协议》</a></span>
            </div>
            <div class="reg_bnt_mt">
                <!--Next需要加icon-->
                <div c-widget="button; color:teal; caption:下一步" class="reg_bnt" onclick="save()"></div>
            </div>
            </form>
            <!--form表单 end-->
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    function save() {
        var code = $("input[name='code']").val();
        $.post( "<c:url value="/reg/save"/>",
                $("#userInfo").serialize(),
                function (data) {
                    if(data.state == "1"){
                        window.location.href="<c:url value="/reg/company"/>";
                    }else {
                        alert(data.msg);
                    }
                }
        )
        /*$.get("<c:url value="/tool/verificateCode"/>",{code:code},function (data) {
            if(data=="succ"){
                $.post( "<c:url value="/reg/save"/>",
                        $("#userInfo").serialize(),
                        function (data) {
                            if(data=="succ"){
                                //alert()
                                window.location.href="<c:url value="/reg/company"/>";
                            }else {
                                alert("失败");


                            }
                        }
                )
            }else{
                return false;
            }

        })*/

        }

    cola(function(model) {
    });
    /*cola.on("ready", function() {
        var allHeight = $("#content").height();
        var leftconHeight = $("#leftcon").height();
        $("#leftcon").css("margin-top", (allHeight - leftconHeight) / 2);
    });*/


    $("#but").click(function(){
        var second=120;
        $.get("<c:url value="/tool/sendVerCode"/>",{phone:$("input[name='userId']").val()},function (data) {});
        var changeN=setInterval(function(){
            second--;
            $("#but").text(second+"秒后重新获取");
            if(second<=0){
                clearInterval(changeN);
                $("#but").text("点击重获验证码");
                $("#but").css({"pointer-events":"auto"});
            };
            if(second>0&&second<120){//在倒计时内禁用
                $("#but").css({"pointer-events":"none"});
            }
        },1000)
        //
    });


    /*
    *
     if(data=="succ"){

     }else{
     alert("验证码发送失败！");
     }*/
</script>

</html>
