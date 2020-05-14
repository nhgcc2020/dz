<%--
  Created by IntelliJ IDEA.
  User: pxy
  Date: 2016/5/22
  Time: 17:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html style="height: 100%; width: 100%">

<head>
    <!--网页页面字符集-->
    <meta charset="UTF-8">
    <!--针对移动设备,网站显示宽度等于设备屏幕显示宽度,内容缩放比例为1:1-->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!--将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面：-->
    <meta name="renderer" content="webkit">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>付款成功</title>
    <!-- css引入和样式定义区域 -->
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/cola-ui/semantic.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/cola-ui/cola.css"/>">
    <script type="text/javascript" src="<c:url value='/resources/jquery/jquery-2.1.3.js'/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/cola-ui/3rd.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/cola-ui/semantic.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/cola-ui/cola.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/cola-ui/i18n/zh-CN/cola.js"/>"></script>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/cola-ui/base.css"/>">
    <!--加载公共js-->
</head>

<body style="height: 100%; width: 100%;">

<div class="pay-success">
    <img src="/images/success.jpg" alt="支付成功">支付成功
</div>

<div class="pay-success-detial">
    <p>立即扫码关注公众号 “ <span>易对账</span> “ ，接收订单-确认收货-在线支付，随时掌握生意状态！</p>
    <p>邀请好友合作伙伴使用 “ <span>易对账</span> ” ，邀请成功还能获得<i>	现金奖励</i>，还不马上行动！</p>
</div>

<div class="pay-success-code">
    <img src="/images/shark_code.png" alt="易对账">
</div>

</body>

</html>
