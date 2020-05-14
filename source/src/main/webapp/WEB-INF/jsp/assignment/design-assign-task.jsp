<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>设计-任务分派</title>
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
    <style type="text/css">
        .prettyck label:before{
            top:1px;
        }
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
            height:40px;

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
            text-align: center !important;
        }
        .tips_contants{position:fixed;top:50%;left:50%;z-index:99999;display:none;margin-top:-150px;margin-left:-150px;width:300px;height:80px;border-radius:5px;background:rgba(0,0,0,.8);color:#fff;text-align:center;line-height:80px}

        .pagination{
            display: none;
        }

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
            font-size: 14px;
        }
        .form-control {
            display: block;
            width: 100%;
            height: 30px;
            padding: 6px 10px 6px 12px;
            font-size: 12px;
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
        .pagination-btn-separator{
            display: none;
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
            /*height: 40px;*/
            /*line-height: 30px;*/

            font-size:12px;
            color:#000;
        }
        .contactbd{
            /*height: 50px;*/
            color: #b3b3b3;
            font-size:12px;
            /*line-height: 45px;*/
        }
        .contentInfo{
            line-height: 23px;
            font-size:12px;
        }
        .remarksInfo{
            font-size:12px;
        }
        .namebdsml{
            font-size:12px;
            color:#b3b3b3;
            line-height: 23px;
            /*margin-left:15px;*/
        }
        .nametask{
            font-size:12px;
            line-height: 23px;
        }
        .telhover,.qqhover{
            margin-left:8px;
            vertical-align: middle;
        }
        .contacthover{
            margin-right:20px;
        }

        .tooltip{
            border:none !important;
            background: transparent !important;
        }
        .tooltip-arrow {
            display: none;
        }
        #assignTaskWin{
            border: none;
            z-index: 999;
            width:700px;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
            background: #fff;
            transition:all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
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

        .nicescroll-rails-vr,.nicescroll-rails-hr{
            /*display: block !important;*/
        }
        #navCondition li{
            margin-right:10px;
        }
        .nav-tabs{
            position: relative;
        }
        .nav-tabs li:nth-child(2).active~.block {
            transform: translate(83px,0);
        }
        .nav-tabs li:nth-child(3).active~.block {
            transform: translate(167px,0);
        }



        .nav-tabs li:nth-child(1)~.block {
            position: absolute;
            bottom: 3px;
            left: 7px;
            width: 60px;
            height: 2px;
            background-color: #2e8ae6;
            transition: all .3s;
        }
.inputLab input{
    vertical-align: middle;
    margin-top: -2px;
}
        .inputLab div{
            display: inline-block;
            margin-top:5px;
        }
        .inputLab label{
            margin-right: 30px;
            margin-left: 4px;
        }


    </style>
</head>
<body class="easyui-layout" style=" overflow: hidden; ;border:none !important;">
<div  id="datagrid-mask-msg"  class="frame_box datagrid-mask-msg" style="display:block;left:50%"><span></span></div>

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
<div id="assignTaskWin" c-widget="Sidebar; direction:top;size:auto;dimmerClose:false" class="segment show-on-ready" style="padding-top:5px;top:50%;left:50%;margin-left:-330px; margin-top:-286px;position:absolute; width: 660px;height:398px;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 22px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;">
        派工</p>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" onclick="closeTaxPoint()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="    text-align: center;
    margin: 0 auto;
    display: block;
    overflow: auto;
    overflow-x: hidden;
    height: 340px;">
        <p style="  width: 500px;margin: 20px auto;font-size: 12px;position: relative;text-align: center;color: #999; background: #f5f5f5;line-height: 30px;height: 30px;">派工后，订单进入设计中状态，相关设计师通过我的任务 查看所属任务</p>
        <span class="customerjc" style="position:relative;text-align:center;margin: 0 auto;font-size:14px;font-weight:normal;color:#44ae80;height: 30px;line-height: 30px;" id="partnerShortname"><span style="    font-size: 30px;
    vertical-align: bottom;" class="iconfont_new">&#xe67c;</span>选择设计师开工干活吧</span>

        <input type="hidden" name="depositRequestedHid" id="depositRequestedHid">
        <input type="hidden" name="totalPriceHid" id="totalPriceHid">
        <input type="hidden" name="receivePriceHid" id="receivePriceHid">

        <div style="margin:20px auto;width:500px;text-align: left;" class="inputLab">

        </div>
        <div style="margin:-1px auto;width:500px;border-top:1px solid #ccc"></div>
        <div style="margin:20px auto;width:500px;">
            <textarea rows="2" id="taskDesc" style="    width: 500px;
    resize: none;
    border-color: #ccc;
    padding: 10px 5px;" placeholder="任务简述"></textarea>
        </div>


        <div style="clear: both;margin: 20px 0 20px 280px;">
            <button type="button" class="btn "  onclick="closeTaxPoint()" style="width:100px;">取消</button>
            <button type="button" class="btn btn-primary" style="margin-left:15px;width:100px;font-size:12px;" onclick="assignTasker(this)">派工</button>
        </div>
    </div>
