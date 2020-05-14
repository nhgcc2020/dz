<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords" content="易对账" />
    <meta name="description" content="易对账" />
    <title>登录易对账</title>
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
    <link href="/resources/business/global.css?v=76321dbcfe" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
    <style>
body{
    background: transparent !important;
}

        .lodingBtn{
            background: #2e8ae6 !important;
            position:relative;
        }
        .lodingBtn:after{
            content: "";
            height:20px;
            width:20px;
            position: absolute;
            left:50%;
            margin-left:-12px;
            top:50%;
            margin-top:-12px;
            border-radius:20px;
            border:2px solid #DEDEDE;
            border-right:2px solid #808000;
            z-index:2;
            animation: lodingB 1s linear infinite;
        }
        @keyframes lodingB{
            0%{
                transform: rotate(0deg);
            }
            100%{
                transform: rotate(360deg);
            }
        }

    .foot p{
    position:absolute;
    bottom:0;
    left:30%;
    right: 30%;
    color:#fff;
    }


        .alert-info {
            color: #31708f;
            font-size: 14px;
            background-color: #d9edf7;
            border-color: #bce8f1;
        }
        .alert-dismissable, .alert-dismissible {
            padding-right: 35px;
        }
        .alert {
            padding: 15px;
            /*margin-bottom: 20px;*/
            border: 1px solid transparent;
            border-radius: 4px;
        }

.back_ground::before{
    content: "";
    position: fixed;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    opacity: .6;
    /*background-color: rgba(0,0,0,.3);*/
    -webkit-transition: all .5s;
    transition: all .5s;
   
}
        .sectionbg{
            background: #fafafa;
            height: 100%;
            left: 0;
            overflow: hidden;
            position: absolute;
            top: 0;
            text-align: center;
            width: 100%;
             -webkit-transform: translateY(0);
            -ms-transform: translateY(0);
             transform: translateY(0);
             -webkit-transition: -webkit-transform .7s cubic-bezier(.825,0,.5,1);
             transition: -webkit-transform .7s cubic-bezier(.825,0,.5,1);
             transition: transform .7s cubic-bezier(.825,0,.5,1);
             transition: transform .7s cubic-bezier(.825,0,.5,1),-webkit-transform .7s cubic-bezier(.825,0,.5,1);
        }
        .logoNew{
            height: 45px;
            /* margin: 20px 0px 0px 20px; */
            position: absolute;
            cursor: pointer;
            left: 20px;
            top: 20px;
        }
