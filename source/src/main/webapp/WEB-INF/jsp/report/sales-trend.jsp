<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>销售数据</title>
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499?v=0709">

    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script src="/resources/util/echarts.common.min.js?v=30600e2acd"></script>
    <script src="/resources/easyui/jquery.easyui.min.js?v=0e0e0cc31b"></script>
    <script src="/resources/easyui/locale/easyui-lang-zh_CN.js?v=af8a82977a"></script>

    <script type="text/javascript" src="/resources/bootstrap/js/bootstrap.min.js?v=9e25e8e29e"></script>
    <script type="text/javascript" src="/resources/bootstrap/bootstrap-datetimepicker.js?v=ca317bd7f1" charset="UTF-8"></script>
    <script type="text/javascript" src="/resources/business/base_new.js?v=9ac481258d" ></script>
    <style>
        .ui.input.drop > .value-content {  top: -3px;  }
        table, th, td{
            vertical-align: top;
        }
        .btn{font-size: 12px;}
        .btn-default{color:#999;}
        .ui.items-view table tbody tr:nth-child(even){
            background: none !important;
        }
        .ui.items-view .item{
            cursor:default;
        }
        #order .table-wrapper>table thead th:nth-child(11),#order .table-wrapper>table thead th:nth-child(1),#order .table-wrapper>table thead th:nth-child(12),#order .table-wrapper>table thead th:nth-child(2){
            font-weight: 700;
        }
        .pagination table{
            height: 50px;
            line-height: 50px;
            float:right;
        }
        .pagination{
            border-radius: 0;
        }
        .datagrid .datagrid-pager{
            border-color:#2e8ae6;
            border-top-width: 2px ;

        }
        .datagrid-row-over,
        .datagrid-header td.datagrid-header-over {
            background: none !important;
            color: #000 ;
            cursor: default;
        }
        .datagrid-header .datagrid-cell{
            height:35px;
            line-height: 35px;
        }
        .datagrid-header, .datagrid-td-rownumber{
            background: #eff1f3;
        }
        .datagrid-header{
            border-width: 0 ;
            /*border-color:  #2e8ae6;;*/
        }
        .datagrid-header .datagrid-cell span{
            font-size:12px;
        }
        .btn-primary{
            background-color: #2e8ae6;
            border-color:#2e8ae6;
            font-size: 14px;
        }
        .btn-primary:hover, .btn-primary:focus, .btn-primary:active, .btn-primary.active, .open .dropdown-toggle.btn-primary{
            background-color: #2e8ae6;
            border-color:#2e8ae6;
        }
        .datagrid-header td, .datagrid-body td, .datagrid-footer td{
            border-style:solid;
            border-color: #e4e4e4;
        }
        .datagrid-row-selected{
            background: none !important;
            color:#000;
        }
        .datagrid .panel-body{
            border:none !important;
        }
        .window .window-body{
            padding:50px 10px 0;
            border:none !important;
            border-width: 0 !important;
            background: #fff;
            border-radius: 0;
        }

        .datagrid-header-row, .datagrid-row{
            height:30px;
            line-height:30px;

        }
        .window-shadow{
            background: none;
        }
        table, th, td{
            vertical-align: middle;
        }
        #msgwindow{
            border: none;
            z-index: 9999;
            width:84%;
            height:100%;
            left:100%;
            box-shadow: 0px 0px 7px #999;
            padding: 2%;
            background: #fff;
            transition:all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
        }
        #taxPointWin{
            border: none;
            z-index: 9999;
            width:700px;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
            min-height:290px;
            background: #fff;
            transition:all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
            display: none;
        }
        .h10{
            clear: both;
            height:10px;
        }
        select option{
            line-height:30px;
            height:30px;
            margin:5px auto;

        }
        .btn.smcolor{
            background-color: #2e8ae6;
            border-color: #2e8ae6;
            color:#fff;
        }
        .datagrid-header .datagrid-cell{
            text-align: center ;
        }
        .tips_contants{position:fixed;top:50%;left:50%;z-index:99999;display:none;margin-top:-150px;margin-left:-150px;width:300px;height:80px;border-radius:5px;background:rgba(0,0,0,.8);color:#fff;text-align:center;line-height:80px}

        .pagination{
            display: none;
        }
        /*    .datagrid-header td,.datagrid-body td{
                padding:5px;
            }*/
        .select2-results__options li{
            position: relative;
        }
        .datagrid-body .datagrid-cell{
            padding:10px;
        }
        .form-control {
            display: block;
            width: 100%;
            height: 30px;
            padding: 6px 10px 6px 12px;
            font-size: 14px;
            line-height: 1.428571429;
            color: #555;
            vertical-align: middle;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .input-group-addon {
            padding: 5px 12px;
            font-size: 14px;
            font-weight: normal;
            line-height: 1;
            text-align: center;
            background-color: transparent !important;
            border: 1px solid #ccc;
            border-radius: 4px;
        }


        #navCondition li{
            margin-right:10px;
        }

        .nav-tabs{
            position: relative;
        }
        .nav-tabs li:nth-child(2).active~.block {
            transform: translate(106px,0);
        }



        .nav-tabs li:nth-child(1)~.block {
            position: absolute;
            bottom: 3px;
            left: 10px;
            width: 70px;
            height: 2px;
            background-color: #2e8ae6;
            transition: all .3s;
        }
        #orderafter:after{
            content: "";
            position: absolute;
            width: 1px;
            border: 1px solid #e4e4e4;
            height: 50px;
            /* background: red; */
            right: 0;
            top: 30px;
        }
        .datagrid-header td, .datagrid-body td, .datagrid-footer td{
            border-width:0;
        }
        .datagrid-header td, .datagrid-body td, .datagrid-footer td{
            border-style:solid;
            border-color: #e4e4e4;
        }
        .datagrid-body td{
            border-bottom:1px solid #eae8e8;
        }

        .nav-tabs>li>a{
            color:#3f3e3e;
            border:none;
        }
        .nav-tabs,.nav-tabs>li.active>a, .nav-tabs>li.active>a:hover, .nav-tabs>li.active>a:focus{
            border:none ;
            font-size:16px;
        }
        .nav-tabs>li.active>a, .nav-tabs>li.active>a:hover, .nav-tabs>li.active>a:focus {
            /*border-bottom: 2px solid #2e8ae6;*/
            color: #2e8ae6;
            padding-bottom:5px;
        }
        .nav-tabs>li>a:hover {
            border: none;
        }

        .nav>li>a:hover, .nav>li>a:focus {
            text-decoration: none;
            background: none !important;
        }
        .dropdown-menu{
            min-width: 100px;
        }
        .row{
            margin:0;
        }
        .panel-noscroll{
            overflow-y:auto;
            overflow-x:hidden;
        }
        .conditionsale span{
            border-radius: 20px;
            width: 50px;
            cursor: pointer;
            color: #000;
            font-size: 14px;
            padding: 6px;
        }
        .conditionsale .active{
            background: #7189aa;
            color:#fff;

        }
        .titletrend{
            color:#999; text-align:center;font-size: 16px;padding-top:20px;
        }
