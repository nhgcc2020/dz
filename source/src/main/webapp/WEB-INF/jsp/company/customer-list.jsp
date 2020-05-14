<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的客户列表</title>
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
    <style type="text/css">

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
            opacity: 0;
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

        .datagrid-header, .datagrid-td-rownumber{
            background: #eff1f3;
        }
        .datagrid-header{
            border-width: 0 ;
        }
        .datagrid-header .datagrid-cell span{
            font-size:14px;
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

        .datagrid-header-row, .datagrid-row,.datagrid-header{
            height:50px;

        }
        .datagrid-header .datagrid-cell{
            /*height:40px;*/
            /*line-height: 40px;*/
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
            /*text-align: center !important;*/
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
        .datagrid-htable  .datagrid-cell{
            padding-left:10px;
        }
        .datagrid-header .datagrid-cell span{
            color: #666;
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
        .panel{
            box-shadow: 0 0 0 ;
        }
        #msgwindow{
            border: none;
            z-index: 9999;
            width:84%;
            height:100%;
            left:100%;
            box-shadow: 0px 0px 7px #999;
            background: #fff;
            transition:all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
        }

        .nav-tabs>li>a{
            color:#3f3e3e;
            border:none;
        }
        .nav-tabs,.nav-tabs>li.active>a, .nav-tabs>li.active>a:hover, .nav-tabs>li.active>a:focus{
            border:none ;
            font-size:14px;
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
        #navCondition li{
            margin-right:10px;
        }
        .nav-tabs{
            position: relative;
        }
        .nav-tabs li:nth-child(2).active~.block {
            transform: translate(98px,0);
        }
        .nav-tabs li:nth-child(3).active~.block {
            transform: translate(198px,0);
            width: 85px;
        }

        #deleteWin{
            border: none;
            z-index: 9999;
            width: 700px;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
            /*min-height:290px;*/
            background: #fff;
            transition: all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
            display: none;
        }
        .nav-tabs li:nth-child(1)~.block {
            position: absolute;
            bottom: -2px;
            left: 5px;
            width: 75px;
            height: 2px;
            background-color: #2e8ae6;
            transition: all .3s;
        }
    </style>
    <%--让表格支持无边框样式--%>
    <style>
        .datagrid-header td, .datagrid-body td, .datagrid-footer td{
            border-width:0;
        }
        .datagrid-header td, .datagrid-body td, .datagrid-footer td{
            border-style:solid;
            border-color: #e4e4e4;
        }
        .datagrid-body td{
            border-bottom:1px solid #f2f2f2;
        }
        .pagination-btn-separator{
            display: none;
        }


        #order .table-wrapper>table thead th:nth-child(1){
            text-align: left;
        }
        .qqhover:hover,.telhover:hover{
            color:#2e8ae6 !important;
        }
        .datagrid-cell, .datagrid-cell-group, .datagrid-header-rownumber, .datagrid-cell-rownumber{
            font-size: 12px;
        }
        .remarkbd{
            height: 30px;
            margin-top: 10px;
            line-height: 30px;
            padding-top: 5px;
            color:#b3b3b3;
            font-size:12px;
            border-top: 1px solid #f2f2f2;
            text-overflow: ellipsis;
            overflow: hidden;
        }
        .namebd{
            margin:9px 0;
            font-size:14px;
            color:#000;
        }
        .contactbd{
            /*height: 50px;*/
            color: #999;
            font-size:12px;
            margin-bottom: 9px;
            /*line-height: 45px;*/
        }
        .namebdsml{
            font-size:12px;
            color:#999;
            margin-left:15px;
        }
        .telhover,.qqhover{
            margin-left:8px;
            vertical-align: middle;
        }
        .contacthover{
            margin-right:14px;
        }
        .tooltip{
            border:none !important;
            background: transparent !important;
        }
        .tooltip-arrow {
            display: none;
        }

        .tooltip-inner{
            opacity:1;
            color: rgb(102, 102, 102);
            background-color: rgb(255, 255, 204);
            border: 1px solid #ffcc00;
        }
        .font12{

            color:#999;
            margin-bottom:10px;
            font-size:12px;
        }
        .font18{
            font-size:18px;
            color:#000;
            /*height:50px;*/
            /*line-height:45px;*/
        }
        .fontColor3c{
            color:#ccc;
        }


       .datagrid-cell-c2-cke{
           color:#ccc;
       }
       .datagrid-header-inner{
           background: #eff1f9;
       }
    </style>
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
    <script src="/resources/easyui/jquery.easyui.min.js?v=0e0e0cc31b"></script>
    <script src="/resources/business/base_new.js?v=9ac481258d"></script>
    <script type="text/javascript" src="/resources/bootstrap/js/bootstrap.min.js?v=9e25e8e29e"></script>
