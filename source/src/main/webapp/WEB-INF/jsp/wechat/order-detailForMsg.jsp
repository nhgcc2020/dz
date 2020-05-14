<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: pxy
  Date: 16/9/21
  Time: 下午9:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>微信消息采购订单详情</title>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <link rel="stylesheet" href="/wechat/css/mui.min.css?v=57ec55e59d">
    <link rel="stylesheet" href="/wechat/css/main.css?v=9e61f29840">
    <link rel="stylesheet" href="/wechat/css/model.css?v=8eaf90bd68">
</head>
<style>
	.delivery {
		position: fixed;
		display: none;
		top: 20%;
		width: 84%;
		background: #fff;
		left: 8%;
		border-radius: 10px;
		z-index: 999;
		text-align: center;
		box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
	}

	.delivery>p:nth-child(1) {
		margin: 60px 0 5px 0;
		font-size: 18px;
		color: #333;
	}

	.delivery>p:nth-child(2) {
		font-size: 14px;
		color: #999;
	}

	.delivery>div {
		color: #ccc;
		border-top: 1px solid #f2f2f2;
		line-height: 50px;
		display: flex;
	}

	.delivery>img {
		margin: 44px 0 90px;
		width: 145px;
		height: 80px;
	}

	.delivery>i {
		position: absolute;
		top: 8px;
		right: 5px;
		font-size: 30px;
		color: #ccc;
	}
</style>

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

    <div class="mui-button-row lay_out" style="margin: 20px 5% 15px;position:fixed;bottom:0px;">
			<button type="button" class="mui-btn mui-btn-primary construction" style="background:#2e8ae6;color:#fff;display:none;">确认收货</button>
	</div>
   <%-- <div class="mui-button-row lay_out">
        <button type="button" class="mui-btn mui-btn-primary" id="daishouhuoNum"></button>
    </div>--%>
    <div class="delivery">
		<p>确认收货</p>
		<p>收货信息将会记录在订单/对账单详情中</p>
		<img src="../../../wechat/image/delivery.png" alt="">
		<div>
			<div class="abolish" style="flex:1;">取消</div>
			<div class="determine" style="flex:1;border-left:1px solid #f2f2f2;color:#4284d9;">确定</div>
		</div>
		<i class="iconfont abolish">&#xe6a0;</i>
	</div>
   <!--  <div class="mui-button-row lay_out">
        <button type="button" class="mui-btn mui-btn-primary" id="sure-product"></button>
    </div> -->
</div>