/*        [class*=" datetimepicker-dropdown"]::before{
            border:none;
            background: transparent;
            top:-20px;
            left:-50px;
            width:0;
            height:0;
        }
        [class*=" datetimepicker-dropdown"]:after{
            border:none;
            background: transparent;
            width:0;
            height:0;
        }*/
        .datagrid-header,
        .datagrid-td-rownumber {
            background: #eff1f9;
        }
    </style>
</head>
<body class="easyui-layout" style="overflow-x:hidden;overflow-y:auto;border:none !important;" >
<div  id="msgwindow"   style="border:none;" ></div>
<%--遮罩--%>
<div class="window-mask" style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:999;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>
<div  data-options="region:'north'" style="position:relative;border:none !important;padding:10px;overflow: hidden;" >
    <section style="position: relative;">
        <p style="font-size: 18px;">销售趋势</p>
        <div style="color: #ff9900;
    position: absolute;
    left: 90px;
    top: 5px;" id="caozuoTip"  data-toggle="popover" data-container="body" data-trigger="hover" data-placement="bottom"
             data-html="true"        data-content="当订单生成即计入统计，如：某张订单，开单日期为4月16日，但订单日期为4月14日，则订单生成后，系统将其归入到4月14日的数据" >报表说明<span  class="iconfont_new" style="position: relative;top:-1px;vertical-align: middle;font-size: 20px">&#xe6b8;</span></div>
    </section>
