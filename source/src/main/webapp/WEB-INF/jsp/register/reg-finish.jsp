<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>申请成功</title>
	<!--针对移动设备,网站显示宽度等于设备屏幕显示宽度,内容缩放比例为1:1-->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<!--将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面：-->
	<meta name="renderer" content="webkit">
	<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
	<!-- css引入和样式定义区域 -->
	<link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.min.css?v=c509be79d3">
	<link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
	<link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">
	<script type="text/javascript" src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
	<script type="text/javascript" src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
	<script type="text/javascript" src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
	<script type="text/javascript" src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
	<script type="text/javascript" src="/resources/cola-ui/i18n/zh-CN/cola.js?v=40433415fd"></script>
	<!--加载公共js-->
	<script src="/common/growingio.js"></script>
	<!--<script type="text/javascript" src="js/public.js"></script>-->
</head>

<body>
<div style="background-color:#00CDCD;height: 100%;width: 15%;display: inline-block;"></div>

<div style="float: right;padding: 1rem;">
	<img width="300px" src="<c:url value="/images/u0.jpg"/>" />
</div>

<div id="content" style="width: 450px;display: inline-block;margin-left: 450px;vertical-align: top;margin-top: 300px;">
	<div style="text-align: left;">
		<img src="<c:url value="/images/welcome/welcome.png"/>"/>
		<p>申请成功！</p>
		<p>我们已经通知管理员尽快审核，审核结果会短信通知你，请注意查阅短信</p>

	</div>
	<div style="text-align: center;margin-top: 5rem;">
		<div c-widget="button; color:green; caption:完善个人账户资料;" onclick="window.location.href='/login/tomain'"></div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<div c-widget="button; class:basic;	caption:返回网站首页;"></div>
	</div>
</div>
</body>
<script type="text/javascript">
	cola(function(model) {

	});
	/*cola.on("ready", function() {
	 var allHeight = $(window).height();
	 var leftconHeight = $("#content").height();
	 $("#content").css("margin-top", (allHeight - leftconHeight) / 2-130);

	 var allWidth = $(window).width();
	 var leftconWidth = $("#content").width();
	 $("#content").css("margin-left", (allWidth - leftconWidth) / 2);

	 });*/
</script>

</html>