</div>


<div  data-options="region:'north'" style="border:none !important;padding:10px 10px 0;margin-right: 10px;overflow: hidden;" >

    <ul class="nav nav-tabs" id="navCondition">
        <li style="position:relative;" class="active">     <a href="#">待分派</a></li>
        <li style="position:relative;"><a href="#">进行中</a></li>
        <li style="position:relative;"><a href="#">已完成</a></li>
        <li class="block"></li>
    </ul>

    <div style="color: #ff9900;
    position: absolute;
    left: 290px;
    top: 20px;" id="caozuoTip"  data-toggle="popover" data-container="body" data-trigger="hover" data-placement="bottom"
         data-html="true"        data-content="当此项任务的所有设计师完工，任务才会已完成" >进行中的任务如何变为已完成<span  class="iconfont_new" style="position: relative;top:-1px;vertical-align: middle;font-size: 20px">&#xe6b8;</span></div>

    <div style="color: #ff9900;
    position: absolute;
    left: 540px;
    top: 22px;">  <span class="prettyck"><input type="checkbox" class="assignDesDef"><label class="blink" style="color: #333;">启用默认设计派工</label></span>
    <span style="margin-left: 20px;color:#999;">启用默认设计派工后,新建销售订单将默认分派到设计派工</span>
    </div>

    <div class="h10"></div>
    <div  style="    padding: 10px;
    border: 1px solid #ebebeb;">

        <form role="form">
            <div class="row" style="margin:0;">
                <div class="col-xs-2" style="width:150px;padding:0 5px 0 0">
                    <%--<input type="text" class="form-control" placeholder="选择客户">--%>
                    <select class="form-control input-xs" id="customerDat" placeholder="选择客户">
                    </select>
                </div>
                <div class="col-xs-2" style="width:150px;padding:0 5px">
                    <select class="form-control input-xs" id="taskerSel">
                        <option value=""></option>
                    </select>
                </div>
                <div class="col-xs-2 " style="width:150px;padding:0 5px"  >

                    <div class="">
                        <div class="input-icon-group">
                            <div class="" style="width:100%">
                                <input type="text" style="" placeholder="订单日期" class="form-control" id="datetimepickers" data-format="yyyy-MM-dd" placeholder="">
                                <%--<span class="glyphicon glyphicon-calendar "></span>--%>
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
                                <input type="text" style="" placeholder="订单日期" class="form-control" id="datetimepickere"  data-format="yyyy-MM-dd"  placeholder=""  >
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
                <div class="col-xs-2" style="padding-left: 0">
                    <button type="button" class="btn btn-primary  modifyOrder " style="font-size:12px;height:30px;line-height:1;" onclick="reload()">查询</button>
                </div>

            </div>
        </form>
    </div>

</div>


