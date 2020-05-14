<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
        <title>邀请链接已失效</title>
        <script src="/wechat/js/mui.min.js?v=eda48251a7"></script>
        <link href="/wechat/css/mui.min.css?v=57ec55e59d" rel="stylesheet"/>
        <link href="/wechat/css/main.css?v=9e61f29840" rel="stylesheet"/>
        <script type="text/javascript" src="/wechat/js/jquery-1.8.3.min.js?v=3576a6e73c"></script>
        <style>
            body, .mui-content{
                background-color: #fff;
            }
            .shark_contant{
                background: #fff;
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
                color: #ff3300;
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
                padding-top: 30px ;
                font-size: 16px;
                color: #3DCC74;
            }
        </style>
    </head>
<body>

<div class="shark_contant">
    <div class="create_success">

        <span style="    font-size: 80px;
    color: #ff3300;" class="iconfont">&#xe6c9;</span>
        <p>短信失效</p>
    </div>
    <div class="create_desc" style="color:#2e8ae6;margin-bottom: 60px;">对方可能发送了新的邀请短信</div>
    <div style="font-size: 16px;margin: 10px auto 0;text-align: center">详情咨询</div>
    <div style="margin: 25px auto 0;text-align: center;color: #3DCC74;font-size: 20px;" id="comShortname"></div>
    <div style="margin: 15px auto 0;text-align: center;color: #3DCC74;"><span id="userName"></span>&nbsp;&nbsp;&nbsp;<span id="tel"></span></div>
</div>

<script>
    $(function () {
        $("#comShortname").text("${comShortname}");
        $("#userName").text("${userName}");
        $("#tel").text("${tel}");
    })
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
    function getRequest() {
        var url = location.search; //获取url中"?"符后的字串
        var theRequest = new Object();
        if (url.indexOf("?") != -1) {
            var str = url.substr(1);
            strs = str.split("&");
            for (var i = 0; i < strs.length; i++) {
                theRequest[strs[i].split("=")[0]] = unescape(strs[i].split("=")[1]);
            }
        }
        return theRequest;
    }
    function forwardOffical() {
        if(IsPC()){window.location.href="/login.jsp";}
    }

    //    if(IsPC()){setTimeout(function(){window.location.href="/login.jsp";},3000);}
</script>
</body>
</html>

