<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="format-detection" content="telephone=no" />
    <meta http-equiv="x-rim-auto-match" content="none">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>创建成功</title>
    <link href="/wechat/css/mui.min.css?v=57ec55e59d" rel="stylesheet"/>
    <link href="/wechat/css/main.css?v=9e61f29840" rel="stylesheet"/>
    <script type="text/javascript" src="/wechat/js/jquery-1.8.3.min.js?v=3576a6e73c"></script>
</head>
<body>

<header class="mui-bar mui-bar-nav heard_nav">
    <h1 class="mui-title">创建成功</h1>
</header>

<div class="mui-content">
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
            <button type="button" class="mui-btn mui-btn-primary" id="copyBtn">注册成功</button>
        </div>
    </div>
</div>
<div class="button-copyright" style="margin-top: 95px;">上海仁石科技有限公司欢迎您注册使用易对账!</br>Copyright@2016 沪 ICP备16005067</div>
<script>
    $("#copyBtn").click(function(){
            window.location.href="/invite/com/create-wechat";
    })
</script>
</body>
</html>
