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
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">
    <script type="text/javascript" src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script type="text/javascript" src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
    <script type="text/javascript" src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
    <script type="text/javascript" src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
    <script type="text/javascript" src="/resources/cola-ui/i18n/zh-CN/cola.js?v=40433415fd"></script>
    <link rel="stylesheet" type="text/css" href="/resources/business/global.css?v=76321dbcfe">
    <!--加载公共js-->
    <!--<script type="text/javascript" src="js/public.js"></script>-->
    <script src="/resources/common/global-config.js?v=051236a6d6"></script>
    <script src="/common/growingio.js"></script>
    <style>
        .registered_modal{
            height: 100%;
            width: 100%;
            background: rgba(0,0,0,0.9);
            position: absolute;
            z-index: 999;
            left: 0px;
            top: 0px;
            display: none;
        }
        .registered_modal h1{
            color: #fff;
            text-align: center;
            height: 80px;
            line-height: 80px;
            margin: 30px 0px;
            font-weight: normal;
        }
        .registered_list{
            list-style: none;
            overflow: hidden;
            margin: 0px auto;
            padding:0px;
        }
        .registered_list li{
            max-width: 32%;
            float: left;
            padding: 10px;
            box-sizing: border-box;
            position: relative;
            margin-left: 2%;
            cursor: pointer;
        }
        .registered_list li:first-child{
            margin:0px;
        }
        .registered_list li a{
            display: block;
            height: 100%;
            width: 100%;
        }
        .registered_list li img{
            width: 100%;
        }
        .line_left,.line_right{
            height: 0;
            background: #fff;
            width: 3px;
            position: absolute;
        }
        .line_top,.line_botton{
            width: 0;
            background: #fff;
            height: 3px;
            position: absolute;
        }
        .line_right{
            right: 0px;
            bottom: 0px;
        }
        .line_left{
            left: 0px;
            top: 0px;
        }
        .line_top{
            left: 0px;
            top: 0px;
        }
        .line_botton{
            right: 0px;
            bottom: 0px;
        }

        @media only screen and (min-width: 1440px) {
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
        @media only screen and (max-width: 1440px) {
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
        @media screen and ( min-width:1440px) {
            .registered_list{
                width: 1200px;
            }
        }
        @media screen and ( min-width:900px) and ( max-width:1440px) {
            .registered_list{
                max-width: 900px;
            }
            .registered_list li{
                max-width: 28%;
                margin-left: 8%;
            }
        }
        /*关闭*/
        .registered_modal_close{
            display: block;
            height: 36px ;
            width:36px;
            color: #000;
            position: absolute;
            right:0px;
            top:0px;
            background: #fff;
            text-align: center;
            line-height: 36px;
            cursor: pointer;
        }
        .ui.input input{
            font-size: 12px;
        }
        .ui.form input[type="text"]{
            font-size: 12px;
            border: 1px solid #adadad;
        }
        #but span{
            font-size: 12px;
        }
        .reg_bnt_mt{
            position: relative;
        }
        .login-jsp{
            position: absolute;
            bottom:0px;
            left:50%;
            font-size: 12px;
            color: #2e8ae6;
            cursor: pointer;
            margin-left:85px;
        }
    </style>
</head>

<body>
<div id="content" style="height: 100%;">
    <!--左边 start-->
    <div id="leftcon" style='display: inline-block;background-color:#5795cc ;width:64.5%;height: 100%'>
        <div style="text-align: center;">
            <div style="margin-top: 14rem">
                <img src="<c:url value="/images/welcome/1_title.png"/>" style="width:60%" >
            </div>
            <img src="<c:url value="/images/welcome/1_image.png"/>" style="margin-top: 10rem;width: 35%;">
        </div>
    </div>

    <div style="width: 35%;display: inline-block;background-color: white;float: right;height: 100%;text-align: center;" >
        <div class="reg_logo_margin tranform2" id="main_logo">
            <div>
                <img class="reg_log_width" src="<c:url value="/images/u0.jpg"/>"/>
                <img class="reg_log_width" src="<c:url value="/images/transforn2.png"/>"/>
            </div>
        </div>
        <div class="clearboth"></div>
        <div class="reg_rcon_padding">
            <!--form表单 start-->
            <form id="userInfo">
            <div class="reg_input" style="border-bottom: 1px solid #2E94E1;text-align: left;padding-bottom: 1rem;">
                <img width="70px" src="<c:url value="/images/u31.png"/>" style="vertical-align: bottom;" /> &nbsp;&nbsp;&nbsp;
					<span style="display: inline-block;line-height: 70px;margin-left: 1rem;">
                         <a href="<c:url value="/jump.html"/>">您也可使用微信注册</a>
						<%--<label name="nickName" style="border-bottom: 1px solid gray;padding: 4px;">${sessionScope.sessionUser.nickName}</label>--%>
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
                        <div id="but" c-widget="button; class:basic;color:blue;width:100%;height:30px" style="font-weight: 500; min-width: 115px;">获取验证码</div>
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
                <input type="checkbox" checked="checked" style="margin: -3px 5px 0px; position: relative;" />同意<span style="color: #2185d0;font-size: 0.89rem;">
                <a target="_blank" href="http://www.yiduizhang.com/privacy.html">《用户隐私保护》</a> 与
                <a target="_blank" href="http://www.yiduizhang.com/service.html">《服务条款协议》</a></span>
            </div>
            <div class="reg_bnt_mt">
                <!--Next需要加icon-->
                <div c-widget="button; color:teal; caption:注册;click:save" class="reg_bnt"></div>
                <div class="login-jsp">已有账号,立即登录</div>
            </div>
            </form>
            <!--form表单 end-->
        </div>
    </div>
</div>

<div class="registered_modal">
    <h1>选择一个最符合您当前需求的使用角色</h1>
    <span class="registered_modal_close" onclick="colse_Div()">X</span>
    <ul class="registered_list">
        <li data-value="1" style="opacity:0.5;">
            <a>
                <img src="<c:url value='/images/signUp/1.jpg'/>"/>
            </a>
        </li>
        <li data-value="2">
            <div class="line_left"></div>
            <div class="line_top"></div>
            <div class="line_right"></div>
            <div class="line_botton"></div>
            <a href="#">
                <img src="<c:url value='/images/signUp/2.jpg'/>"/>
            </a>
        </li>
        <li data-value="3">
            <div class="line_left"></div>
            <div class="line_top"></div>
            <div class="line_right"></div>
            <div class="line_botton"></div>
            <a href="#">
                <img src="<c:url value='/images/signUp/3.jpg'/>"/>
            </a>
        </li>
    </ul>
</div>
</body>
<script type="text/javascript">
    $(function(){
        $('.registered_list li').click(function(){
            var value = $(this).data("value");
            switch(value) {
                case 1:
                    $("<div class='tips_contants'>").fadeIn(250).html("暂未开放").delay(1000).fadeOut(250).appendTo('body');
                    <%--window.location.href="<c:url value="/login/tomain"/>";--%>
                    break;
                case 2:
                    window.location.href="<c:url value="/reg/main-industry"/>";
                    break;
                case 3:
                    window.location.href="<c:url value="/reg/addCom"/>";
                default:
                    break;
            }
        });
        $('.registered_modal_btn').click(function(){
            $('.registered_modal').animate({
                top:'0px'
            },300,function(){
                $('.registered_list').fadeIn(1000);
            });
        });
        $('.registered_list li').mousemove(function(){
            $(this).children('div:even').stop(true).animate({
                height:'100%'
            },400);
            $(this).children('div:odd').stop(true).animate({
                width:'100%'
            },400);
        });
        $('.registered_list li').mouseleave(function(){
            $(this).children('div:even').stop(true).animate({
                height:'0'
            },400);
            $(this).children('div:odd').stop(true).animate({
                width:'0'
            },400);
        });
    })

    function colse_Div(){
        $('.registered_modal').slideUp(500);
    };

    function openDiv(){
        /*var code = $("input[name='code']").val();
        if(code == undefined || code == ""){
            $("<div class='tips_contants'>").fadeIn(250).html("短信验证码不能为空").delay(3000).fadeOut(250).appendTo('body');
            return false;
        }*/
       $('.registered_modal').slideDown(500);
    }
    cola(function(model) {
        model.action({
            save:function (btn) {
                btn.set("disabled",true);
                btn.set("state","loading");

                var code = $("input[name='code']").val();
                if(code == undefined || code == ""){
                    $("<div class='tips_contants'>").fadeIn(250).html("短信验证码不能为空").delay(3000).fadeOut(250).appendTo('body');
                    btn.set("disabled",false);
                    btn.set("state","");
                    return false;
                };

                $.get("<c:url value="/tool/verificateCode"/>",{code:code},function (data) {
                    if(data=="1"){
                        $.post( "<c:url value="/reg/save"/>",
                                $("#userInfo").serialize(),
                                function (data) {
                                    if(data.state == "1"){
                                        btn.set("disabled",false);
                                        btn.set("state","");
                                        openDiv();
                                    }else {
                                        $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(3000).fadeOut(250).appendTo('body');
                                        btn.set("disabled",false);
                                        btn.set("state","");
                                    }
                                }
                        )
                    }else{
                        $("<div class='tips_contants'>").fadeIn(250).html("验证码有误").delay(3000).fadeOut(250).appendTo('body');
                        btn.set("disabled",false);
                        btn.set("state","");
                    }
                });
            }
        })
    });

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

    $(".login-jsp").click(function(){
        window.location = dz_url+"login.jsp"
    })

    $("#main_logo").click(function(){
        window.open(dz_url+"index.html");
    })

</script>

</html>