<div id="regionCon"  data-options="region:'center'" style="border:none !important;padding:10px;width: 100%;" >

    <table id="order"  style="width: 100%;" class="easyui-datagrid order"
           data-options="remoteSort:false,

           nowrap:true,
           singleSelect:false,
           <%--fitColumns:true,--%>
           onClickCell:assignTask,
           checkOnSelect:false,onLoadSuccess:onLoadSuccess,fit:true">
        <thead>
        <tr>

            <th data-options="field:'orderDate',sortable:true,width:140,align:'left',formatter: function(value, row) {
            return orderTable.partnerInfoCall(row);

          		}">订单概要</th>
            <th data-options="field:'businessDesc',width:420,align:'left',formatter: function(value, row) {
            return orderTable.contentInfo(row);
          		}">业务内容</th>
            <th data-options="field:'partnerShortname',width:120,align:'center'">客户</th>
            <th data-options="field:'contactName',width:80,align:'center'">联系人</th>
            <th data-options="field:'remarks',width:250,align:'left',formatter: function(value, row) {
            return orderTable.remarksInfo(row);
          		}">任务说明</th>
            <th data-options="field:'taskUser',width:120,align:'left',formatter: function(value, row) {
            return orderTable.taskInfo(row);
          		}">任务人</th>
            <th data-options="field:'salesNo',width:150,align:'center'">销售单号</th>
            <th data-options="field:'taskDate',width:130,sortable:true,align:'center',formatter: function(value, row) {
            return orderTable.taskDate(row);
          		}">分派时间</th>
            <th data-options="field:'cz',width:80,resizable:false,align:'center',formatter: function(value, row) {
          			return orderTable.formatStatus(row);
          		}">操作</th>
        </tr>
        </thead>
    </table>



</div>
<script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
<script src="/resources/easyui/jquery.easyui.min.js?v=0e0e0cc31b"></script>
<script src="/resources/easyui/locale/easyui-lang-zh_CN.js?v=af8a82977a"></script>
<script src="/resources/bootstrap/js/bootstrap.min.js?v=9e25e8e29e"></script>
<script src="/resources/bootstrap/bootstrap-datetimepicker.js?v=ca317bd7f1" charset="UTF-8"></script>
<script src="/resources/easyui/pace.min.js?v=cdbdd88ddf"></script>
<script src="/resources/business/base_new.js?v=9ac481258d"></script>


