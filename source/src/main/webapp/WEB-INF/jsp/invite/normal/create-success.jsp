<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="format-detection" content="telephone=no" />
    <meta http-equiv="x-rim-auto-match" content="none">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>创建成功</title>
    <link href="/wechat/css/mui.min.css?v=57ec55e59d" rel="stylesheet"/>
    <link href="/wechat/css/main.css?v=9e61f29840" rel="stylesheet"/>
    <script src="/wechat/js/jquery-1.8.3.min.js?v=3576a6e73c"></script>
    <script src="/resources/common/global-config.js?v=051236a6d6"></script>
    <style>
        body{
            background: rgba(0,0,0,0.8);
        }
        .mui-content{
            max-width: 640px;
            margin: 0px auto;
            min-height:100%;
            position: relative;
        }
        .shark_contant{
            height:auto;
            max-width:640px;
            margin: 0px auto;
            background: linear-gradient(#66b3ff,#2e8ae6);
            padding-bottom: 30px;
            overflow: hidden;
        }
        .error_tips {
            display: none;
            position: absolute;
            bottom: 80px;
            width: 80%;
            left: 10%;
            height: 36px;
            line-height: 36px;
            background: rgba(0, 0, 0, 0.7);
            color: #fff;
            z-index: 999;
            font-size: 12px;
            border-radius: 5px;
            text-align: center;
        }
    </style>
</head>
<body>


<div class="mui-content" style="height: 100%;">
    <div class="mui-content-padded related_form_content">
        <h1>祝贺您成功创建企业账号，并成为管理员！</h1>

        <ul class="new-fixed">
            <li><span>登录账号</span> <b id="username">${user.userId}</b> </li>
            <li><span>真实姓名</span> <b id="realName">${user.realName}</b> </li>
            <li><span>企业名称</span> <b id="comName">${companyView.comName}</b> </li>
            <li><span>企业简称/品牌</span> <b id="comShortname">${companyView.comShortname}</b> </li>
            <li><span>企业对账号</span> <b id="comId">${companyView.comId}</b> </li>
            <li><span>内部邀请码</span> <b id="withinComId">${companyView.withinComId}</b> </li>
        </ul>

        <div class="mui-button-row related_form_sub">
            <button type="submit" class="mui-btn mui-btn-primary" id="next_tap">开始探索之旅！</button>
        </div>
    </div>
</div>
<script>
    $(".mui-content").height($(window).height());
    $("#next_tap").click(function(){
        $("<div class='error_tips'>").fadeIn(250).html("请关注我们的公众号-易对账，或者登录官网。").appendTo(".mui-content");
        setTimeout(function(){
            var system = {
                win: false,
                mac: false,
                xll: false,
                ipad:false
            };
            var p = navigator.platform;
            system.win = p.indexOf("Win") == 0;
            system.mac = p.indexOf("Mac") == 0;
            system.x11 = (p == "X11") || (p.indexOf("Linux") == 0);
            if(system.win||system.mac||system.xll){
                window.location.href= dz_url+'login.jsp';
            }else{
                window.location.href="/invite/com/create-wechat";

            }
        },3000);
    })
</script>
</body>
</html>
