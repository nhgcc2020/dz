<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--
  Created by IntelliJ IDEA.
  User: pxy
  Date: 16/9/19
  Time: 上午1:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
    <title>联合登录</title>
    <link href="/wechat/css/mui.min.css?v=57ec55e59d" rel="stylesheet"/>
    <link href="/wechat/css/main.css?v=9e61f29840" rel="stylesheet"/>
    <script src="/wechat/js/mui.min.js?v=eda48251a7"></script>
    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
</head>
<body>


<div class="mui-content">
    <div class="mui-content-padded related_account">
        <div class="header_img"><img id="header" style="border-radius: 80px" src="${user.avatarPath}" alt="头像" /></div>
        <p>亲爱的微信用户：<span id="nickName">${user.nickName}</span><br><span>为了给您更好的服务，请关联一个易对账账号</span></p>
        <p>已有易对账账号？</p>
        <a href="/wechat/member/account-relating.html?openId=${user.bindWechat}" type="button" class="mui-btn mui-btn-outlined" id="related">立即关联</a>
    </div>
</div>
</body>
</html>