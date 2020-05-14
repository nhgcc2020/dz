<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>微信消息采购对账单明细页面</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<link rel="stylesheet" href="/wechat/css/mui.min.css">
		<link rel="stylesheet" href="/wechat/css/main.css">
		<link rel="stylesheet" href="/wechat/css/model.css">
		<script src="/common/growingio.js"></script>
	</head>

	<body>
		<!--这个是加载框，切勿修改-->
		<div class="loadingssss loading_box"><span></span></div>

		<div class="mui-content">
			<div class="Cooperation_information" id="Cooperation_information"></div>

			<div class="order_new_contant" id="order_new_contant"></div>


			<div class="table_detail" >
				<ul id="table_detail"></ul>
			</div>

			<div class="remark" id="remark"></div>


			<!--<div class="mui-button-row lay_out" style="margin: 20px 5% 15px;">
				<button type="button" class="mui-btn mui-btn-primary" id="daishouhuoNum"></button>
			</div>-->

			<br>
		</div>

	</body>
	<script src="/wechat/js/jquery-1.8.3.min.js"></script>
	<script src="/wechat/js/main.js"></script>
	<script>
		var purchasecheckingNo = GetRequest().purchasecheckingNo;		//获取订单号
		var orderStatus = String(GetRequest().orderStatus);		//获取传过来的值
		//判断从上一个页面传递过来的值
		if(orderStatus == 09){
			$("#daishouhuoNum").html("返回待付款");
			$("#daishouhuoNum").click(function(){
				window.location="synchpurchasechecking-order-list.html?tab=1";
			});
		}else if(orderStatus == 10){
			$("#daishouhuoNum").html("返回已付款");
			$("#daishouhuoNum").click(function(){
				window.location="synchpurchasechecking-order-list.html?tab=2";
			});
		}
		var selectVos;
		var orderDate;
		$.ajax({
			url:'../../../wx/menu/purchaseCheckingOrderVo',
			type:'GET',
			async:true,
			data:{purchasecheckingNo:purchasecheckingNo}, //传递参数
			dataType:"json",
			timeout:"10000",
			success:function(data){
				orderDate = data.orderDate;
				var salesNo = data.salesNo;
				$(".loading_box").removeClass("loadingssss");
				selectVos = data.selectVos;
				document.getElementById('Cooperation_information').innerHTML =
						"<p>"+"<span class='detial_left'>供应商：</span>"+data.partnerShortname+"</p>"
						+"<p>"+"<span class='detial_left'>对账单日期：</span>"+data.orderDate+"</p>"
						+"<p>"+"<span class='detial_left'>对账单号：</span>"+data.purchasecheckingNo+"</p>"
						+"<p>"+"<span class='detial_left'>对账单金额：</span>"+(data.totalPrice).toFixed(2)+"</p>"
						+"<p>"+"<span class='detial_left'>项目名称：</span>"+data.caseDesc+"</p>";

				document.getElementById('table_detail').innerHTML =
						"<li>"+"<span class='detial_left'>合计金额：</span>"+(data.price).toFixed(2)+"</li>"
						+"<li>"+"<span class='detial_left'>折扣优惠：</span>-&nbsp;"+(data.discount).toFixed(2)+"</li>"
						+"<li>"+"<span class='detial_left'>减免金额：</span>-&nbsp;"+(data.preferential).toFixed(2)+"</li>"
						+"<li>"+"<span class='detial_left'>税款金额：</span>"+(data.taxPrice).toFixed(2)+"</li>"
						+"<li>"+"<span class='detial_left'>对账单金额：</span>"+(data.totalPrice).toFixed(2)+"</li>"
						+"<li>"+"<span class='detial_left'>预付金额：</span>-&nbsp;"+(data.depositRequested).toFixed(2)+"</li>"
						+"<li>"+"<span class='detial_left'>应付金额：</span>"+(data.receivablesMoney).toFixed(2)+"</li>"
						+"<li>"+"<span class='detial_left'>实付金额：</span>"+(data.paidUp).toFixed(2)+"</li>"
						+"<li>"+"<span class='detial_left'>制单时间：</span>"+data.createTime+"</li>";

				document.getElementById('remark').innerHTML =
						"<p>备注：</p>"
						+"<p>"+data.remarks+"</p>";
				var allDetails = {};
				$.each(data.details,function(key,val){
					var businessType =  val.businessType;
					if(allDetails[businessType] == undefined){
						var subDetails = new Array();
						subDetails.push(val);
						allDetails[businessType] = subDetails;
					}else{
						allDetails[businessType].push(val);
					}

				});
				for(var detailObj in allDetails){
					Createlement(allDetails[detailObj]);
				}
			},
			error:function(){
				$("<div class='error_tips'>").fadeIn(250).html("数据请求失败").delay(500).fadeOut(250).appendTo("body");
			}
		})

		function Createlement(val){
			var businessType = val[0].businessType;
			var businessTypeview ;
			for(var num=0;num < selectVos.length;num++){
				if(selectVos[num].value== businessType){
					businessTypeview = "明细";
				}
			}
			var htmlStr =
					"<div class='order_new_list'>"+
					"<h2>"+businessTypeview+"<span>共计"+val.length+"条</span> <b class='iconfont'>&#xe68d;</b></h2>"+
					"<ul>";
			for(var i = 0; i < val.length; i++){
				var myUrl = encodeURI(encodeURI("order-detail-next.html?purchasecheckingNo="+val[i].purchasecheckingNo+"&&orderStatus="+orderStatus+"&&orderDate="+orderDate+"&&businessTypeview="+businessTypeview));
				htmlStr +=
						"<li>"
						+"<a>"
						+"<h4>"+val[i].businessDesc+"</h4>"
						+"<p>"+"物料制作："+val[i].requirements+"</p>"
						+"<p>"+val[i].length+"m"+"*"+val[i].width+"m"+"<span>"+val[i].quantity+"</span>"+"<span>￥"+val[i].totalPrice.toFixed(2)+"</span>"+"</p>"
						+"</a>"
						+"</li>"
			}
			htmlStr += "</ul>"+ "</div>";
			$("#order_new_contant").append(htmlStr);
		}

		//tab点击切换
		$('.order_new_contant').on("click",".order_new_list h2",function(){
			$(this).children('b').toggleClass('active');
			$(this).next('ul').slideToggle(500);
		})


	</script>
</html>