</head>
<body class="easyui-layout" style=" overflow: hidden; ;border:none !important;">
<div  id="msgwindow"   style="border:none;" ></div>
<div class="window-mask" style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:999;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>

<div id="orderProcedure" class=" animated flipInY" style="box-shadow: rgba(0, 0, 0, 0.2) 1px 3px 10px 2px;
 width:580px;-webkit-animation-fill-mode:both;-webkit-animation-duration: 1s;display: none;
 background: rgb(255, 255, 255); position: absolute; z-index: 9999; top: 50%; left: 50%; margin-left: -435px; margin-top: -286px; ">
    <div style="font-size: 18px;color: #333;line-height: 50px; border-bottom: 1px solid #e4e4e4; padding-left: 15px;">加好友</div><span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" onclick="closeOverFlow()"><img src="../../images/close_user.png" alt="点击关闭"></span>

    <div style="margin: 0 auto; width:490px;">
        <div style="background: url('/resources/images/addfriend.png') 10px no-repeat;margin-top:10px;height: 66px;width:490px;"></div>
        <div style="font-size: 12px;color:#666;background-color: #f5f5f5; text-align: center;margin: 20px auto; line-height: 30px;">作为好友，你给对方建的销售单，对方可以通过采购菜单查看！</div>
        <div style=" padding: 0 20px;">
            <div class="invite_content" style="
          margin-top:2rem;
    text-align: center;">
                <p id="inviteCom" style="font-size:16px; margin: 1rem auto 2rem;"></p>
                <p id="inviteName" style="color:#ccc; margin: 1rem auto 2rem;"></p>
                <input type="hidden" value="" id="partnerKeyPop">
                <input name="sendPhone" id="sendPhone" maxlength="11" placeholder="请填写手机号码" style="
            margin: 0em;
    -webkit-box-flex: 1;
    -webkit-flex: 1 0 auto;
    -ms-flex: 1 0 auto;
    flex: 1 0 auto;
    -webkit-tap-highlight-color: rgba(255, 255, 255, 0);
    text-align: left;
    padding: 0px 30px 0px 10px;
    height: 30px;
    line-height: 30px;
    background: #FFFFFF;
    border: 1px solid #adadad;
    color: #999;
    border-radius: 3px;
    transition: box-shadow 0.1s ease, border-color 0.1s ease;
            width:250px;"  onkeyup="checkPhone()" >
                <p style="color: #ff9900;margin: 1rem auto 2rem;font-size: 12px;width: 250px;text-align: right;" c-bind="tips" id="tips">请再次确认,发送后手机号将无法修改</p>
            </div>
        </div>
        <div style="clear: both; padding-bottom: 20px; text-align: center">
            <button type="button" class="btn  btn-default" onclick="closeOverFlow()" style="width:100px;">取消</button>
            <button type="button" id="sendMsgBtn" disabled class="btn btn-primary" style="margin-left:15px;width:100px;font-size:12px;" onclick="sendMsg(this)">发送短信</button>
        </div>
    </div>

