<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>注册成功页</title>
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
	<script type="text/javascript" src="resources/cola-ui/i18n/zh-CN/cola.js?v=40433415fd"></script>
	<!--加载公共js-->
	<script src="/common/growingio.js"></script>
	<!--<script type="text/javascript" src="js/public.js"></script>-->
	<script src="/resources/common/global-config.js?v=051236a6d6"></script>
	<style>

		@media only screen and (min-width: 1440px) {
			.reg_logo_margin {
				margin-top: 1rem;
				margin-right: 1rem;
				margin-bottom: 6rem;
			}
			.reg_input {
				margin: 1.5rem 0;
				text-align: left;
			}
			.reg_rcon_padding {
				padding: 1rem 7rem
			}
			.reg_bnt_mt {
				text-align: center;
				margin-top: 5rem;
			}
			.reg_info_mt {
				margin-top: 6rem;
				text-align: left;
			}
			.reg_log_width {
				width: 180px;
			}
			.reg_bnt {

				line-height: 35px !important;
				font-size: 1.2rem;
			}
			* {
				font-size: 1.1rem;
			}
			.li_left {
				margin-top: 1.5rem;
				display: inline-block;
			}
			li {
				text-align: left;
			}
		}
		@media only screen and (max-width: 1440px) {
			.reg_logo_margin {
				margin-top: 1rem;
				margin-right: 1rem;
				margin-bottom: 4rem;
			}
			.reg_input {
				margin: 1.5rem 0;
				text-align: left;
			}
			.reg_rcon_padding {
				padding: 1rem 5rem;
			}
			.reg_bnt_mt {
				text-align: center;
				margin-top: 2rem;
			}
			.reg_info_mt {
				margin-top: 3rem;
				text-align: left;
			}
			.reg_log_width {
				width: 180px;
			}
		}
		.tranform2{
			width:180px;
			height:32px;
			overflow: hidden;
			position: relative;
			cursor: pointer;
			float: right;
		}
		.tranform2>div img{
			width:180px;
			height:32px;
		}
		.tranform2>div{
			height:32px;
			width:370px;
			top:0px;
			left:0px;
			position: absolute;
			transition:all 0.2s linear;
		}
		.tranform2>div:hover{
			left:-180px;
		}
	</style>
</head>

