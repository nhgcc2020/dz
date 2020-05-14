<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>公司注册</title>
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
		<!--<script type="text/javascript" src="js/public.js"></script>-->
		<script src="/common/growingio.js"></script>
		<style>
			@media only screen and (min-width: 1440px) {
				.reg_logo_margin {
					margin-top: 1rem;
					margin-right: 1rem;
					margin-bottom: 6rem;
				}
				.reg_input {
					margin: 2rem 0;
					text-align: left;
				}
				.reg_rcon_padding {
					padding: 1rem 7rem
				}
				.reg_bnt_mt {
					text-align: center;
					margin-top: 2.6rem;
				}
				.reg_info_mt {
					margin-top: 6rem;
					text-align: left;
				}
				.reg_log_width {
					width: 180px;
				}
				.reg_bnt {
					width: 145px;
					line-height: 35px !important;
					font-size: 1.2rem;
				}
				* {
					font-size: 1.1rem;
				}
			}

			@media only screen and (max-width: 1440px) {
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
			#comTypeRg div:first-child{
				margin-right: 8rem;
			}
			.name-sure{
				padding:0px 7px !important;
				background-color: #fff !important;
				border: 1px solid #adadad !important;
				cursor: default;
				height: 30px;
				line-height: 27px !important;
				font-weight: normal;
			}
			.name-sure span{
				font-size: 12px !important;
			}
		</style>
	</head>

	<body>
		<div id="content" style="height: 100%;">
			<div id="leftcon" style='display: inline-block;background-color:#eb9c37 ;width:64.5%;height: 100%'>
				<div style="text-align: center;">
					<div style="margin-top: 14rem">
						<img id="leftTitle" src="/images/welcome/2j_title.png"style="width:63%">
					</div>
					<img id="leftImage" src="/images/welcome/2j_image.png" style="margin-top: 10rem;width: 35%;">
				</div>
			</div>
			<!--右边 s-->
			<div style="width: 35%;display: inline-block;background-color: white;float: right;height: 100%;text-align: center;" >
				<div style="text-align: right;" class="reg_logo_margin">
					<img class="reg_log_width" src="/images/u0.jpg">
				</div>
				<!---->
				<div class="reg_rcon_padding">

					<div class="reg_input" style="text-align: left;padding-bottom: 1rem;font-size: 1.2rem;">
						<%--你可以选择创建新企业，或加入已创建企业--%>
							加入已创建企业
					</div>
					<div class="reg_input" style="border-bottom: 1px solid #2E94E1;text-align: left;"></div>
					<from id="add_con">
						<div style="margin: 2rem 0;text-align: left;">
							<span style="color: red;">重要提示：</span>可以加入多家企业，加入前需从管理员处获得内部邀请码
						</div>

						<div class="reg_input" style="margin-bottom: 1rem;">
							<div style="margin-bottom: 0.5rem;">真实姓名</div>
							<div c-widget="Input;iconPosition:left; value:${sessionScope.sessionUser.realName}; labelPosition:right" style="width: 100%;">
								<div c-widget="Label; text:请确认这是您的真实姓名" class="name-sure"></div>
							</div>

						</div>

						<div class="reg_input">
							<div style="margin-bottom: 0.5rem;">内部邀请码</div>
							<div c-widget="Input;placeholder: 请输入10位数字字母组合的内部邀请码;name:insideCode" style="width: 100%;"></div>
						</div>
						<!--<div style="margin: 1rem 0; text-align: left;">
					请确认这是您的真实姓名，以便您要加入的企业账户管理员识别
				</div>-->
						<div style="text-align: left;margin-top: 2.5rem;">
							<!--Next需要加icon-->
							<div c-widget="button;class:basic;color:blue; caption:检索该企业;click:showHeader2" style="width: 173px;"></div>
							<!--<div c-widget="button; color:teal; caption:下一步 &nbsp;&nbsp;&nbsp; >;" class="reg_bnt" onclick="window.location.href='3.html'"></div>-->
						</div>
						<div id="search2" style="text-align: left;margin-top: 2rem;display: none;">没有查询到符合该内部邀请码的企业，请核对后重新查询。</div>
						<div id="search" style="text-align: left;margin-top: 2rem;display: none;">
							<input  id="comKey"  type="hidden">
							<p>
								企业名称&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#2F71A9;"><label id="cName_show"></label></span>
							</p>
							<p>
								内部邀请码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#2F71A9;"><label id="cCode_show"></label></span><br>
							</p>
							<p>
								管理人员&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#2F71A9;"><label id="cUser_show"></label></span><br>
							</p>
							<p>
								手机号码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#2F71A9;"><label id="cPhone_show"></label></span><span style="color:#2F71A9;"></span>
							</p>
							<div style="text-align: center;">
								<div c-widget="button; color:teal;click:apply;caption:申请加入 &nbsp;&nbsp;&nbsp;" class="reg_bnt"></div>
							</div>

						</div>
					</from>


				</div>
			</div>
		</div>
	</body>
	<script type="text/javascript">

		cola(function(model) {

			model.action({
				//查找企业信息
				showHeader2: function() {
					var insideCode = $('input[name="insideCode"]').val();
					$.post(
							"/reg/findByCom",
							{insideCode:insideCode},
							function (data) {
								if(data == 'null'){
									$("#search2").show();
								}else{
									var com = data;
									$("#cName_show").text(com.comName);
									$("#cCode_show").text(com.withinComId);
									$("#cUser_show").text(com.adminName);
									$("#cPhone_show").text(com.adminPhone);
									$('#comKey').val(com.comKey);
									$("#search").show();
								}

							}
					)

				},
				apply:function(btn){
					btn.set("disabled",true);
					btn.set("state","loading")
					var comName = $("#cName_show").text();
					var comKey  = $("#comKey").val();
					$.ajax({
						type: "POST",
						url: "/reg/applyCom",
						data: {comName:comName,comKey:comKey},
						async:"false",
						dataType: "json",
						success:function(callback){
							if(callback =="1"){
								window.location.href="/reg/add_succ";
								btn.set("disabled",false);
								btn.set("states","");
							}else{
								$("<div class='tips_contants'>").fadeIn(250).html("申请失败失败").delay(500).fadeOut(250).appendTo('body');
								//cola.alert("申请失败失败",{title: "提示", level: "warning"});
								btn.set("disabled",false);
								btn.set("states","");
							}
						}
					})
				}

			});

		});
		cola.on("ready", function() {
			var allHeight = $("#content").height();
			var leftconHeight = $("#leftcon").height();
			$("#leftcon").css("margin-top", (allHeight - leftconHeight) / 2);
		});

	</script>

</html>