</div>
<div  data-options="region:'center'" id="centerScroll" style="border:none !important;position:relative;overflow-x:hidden;padding:10px 30px 10px 20px;" >
    <ul class="nav nav-tabs" id="navCondition" style="font-size:16px;">
        <li class="active">     <a href="#">按自然年</a></li>
        <li><a href="#">按自然月</a> </li>
        <li class="block"></li>
    </ul>

    <div style="

    position: absolute;
    right: 200px;
    width:100px;
    z-index: 999999;
    top: 15px;" >
        <select class="form-control input-xs" id="yearDat" onchange="reload()">
            <option value="2017">2017年</option>
            <option value="2018">2018年</option>
            <option value="2019">2019年</option>
            <option value="2020">2020年</option>
        </select>
    </div>

    <div style="

    position: absolute;
    right: 80px;
    width:100px;
    z-index: 999999;
    top: 15px;">
        <select  class="form-control input-xs" onchange="reload()" id="monthDat">
            <option value="01">1月</option>
            <option value="02">2月</option>
            <option value="03">3月</option>
            <option value="04">4月</option>
            <option value="05">5月</option>
            <option value="06">6月</option>
            <option value="07">7月</option>
            <option value="08">8月</option>
            <option value="09">9月</option>
            <option value="10">10月</option>
            <option value="11">11月</option>
            <option value="12">12月</option>
        </select>
    </div>

    <section style="position: relative">

    </section>


    <div class="h10" style="    background: #ccc;
    height: 1px;
    margin: 10px  auto 20px;
    width: 100%;"></div>

    <div class="row" style="height: 120px;width:100%;background: #f8f9fd;">
        <div class="col-xs-6 titletrend"  id="orderafter">
            <div>订单</div>

            <div style="margin-top:10px;color:#000;display: inline-block;font-size: 28px;" id="orderNum"></div><span style="margin-left:10px;">笔</span>
        </div>
        <div class="col-xs-6 titletrend" >
            <div>订单金额</div>
            <div style="color:#000;margin-top:10px;font-size: 28px;" id="orderAmount"></div>
        </div>
    </div>

    <div class="h10" ></div>
    <div style="position: relative;width:100%;height: 420px;font-size: 30px;">
        <div id="mainduizhangInner"  style="width: 100%;height: 420px;background: url('/resources/images/nodata.png') center center no-repeat #fff;"></div>
        <div style="position: absolute;
    right: 30px;
    top: 1px;" class="conditionsale">
            <span style=" " class="active">按金额</span>
            <span style="
         ">按笔数</span>
        </div>
    </div>
    <div class="h10" ></div>
    <table id="order"  style="width: 100%;" class="order"
           data-options="remoteSort:false,
           <%--fitColumns:true,--%>
           <%--scrollbarSize:0,--%>
           nowrap:true,singleSelect:false,checkOnSelect:false,onLoadSuccess:onLoadSuccess">
    </table>
</div>
<div id="orderProcedure" style="box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2); background: #fff; position: absolute;z-index: 9999;top:50%;left:50%;margin-left:-435px;margin-top:-286px; display: none;">
    <div style="font-size: 18px;color: #333;line-height: 50px; border-bottom: 1px solid #e4e4e4; padding-left: 15px;">快速了解订单流程</div><span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" onclick="closeOverFlow()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="font-size: 12px;color:#666;background-color: #f5f5f5; text-align: center; width: 500px; margin: 20px auto; line-height: 30px;">颜色区块表示系统对应操作 !  灰色区块为辅助操作</div>
    <div style="margin: 70px auto 60px; padding: 0 20px;"><img src="../../images/orderflow.png" alt="订单流程图"></div>
    <div style="text-align: center;border:1px solid #ccc; border-radius: 3px;font-size: 12px;color: #ccc; height: 30px; width: 120px;line-height: 30px;margin: 0 auto 30px;cursor: pointer; " onclick="closeOverFlow()">我知道了</div>