</div>

<%--<div class="modal fade" id="myModal" tabindex="-1" style="overflow: hidden;"  role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">--%>
    <%--<div class="modal-dialog" style="width:300px;">--%>
        <%--<div class="modal-content">--%>
            <%--<div class="modal-header">--%>
                <%--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>--%>
                <%--<h4 class="modal-title" id="myModalLabel">提示</h4>--%>
            <%--</div>--%>
            <%--<div class="modal-body">确定要删除吗？</div>--%>
            <%--<div class="modal-footer">--%>
                <%--<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>--%>
                <%--<button type="button" class="btn btn-primary" onclick="delOrderConfirm();return false;">确认</button>--%>
            <%--</div>--%>
        <%--</div><!-- /.modal-content -->--%>
    <%--</div><!-- /.modal-dialog -->--%>
<%--</div>--%>

<div id="deleteWin" class=" animated flipInY" style="    padding-top: 5px;
    top: 50%;
    left: 50%;
    margin-left: -125px;
    margin-top: -93px;
    position: absolute;
    width: 330px;
    height: 187px;">
    <p style="    position: relative;
    font-weight: 100;
    text-align: left;
    font-size: 22px;
    margin: 0px auto;
    padding: 5px 20px;
    border-bottom: 1px solid #ccc;">
        提示</p>
    <span id="closetranform" style="    position: absolute;
    top: 20px;
    right: 1px;
    display: block;
    height: 30px;
    width: 30px;
    cursor: pointer;" onclick="closeTaxPoint()"><i
            style="background: url('/images/close_user.png');width:14px;height: 14px;display: block"
            alt="点击关闭"></i></span>
    <div style="    text-align: center;
    margin: 20px auto;">
            <span class="customerjc" style="    position: relative;
    text-align: center;
    margin: 0 auto;
    font-size: 22px;
    font-weight: normal;
    color: #44ae80;
    height: 30px;
    line-height: 30px;">确定要删除吗？</span>
        <div style="clear: both;margin-top:45px;">
            <button type="button" class="btn  btn-default"  onclick="closeTaxPoint()" style="width:92px;">取消</button>
            <button type="button" class="btn btn-primary" style="margin-left:12px;width:92px;font-size:12px;" onclick="delOrderConfirm(this)">确认</button>
        </div>
    </div>
</div>


<div  data-options="region:'north'" style="border:none !important;padding:10px 10px 0;margin-right: 10px;overflow: hidden;" >

    <ul class="nav nav-tabs" id="navCondition">
        <li style="position:relative;" class="active" number="" >     <a href="#">全部客户</a></li>
        <li style="position:relative;" number="1" >     <a href="#">好友客户</a></li>
        <li style="position:relative;" number="-1" >     <a href="#">非好友客户</a></li>
        <!--<li style="position:relative;" class="active"><a href="#"></a>     <span id="message-num-circle1" style="
       line-height: 18px;
    text-align: center;
    height: 18px;
    min-width: 18px;
    background: #da4654;
    color: #fff;
    border-radius: 20px;
    position: absolute;
    left: 73px;
    top: 5px;
    padding:0 2px;
    font-size: 12px; ">0</span></li>-->
        <li class="block"></li>
    </ul>

    <div style="color: #ff9900;
    position: absolute;
    right: 30px;
    top: 20px;cursor: pointer;" id="caozuoTip"  data-toggle="popover" data-container="body" data-trigger="hover" data-placement="bottom"
         data-html="true"        data-content="1.  搜索客户 <span style='color:#ff9900'>输入关键字，敲回车即可搜索</span><br>
