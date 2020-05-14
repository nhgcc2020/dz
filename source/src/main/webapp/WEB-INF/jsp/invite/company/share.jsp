<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>创建成功</title>
    <script src="/wechat/js/mui.min.js?v=eda48251a7"></script>
    <link href="/wechat/css/mui.min.css?v=57ec55e59d" rel="stylesheet"/>
    <link href="/wechat/css/main.css?v=9e61f29840" rel="stylesheet"/>
    <script type="text/javascript" src="/wechat/js/jquery-1.8.3.min.js?v=3576a6e73c"></script>
    <script type="text/javascript" src="/resources/cola-ui/china_city.js?v=bef170068c"></script>
    <style>
        .shark_contant{
            background: #fff;
            /*height:100%;*/
            max-width:640px;
            margin: 0px auto;
        }
        .create_success{
            text-align: center;
            padding-top: 50px ;
        }
        .create_success img{
            height:60px;
            width: 60px;
        }
        .create_success p{
            font-size: 30px;
            margin-top: 30px;
            color: #3DCC74;
        }
        .create_link{
            text-align: center;
            height:72px;
            line-height: 36px;
            color: #666;
            position: absolute;
            top:50%;
            width:100%;
            left: 0px;
            margin-top:-36px;
        }
        .create_desc{
            text-align: center;
            padding-top: 10px ;
            font-size: 16px;
            color: #3DCC74;
        }
        .iconfont{
            position: absolute;
            top:50px;
            font-size: 120px;
            left: 56px;
            color: #ccc;
        }
    </style>
</head>
<body>

<div class="shark_contant">
    <div class="create_success">
        <img src="/wechat/image/u8087.png" alt="">
        <p>注册成功</p>
    </div>
    
    <div class="create_desc">接收好友订单&nbsp;&nbsp;对账轻松搞定</div>
    <%--<div class="create_link"></div>--%>
     <!--href="/download/file/androidapp?key1=8D41656D58729589BF122DC28C3271E5"-->
    <div style="display:block;margin:20px auto;width:230px;height:190px;position:relative;border:1px solid #e3e3e3;">
        <i class="iconfont">&#xe683;</i>
        <p style="position:absolute;top:130px;left:24px;background:#fff;">
            <a href="https://www.yiduizhang.com/download/file/androidapp?key1=8D41656D58729589BF122DC28C3271E5
">下载安卓APP</a>&#x3000;
            <a href="https://itunes.apple.com/cn/app/%E6%98%93%E5%AF%B9%E8%B4%A6/id1274034557?mt=8"> 下载苹果APP</a>
        </p>
    </div>
     <div onclick="forwardOffical()" style="margin: auto;width:230px;height: 190px;position:relative;border:1px solid #e3e3e3;">
        <i class="iconfont">&#xe66b;</i>
        <p style="text-align:center;position:absolute; top:120px;width:100%;">电脑访问<br>www.yiduizhang.com</p>
    </div>
    <%--<div style="    margin: auto;--%>
    <%--background: url(/wechat/image/h5.png) no-repeat center;--%>
    <%--width: 100%;--%>
    <%--background-size: 100%;--%>
    <%--height: 6670px;"></div>--%>
    <%--<div><img style="width:100%;" src="/wechat/image/h5.png"></div>--%>
</div>

<script>
    function IsPC() {
        var userAgentInfo = navigator.userAgent;
        var Agents = ["Android", "iPhone",
            "SymbianOS", "Windows Phone",
            "iPad", "iPod"];
        var flag = true;
        for (var v = 0; v < Agents.length; v++) {
            if (userAgentInfo.indexOf(Agents[v]) > 0) {
                flag = false;
                break;
            }
        }
        return flag;
    }

    function forwardOffical() {
        if(IsPC()){window.location.href="/login.jsp";}
    }
    function downApp() {
//        window.open("/download/file/androidapp?key1=8D41656D58729589BF122DC28C3271E5");
        window.location.href="/resources/images/pricewaynew.png";
    }
    //    if(IsPC()){setTimeout(function(){window.location.href="/login.jsp";},3000);}
</script>
</body>
</html>
