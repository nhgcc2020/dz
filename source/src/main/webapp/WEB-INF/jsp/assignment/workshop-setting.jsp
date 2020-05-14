<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>制作-工作车间</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">

    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/animate.css?v=044dba19fd">
    <style type="text/css">
        .prettyck label:before{
            top:1px;
        }
        .namebd{
            font-size:12px;
            color:#4284d9;
            cursor: pointer;
            text-decoration: underline;
        }
        .topbarPrCss{
            display: none;        position: absolute;
            top: 0px;
            left: 0px;
            z-index: 999;
            background: rgb(255, 255, 255);
            height: 100%;
            border-bottom: 1px solid rgb(204, 204, 204);
            /*overflow: hidden;*/
            width: 100%;
            box-shadow: rgba(34, 36, 38, 0.14902) 0px 0px 20px;
            box-sizing: border-box;
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
            height:40px;

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

        .contactbd{
            /*height: 50px;*/
            color: #b3b3b3;
            font-size:12px;
            /*line-height: 45px;*/
        }
        .namebdsml{
            font-size:12px;
            color:#b3b3b3;
            margin-left:15px;
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
        .datagrid-body{
            overflow-x:hidden ;
        }
        .nicescroll-rails-vr,.nicescroll-rails-hr{
            /*display: block !important;*/
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
        .nav-tabs li:nth-child(1)~.block {
            position: absolute;
            bottom: 3px;
            left: 10px;
            width: 70px;
            height: 2px;
            background-color: #2e8ae6;
            transition: all .3s;
        }
        #taxPointWin{
            border: none;
            z-index: 99;
            width:700px;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
            min-height:290px;
            background: #fff;
            transition:all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
            display: none;
        }
        .labelCon{
            display: inline-block;
            margin: 0 10px 0 0;
        }
        .labelCon:hover{
            color:#4284d9;
        }
        .west ul>li.active{
            background: #D6E8F3 !important;
        }
    </style>
    <script src="/resources/jquery/jquery-2.1.3.js?v=b11891de95"></script>
    <script src="/resources/easyui/pace.min.js?v=cdbdd88ddf"></script>
    <script src="/resources/bootstrap/js/bootstrap.min.js?v=9e25e8e29e"></script>
    <script src="/resources/easyui/jquery.easyui.min.js?v=0e0e0cc31b"></script>
    <script src="/resources/easyui/locale/easyui-lang-zh_CN.js?v=af8a82977a"></script>
    <script src="/resources/business/base_new.js?v=9ac481258d"></script>
    <script src="/resources/pageConfig.js?v=d1935279f7"></script>
    <script src="/resources/business/workshop-setting.js?v=abc75b6555"></script>

</head>
<body class="easyui-layout" style=" overflow: hidden; ;border:none !important;">
<div  id="datagrid-mask-msg"  class="frame_box datagrid-mask-msg" style="display:block;left:50%"><span></span></div>
<div id="taxPointWin"  style="padding-top:5px;top:50%;left:50%;margin-left:-300px; margin-top:-230px;position:absolute; width: 600px;height:375px;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 18px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;color:#000;" id="fuwuTitle">
        创建工作车间</p>
    <input type="hidden" name="fwdjId" id="fwdjId" />
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" onclick="orderTableWs.closeTaxPoint()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <div style="    width: 485px;margin: 30px auto 25px;line-height: 30px;position: relative;text-align: right;">
            <div class="form-group" >

                <div class="col-sm-12 " style="
    padding: 0;
margin-bottom: 10px;
    text-align: left;
    color:#000;
    font-size:14px;
">
                  选择工序&#x3000;&#x3000; <select type="text" multiple="multiple" readonly style="width:390px;" class="form-control" id="gxWaySel">
                    </select>
                </div>
            </div>
        </div>

        <div style="clear: both;margin: 20px 0 0 0; padding-bottom: 20px; position:absolute;bottom:10px;right:65px;">
            <button type="button" class="btn  btn-default"  onclick="orderTableWs.closeTaxPoint()" style="width:90px;">取消</button>
            <button type="button" class="btn btn-primary" style="margin-left:5px;width:90px;font-size:12px;" onclick="orderTableWs.saveTable(this)">填充单行</button>
            <button type="button" class="btn btn-primary" style="margin-left:5px;width:90px;font-size:12px;" onclick="orderTableWs.saveTableAll(this)">填充全部</button>
        </div>
    </div>
</div>
<div  id="msgwindow"   style="border:none;" ></div>

<div class="window-mask" style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:9;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>

<div data-options="region:'north'" style="border:none !important;overflow: hidden;">
    <article style="    text-align: left;
    font-size: 1.6rem;
    padding: 1.2rem;
    border: 1px solid #dadadf;
    margin: 12px 12px 0;">
        工序关联服务类目
        <%--<div class="col-xs-6 pull-right" style="margin-top:-5px;text-align: right">--%>
            <%--<button type="button" class="btn btn-primary"  onclick="orderTableWs.guanlianGx(this)" style="">批量关联</button>--%>
        <%--</div>--%>
    </article>
    <div style="color: #ff9900;
    position: absolute;
    left: 200px;
    top: 29px;">  <span class="prettyck"><input class="assignDesDef" type="checkbox"><label style="color: #333;">启用默认制作派工</label></span>
        <span style="margin-left: 20px;color:#999;">启用默认制作派工后,新建销售订单将默认打开制作派工</span>
    </div>
</div>


<div id="regionCon"  data-options="region:'center'" style="border:none !important;padding:10px;width: 100%;" >



        <div  style="    width: 174px;
    height: 100%;
    position: absolute;">
            <div  class="west westl" style="position: absolute;left: 0;">
                <h1 class="westH1Left">类目</h1>
                <ul id="leftMenu">

                </ul>
            </div>
        </div>

        <div class="orderTbText"  style="width: 100%;
    height: 100%;
    padding: 0 0 10px 180px;">

                        <div id="tbOrder" class="col-xs-6" style="padding-bottom:11px;padding-top:2px;">
                            <div class="input-group">
                                <input type="text" class="form-control"

                                       onkeypress="if(event.keyCode == 13) {reload('');return false;}"
                                       id="searchKey" placeholder="输入 物料制作说明 搜索" style="      width: 282px;
    border-radius: 30px;
    color: #000;
    font-size: 12px;
    adding-right: 30px;">
                               <span class=" iconfont_new" id="searchBtn" onclick="reload()"  style="        cursor: pointer;
    position: absolute;
    top: 2px;
    width: 20px;
    right: 8px;
    font-size: 20px;
    transform: rotate(-5deg);
    color: #b3b3b3;">&#xe6df;</span>
                            </div>
                        </div>
                            <table id="order" toolbar="#tbOrder"  style="width: 100%;margin-top:50px;" class="easyui-datagrid "
                                   data-options="remoteSort:false,
fitColumns : true,fit:true,
           nowrap:true,singleSelect:true,checkOnSelect:false,
          onLoadSuccess:onLoadSuccess">
                                <thead>
                                <tr>

                                    <th data-options="field:'index',width:50,align:'center',formatter:function(val,row,index){
                return index+1;
                }">
                                        序号
                                    </th>
                                    <th data-options="field:'categoryDesc',width:100,align:'left'">物料制作说明</th>
                                    <th data-options="field:'workingProcedure',width:100,align:'left',formatter:orderTableWs.relateWkShop">关联制作工序</th>
                                </tr>
                                </thead>
                            </table>
        </div>
</div>

</body>
</html>