2.  <span style='color:#ff9900'>伙伴备注</span>可在列表上查看，当内容过多时，将光标移至备注区域
可查看全部内容" >操作技巧<span  class="iconfont_new" style="position: relative;top:-1px;vertical-align: middle;font-size: 20px">&#xe6b8;</span></div>
    <div class="h10"></div>
    <div  style="    padding: 6px 10px 12px;
    border-bottom: 1px solid #f2f2f2;">
        <form role="form">
            <div class="row" style="margin:0;">

                <div class="col-xs-2" style="padding-left:1px;">
                    <div class="input-group">
                        <input type="text" class="form-control"

                               onkeypress="if(event.keyCode == 13) {reload('');return false;}"
                               id="searchKey" placeholder="输入 助记码、企业简称搜索" style="      width: 208px;
    border-radius: 30px;
    color: #b3b3b3;
    font-size: 12px;
    padding-right: 30px;">
                        <!--<span class="input-group-btn" id="searchBtn"  style="        cursor: pointer;
    position: absolute;
    top: 2px;
    width: 20px;
    right: 8px;
    font-size: 20px;
    transform: rotate(-5deg);
    color: #b3b3b3;">-->
						<button class="btn btn-primary" id="searchBtn" type="button" style="height:30px; line-height:1;cursor: pointer;
    position: absolute;
    top: 0px;
    right: -62px;font-size:12px;">
							搜索
						</button>
					<!--</span>-->
                    </div>
                </div>
                <button type="button" class="btn btn-primary pull-right modifyOrder " style="font-size: 12px;margin-left:10px;height:30px;line-height:1;" onclick="window.parent.openPartner();">创建生意伙伴</button>
                <%--<button type="button" class="btn btn-default pull-right modifyOrder " style="margin-left:15px;height:30px;line-height:1;--%>
                <%--background: #fff !important;--%>
                <%--color: #b3b3b3;border-color: #b3b3b3;" onclick="showModPartner()">修改</button>--%>
                <button type="button" id="" class="btn btn-default pull-right generatorBill " style="margin-left:15px;height:30px;line-height:1;
    background: #fff !important;
    color: #b3b3b3;border-color: #b3b3b3;" onclick="delOrder()">删除</button>
            </div>
        </form>
    </div>

    <script>
        $(function () {
            $("[data-toggle='popover']").popover();
        });
        function partnerInfoCall(row) {
            var qq='',tel='',partnerTel="",contacterName="";
            if(row.contacterName=="" || row.contacterName==null){
                contacterName = "<span style='color:#ccc;'>未填写</span>"
            }else{
                contacterName = row.contacterName;
            }
            if(row.partnerQQ !=''){
                qq= '<span class=\"iconfont_new qqhover\" data-toggle="tooltip" data-placement="right" title="'+row.partnerQQ+'" style=\"font-size: 20px;color:#ccc;\">&#xe6d9;</span>';
            }
            if(row.tel1 !=''){
                tel= '<span class=\"iconfont_new telhover\"  data-toggle="tooltip" data-placement="right" title="'+row.tel1+'" style=\"font-size: 24px;color:#ccc;\">&#xe683;</span>';
            }
            if(row.partnerTel !=''){
                partnerTel='<span class=\"iconfont_new telhover\"  data-toggle="tooltip" data-placement="right" title="'+row.partnerTel+'" style=\"font-size: 24px;color:#ccc;\">&#xe683;</span>';
            }
            return "<div class='namebd'><span onclick='showModPartner("+JSON.stringify(row)+")' style='color:#2e8ae6;cursor: pointer;'>"+row.partnerShortname+"</span><span class='namebdsml'>"+row.partnerName+"</span></div>"+
                "<div class='contactbd'><span class='contacthover'>"+contacterName+"</span>"+tel+qq+"</div>";

        }
        //好友状态
        //  $default == 5  出现申请好友按钮
        var partnerStatusConfig = {
            "0": "非好友",
            "1": "互为好友",
            "2": "申请中",
            "3": "已拒绝",
            "4": "待申请",
            "5": "待邀请",
            "6": "邀请中"
        };
        function formatStatus(value,row,index){
            if(value==="1"){
                return 	'<span style="color: #4fc3c3;">'+partnerStatusConfig[value]+'</span>' ;
            }else{
                return '<span style="color: #999;">'+partnerStatusConfig[value]+'</span>';
            }
        }
        function orderNumber(index) {
            return index + 1;
        }
        function formatMoney(row1,row2) {
            var fontc="";
            if(row1=="0"){
                fontc="fontColor3c";
            }
            return '<div class=\'font12 '+fontc+'\'>'+row1+'&nbsp;笔</div >'+'<div class=\'font18 '+fontc+'\'>'+row2+'</div>' ;
        }
        function partnerAddress(value) {
            if(value == ""|| value == null){
                return '<span style="color:#ccc;">未填写</span>';
            }else{
                return value;
            }
        }
    </script>