</div>
<script src="/common/growingio.js"></script>
<script type="text/javascript">
    var mainduizhang = echarts.init(document.getElementById('mainduizhangInner'));
    mainduizhang.showLoading();
    function mainduizhang1(result) {
        // 饼图

        var option={};
        var xarr=[],yarr=[],datarr=[],type="";
        if($(".conditionsale span.active").index()==0){
            type="1";
        }
        if($("#navCondition li.active").index()==0){
            console.log(result);
            for(var i=0;i<result.length;i++){
                var ar=result[i];
                xarr.push(Number(ar["months"])+"月");
                datarr.push(type=="1"?ar["totalPrice"]:ar["orderNum"]);
            }

        }else{       for(var i=0;i<result.length;i++){
            var ar=result[i];
            xarr.push(Number(ar["days"]));
            datarr.push(type=="1"?ar["totalPrice"]:ar["orderNum"]);
        }
}

        option = {
            color: ['#f7c2c5'],
            tooltip : {
                trigger: 'axis',
                axisPointer: {
                    type: 'none',
                    label: {
                        backgroundColor: '#6a7985'
                    }
                }
            },
            legend: {
                data:['销售趋势'],
                show:false
            },
            grid: {
                left: '3%',
                right: '3%',
                bottom: '3%',
//                borderColor:'#fff',
                containLabel: true
            },
            xAxis : [
                {

                    axisLine:{
                        lineStyle:{
                            color:"#7189aa",
                            opacity:'0.1'
                        }
                    },
                    type : 'category',
                    boundaryGap : false,
                    data : xarr
                }
            ],
            yAxis : [
                {
//                    show:false,
                    axisLine:{
                        lineStyle:{
                            color:"#7189aa",
                            opacity:'0.1'
                        }
                    },
                    splitLine:{
                        lineStyle: {
                            color: ['#f2f3f8']
                        }
                    },
                    type : 'value'
                }
            ],
            series : [
                {
                    symbolSize:10,
                    symbol:'circle',
                    name:'销售趋势',
                    type:'line',
                    itemStyle : {
                        normal : {
                            color:'#f7c2c5',
                            lineStyle:{
                                color:'#f7c2c5'
                            }
                        }
                    },
//                    areaStyle: {normal: {}},
                    data:datarr
                }
            ]
        };

        mainduizhang.setOption(option);
        $(window).on("resize", function () {
            mainduizhang.resize()
        })
    }

    function initChartsMain(result){
        if(result && result !=null){
        mainduizhang1(result);
        }
        mainduizhang.hideLoading();
    }



    $(function () {

        $("#yearDat").val(new Date().getFullYear());
        var md=Number(new Date().getMonth())+1;
        if(md<10){md="0"+md};
        $("#monthDat").val(md);
        $("#monthDat").select2({
            minimumResultsForSearch: Infinity
        });
        $("#yearDat").select2({
            minimumResultsForSearch: Infinity
        });
//        $("#centerScroll").niceScroll({
//            touchbehavior:false,
//            cursorcolor:"#d9d9d9",
//            cursoropacitymax:1,
//            cursorwidth:10,
//            cursorborder:"none",
//            cursorborderradius:"5px",
//            background:"#efefef",
//            autohidemode:false
//        });
        $("[data-toggle='popover']").popover();
        $(".conditionsale ").on("click","span",function () {
            $(this).addClass("active").siblings().removeClass("active");
            reload("");
        });
        $("#navCondition ").on("click","li",function () {
            $(this).addClass("active").siblings().removeClass("active");
            reload("");
        });
        reload();
    });
    function GetRequest() {
        var url = location.search; //获取url中"?"符后的字串
        var theRequest = new Object();
        if (url.indexOf("?") != -1) {
            var str = url.substr(1);
            strs = str.split("&");
            for (var i = 0; i < strs.length; i++) {
                theRequest[strs[i].split("=")[0]] = unescape(strs[i].split("=")[1]);
            }
        }
        return theRequest;
    }

    function reload() {
        var y=$("#yearDat").val(),m=$("#monthDat").val(),param={},type="";
        if(!y){
            y= new Date().getFullYear();
        }
        if(!m){
            m= Number(new Date().getMonth())+1;
        }
        if($("#navCondition li.active").index()==0){
            param={
                "year":y,
                "month" : ""
            };
      type="1"
        }else{       param={
            "year":y,
            "month" :m
        };
        type="0";
        }
//        report/salesorder/salesTrend
//        year
//        month
        var url='report/saleorder/salestrend';
//        var url='ydz/salesorder/listPageTotalDetailByOrder';
//        {"days":"03","months":"5","orderNum":"0","totalPrice":"0","trend":"1","years":"2017"},
        var arrclo=[];
        arrclo.push({field:'ck1',fixed:true,align:'center',title:'',width:'15%'});
        arrclo.push({field:'orderDate',title:'日期',width:'20%',align:'center',formatter: function(value, row) {
            if(type=="0"){
                return row.years+'-'+row.months+'-'+row.days
            }else{
                return row.years+'-'+row.months ;
            }

        }});
        arrclo.push({field:'orderNum',align:'center',title:'订单笔数',width:'20%'});

        arrclo.push({field:'totalPrice',width:'20%',align:'right',formatter: function(value, row) {
            var tv="";
            if(row.trend=="1"){
                tv='<span style="color:#0e932e" class="iconfont_new">&#xe6dc;</span>';
            }else{
                tv='<span style="color:#ea9518" class="iconfont_new">&#xe6db;</span>';
            }
//            <span class="iconfont_new" style="font-size: 60px;color:#3dcc74;">&#xe6c7;</span>
            return  accounting.formatNumber(value,2)+tv;
        },title:'订单金额'});
        arrclo.push({field:'ck',align:'center',fixed:true,title:'',width:'25%'});
            $('#order').datagrid({
                url : url,
                pagination:false,
                columns:[arrclo],
                queryParams :param
            });

    }
    function onLoadSuccess(data){
        var total = 0,amount=0;
        if (data.rows.length > 0 ) {

            var rows = $('#order').datagrid('getRows');//获取当前的数据行

            for (var i = 0; i < rows.length; i++) {
                total += Number(rows[i]['orderNum']);
                amount += Number(rows[i]['totalPrice']);
            }
            $("#orderNum").html(total);
            $("#orderAmount").html("￥ "+accounting.formatNumber(amount,2));
        }else{
            $("#orderNum").html(total);
            $("#orderAmount").html("￥ "+amount);
            $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
        }
        initChartsMain(data.rows);
    }

    function openDt(obj){
        var url = "/ydz/salesorder/salesOrderDetail?salesNo=" +$(obj).attr("data-id") + "&industryId=" + $(obj).attr("data-did");
        showMessageDialog(url,"","84%","100%",true);
    }
    function msg(content){
        $("#msgwindow").html(content).addClass("activ");
    }
    function hideMsg() {
        $(".window-mask").hide();
        $("#msgwindow").css({left:"100%"}).removeClass("activ");
    }
    function showMessageDialog(url, title, width, height, shadow) {
        var content = '<iframe id="msgF" src="'+url+'" width="100%" height="99%" frameborder="0" scrolling="yes"></iframe>';
        $("#msgwindow").empty();
        $("#msgwindow").css({left:"16%"});
        $(".window-mask").hide();
        var last = Date.now();
        setTimeout(function(){
            // 监听动画完成时间
            if($("#msgwindow").hasClass("activ")){
                msg(content);
            }else{
                $("#msgwindow")[0].addEventListener('webkitTransitionEnd', function(){
                    if(Date.now() - last < 3000){
                        msg(content);
                    }
                }, false);
            }

        }, 0);
    }



</script>
</body>
</html>