</body>
<script src="/wechat/js/jquery-1.8.3.min.js?v=3576a6e73c"></script>
<script src="/wechat/js/main.js?v=7a85ec546f"></script>
<script>
    var purchaseNo = "${purchaseNo}";		//获取协同采购订单号
    var salesNo = "${salesNo}";
    var nowStatus = "01";
    //判断从上一个页面传递过来的值
        /*$("#daishouhuoNum").html("返回待收货订单");*/
        //收货
        $('#sure-product').click(function(){

            if(nowStatus == "03"){
                $.ajax({
                    url:'/wx/synchroPurchase/takeover',
                    type:'GET',
                    async:true,
                    data:{purchaseNoIns:purchaseNo,orderStatus:"04",salesNoIns:salesNo}, //传递参数
                    dataType:"json",
                    success:function(data){
                        $("<div class='error_tips'>").fadeIn(250).html("收货成功").delay(5000).fadeOut(250).appendTo("body");
                        /*setTimeout(function () {
                            window.location.href="/wechat/default/purchaseOrder/synchpurchase-order-list.html?tab=2";

                        },1000);*/
                    },
                    error:function(){
                        $("<div class='error_tips'>").fadeIn(250).html("数据请求失败").delay(500).fadeOut(250).appendTo("body");
                    }
                });
            }else {
                $("<div class='error_tips'>").fadeIn(250).html("该单已收货").delay(500).fadeOut(250).appendTo("body");
                /*setTimeout(function(){
                    window.location.href="/wechat/default/purchaseOrder/synchpurchase-order-list.html?tab=2";
                },1000)*/
            }
        });



    var selectVos;
    var orderDate;
    function message(){
    $.ajax({
        url:'/wx/menu/purchaseOrderVo',
        type:'GET',
        async:true,
        data:{purchaseNo:purchaseNo}, //传递参数
        dataType:"json",
        success:function(data){
            nowStatus = data.orderStatus;
            if(nowStatus == "03"){
               /*  $('#sure-product').html("确认收货"); */
            }else{
               /*  $('#sure-product').html("返回采购列表"); */
            }
            orderDate = data.orderDate;
            var salesNo = data.salesNo;
            $(".loading_box").removeClass("loadingssss");
            selectVos = data.selectVos;
            document.getElementById('Cooperation_information').innerHTML =
                    "<p>"+"<span class='detial_left'>供应商：</span>"+data.partnerShortname+"</p>"
                    +"<p>"+"<span class='detial_left'>订单日期：</span>"+data.orderDate+"</p>"
                    +"<p>"+"<span class='detial_left'>订单号：</span>"+data.purchaseNo+"</p>"
                    +"<p>"+"<span class='detial_left'>订单总金额：</span>"+data.totalPrice+"</p>"
                    +"<p>"+"<span class='detial_left'>项目名称：</span>"+data.caseDesc+"</p>";

            document.getElementById('table_detail').innerHTML =
            "<li>"+"<span class='detial_left'>小计金额：</span>"+data.price+"</li>"
            +"<li>"+"<span class='detial_left'>折扣优惠：-</span>"+data.discount+"</li>"
            +"<li>"+"<span class='detial_left'>减免金额：-</span>"+data.preferential+"</li>"
            +"<li>"+"<span class='detial_left'>合计金额：</span>"+data.totalPrice+"</li>"
            +"<li>"+"<span class='detial_left'>预收金额：-</span>"+data.depositRequested+"</li>"
            +"<li>"+"<span class='detial_left'>应收金额：</span>"+data.receivablesMoney+"</li>"
            +"<li>"+"<span class='detial_left'>制单时间：</span>"+data.createTime+"</li>"
            + "<li class='condition' style='display:none;'>" + "<span class='detial_left'>收货状态：</span><span style='color:#01a09a;'>已收货&nbsp;" + data.receivedTime + "</span></li>";


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
            if(data.isReceived==1){
				$(".condition").show();
			}
			if(data.salesNo&&data.isReceived==0){
				$(".construction").show();
			}
        },
        error:function(){
            $("<div class='error_tips'>").fadeIn(250).html("数据请求失败").delay(500).fadeOut(250).appendTo("body");
        }
    })
}
message();
    function Createlement(val){
        var businessType = val[0].businessType;
        var businessTypeview ;
        for(var num=0;num < selectVos.length;num++){
            if(selectVos[num].value== businessType){
                businessTypeview = selectVos[num].text;
            }
        }
        var htmlStr =
                "<div class='order_new_list'>"+
                "<h2>"+businessTypeview+"<span>共计"+val.length+"条</span> <b class='iconfont active'>&#xe68d;</b></h2>"+
                "<ul style='overflow:hidden;display:block;'>";
        for(var i = 0; i < val.length; i++){
            var myUrl = encodeURI(encodeURI("/wechat/default/purchaseOrder/order-detail-next.html?purchaseNo="+val[i].purchaseNo+"&&orderStatus=04&&orderDate="+orderDate+"&&businessTypeview="+businessTypeview));
            htmlStr +=
                    "<li>"
                    +"<a href='"+myUrl+"'>"
                    +"<h4>"+"业务内容描述："+val[i].businessDesc+"</h4>"
                    +"<p>"+"物料制作："+val[i].requirements+"</p>"
                    +"<p>"+val[i].length+"m"+"*"+val[i].width+"m"+"<span>"+val[i].quantity+val[i].unit+"</span>"+"<span>￥"+val[i].totalPrice.toFixed(2)+"</span>"+"</p>"
                    +"</a>"
                    +"</li>"
        }
        htmlStr += "</ul>"+ "</div>";
        
        $("#order_new_contant").html(htmlStr);
    }

    //tab点击切换
    $('.order_new_contant').on("click",".order_new_list h2",function(){
        $(this).children('b').toggleClass('active');
        $(this).next('ul').slideToggle(500);
    })

    // 收货
	$(".construction").click(function(){
		$(".delivery").show();
	})
	$(".abolish").click(function(){
		$(".delivery").hide();
	})
	$(".determine").click(function(){
		$(".delivery").hide();
		 $.ajax({
                type: "GET",
                url: "/wx/purchase/delivery",
                data: {purchaseNo: purchaseNo},
                dataType: "json",
                success: function (dt) {
                   $("<div class='error_tips'>").fadeIn(250).html(dt.msg).delay(1000).fadeOut(250).appendTo("body");
                   setTimeout(function(){
                    message();
                    $(".construction").hide();
                   },1500)
                },
                error: function () {
                

                }
             })
	})
</script>
</html>