</div>


<div id="regionCon"  data-options="region:'center'" style="border:none !important;padding:10px;width: 100%;" >

    <table id="order"  style="width: 100%;" class="easyui-datagrid order"
           data-options="remoteSort:false,

           nowrap:true,singleSelect:false,
           fitColumns:true,
           checkOnSelect:false,onLoadSuccess:onLoadSuccess,fit:true">
        <thead>
        <tr>
            <th data-options="field:'ck',checkbox:true,width:28"></th>
            <th data-options="field:'cke',fixed:true,align:'center',width:60,formatter: function(value, row,index) {
          			return orderNumber(index);
          		}"></th>
            <th data-options="field:'orderDate',fixed:true,width:400,align:'left',formatter: function(value, row) {
            return partnerInfoCall(row);

          		}">概要</th>
            <th data-options="field:'no',width:40,align:'left'"></th>
            <%--<th data-options="field:'gt6TotalPrice',resizable:false,width:200,align:'center',formatter: function(value, row) {--%>
          			<%--return  formatMoney(row.gt6OrderNum,row.gt6TotalPrice);--%>
          			<%--&lt;%&ndash;return '<div>'+row.gt6OrderNum+'笔</div>'+'<div>'+row.gt6TotalPrice+'</div>' ;&ndash;%&gt;--%>
          		<%--}">超过6个月待对账</th>--%>
            <%--<th data-options="field:'gt3TotalPrice',resizable:false,align:'center',width:200,formatter: function(value, row) {--%>
          			<%--return formatMoney(row.gt3OrderNum,row.gt3TotalPrice);--%>
          		<%--}">超过3个月待对账</th>--%>
            <th data-options="field:'partnerAddress',align:'left',width:400,formatter: function(value, row) {
          			 return partnerAddress(value);
          		}">所在地</th>
            <th data-options="field:'remarks',align:'left',width:200,formatter: function(value, row) {
          			return partnerAddress(value);
          		}">备注</th>
            <th id="relation" data-options="field:'partnerStatus',width:200,resizable:false,align:'center',formatter: function(value, row,index) {
          			return formatStatus(value,row,index);
          		}">伙伴关系<!--<i class="iconfont_new" style="font-size:25px;position:relative;top:5px;color:#ff9900;">&#xe6b8;</i>--></th>
        </tr>
        </thead>
    </table>
</div>
<div style="font-weight: bolder;position: fixed;bottom:10px;left:30px; line-height: 40px; overflow: hidden;">
    客户数 :
    <span style="color: red;margin-right: 15px;" id="order2PagerPrice">0</span>
