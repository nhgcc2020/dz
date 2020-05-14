<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>扫描关注服务号</title>
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
	<!--加载公共js-->
	<script src="/common/growingio.js"></script>
	<!--<script type="text/javascript" src="js/public.js"></script>-->
	<style>
		@media only screen and (max-width: 1440px) {
			.reg_input {
				margin: 1.5rem 0;
				text-align: left;
			}
			.reg_rcon_padding{
				padding: 1rem 5rem;
			}
			.reg_bnt_mt{
				text-align: center;

			}
			.reg_info_mt{
				margin-top: 3rem;
				text-align: left;
			}
			.reg_log_width{
				width: 200px;
			}
		}
		@media only screen and (min-width: 1440px) {
			.reg_logo_margin {
				margin-bottom: 6rem;
			}
			.reg_input {
				margin: 1.5rem 0;
				text-align: left;
			}

			.reg_rcon_padding{
				padding: 1rem 7rem
			}
			.reg_bnt_mt{
				text-align: center;
				/*margin-top: 5rem;*/

			}
			.reg_info_mt{
				margin-top: 6rem;text-align: left;
			}
			.reg_log_width{
				width: 280px;
			}
			.reg_bnt{
				min-width: 330px;
				line-height: 35px !important;
				font-size: 1.2rem;
			}

			*{
				font-size: 1.1rem;
			}
			.li_left{
				margin-top:1.5rem ;
				display: inline-block;

			}
			li{
				text-align: left;
			}
		}
	</style>
</head>

<body>
<div id="content" style="height: 100%;">

	<!--左边 start-->
	<div id="leftcon" style='display: inline-block;background-color:#666699 ;width:64.5%;height: 100%'>
		<div style="text-align: center;">
			<div style="margin-top: 14rem">
				<img src="<c:url value="/images/welcome/6_title.png"/>">
			</div>
			<img src="<c:url value="/images/welcome/6_image.png"/>" style="margin-top: 10rem">
		</div>
	</div>
	<!--左边 end-->

	<!--右边 s-->
	<div style="width: 35%;display: inline-block;background-color: white;float: right;height: 100%;text-align: center;" >
		<div style="text-align: right;" class="reg_logo_margin">
			<img class="reg_log_width" src="<c:url value="/images/u0.jpg"/>" />
		</div>
		<div class="reg_rcon_padding">
			<div class="reg_input" style="text-align: left;padding-bottom: 1rem;">
				请关注我们的微信服务号！<br> 我们会将下列信息发到您的微信里，便于您邀请同事或合作伙伴！
			</div>
			<div style="border-bottom: 1px solid #999999;text-align: left;padding-bottom: 1rem;margin-bottom: 1.5rem;">
				<div style="margin-bottom: 0.5rem;">企业对账号（用于邀请好友客户或供应商）</div>
				<label style="color: #898989;">${companyView.comId}</label>
			</div>
			<div style="border-bottom: 1px solid #999999;text-align: left;padding-bottom: 1rem;margin-bottom: 1.5rem;">
				<div style="margin-bottom: 0.5rem;">内部邀请码（用于邀请企业内部同事的申请验证）</div>
				<label style="color: #898989;">${companyView.withinComId}</label>
			</div>
			<div style="text-align: center;padding-bottom: 1rem;margin-bottom: 1.8rem;">
				<img src="<c:url value="/images/u10.jpg"/>" />
			</div>

			<div class="reg_bnt_mt">
				<!--Next需要加icon-->
				<div c-widget="button; color:teal; caption:开始探索之旅！ &nbsp;&nbsp;&nbsp; >;" class="reg_bnt" onclick="window.location.href='<c:url value="/login/tomain"/>'"></div>
			</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
	cola(function(model) {
	});
	cola.on("ready", function() {
		var allHeight = $("#content").height();
		var leftconHeight = $("#leftcon").height();
		$("#leftcon").css("margin-top", (allHeight - leftconHeight) / 2);
	});
</script>

</html>