<body>
<div id="content" style="height: 100%;">

	<!--左边 start-->
	<div id="leftcon" style='display: inline-block;background-color:#666699 ;width:64.5%;height: 100%'>
		<div style="text-align: center;">
			<div style="margin-top: 14rem">
				<img src="<c:url value="/images/welcome/6_title.png"/>" style="width: 56%;">
			</div>

			<%--/images/welcome/6_image.png--%>
			<img src="<c:url value="/images/u10.jpg"/>" style="margin-top: 10rem;width: 28%;">
		</div>
	</div>
	<!--左边 end-->

	<%--<div id="leftcon" style='display: inline-block;background-color:#4eb45e ;width:64.5%;height: 100%'>
		<div style="text-align: center;">
			<div style="margin-top: 14rem">
				<img src="<c:url value="/images/welcome/5_title.png"/>">
			</div>
			<img src="<c:url value="/images/welcome/5_image.png"/>" style="margin-top: 10rem">
		</div>
	</div>--%>

	<!--右边 s-->
	<div style="width: 35%;display: inline-block;background-color: white;float: right;height: 100%;text-align: center;" >

		<div class="reg_logo_margin tranform2" id="main_logo">
			<div>
				<img class="reg_log_width" src="<c:url value="/images/u0.jpg"/>"/>
				<img class="reg_log_width" src="<c:url value="/images/transforn2.png"/>"/>
			</div>
		</div>
		<div class="clearboth"></div>

		<div class="reg_rcon_padding">
			<div class="reg_input" style="text-align: left;padding-bottom: 0rem;">
				祝贺您成功创建企业账号，并成为该企业账号的管理员！

			</div>

			<div style="border-bottom: 1px solid #999999;text-align: left;padding-bottom: 1rem;margin-bottom: 1.5rem;">
				<div style="margin-bottom: 0.5rem;">登录账号（用户名/手机号）</div>
				<label style="color: #898989;">${user.userId}</label>
			</div>

			<div style="border-bottom: 1px solid #999999;text-align: left;padding-bottom: 1rem;margin-bottom: 1.5rem;">
				<div style="margin-bottom: 0.5rem;">真实姓名</div>
				<label style="color: #898989;">${user.realName}</label>
			</div>
			<div style="border-bottom: 1px solid #999999;text-align: left;padding-bottom: 1rem;margin-bottom: 1.5rem;">
				<div style="margin-bottom: 0.5rem;">企业名称</div>
				<label style="color: #898989;">${companyView.comName}</label>
			</div>
			<div style="border-bottom: 1px solid #999999;text-align: left;padding-bottom: 1rem;margin-bottom: 1.5rem;">
				<div style="margin-bottom: 0.5rem;">企业简称/品牌</div>
				<label style="color: #898989;">${companyView.comShortname}</label>
			</div>
			<!--<div  style="border-bottom: 1px solid #999999;text-align: left;padding-bottom: 1rem;margin-bottom: 1.5rem;">
                <div style="margin-bottom: 0.5rem;">企业对账号（用于添加好友客户或供应商）</div>
                <label style="color: #898989;">KB918898</label>
        </div>
        <div  style="border-bottom: 1px solid #999999;text-align: left;padding-bottom: 1rem;margin-bottom: 1.5rem;">
                <div style="margin-bottom: 0.5rem;">内部邀请码（用于邀请企业内部同事的申请验证）</div>
                <label style="color: #898989;">KB1888TD</label>
        </div>-->
			<%--<div style="border-bottom: 1px solid #999999;text-align: left;padding-bottom: 1rem;margin-bottom: 1.5rem;">
				<div style="margin-bottom: 0.5rem;">企业性质</div>
				<label style="color: #898989;">
					<c:if test="${companyView.comAttr eq '1'}">有限公司</c:if>
					<c:if test="${companyView.comAttr eq '2'}">个体用户</c:if>
				</label>
			</div>
			<div style="border-bottom: 1px solid #999999;text-align: left;padding-bottom: 1rem;margin-bottom: 1.5rem;">
				<div style="margin-bottom: 0.5rem;">企业区域</div>
				<label style="color: #898989;">${companyView.province}&nbsp;&nbsp;&nbsp;${companyView.city}&nbsp;&nbsp;&nbsp;${companyView.country}</label>
			</div>--%>
			<div style="border-bottom: 1px solid #999999;text-align: left;padding-bottom: 1rem;margin-bottom: 1.5rem;">
				<div style="margin-bottom: 0.5rem;">企业对账号（用于邀请好友客户或供应商）</div>
				<label style="color: #898989;">${companyView.comId}</label>
			</div>
			<div style="border-bottom: 1px solid #999999;text-align: left;padding-bottom: 1rem;margin-bottom: 1.5rem;">
				<div style="margin-bottom: 0.5rem;">内部邀请码（用于邀请企业内部同事的申请验证）</div>
				<label style="color: #898989;">${companyView.withinComId}</label>
			</div>
			<div class="reg_bnt_mt">
				<!--Next需要加icon-->
				<div c-widget="button; color:teal; caption:开始探索之旅！;click:save" class="reg_bnt"></div>
			</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
	cola(function(model) {
		model.action({
			save:function(btn){
				btn.set("disabled",true);
				btn.set("state","loading");
				window.location.href='<c:url value="/login/tomain"/>';
			}
		})
	});
	cola.on("ready", function() {
		var allHeight = $("#content").height();
		var leftconHeight = $("#leftcon").height();
		$("#leftcon").css("margin-top", (allHeight - leftconHeight) / 2);
	});
	$("#main_logo").click(function(){
		window.open(dz_url+"index.html");
	})
</script>

</html>