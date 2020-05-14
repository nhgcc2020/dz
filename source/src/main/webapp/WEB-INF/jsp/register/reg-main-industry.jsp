<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>选择大行业</title>
	<!--针对移动设备,网站显示宽度等于设备屏幕显示宽度,内容缩放比例为1:1-->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<!--将下面的 <meta> 标签加入到页面中，可以让部分国产浏览器默认采用高速模式渲染页面：-->
	<meta name="renderer" content="webkit">
	<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
	<!-- css引入和样式定义区域 -->
	<link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
	<link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">
	<link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
	<script type="text/javascript" src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
	<script type="text/javascript" src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
	<script type="text/javascript" src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
	<script type="text/javascript" src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
	<script type="text/javascript" src="/resources/cola-ui/i18n/zh-CN/cola.js?v=40433415fd"></script>
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

			.reg_rcon_padding{
				padding: 1rem 7rem
			}
			.reg_bnt_mt{
				text-align: center;
				margin-top: 2.5rem;

			}
			.reg_info_mt{
				margin-top: 6rem;text-align: left;
			}
			.reg_log_width{
				width: 180px;
			}
			.reg_bnt{
				width: 145px;
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
		@media only screen and (max-width: 1440px) {
			.reg_logo_margin {
				margin-top: 1rem;
				margin-right: 1rem;
				margin-bottom: 3rem;
			}
			.reg_input {
				margin: 1.5rem 0;
				text-align: left;
			}
			.reg_rcon_padding{

				padding: 1rem 5rem;
			}
			.reg_bnt_mt{
				text-align: center;
				margin-top: 2rem;
			}
			.reg_info_mt{
				margin-top: 3rem;
				text-align: left;
			}
			.reg_log_width{
				width: 180px;
			}
			.li_left{
				margin-top:2px;
				display: inline-block;

			}
			li{
				text-align: left;
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


	<div id="leftcon" style='display: inline-block;background-color:#4eb45e ;width:64.5%;height: 100%'>
		<div style="text-align: center;">
			<div style="margin-top: 14rem">
				<img src="<c:url value="/images/welcome/5_title.png"/>" style="width:51%">
			</div>
			<img src="<c:url value="/images/welcome/5_image.png"/>" style="margin-top: 10rem;width: 33%;">
		</div>
	</div>

	<%--<div id="leftcon" style='display: inline-block;background-color:#ff477d ;width:64.5%;height: 100%'>
		<div style="text-align: center;">
			<div style="margin-top: 14rem">
				<img src="<c:url value="/images/welcome/3_title.png"/>">
			</div>
			<img src="<c:url value="/images/welcome/3_image.png"/>" style="margin-top: 10rem">
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
			<div>
				<div class="reg_input" style="text-align: left;padding-bottom: 2rem;">
					请选择一个大行业（单选项）

				</div>
				<input type="hidden" id="mId" />
				<div  style="border-bottom: 1px solid #2E94E1;text-align: left;padding-bottom: 1rem;margin-bottom: 0.5rem;">
					<i class="iconfont font_checked checkereding" onclick="change(this)" name="check_right" data-value="1">&#xe6a9;</i>
					<%--<img src="<c:url value="/images/u2.png"/>" onclick="change(this)" name="check_right" data-value="1" style="width: 1.5rem;height: 1.5rem;" />--%>
					<label style="margin-left:15px;vertical-align: super;">
						泛广告印刷包装行业上下游企业
					</label >
				</div>
				<ul class="small-block-grid-2 medium-block-grid-3 large-block-grid-4 xlarge-block-grid-4">
					<li><span class="li_left l-60">广告设计</span></li>
					<li><span class="li_left l-60">媒体代理</span></li>
					<li><span class="li_left l-60">喷绘写真</span> </li>
					<li><span class="li_left l-60">字牌雕刻</span> </li>


					<li><span class="li_left l-60">条幅制作</span> </li>
					<li><span class="li_left l-60">婚庆公司</span> </li>

					<li><span class="li_left l-60">印刷厂</span> </li>
					<li><span class="li_left l-60">包装厂</span></li>
					<li><span class="li_left l-60">CTP输出</span> </li>
					<li><span class="li_left l-60">后道加工</span> </li>
					<li><span class="li_left l-60">器材租赁</span> </li>
					<li><span class="li_left l-60">会展公司</span> </li>
					<li><span class="li_left l-85">广告耗材经销</span></li>
					<li><span class="li_left l-85">印刷耗材经销</span></li>
					<li><span class="li_left l-85">广印设备经销</span></li>
				</ul>
			</div>


			<div style="margin-top: 3rem;">
				<div  style="border-bottom: 1px solid #2E94E1;text-align: left;padding-bottom: 1rem;margin-bottom: 0.5rem;">
					<i class="iconfont font_checked">&#xe68f;</i>
					<%--<img src="<c:url value="/images/u48.png"/>" &lt;%&ndash;onclick="change(this)"&ndash;%&gt; name="check_right" data-value="2" style="width: 1.5rem;height: 1.5rem;" />--%>
					<label style="margin-left: 15px;vertical-align: super;" class="display_hid">
						现代服务业
					</label >
				</div>
				<ul class="small-block-grid-2 medium-block-grid-3 large-block-grid-4 xlarge-block-grid-4 display_hid">
					<li><span class="li_left l-60">财务代账公司</span></li>
					<li><span class="li_left l-60">孵化器/众创空间</span></li>
					<li><span class="li_left l-60">
互联网软件行业
</span> </li>
					<li><span class="li_left l-60">培训教育行业</span> </li>
				</ul>
			</div>

			<div style="margin-top: 3rem;">
				<div  style="border-bottom: 1px solid #2E94E1;text-align: left;padding-bottom: 1rem;margin-bottom: 0.5rem;">
					<i class="iconfont font_checked">&#xe68f;</i>
					<%--<img src="<c:url value="/images/u48.png"/>" &lt;%&ndash;onclick="change(this)"&ndash;%&gt; name="check_right" data-value="3" style="width: 1.5rem;height: 1.5rem;" />--%>
					<label style="margin-left: 15px;vertical-align: super;" class="display_hid">
						其他行业
					</label >
				</div>
				<ul class="small-block-grid-2 medium-block-grid-3 large-block-grid-4 xlarge-block-grid-4 display_hid">
					<li><span class="li_left l-60">数码3C类</span></li>
					<li><span class="li_left l-60">家用电器</span></li>
					<li><span class="li_left l-60">五金建材</span> </li>
					<li><span class="li_left l-60">文体用品</span> </li>

					<li><span class="li_left l-60">家居装饰</span></li>
					<li><span class="li_left l-60">电子电气</span></li>
					<li><span class="li_left l-60">汽修汽配</span> </li>
					<li><span class="li_left l-60">母婴用品</span> </li>
				</ul>
			</div>
			<div class="reg_bnt_mt">
				<!--Next需要加icon-->
				<div c-widget="button; color:teal; caption:下一步;click:save" class="reg_bnt"></div>
			</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
	var mId=1;

	function change(img){
	 	mId	= $(img).data("value");
		console.info(mId);

		$("img[name='check_right']").attr("src","<c:url value="/images/u48.png"/>");
		$(img).attr("src","<c:url value="/images/u2.png"/>");
	}
	cola(function(model) {
		model.action({
			save:function (btn) {
				btn.set("disabled",true);
				btn.set("state","loading");
				window.location.href="<c:url value="/reg/detail-industry"/>";

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