<script>
    var pageDoneTaskUrl="/order/assignment/doneTask";//完工请求
    var pageAssginUrl="order/assignment/assignTask";//派工请求
    var pageAssginUpdateUrl="order/assignment/updateAssignTask";//进行中的派工发出请求
    var pageStartAssginUrl="/order/assignment/listAssignTasks";//进行中已完成派工请求

    var pagePartnerUrl="/system/partner/dropdownPartner?partnerType=1";//客户请求
    var pageTableUrl='/order/assignment/listAssignStandingBy';//表格数据请求
    var pageAssignEmpUrl='/order/assignment/listAssignEmployee';//任务人请求数据
    var pageConfigConUrl="/company/config/get"; //配置信息获取
    var pageConfigUpdateConUrl="/company/config/update"; //配置信息获取    {key:XXX,value:XXX}

    $(function () {
        $('#datetimepickers').datetimepicker({ format: 'yyyy-mm-dd', language:  'zh-CN',   autoclose: true,
            minView:'month'}).on("click",function(){
            $("#datetimepickers").datetimepicker("setEndDate",$("#datetimepickere").val())
        });
        $('#datetimepickere').datetimepicker({ format: 'yyyy-mm-dd', language:  'zh-CN',     autoclose: true,
            minView:'month'}).on("click",function(){
            $("#datetimepickere").datetimepicker("setStartDate",$("#datetimepickers").val())
        });


        $.ajax({
            url:pageAssignEmpUrl,
            dataType:"json",
            success:function(data){
                $("#taskerSel").html( returnopt(data.taskEmployees,2));
                $("#taskerSel").select2({
                    minimumResultsForSearch: Infinity
                });
                selPartner();
            }
        });
        var selPartner=
            function () {
                $.ajax({
                    url:pagePartnerUrl,
                    dataType:"json",
                    success:function(data){
                        $("#customerDat").html( returnopt(data,1));
                        $("#customerDat").select2({
                            templateResult: formatState
                        });
                        reload();
                    },
                    error:function(){
                    }
                });
            }




        //全部订单搜索
        $("#searchBtn").click(function () {
            var status= $("#btnGrpOp").find(".btn.smcolor").attr("data-s");
            reload(status);

        })
        $.ajax({
            url: pageConfigConUrl,
            type: 'GET',
            dataType: "json",
            success: function (dt) {
                var d=dt.data;
                if(d.length>0){
                    for(var i=0;i<d.length;i++){
                        if(d[i].configKey=="ASSIGN_DESIGN"){
                            if(d[i].configValue=="1"){
                               $(".assignDesDef").prop("checked",true);
                            }else{
                                $(".assignDesDef").prop("checked",false);
                            }
                        }
                    }

                }
            }
        });
$(".assignDesDef").on("click",function () {
    var t=$(this).is(":checked")?"1":"0";
    $.ajax({
        url: pageConfigUpdateConUrl,
        type: 'GET',
        data:{"key":"ASSIGN_DESIGN","value":t},
        dataType: "json",
        success: function (dt) {
        }
    });
})
    });

    function  returnopt(data,type) {
        var opt="";
        if(type==2){opt='<option value="ALL">全部任务人</option>'}
        for(var i=0;i<data.length;i++){
            var dt=data[i];
            var dtn ="";
            if(type ==1){
//                    if(dt.partnerShortname==undefined){continue;}
                dtn =dt.myComShortname==undefined?"全部客户":dt.myComShortname;
                opt +='<option value="'+dt.partnerKey+'">'+dtn+'</option>';
            }
            if(type ==2){
                dtn =dt.realName;
                opt +='<option value="'+dt.employeeId+'">'+dtn+'</option>';
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
<script>

    $(function () {

    });
    var orderTable={
        partnerInfoCall:function (row) {
            var r=row.caseDesc==""?"无名称":row.caseDesc;
            return '<div class="namebd">'+new Date(row.orderDate).Format("yyyy-MM-dd")+'</div>'+'<div class="namebd"><span class="namebdsml">'+r+'</span></div>'
                ;
        },
        contentInfo:function (row) {
            var c=row.businessDesc.replace(new RegExp(";","gm"),'<br>');
            return '<div class="contentInfo">'+c+'</div>'
        },
        remarksInfo:function (row) {
            if(row.taskDesc==""){
                return '<div class="" style="color:#ccc;">无说明</div>'
            }else{
                return '<div class="namebd"><div class=" remarksInfo">'+row.taskDesc+'</div></div>'
            }
        },
        formatStatus: function (row){
            if($('#navCondition li.active').index()==2){
                return ''
            }
            return '<span style="cursor:pointer;color: #4284d9;" >派工</span>'
        },
        taskInfo: function (row){
            if(row.taskUser==null || row.taskUser==""){
                return ''
            }
            var ar=row.taskUser.split(";");
            var html="";
            for(var i=0;i<ar.length;i++){
                var a1=ar[i];
                console.log(a1);
                console.log(a1.slice(-1));
                if(a1.slice(-1)=="1"){
                    html+='<span class="nametask" style="display: block">'+a1.slice(0,a1.length-1)+'</span>'
                }else{
                   html+='<span class="nametask" style="color: #4db287;display: block">'+a1.slice(0,a1.length-1)+'【完工】</span>'
                }

            }
            return html;
        },
        taskDate: function (row){
            if(row.taskDate==null || row.taskDate==""){
                return ''
            }
            return '<span style="color: #b3b3b3;" >'+row.taskDate+'</span>'
        }
    };

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

    function  assignTask(index,field,value){
        if($('#navCondition li.active').index()==2){return;}
            if(field=="cz"){
                var rowData = $("#order").datagrid('getData').rows[index];
                $(".window-mask").show();
                $.ajax({
                    url:pageAssignEmpUrl,
                    dataType:"json",
                    data:{"taskNo":rowData.taskNo},
                    success:function(data){
                        var c='',dt=data.taskEmployees,dt2=data.doingTaskEmployee,dtarr=[],dtarr2=[];
                        if(dt2){
                            for (var k = 0; k < dt2.length; k++) {
                                if(dt2[k].status=="2"){
                                    dtarr.push(dt2[k].taskEmployeeId);
                                }
                                if(dt2[k].status=="1"){
                                    dtarr2.push(dt2[k].taskEmployeeId);
                                }
                                }
                        }
                        for(var i=0;i<dt.length;i++){
                            var t="tasker"+i;
                            if(dt2 && $.inArray(dt[i].employeeId, dtarr)>=0){
                       c +='  <div data-toggle="popover" data-toggle="popover" data-container="body" data-trigger="hover" data-placement="bottom" ' +
                           'data-html="true"   data-content="已完工,无法撤销"><input  tid="'+rowData.taskNo+'" did="'+rowData.salesNo+'" type="checkbox" value="'+dt[i].employeeId+'"  checked disabled name="tasker"  id="'+t+'"><label for="'+t+'">'+dt[i].realName+'</label></div>';
                            }else  if(dt2 && $.inArray(dt[i].employeeId, dtarr2)>=0){
                                c +='<div ><input tid="'+rowData.taskNo+'" did="'+rowData.salesNo+'" checked type="checkbox" value="'+dt[i].employeeId+'" name="tasker" id="'+t+'"><label for="'+t+'">'+dt[i].realName+'</label></div>';
                            }else{
                                c +='<div ><input tid="'+rowData.taskNo+'" did="'+rowData.salesNo+'" type="checkbox" value="'+dt[i].employeeId+'" name="tasker" id="'+t+'"><label for="'+t+'">'+dt[i].realName+'</label></div>';
                            }
                        }
                        $(".inputLab").html(c);
                        $('[data-toggle="popover"]').popover();
                        $("#taskDesc").val(rowData.taskDesc);
                        $("#assignTaskWin").css({display:'block'});
                    }
                });
            }
    }
    function closeTaxPoint() {
        $(".window-mask").hide();
        $("#assignTaskWin").css({display:'none'});
    }
    function assignTasker() {
        var txt=$("input[name='tasker']:checked"),url="";

        if(txt.length==0){      $("<div class='tips_contants'>").fadeIn(250).html("请至少选择一位员工").delay(3000).fadeOut(250).appendTo('body');return;}
        var numArr = []; // 定义一个空数组
        for (var i = 0; i < txt.length; i++) {
            numArr.push(txt.eq(i).val()); // 将文本框的值添加到数组中
        }
        var data={},taskNo=$(txt[0]).attr("did")?$(txt[0]).attr("tid"):"";
        var userKey=numArr.join(","),salesNo=$(txt[0]).attr("did")?$(txt[0]).attr("did"):"",taskDesc=$("#taskDesc").val();
        if($('#navCondition li.active').index()==1){url=pageAssginUpdateUrl;
             data={"taskEmployeeId":userKey,"taskNo":taskNo,"taskDesc":taskDesc};
        }else{url=pageAssginUrl;
             data={"taskEmployeeId":userKey,"salesNo":salesNo,"taskDesc":taskDesc};
        }


        $.ajax({
            url: url,
            type: "post",
            data:data,
            dataType: "json",
            success: function (callBack) {
                    $("<div class='tips_contants'>").fadeIn(250).html(callBack.msg).delay(3000).fadeOut(250).appendTo('body');
                closeTaxPoint();
                    reload();
            }, error: function () {
                $("<div class='tips_contants'>").fadeIn(250).html("添加出错,请联系管理员").delay(3000).fadeOut(250).appendTo('body');
            }
        });
    }
    function formatMoney(row1,row2) {
        var fontc="";
        if(row1=="0"){
            fontc="fontColor3c";
        }
        return '<div class=\'font12 '+fontc+'\'>'+row1+'&nbsp;笔</div >'+'<div class=\'font18 '+fontc+'\'>'+row2+'</div>' ;
    }
</script>
<script>
   $(function () {
        $("#navCondition").on("click","li",function () {
            $(this).addClass("active").siblings().removeClass("active");
            reload("");

        });
        $("#searchBtn").click(function () {
            reload("");

        })
//        datagrid-body
       $('[data-toggle="popover"]').popover();
    });

    function onLoadSuccess(data){
        try{
            if (data.rows.length > 0 ) {
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

    function reload() {
        console.log("reload");
        var st=$('#navCondition li.active').index()==0?"":$('#navCondition li.active').index();
        var url=$('#navCondition li.active').index()==0?pageTableUrl:pageStartAssginUrl;
        var queryParams ={
            "partnerKey":$("#customerDat").val(),
            "taskEmployeeId":$("#taskerSel").val(),
            "startDate":$("#datetimepickers").val(),
            "endDate":$("#datetimepickere").val(),
            "type":"1",
            "status":st
        };
        $.ajax({
            url:url,
            data:queryParams,
            dataType:"json",
            type:"post",
            success:function(data){
                $('#order').datagrid({
                    data:data,
                    loadFilter: function(data){
                        if (data.data){
                            return data.data;
                        } else {
                            return data;
                        }
                    },
                    pagination:false
                });
            },error:function () {
                $('#order').datagrid({
                    data:[],
                    pagination:false
                });
            }
        });
//

    }


</script>

</body>
</html>