.logoNew img {
    height: 45px;
    width: auto;
}
    </style>
    <!--[if lt IE 10]>
    <script src="/wechat/js/jquery-1.8.3.min.js?v=3576a6e73c"></script>
    <script src="/resources/util/respond.min.js?v=afc1984a3d"></script>
    <![endif]-->
    <script>
        if(!window.jQuery) {
            document.write('<script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"><\/script>');
        }

    </script>
    <script>
        var _hmt = _hmt || [];
        (function () {
            var hm = document.createElement("script");
            hm.src = "https://hm.baidu.com/hm.js?9f66759d01bead4ba7509b00b4542912";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>
    <script src="/resources/common/change_bg.js?v=c5c2beed41d"></script>
</head>
<body style="width: 100%; height: 100%; position: absolute;">
<!--[if IE ]>
<div class="alert alert-info alert-dismissable" style="z-index:9999;position:absolute;width:100%;text-align: center">
    您的浏览器版本将不能正常浏览。请使用 Google Chrome 浏览器。
    如果您在使用双核浏览器，请切换到高速 / 极速 / 神速核心。
</div>
<![endif]-->
<div class="alert alert-info alert-dismissable" style="display:none;z-index:9999;position:absolute;width:100%;text-align: center">
    您的浏览器版本将不能正常浏览。请使用 Google Chrome 浏览器。
    如果您在使用双核浏览器，请切换到高速 / 极速 / 神速核心。
</div>
<div class="sectionbg">
    <div class="back_ground" style="display: none;">
        <div class="logoNew" style="cursor: default; margin:0;">
        <a href="https://www.yiduizhang.com"><img src="/images/login/logo_ad.png" /></a>
    </div>
    </div>
<div class="logoNew" style="cursor: default; margin:0;">
</div>
<div class="hope_word"></div>
<div class="main" style="height:0;">
    <div class="contents">
        <div class="right login_right" style="opacity: .9;position:absolute;right:15%;top:100px;">
            <h1>账户登录<a href="<c:url value="/reg/nomal"/>"></a></h1>
            <form action="#" class="loging_form">
                <p>
                    <input type="text" name="userId" id="userId" placeholder="请输入手机号码" />
                </p>
                <p>
                    <%--<input type="password" name="password" style="display: none;"/>--%>
                    <input type="password" name="password" id="password" placeholder="请输入密码"/>
                </p>
                <p class="checkbox_rember">
                    <span class="prom">
                        <i class="iconfont_new" >&#xe6cc;</i><span class="prompt"></span>
                    </span>
                    <a href="<c:url value="/reg/forget-password"/>">忘记密码  ?</a>
                </p>
                <p style="border: 0px">
                    <button id="loginBtn" style="line-height: 34px">立即登录</button>
                </p>
            </form>
            <div style="float:left;margin-top:30px;font-size:14px;"><a style="color:#4284D9!important;" href="https://www.yiduizhang.com">返回首页</a></div>
            <div class="wechat_div">
            	还没有账户？
            	<a id="download" class="wechat_loding">立即注册</a>
            </div>
        </div>
    </div>
</div>

<div class="foot">
    <p>
        @2016 上海仁石科技有限公司 / All Rights Reserved 沪 ICP备16005067
    </p>
</div>
</div>
<script src="/resources/common/global-config.js?v=051236a6d6"></script>
<script type="text/javascript">
    //session失效后 iframe内部刷新
    var _topWin = window;
    while (_topWin != _topWin.parent.window) {
        _topWin = _topWin.parent.window;
    }
    if (window != _topWin)_topWin.document.location.href = '/login.jsp';
		$('input').focus(function(){
			$(this).parent().addClass("border_color").siblings().removeClass("border_color")
		})
    var input_val;
		$('input[name="userId"]').blur(function(){
            input_val = $(this).val()
			if(input_val=="" || input_val==null){
	            $('.prom').show()
	            $('.prompt').text('请输入手机号！')
			}else{
            	$('.prom').hide()
            }
            
            
/*             else if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(input_val))){
	            $('.prompt').text('手机号码格式不正确！')
	            $('.prom').show()
            } */

		})
    var userIdVal = document.getElementById("userId");
    var loUser = localStorage.getItem("userIdVal");
    $("#loginBtn").on("click",function(event){

        //设置缓存
        if(userIdVal.value !== ""){
            localStorage.setItem("userIdVal",userIdVal.value);
        }
        event.preventDefault();
        var $btn = $(this);
        $btn.text("")
        $btn.addClass("lodingBtn");
        $btn.attr("disabled","true");
        var userId = $('input[name="userId"]').val();
        var password = $("#password").val();
        $.post("login/login_login",
                {userId:userId, password:password},
                function(data){
                    var json = data;
                    //var json = eval("("+data+")");
                    if(json.state != "1"){
                        if(json.type == "no_company"){
                            $btn.removeClass("lodingBtn");
                            $btn.text("登录成功！");
                        }else{
                        	if(userId=="" || userId==null){
									            $('.prom').show()
									            $('.prompt').text('手机号不能为空！')
									          }else if(password=="" ||password==null){
                            $('.prom').show()
                            $('.prompt').text('密码不能为空！')
                        }else{
                            $('.prom').show()
                            $(".prompt").text('用户名或密码错误，请重新输入！')
                        }
                            setTimeout(function(){
                                $btn.text("立即登录");
                                $btn.removeClass("lodingBtn");
                                $btn.removeAttr("disabled");
                                return false;
                            },500);
                        }


                    }else{
                        $btn.removeClass("lodingBtn");
                        $btn.text("登录成功！");
                        setTimeout('window.location.href="/login/tomain"',200);
                    }
                }
        )
    });
    $(".logo_font").click(function(){
        window.location ="/index.html";
    });
    $(".wechat_loding").attr("href","/register.jsp");
</script>
</body>
</html>