</div>
<script>


    function delOrder() {
        var order4ItemsArr =$('#order').datagrid('getChecked');
        var partnerMod = order4ItemsArr[0];
        if (order4ItemsArr.length > 1) {
            $("<div class='tips_contants'>").fadeIn(250).html("每次只可删除单个生意伙伴").delay(3000).fadeOut(250).appendTo('body');
            return false;
        }
        if (order4ItemsArr.length  == 0) {
            $("<div class='tips_contants'>").fadeIn(250).html("请勾选你需要删除的生意伙伴").delay(3000).fadeOut(250).appendTo('body');
            return false;
        }

        if (partnerMod["partnerKey"] == "temp-customer") {
            $("<div class='tips_contants'>").fadeIn(250).html("过路客不可删除").delay(3000).fadeOut(250).appendTo('body');
            return false;
        }

        if (partnerMod["partnerStatus"] != "5") {
            $("<div class='tips_contants'>").fadeIn(250).html("只可删除待邀请状态的生意伙伴").delay(3000).fadeOut(250).appendTo('body');
            return false;
        }
        $(".window-mask").show();
        $('#deleteWin').show();
    }
    function delOrderConfirm(){
        var order4ItemsArr =$('#order').datagrid('getChecked');
        var partnerMod = order4ItemsArr[0];

        $.ajax({
            type: "POST",
            url: "/system/partner/delPartner",
            data: {partnerKey: partnerMod["partnerKey"]},
            dataType: "json",
            success: function (callback) {
                if (callback.state == "1") {
                    $("<div class='tips_contants'>").fadeIn(250).html(callback.msg).delay(2000).fadeOut(250).appendTo('body');
                    setTimeout(function () {
                        window.location.reload();
                    }, 2000);
                } else {
                    $("<div class='tips_contants'>").fadeIn(250).html(callback.msg).delay(2000).fadeOut(250).appendTo('body');
                }
            }
        })
    }
