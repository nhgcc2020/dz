<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>销售订单列表</title>
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap-datetimepicker.min.css?v=af98bc60b4">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">

    <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
    <script src="/resources/easyui/jquery.easyui.min.js?v=0e0e0cc31b"></script>
    <script src="/resources/easyui/locale/easyui-lang-zh_CN.js?v=af8a82977a"></script>
    <script src="/resources/bootstrap/js/bootstrap.min.js?v=9e25e8e29e"></script>
    <script src="/resources/bootstrap/bootstrap-datetimepicker.js?v=ca317bd7f1" charset="UTF-8"></script>
    <script src="/resources/business/base_new.js?v=9ac481258d"></script>
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
        .datagrid-header .datagrid-cell{
            text-align: center !important;
        }
        .tips_contants{position:fixed;top:50%;left:50%;z-index:99999;display:none;margin-top:-150px;margin-left:-150px;width:300px;height:80px;border-radius:5px;background:rgba(0,0,0,.8);color:#fff;text-align:center;line-height:80px}

        .pagination{
            display: none;
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
        .datagrid-body td{
            position: relative;
        }
        .datagrid-cell a:hover,.datagrid-cell a:visited,.datagrid-cell a:link{
            color:#4284d9;
            text-decoration: none;
        }
    </style>
</head>
<body class="easyui-layout" style="border:none !important;" >
<div  id="msgwindow"   style="border:none;" ></div>
<%--遮罩--%>
<div class="window-mask" style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:999;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>
<div  data-options="region:'north'" style="border:none !important;padding:10px;margin-right: 10px;overflow: hidden;" >
    <div style="background:#f2f2f2;height:35px;padding-left:30px;">
        <span style="font-size:16px;">给好友伙伴同步待对账订单</span>&#x3000;
        <span>例如 : 你给李某记了几个月的账，某天他也使用了易对账，你们互相加为了好友，这时你可以将成为好友前的待对账订单同步给他，方便对账</span>
        <div style="cursor: pointer;color: #ec818e;font-size: 12px;margin-top:10px;margin-left: 20px; display:inline-block;" onclick="showOverFlow()">什么是好友伙伴>>
        </div>
        <span class="back" style="position:relative;float:right;margin-right:10px;top:10px; cursor: pointer;"><i class="iconfont_new" style="position:absolute;top:-10px;font-size:25px;">&#xe6f6;</i>&#x3000;&#x3000;返回</span>
    </div>

    <div class="h10"></div>
    <form role="form">
        <div class="row" style="margin:0;">
            <div class="col-xs-2" style="width:150px;padding:0 5px 0 0">
                <select class="form-control input-xs" id="customerDat" placeholder="选择客户">
                </select>
            </div>
            <div class="col-xs-2" style="width:150px;padding:0 5px">
                <select class="form-control input-xs" id="dateDat">
                    <option value=""></option>
                </select>
            </div>
            <div class="col-xs-2 " style="width:150px;padding:0 5px"  >

                <div class="">
                    <div class="input-icon-group">
                        <div class="" style="width:100%">
                            <input type="text" class="form-control" id="datetimepickers" data-format="yyyy-MM-dd" placeholder="">
                            <span onclick="$('#datetimepickers').datetimepicker('show');" class="" style="
    position: absolute;
    right: 10px;
    top: 3px;
"><i class="iconfont_new" style="font-size: 18px;">&#xe6a6;</i></span>
                            </input>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-2 " style="width:150px;padding:0 5px"  >

                <div class="">
                    <div class="input-icon-group">
                        <div class="" style="width:100%">
                            <input type="text" class="form-control" id="datetimepickere"  data-format="yyyy-MM-dd"  placeholder=""  >
                            <span onclick="$('#datetimepickere').datetimepicker('show');" class="" style="
    position: absolute;
    right: 10px;
    top: 3px;
"><i class="iconfont_new" style="font-size: 18px;">&#xe6a6;</i></span>
                            </input>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-2">
                <div class="input-group">
                    <input type="text" class="form-control" id="searchK" placeholder="搜订单号/项目名称/业务内容..." style="width:212px;">
                    <span class="input-group-btn">
						<button class="btn btn-primary" id="searchBtn" type="button" style="height:30px; line-height:1;">
							搜索
						</button>
					</span>
                </div>
            </div>
            <button type="button" id="" class="btn btn-primary pull-right generatorBill" style="height:30px;line-height:1;" onclick="openTaxPoint()">同步</button>
        </div>
    </form>
    <script>

        $(function () {
            var dateObj = orderUtil.dpDateCompute("ld", 30);
            $('#datetimepickers').datetimepicker({ format: 'yyyy-mm-dd', language:  'zh-CN',   autoclose: true,
                minView:'month'}).on("click",function(){
                $("#datetimepickers").datetimepicker("setEndDate",$("#datetimepickere").val())
            });
            $('#datetimepickere').datetimepicker({ format: 'yyyy-mm-dd', language:  'zh-CN',     autoclose: true,
                minView:'month'}).on("click",function(){
                $("#datetimepickere").datetimepicker("setStartDate",$("#datetimepickers").val())
            });
            $("#datetimepickers").val(dateObj.beforeDate);
            $("#datetimepickere").val(dateObj.nowDate);
            $("#dateDat").html( returnopt(orderUtil.dateConfig,2)).change(function(){
                var code = $(this).val().substring(0, 2);
                var num = $(this).val().substring(2, $(this).val().length);
                var dt = orderUtil.dpDateCompute(code, num);
                $("#datetimepickers").val(dt.beforeDate);
                $("#datetimepickere").val(dt.nowDate);
            });
            $("#dateDat").select2({
                minimumResultsForSearch: Infinity
            });

            $.ajax({
                url:"/system/partner/dropdownPartner?partnerType=1",
                dataType:"json",
                success:function(data){
                    $("#customerDat").html( returnopt(data,1));
                    $("#customerDat").select2({
//                        maximumInputLength:2，
                        templateResult: formatState
                    });
                    var showNum = "order4";
                    var type = GetRequest().type;
                    if (type != "" && type != undefined) {
                        showNum = type;
                    }
                    reload();
                },
                error:function(){
                }
            });

            $(".back").click(function(){
                location.href = '/openPage?pageName=advert_sales-order-list';
            })

            //全部订单搜索
            $("#searchBtn").click(function () {
                reload();
            })
        });
        function  returnopt(data,type) {
            var opt="";
            for(var i=0;i<data.length;i++){
                var dt=data[i];
                var dtn ="";
                if(type ==1){
//                    if(dt.partnerShortname==undefined){continue;}
                    dtn =dt.myComShortname==undefined?"全部客户":dt.myComShortname;
                    opt +='<option value="'+dt.partnerKey+'">'+dtn+'</option>';
                }
                if(type ==2){
                    dtn =dt.show;
                    opt +='<option value="'+dt.key+'">'+dtn+'</option>';
                }
            }
            return opt;
        }
        function formatState (state) {
            var $state = $(
                '<span >'+state.text + '</span>'
//                '<span style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;width:90px;display: block;">'+state.text + '</span><i style="position:absolute;right:0;top:5px;">sfsd</i>'
//                '<span><img src="/' + state.element.value.toLowerCase() + '.png" class="img-flag" /> ' + state.text + '</span>'
            );
            return $state;
        }



    </script>
</div>

<div  data-options="region:'center'" style="border:none !important;padding:10px;width: 100%;" >
    <table id="order"  style="width: 100%;" class="easyui-datagrid order"
           data-options="remoteSort:false,
           nowrap:true,singleSelect:false,checkOnSelect:false,onLoadSuccess:onLoadSuccess,fit:true">
    </table>
</div>

<%--订单流程详情--%>
<div id="orderProcedure" style="box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2); background: #fff; position: absolute;z-index: 9999;top:50%;left:60%;margin-left:-435px;margin-top:-286px; display: none;">
    <div style="font-size: 18px;color: #333;line-height: 50px; padding-left: 15px;"></div><span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" onclick="closeOverFlow()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="margin: 50px auto 60px; padding: 0 50px;"><img src="../../images/firend.png" alt="订单流程图"></div>
    <div style="text-align: center;border:1px solid #ccc; border-radius: 3px;font-size: 12px;color: #ccc; height: 30px; width: 120px;line-height: 30px;margin: 0 auto 30px;cursor: pointer; " onclick="closeOverFlow()">我知道了</div>
</div>
<!--同步弹出框-->
<div id="taxPointWin" c-widget="Sidebar; direction:top;size:auto;dimmerClose:false" class="segment show-on-ready" style="padding-top:5px;top:50%;left:50%;margin-left:-330px; margin-top:-200px;position:absolute; width: 440px;height:300px;">
     <p style="position:relative;font-weight: 100; text-align: left; font-size: 18px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;">
        订单同步确认</p>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" onclick="closeTaxPoint()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <p style="  width: 350px;margin: 20px auto;font-size: 12px;position: relative;text-align: center;color: #999; background: #f5f5f5;line-height: 30px;height: 30px;">同步成功后，对方就可以登录他的易对账通过采购查看啦</p>
        <span class="customerjc" style="position:relative;text-align:center;margin: 0 auto;font-size:16px;font-weight:normal;color:#44ae80;height: 30px;line-height: 30px;" data-title="客户简称" id="partnerShortname">通过对账单和客户做确认</span>
        <div style="font-size:16px;padding:20px;">已选择<span id="numIndex" style="color:#fe3333;"></span>张待对账订单</div>
        <div style="clear: both;margin: 20px auto;">
            <button type="button" class="btn "  onclick="closeTaxPoint()" style="width:100px;font-size:12px;">以后再说</button>
            <button type="button" class="btn btn-primary" style="margin-left:30px;width:100px;font-size:12px;" onclick="batchGenerateBill(this)">立即同步</button>
        </div>
    </div>
</div>
<script src="/common/growingio.js"></script>
<script type="text/javascript">


    var pageUrl="/ydz/salesorder/listPageTotalDetailByOrder";// 本页面请求url
    var pageUr2="/ydz/salesorder/synchroSingleSalesOrder"  //同步数据
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
        var url=pageUrl;
        var arrclo=[];
        arrclo.push({field:'ck',checkbox:true});
        arrclo.push({field:'orderDate',title:'下单日期',width:100,align:'center'});
        arrclo.push({field:'partnerShortname',title:'客户简称',width:120});
        arrclo.push({field:'contactName',width:80,align:'left',title:'联系人'});
        arrclo.push({field:'businessDesc',width:200,title:'业务内容'});
        arrclo.push({field:'requirements',width:200,title:'物料/制作/说明'});
        arrclo.push({field:'specification',width:100,align:'left',title:'规格(m)'});
        arrclo.push({field:'quantity',width:60,align:'center',title:'数量'});
        arrclo.push({field:'totalArea',width:60,align:'right',title:'面积(㎡)'});
        arrclo.push({field:'unit',width:80,align:'center',title:'单位'});

        arrclo.push({field:'unitPrice',width:80,align:'right',formatter: function(value, row) {
            return accounting.formatNumber(value,2);
        },title:'单价(元)'});
        arrclo.push({field:'totalPrice',width:100,align:'right',formatter: function(value, row) {
            return accounting.formatNumber(value,2);
        },title:'行小计(元)'});
        arrclo.push({field:'totalPriceOrder',width:100,align:'right',formatter: function(value, row) {
            return accounting.formatNumber(value,2);
        },title:'订单金额'});
        arrclo.push({field:'createTime',sortable:true,width:130,align:'center',title:'制单时间'});
        arrclo.push({field:'salesNo',width:155,align:'center',title:'单号',formatter: function(value, row) {
            if(row.purchaseNo !=''){
                return value+'<p class="plistmarkSale">协</p>';
            }
            return value;
        }});
            $('#order').datagrid({
                url : url,
                pagination:true,
                columns:[arrclo],
                queryParams : {
                    "partnerKey":$('#customerDat').val(),                   
                    "endTime":$('#datetimepickere').val(),
                    "searchKey":$('#searchK').val(),
                    "startTime" : $('#datetimepickers').val(),
                    "notSynchro" : 1
                }
            });
        var pager = $('#order').datagrid('getPager');	// get the pager of datagrid
        pager.pagination({
            layout:['first','links','last'],
            showRefresh:false,
            displayMsg:''
        });
        $(".pagination").show();
    }
    //        url:'ydz/salesorder/listPageTotalDetail?orderStatus=01'
    //        ,url:'ydz/salesorder/listPageTotalDetail?orderStatus=04'
    //        ,url:'ydz/salesorder/listPageTotalDetail?orderStatus=05'
    //        ,url:'ydz/salesorder/listPageTotalDetail'

    /*  order 全部订单
     order5 已对账订单
     order4 待对账订单
     order2 待提交（草稿箱）*/

    //        $('#order').datagrid('enableCellEditing');
    function msg(content){
        $("#msgwindow").html(content).addClass("activ");
    }
   
    function onLoadSuccess(data){
        if (data.rows.length > 0 ) {

            var num=0;
            for(var i=0;i<data.rows.length;i++){
                num +=Number(data.rows[i]["totalPrice"]);
            }
            $("#order2PagerNum").text(data.total);
            $("#order2PagerPrice").text(accounting.formatNumber(num,2));

            mergeCellsByField("order", 'ck,orderDate,salesNo,partnerShortname,contactName,createTime,totalPriceOrder');
        }else{
            $("#order2PagerNum").text(0);
            $("#order2PagerPrice").text("0.00");
            $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
        }
    }
    //订单示意图
    function showOverFlow(){
        $("#orderProcedure").css({display:'block'})
        $(".window-mask").show();
    }
    function closeOverFlow(){
        $("#orderProcedure").css({display:'none'})
        $(".window-mask").hide();
    }
    function mergeCellsByField(tableID, colList) {
        var ColArray = colList.split(",");
        var tTable = $("#" + tableID);
        var TableRowCnts = tTable.datagrid("getRows").length;
        var tmpA;
        var tmpB;
        var PerTxt = "";
        var CurTxt = "";
        var alertStr = "";
        for (j = ColArray.length - 1; j >= 0; j--) {
            PerTxt = "";
            tmpA = 1;
            tmpB = 0;

            for (i = 0; i <= TableRowCnts; i++) {
                if (i == TableRowCnts) {
                    CurTxt = "";
                }
                else {
                    CurTxt = tTable.datagrid("getRows")[i][ColArray[j]]+tTable.datagrid("getRows")[i]["salesNo"];
                }
                if (PerTxt == CurTxt) {
                    tmpA += 1;
                }
                else {
                    tmpB += tmpA;

                    tTable.datagrid("mergeCells", {
                        index: i - tmpA,
                        field: ColArray[j],//合并字段
                        rowspan: tmpA,
                        colspan: null
                    });
                    tmpA = 1;
                }
                PerTxt = CurTxt;
            }
        }
    }
    function openTaxPoint() {
        
//        var order4ItemsArr =$('#order').datagrid('getSelections');
        var order4ItemsArr =$('#order').datagrid('getChecked');
        var order4Items=[];
        var checkRow="";
        for(var i=0;i<order4ItemsArr.length;i++){
            if(i==0){
                checkRow=order4ItemsArr[i].salesNo;
                order4Items.push(order4ItemsArr[i]);
            }else{
                if(order4ItemsArr[i].salesNo==checkRow){
                    continue;
                }else{
                    checkRow=order4ItemsArr[i].salesNo;
                    order4Items.push(order4ItemsArr[i]);
                }
            }
        }

        var partnetKey,partnerShortname;
        var flag = false;
        var numIndex = 0,partnerIndex=0;
        $.each(order4Items,function (index, element) {
            //判断是否同一用户
            if (numIndex == 0) {
                partnetKey = element.partnerKey;
                partnerShortname = element.partnerShortname;
            } else if (partnetKey != element.partnerKey) {
                $("<div class='tips_contants'>").fadeIn(250).html("请选择相同客户").delay(3000).fadeOut(250).appendTo('body');
                flag = true;
                return false;
            }
            numIndex++;
        });
//        只能勾选同一类型的订单生成对账单
//        如订单号旁标识“协”，则说明此单为好友订单

        if (flag) {
            return false;
        }
        var salesNos = new Array();
        $.each(order4Items,function (index, element) {
            salesNos.push(element.salesNo);
        });
        if (salesNos.length == 0) {
            $("<div class='tips_contants'>").fadeIn(250).html("请选择需要同步的订单").delay(3000).fadeOut(250).appendTo('body');
        } else {
            $(".window-mask").show();
            $("#numIndex").text(numIndex);
            $("#partnerShortname").text(partnerShortname);
            $("#taxPointWin").css({display:'block'});
        }
    }

 function closeTaxPoint() {
        $("#taxPointWin").css({display:'none'});
        $(".window-mask").hide();
    }


    function  batchGenerateBill(btn) {
        $(btn).attr("disabled", true);
        var order4ItemsArr =$('#order').datagrid('getChecked');
        var order4Items=[];
        var checkRow="";
        for(var i=0;i<order4ItemsArr.length;i++){
            if(i==0){
                checkRow=order4ItemsArr[i].salesNo;
                order4Items.push(order4ItemsArr[i]);
            }else{
                if(order4ItemsArr[i].salesNo==checkRow){
                    continue;
                }else{
                    checkRow=order4ItemsArr[i].salesNo;
                    order4Items.push(order4ItemsArr[i]);
                }
            }
        }
        var salesNos = new Array();
        var partnetKey;
        var flag = false;
        var numIndex = 0;
        $.each(order4Items,function (index,element) {
            salesNos.push(element.salesNo);
            //判断是否同一用户
            if (numIndex == 0) {
                partnetKey = element.partnerKey;
            } else if (partnetKey != element.partnerKey) {
                $(btn).attr("disabled", false);
                $("<div class='tips_contants'>").fadeIn(250).html("请选择相同客户").delay(3000).fadeOut(250).appendTo('body');
                flag = true;
                return false;
            }
            numIndex++;

        });
        if (flag) {
            return false;
        }

        var parse;
        parse=salesNos.join(',');
        console.log(parse)
        $.ajax({
            type: "POST",
            url: pageUr2,
            data: {"salesNos":parse},
            async: "false",
            dataType: "json",
            success: function (callback) {
                closeTaxPoint();
                 $(btn).attr("disabled", false);
               $("<div class='tips_contants'  style='line-height: 40px'>").fadeIn(250).html("<i style='color:#fff;font-size:20px;position:relative;top:3px;' class='iconfont_new'>&#xe6c7;</i>&#x3000;同步成功</br>可以告知对方通过 【采购单列表】 查看").delay(3000).appendTo('body');
                setTimeout(function(){
                    location.reload();
                },2000)
            },
            error: function () {
                closeTaxPoint();
                $(btn).attr("disabled", false);
                $("<div class='tips_contants'>").fadeIn(250).html("同 步 失 败").delay(3000).fadeOut(250).appendTo('body');
                setTimeout(function(){
                    location.reload();
                },2000)
            }
        })
    }
</script>
</body>
</html>