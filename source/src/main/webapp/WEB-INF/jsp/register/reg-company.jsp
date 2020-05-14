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
		<link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">
		<script type="text/javascript" src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
		<script type="text/javascript" src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
		<script type="text/javascript" src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
		<script type="text/javascript" src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
		<script type="text/javascript" src="/resources/cola-ui/i18n/zh-CN/cola.js?v=40433415fd"></script>
		<script src="/resources/cola-ui/china_city.js?v=bef170068c"></script>
		<script src="/resources/common/global-config.js?v=051236a6d6"></script>
		<!--加载公共js-->
		<script src="/common/growingio.js"></script>
		<!--<script type="text/javascript" src="js/public.js"></script>-->
		<style>


			.select_div {
				display: inline-block;
				width: 49.5%;
				border: 1px solid #1678C2;
				text-align: center;
				padding: 4px;
				cursor: pointer;
				color: #1678C2;
			}
			
			.unselect_div {
				display: inline-block;
				width: 49.5%;
				text-align: center;
				padding: 4px;
				cursor: pointer;
				border: 1px #DFDFDF solid;
				color: #212121;
			}

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
			.lodingBtn{
				background: gray !important;
				position:relative;
			}
			.lodingBtn:after{
				content: "";
				height:20px;
				width:20px;
				position: absolute;
				left:50%;
				margin-left:-12px;
				top:50%;
				margin-top:-12px;
				border-radius:20px;
				animation: lodingB 1.5s linear infinite;
				background: url("/images/lodingBck.png") center no-repeat;
			}
			@keyframes lodingB{
				0%{
					transform: rotate(0deg);
				}
				100%{
					transform: rotate(360deg);
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
			.ui.input.drop > .value-content{
				top:-3px;
			}
		</style>
	</head>

	<body>
		<div id="content" style="height: 100%;">
			<div id="leftcon" style='display: inline-block;background-color:#366b95 ;width:64.5%;height: 100%'>
				<div style="text-align: center;">
					<div style="margin-top: 14rem">
						<img id="leftTitle" src="<c:url value="/images/welcome/2c_title.png"/>"style="width:63%" >
					</div>
					<img id="leftImage" src="<c:url value="/images/welcome/2c_image.png"/>" style="margin-top: 10rem;width: 35%;">
				</div>
			</div>
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
					<div class="reg_input" style="text-align: left;padding-bottom: 1rem;font-size: 1.2rem;">
							创建新企业
					</div>
					<div class="reg_input" style="border-bottom: 1px solid #2E94E1;text-align: left;"></div>
					<form id="create_con">
						<input type="hidden" name="comAttr" value="1" />
						<input type="hidden" name="bossOrAdmin" value="boss"/>

						<input type="hidden" name="comProvince" value="${resultMap.region_id}"/>
						<input type="hidden" name="comCity" value="${resultMap.city_id}"/>
						<input type="hidden" name="comCountry" value=""/>
						<input type="hidden" name="industryId" value="${resultMap.industryId}"/>


						<div class="reg_input">
							<div style="margin-bottom: 0.5rem;">我的角色</div>
							<div>
								<div id="boss_div" class="select_div" onclick="boss()">
									<span style="line-height: 30px; font-size: 14px;">法人代表兼管理员</span>
									<img id="righticon2" src="<c:url value="/images/right.png"/>" width="30px" style="position: relative;vertical-align: bottom;">
								</div><div id="admin_div" class="unselect_div" onclick="admin()"><span style="line-height: 30px;font-size: 14px;">管理员</span></div>
							</div>
						</div>
						<div class="reg_input">
							<div style="margin-bottom: 0.5rem;">企业全称<span style="color: red">（注册后不可修改）</span></div>
							<div c-widget="Input;placeholder: 填写营业执照上的公司全称（在线支付要用到实名认证）;name:comName;" style="width: 100%; font-size: 12px;"></div>
						</div>
						<div class="reg_input">
							<div style="margin-bottom: 0.5rem;">简称或品牌</div>
							<div c-widget="Input;placeholder:  请填写对外的公司简称或品牌（3-8个字为宜）;name:comShortname;" style="width: 100%;font-size: 12px;"></div>
						</div>



						<div class="reg_input">
							<div style="margin-bottom: 0.5rem;">企业区域</div>
							<div class="ui form">
								<div class="fields" style="margin-bottom: 0rem !important;">
									<div id="comProvince" class="field five wide" c-widget="icon:dropdown iconfont;dropdownHeight:200px;"></div><div id="comCity" class="field five wide" c-widget="icon:dropdown iconfont;dropdownHeight:200px;"></div><div id="comCountry"  class="field six wide" c-widget="icon:dropdown iconfont;dropdownHeight:200px;"></div>
								</div>
							</div>
						</div>
						<div class="reg_info_mt">
							<%--<input type="checkbox" checked="checked" style="margin: 3px 5px 0 0;" />同意<span style="color: #2185d0;font-size: 0.89rem;">《企业用户服务协议》 与 《企业隐私保护协议》</span>--%>
						</div>
						<div class="reg_bnt_mt">
							<!--Next需要加icon-->
							<div c-widget="button; color:teal; click:save" class="reg_bnt">下一步</div>
							<%--<button c-widget="click:save" class="reg_bnt">下一步</button>--%>
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
	<script type="text/javascript">
		cola(function(model) {
			model.set("provinceList",ProvinceJson);
			var nowCityArray = new Array();
			for(var i=0;i<CityJson.length;i++){
				if(CityJson[i].provinceId == '${resultMap.region_id}'){
					nowCityArray.push(CityJson[i])
				}
			}
			model.set("cityList",nowCityArray);

			var countryArray = new Array();
			for(var i=0;i<CountryJson.length;i++){
				if(CountryJson[i].cityId == '${resultMap.city_id}'){
					countryArray.push(CountryJson[i])
				}
			}
			model.set("countryList",countryArray);


			model.action({
				change_con:function(self,arg) {
					console.info(arg);
					if(arg.value == "1"){
						$("#create_con").show();
						$("#add_con").hide();
						//修改配色
						var leftTitleUrl = "<c:url value="/images/welcome/2c_title.png"/>";
						var leftImageUrl = "<c:url value="/images/welcome/2c_image.png"/>";

						$("#leftTitle").attr("src",leftTitleUrl);
						$("#leftImage").attr("src",leftImageUrl);
						$("#leftcon").css("background-color","#366b95");
					}else{
						$("#create_con").hide();
						$("#add_con").show();
						//修改配色
						var leftTitleUrl = "<c:url value="/images/welcome/2j_title.png"/>";
						var leftImageUrl = "<c:url value="/images/welcome/2j_image.png"/>";

						$("#leftTitle").attr("src",leftTitleUrl);
						$("#leftImage").attr("src",leftImageUrl);
						$("#leftcon").css("background-color","#eb9c37");
					}

				},
				save:function (btn) {
					btn.set("disabled",true);
					btn.set("state","loading");
					cola.widget("comProvince").get("value") != undefined ? $("input[name='comProvince']").val(cola.widget("comProvince").get("value")) : "";
					cola.widget("comCity").get("value") != undefined ? $("input[name='comCity']").val(cola.widget("comCity").get("value")) : "";
					cola.widget("comCountry").get("value") != undefined ? $("input[name='comCountry']").val(cola.widget("comCountry").get("value")) : "";
					$.post(
							"<c:url value="/reg/saveCom"/>",
							$("#create_con").serialize(),
							function (data) {
								if(data=="1"){
									window.location.href="<c:url value="/reg/create_succ"/>";
								}else{
									btn.set("disabled",false);
									btn.set("state","");
									$("<div class='tips_contants'>").fadeIn(250).html("失败").delay(3000).fadeOut(250).appendTo('body');
								}
							}
					);
				}
			});

			model.widgetConfig({
				//所在省
				comProvince:{
					$type: "dropdown",
					items: "{{provinceList}}",
					openMode: "drop",
					valueProperty:"provinceId",
					textProperty:"provinceName",
					value:"${resultMap.region_id}",
					change:function (self,arg) {
						nowCityArray.splice(0,nowCityArray.length);
						for(var i=0;i<CityJson.length;i++){
							if(CityJson[i].provinceId == self.get("value")){
								nowCityArray.push(CityJson[i])
							}
						}
						model.set("cityList",nowCityArray);
						cola.widget("comCity").set("value","");
						cola.widget("comCountry").set("value","");

						/*$.post("/place/citybyprovince",{"provinceId":self.get("value")},function(data){
							model.set("cityList",eval("("+data+")"));
							cola.widget("comCity").set("value","");
							cola.widget("comCountry").set("value","");

						});*/
					}
				},
				//所在市
				comCity:{
					$type: "dropdown",
					items: "{{cityList}}",
					openMode: "drop",
					valueProperty:"cityId",
					textProperty:"cityName",
					value:"${resultMap.city_id}",
					change:function (self,arg) {
						countryArray.splice(0,countryArray.length);
						for(var i=0;i<CountryJson.length;i++){
							if(CountryJson[i].cityId == self.get("value")){
								countryArray.push(CountryJson[i])
							}
						}
						model.set("countryList",countryArray);
						cola.widget("comCountry").set("value","");
						/*$.post("/place/countrybycity",{"cityId":self.get("value")},function(data){
							model.set("countryList",eval("("+data+")"));
							cola.widget("comCountry").set("value","");
						})*/
					}
				},
				//所在县
				comCountry:{
					$type: "dropdown",
					items: "{{countryList}}",
					openMode: "drop",
					valueProperty:"countryId",
					textProperty:"countryName"
				}
			});

		});
		cola.on("ready", function() {
			var allHeight = $("#content").height();
			var leftconHeight = $("#leftcon").height();
			$("#leftcon").css("margin-top", (allHeight - leftconHeight) / 2);
		});

		function boss() {
			$("#righticon2").remove();
			$("#boss_div").append('<img id="righticon2" src="<c:url value="/images/right.png"/>" width="30px" style="position: relative;vertical-align: bottom;">');
			$("#admin_div").removeClass("select_div")
			$("#admin_div").addClass("unselect_div")
			$("#boss_div").removeClass("unselect_div");
			$("#boss_div").addClass("select_div");
			$("input[name='bossOrAdmin']").val("boss");
		}

		function admin(){
			$("#righticon2").remove();
			$("#admin_div").append('<img id="righticon2" src="<c:url value="/images/right.png"/>" width="30px" style="left: 2rem;position: relative;vertical-align: bottom;">');
			$("#boss_div").removeClass("select_div")
			$("#boss_div").addClass("unselect_div")
			$("#admin_div").removeClass("unselect_div");
			$("#admin_div").addClass("select_div");
			$("input[name='bossOrAdmin']").val("admin");
		}

		$("#main_logo").click(function(){
			window.open(dz_url+"index.html");
		})
	</script>

</html>