function closeTaxPoint() {
    $(".window-mask").hide();
    $("#deleteWin").css({display:'none'});
}

    function  showModPartner(partnerMod) {

        if (partnerMod["partnerKey"] == "temp-customer") {
            $("<div class='tips_contants'>").fadeIn(250).html("过路客不可修改").delay(3000).fadeOut(250).appendTo('body');
            return false;
        }
        //公司
        if (partnerMod["partnerAttr"] == "1") {
            url = "/system/partner/modPageCom?partnerKey=" + partnerMod["partnerKey"]+"&contacterId="+partnerMod["contacterId"];
        } else {
            //个人
            url = "/system/partner/modPagePerson?partnerKey=" + partnerMod["partnerKey"]+"&contacterId="+partnerMod["contacterId"];
        }
        var url;

        showMessageDialog(url,"","84%","100%",true);
    }

    function closeModPartner(type) {
        $(".window-mask").hide();
        $("#msgwindow").css({left:"100%"}).removeClass("activ");
        if(type == 0){
            location.reload();
        }
    }
    function msg(content){
        $("#msgwindow").html(content).addClass("activ");
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
    function checkPhone() {
        var keyword = $("#sendPhone").val();

        if(keyword.length<11){
            $("#sendMsgBtn").prop("disabled", true);
            return;
        }
        if (!(/^1[34578]\d{9}$/.test(keyword))) {
//            $("#tips").css("color", "#DA4654");
            $("#tips").html("手机号码格式错误");
            $("#sendMsgBtn").prop("disabled", true);
            comFalgCom = false;
            return comFalgCom;
        }
//       $("#sendMsgBtn").prop("disabled", false);
        $.ajax({
            type: "POST",
            url: "/system/partner/isRegistered",
            data: {phone: keyword},
            dataType: "json",
            success: function (data) {
                if (data) {
//                    $("#tips").css("color", "#DA4654");
                    $("#tips").html("该手机已注册，请通过顶部 + <span class='blueColor'>加对方为好友</span> 吧");
                    $("#sendMsgBtn").prop("disabled", true);
                    comFalgCom = false;
                } else {
//                    $("#tips").css("color", "#ee8e52");
                    $("#tips").html("请再次确认,发送后手机号将无法修改");
                    $("#sendMsgBtn").prop("disabled", false);
                    comFalgCom = true;
                }
            }
        });
        return comFalgCom;

    }
    function showOverFlow(obj){
//        partnerName  partnerAttr tel1  contacterName partnerKey 
//        data-kid='+row.partnerKey+'data-pid='+row.tel1+' data-cid='+row.contacterName+' data-id='+row.partnerName+' data-did='+row.partnerAttr+';
        var partner=$(obj);
        var partnerAttr = partner.data("did");
        //1 公司
        if (partnerAttr == "1") {
            $("#inviteCom").html(partner.data("id"));
        } else {
            $("#inviteCom").html("个人伙伴");
        }
        $("#sendPhone").html(partner.data("pid"));
        $("#inviteName").html(partner.data("cid"));
        $("#partnerKeyPop").val(partner.data("kid"));
        $("#orderProcedure").css({display:'block'});
//        $("#orderProcedure").addClass(" flipInY").removeClass("flipOutY");
        $(".window-mask").show();
//        flipInY flipOutY
    }
    function closeOverFlow(){
//        $("#orderProcedure").addClass(" flipOutY").removeClass("flipInY");//css({display:'none'});
        $("#orderProcedure").css({display:'none'});//css({display:'none'});
        $("#sendPhone").val("");
        $("#partnerKeyPop").val("");
        $("#sendMsgBtn").prop("disabled", true);
        $(".window-mask").hide()
    }
    function sendMsg (btn) {

        /*
         if (!model.action("checkPhone")()) {
         btn.set("disabled",false);
         btn.set("state","");
         return false;
         }
         */

        var partnerKey =  $("#partnerKeyPop").val();
        var phone = $("#sendPhone").val();
        $.post("/system/partner/sendInviteMsg",
            {
                partnerKey: partnerKey,
                phone: phone
            },
            function (data) {
                $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(3000).fadeOut(250).appendTo('body');
                if (data.state) {
                    reload("");
                }
            })
    }

    $(function () {
        $("#navCondition").on("click","li",function () {
            $(this).addClass("active").siblings().removeClass("active");
            reload("");

        });
        $("#searchBtn").click(function () {
            reload("");

        })
//        datagrid-body

    });

    var numGlobal=0;
    function onLoadSuccess(data){
    //     try{
        
    // }catch(e){

    //     $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
    // }
        $("#order2PagerPrice").text(data.total)
        try{
            if(numGlobal==0){
                $("#message-num-circle0").text(data.nowTotal);
                $("#message-num-circle1").text(data.total);
                numGlobal++;
            }

            if (data.rows.length > 0 ) {
                $("[data-toggle='tooltip']").tooltip();

//                $("#regionCon").niceScroll({
                /*             $(".datagrid-body:last").niceScroll({
                 cursorcolor: "#aaa", // change cursor color in hex
                 cursorwidth:"12px",
                 autohidemode:"leave",
                 //                    hidecursordelay:9000,
                 cursorborderradius:"6px"



                 });*/
            }else{
                $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
            }
        }catch(e){

//            $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
        }

    }

    function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null)return unescape(r[2]);
        return null;
    }

    function reload(status) {
        var url='/system/partner/customerList';

        /*  var type = GetQueryString("type");
         var para = {};
         if (type == "2") {
         $("#friendOptions").remove();
         para.partnerStatus = "1";
         }
         if (type == "3") {
         $("#friendOptions").remove();
         para.partnerStatus = "0";
         }*/
        if(status==""){
            $('#order').datagrid({
                url : url,
                pagination:true,
                queryParams : {
                    "searchKey":$('#searchKey').val(),
                    "type":1,
                    "partnerStatus": $("li.active").attr("number")
                }
            });
        }
//        $('#order').datagrid('loadData', JSON.parse(msg));
        /*      $('#order').datagrid({
         data: [
         {f1:'value21', f2:'value22'}
         ]
         });*/
        var pager=$("#order").datagrid('getPager');
        pager.pagination({
            layout:['first','links','last'],
            showRefresh:false,
            displayMsg:''
        });
        $(".pagination").show();
    }
    $(function () {
        reload("");//初始化grid数据
    });

</script>
</body>
</html>
