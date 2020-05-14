<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>服务分类定价</title>
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">

    <script src="/resources/jquery/jquery-2.1.3.js?v=b11891de95"></script>
    <script src="/resources/easyui/pace.min.js?v=cdbdd88ddf"></script>
    <script src="/resources/pageConfig.js?v=d1935279f7"></script>
    <script src="/resources/business/base_new.js?v=9ac481258d"></script>
    <script src="/resources/easyui/jquery.easyui.min.js?v=0e0e0cc31b"></script>
    <script src="/resources/business/dzorder/service-pricing.js?v=709c24ac37"></script>
    <style>
        .categoryDescEdit{
            position: relative;
            margin-right: 15px;
            overflow: hidden;
            cursor: pointer;
        }
        .categoryDescEdit>span{
            display: none;
            position: absolute;
            right: 1px;
            top: 1px;
            cursor: pointer;
        }

        .categoryDescEdit:hover >span{
            display: block;
        }

        .ui.widget-table table tbody td > div {  overflow: hidden;  padding: 0.2em 0.4em;  }
        .ui.input input{  padding: 0.5em 0.3em;  text-align:left  }
        .ui.widget-table table thead th{background: #fff;}
        .ui.widget-table > .fixed-header, .ui.widget-table > .fixed-footer{z-index: 99}

        .closeMore{width:20px;height:20px;position:absolute;right:0;top:0;cursor:pointer;text-indent:0}
        .closeMore:after,.closeMore:before{content:'';position:absolute;top:50%;width:20px;height:1px;background-color:#888;-webkit-transform:rotate(45deg);transform:rotate(45deg)}
        .closeMore:after{-webkit-transform:rotate(-45deg);transform:rotate(-45deg)}
        #learnMore  .closeMore:hover {  -webkit-transform: rotate(90deg);  }
        .partner_tips_2:before {
            position:relative;
        }       .radio, .checkbox{
                    margin:0;
                }
        .items tr td:nth-child(2) input{
            text-align: left;
        }
        .items tr td:nth-child(3) input,.items tr td:nth-child(4) input{
            border:none;

        }
        .items tr:nth-child(even) td:nth-child(3) input, .items tr:nth-child(even) td:nth-child(4) input{
            background: #f5f7fa;
        }
        .ui.list-view .items{
            height:260px;}

        .ui.list-view .list.item:hover{
            background: #4284d9;
            color:#fff;
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
            background: #d6e8f3 !important;
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
        #modifyMenuWin{
            border: none;
            z-index: 99;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
            min-height:290px;
            background: #fff;
            transition:all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
            display: none;
        }
        .priceDetailWin{
            border: none;
            z-index: 99;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
            min-height:290px;
            background: #fff;
            transition:all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
            display: none;
        }
        .priceDetailSet{
            border: none;
            z-index: 99;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
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
            padding:0 10px;
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
            height: 40px;
            line-height: 30px;

            font-size:14px;
            color:#000;
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
        #navCondition li{
            margin-right:10px;
        }
        .datagrid-header td{
            text-align: center;
        }
        .datagrid-td-rownumber{
            background: #fff;
        }
        .nav-tabs{
            position: relative;
        }
        .nav-tabs li:nth-child(2).active~.block {
            transform: translate(120px,0);
        }



        .nav-tabs li:nth-child(1)~.block {
            position: absolute;
            bottom: 3px;
            left: 10px;
            width: 120px;
            height: 2px;
            background-color: #2e8ae6;
            transition: all .3s;
        }

        .datagrid-body td{
            text-align: center;
        }
        .select2-container--default .select2-results>.select2-results__options{
            max-height: 200px;
        }
        .select2-container--default .select2-selection--single, .select2-container .select2-selection--single .select2-selection__rendered{
            text-align: left;
        }
        .westH1Left{
            text-align: center;
            font-size: 16px;

            margin-bottom:5px;
            padding: 10px 0;
            background: #e6f0f5;
            color: #6b9cdf;
        }
        .westH1Right{
            text-align: center;
            font-size: 16px;
            background: #e6f0f5;
            color: #6b9cdf;
            margin-bottom:5px;
            padding: 10px 0;

        }
        .westl{
            margin: 0px 5px 5px 10px;
        }
        .westr{
            margin: 0px 10px 5px 5px;
        }


        .west ul>li{
            letter-spacing: 2px;
            position: relative;
            padding-left: 10px;
            cursor: pointer;
            padding-right: 55px;
            border-bottom: 1px solid #eaeaea;
            height: 55px;
            overflow: hidden;
            color:#333;
            line-height: 55px;
            -ms-text-overflow: ellipsis;
            white-space: nowrap;
            text-overflow: ellipsis;
            font-size: 14px;
        }
        .west ul>li.fail{
            color:#999;
        }
        .west{
            width:174px;
            height: 100%;
        }
        .west ul>li>span{
            color: #8cb5e5;
            font-size: 12px;
            position: absolute;
            right: 3px;
            top: 0;
            visibility: hidden;
        }
        .west ul>li.active{
            background: #eff1f3;
        }
        .west ul>li:hover>span{
            visibility: visible;
            cursor: pointer;
        }
        .west .addMenu{
            text-align: center;
            padding: 0;
            color: #4284d9;
            /*width: 130.5px;*/
            height: 40px;
            font-size: 12px;
            cursor: pointer;
            line-height: 40px;
            border-bottom: 1px solid #dedede;
        }
        #rightMenu{
            overflow: auto;
            max-height:calc(100% - 170px);
        }
        #leftMenu{
            overflow: auto;
            max-height:calc(100% - 170px);
        }
        .panel-header, .panel-body{
            border-color: #eaeaea;
            border-left:0;
        }
        .datagrid-toolbar, .datagrid-pager{
            background: #fff;
        }
        .youhui{
            color:#5cb85c !important;
            font-weight: 700; 
        }
        .checkbox-slider--b-flat.checkbox-slider-md input + span:before {
            content: "停用";
            text-align: left;
            color:#fff;
            text-indent: 30px;
        }
        .checkbox-slider--b-flat.checkbox-slider-md input:checked+span:before {
            content: "启用";
            text-align: left;
            color:#fff;
            text-indent: 13px;
        }
        .checkbox-slider-md input+span:before{
            width:65px;
        }

        .checkbox-slider-md input:checked+span:after,.checkbox-slider--b-flat input:checked + span::after{
            margin-left: 40px;
        }
        .checkbox-slider--b-flat input+span:before{
            background: #666;
        }
        .checkbox-slider--b-flat.checkbox-slider-md input+span:after, .checkbox-slider--b-flat.checkbox-slider-md input+span:before{
            border-radius: 80px;
        }
        .checkbox-slider-md input+span:after{
            width:25px;
        }
        .checkbox-slider-md input+span:after, .checkbox-slider-md input+span:before{
            height: 25px;
            line-height: 25px;
        }
        .requireMenu{
            margin-bottom: 10px;
            text-align: left;color:#da4654;
        }
        .brdnone{
            border:none;
        }
        .datagrid-header-row, .datagrid-row, .datagrid-header{
            height: 50px;
        }
        .descSec{
            color:#ff704f;
            font-size: 12px;
            margin-left:15px;
        }
    </style>
</head>
<body  class="easyui-layout">
<div  id="datagrid-mask-msg"  class="frame_box datagrid-mask-msg" style="display:block;left:50%"><span></span></div>

<div id="deleteWin" class=" animated flipInY" style="    padding-top: 5px;
    top: 50%;
    left: 50%;
    margin-left: -125px;
    margin-top: -143px;
    position: absolute;
    width: 330px;
    height: 287px;">
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
            <span class="customerjcName" style="
                display: block;

                position: relative;
    text-align: center;
    margin: 40px auto;
    font-size: 22px;
    font-weight: normal;
    height: 30px;
    line-height: 30px;"></span>
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
            <button type="button" class="btn btn-primary" style="margin-left:12px;width:92px;font-size:12px;" onclick="deleteServLast(this)">确认</button>
        </div>
    </div>
</div>

<div id="taxPointWin" class="segment show-on-ready" style="padding-top:5px;top:50%;left:50%;margin-left:-300px; margin-top:-230px;position:absolute; width: 600px;height:460px;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 18px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;" id="fuwuTitle">
        添加服务定价    </p>

    <input type="hidden" name="fwdjId" id="fwdjId" />
    <input type="hidden" name="fwdjcid" id="fwdjcid" />
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" onclick="closeTaxPoint()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <div style=" margin: 20px 0 25px 2px;line-height: 30px;position: relative;text-align: right;">
            <div class="form-group" >
                <label class="col-sm-4 control-label" style="
    padding-right: 15px;
    text-align: right;
    font-size: 14px;
">服务内容：</label>
                <div class="col-sm-5 " style="
    margin-bottom: 10px;
padding:0;
">
                    <input type="text" style="width:214px;" class="form-control" id="categoryDesc" placeholder="请填写服务内容" />

                </div><div class="col-sm-3 hide requireMenu">服务不能为空</div>
                <label class="col-sm-4 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">计价方式：</label>
                <div class="col-sm-8 " style="
    padding: 0;text-align: left;
margin-bottom: 10px;
">
                    <select type="text" style="width:214px;" class="form-control" id="priceWaySel" placeholder="">
                    </select>
                </div>
                <label class="col-sm-4 control-label" style="
  padding-right: 15px;
    text-align: right;
    font-size: 14px;
">计价单位：</label>
                <div class="col-sm-8 " style="
    padding: 0;text-align: left;
margin-bottom: 10px;
">
                <select type="text" style="width:214px;" class="form-control" id="priceUnitSel" placeholder="计价单位">
                </select>
            </div>
            </div>
        </div>
        <div style="    clear: both;
    margin: auto;
    padding-top: 20px;
    width: 400px;
    border-bottom: 1px solid #ccc;"></div>

        <div style="  margin: 0 ; padding-top: 30px ; position: relative;">
                <div class="form-group" style="height: 30px;line-height: 30px;">
                    <label class="col-sm-4 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">优惠价：</label>
                    <div class="col-sm-8 pull-right" style="
    padding: 0;

">
                        <input data-s='select'style="width:214px;text-align: right"  type="text"  class="form-control" id="priceyh" placeholder="" />
                    </div>
                </div>
            <div class="form-group" style="height: 30px;line-height: 30px;">
                <label class="col-sm-4 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">标准价：</label>
                <div class="col-sm-8 pull-right" style="
    padding: 0;
">
                    <input data-s='select' style="width:214px;text-align: right"  type="text"  class="form-control" id="pricebz" placeholder="" />
                </div>
            </div>

            <div class="form-group" style="height: 30px;line-height: 30px;">
                <label class="col-sm-4 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">零散价：</label>
                <div class="col-sm-8 pull-right" style="
    padding: 0;

">
                    <input data-s='select' style="width:214px;text-align: right" type="text"  class="form-control" id="pricels" placeholder="" />
                </div>
            </div>

        </div>

        <div style="clear: both;margin: 20px 0 0 280px; padding-bottom: 20px; position:absolute;bottom:10px;right:30px;">
            <button type="button" class="btn  btn-default"  onclick="closeTaxPoint()" style="width:92px;">取消</button>
            <button type="button" class="btn btn-primary" style="margin-left:12px;width:92px;font-size:12px;" onclick="saveTable()">保存</button>
        </div>
    </div>
</div>
<div id="modifyMenuWin"  style="    padding-top: 5px;
    top: 50%;
    left: 50%;
    margin-left: -255px;
    margin-top: -150px;
    position: absolute;
    width: 511px;
    height: 301px;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 18px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;" id="menuTitle">
    </p>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" onclick="closeModifyMenu()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <div style="    width: 500px;margin: 66px auto 25px 47px;line-height: 30px;position: relative;text-align: right;">
            <div class="form-group" >
                <label style="    padding-right: 0;
    width: 70px;
    text-align: left;" class="col-sm-4 control-label">类目:</label>
                <div class="col-sm-5 " style="
    padding: 0;
    margin-bottom: 10px;
    width:210px;
    text-align: right;">
                    <input type="hidden" name="menu" id="menuId" />
                    <input type="hidden" name="pCode" id="pCode" />
                    <input type="text" class="form-control" maxlength="40" id="menu1" placeholder="请填写类目" />
                    <input type="hidden" id="menuv1" />
                </div>
                <div class="col-sm-3 hide requireMenu">类目不能为空</div>

            </div>
            <%--<div class="form-group" >--%>

                <%--<div class="col-sm-8 " style="--%>
    <%--padding: 0;--%>
    <%--margin-bottom: 10px;--%>
    <%--text-align: right;--%>
<%--">--%>
                    <%--<input type="text" class="form-control" id="menu2" placeholder="请填写二级类目" />--%>
                    <%--<input type="hidden" id="menuv2" />--%>
                <%--</div>--%>

            <%--</div>--%>
            <%--<div style="border-bottom:1px solid #ccc;width: 100%;"></div>--%>
                <label style="    padding-right: 0;
    width: 70px;margin-top:14px;clear:both;
    text-align: left;" class="col-sm-4 control-label">状态:</label>
                <div class="col-sm-8 " style="
    padding: 0;
    margin: 14px 0;
    text-align: right;
">

                        <%--<label style="    vertical-align: middle;--%>
    <%--font-size: 14px;--%>
    <%--margin-top: 5px;">类目启用</label>--%>
                    <div  class="checkbox checkbox-slider--b-flat checkbox-slider-md " style="">
                        <label>
                            <input type="checkbox" id="switchMenu" checked="checked" value="1"  ><span></span>
                        </label>
                    </div>
                            <div style="    position: absolute;
    top: 0;
    left: 80px;" class="hide addtip">如关闭,类目所有服务停用,且不可单独启用服务</div>
                            <div style="     position: absolute;
    top: 0;
    color: #ff9900;
    left: 80px;" class="hide deletetip">如删除,类目所有服务将删除,且不可恢复</div>
                </div>


        </div>

        <div style="clear: both; padding-bottom: 20px; position:absolute;bottom:10px;right:30px;">
            <button type="button" class="btn  btn-default"  onclick="closeModifyMenu()" style="width:92px;">取消</button>
            <button type="button" class="btn btn-primary" style="margin-left:14px;width:92px;font-size:12px;" id="saveMenu" onclick="saveMenu(this)">保存</button>
        </div>
    </div>
</div>
<div class="window-mask" style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:9;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>
<div class="priceDetailWin"  style="    padding-top: 5px;
    top: 40%;
    left: 50%;
    margin-left: -355px;
    margin-top: -195px;
    position: absolute;
    width: 711px;
    height: 391px;">
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" onclick="closePrice()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <div style=" background: url('/resources/images/servicetip.png');
    width: 711px;
    height: 311px;">

        </div>
        <div class="form-group" >
            <div class="col-sm-6 " style="
    padding: 0;
    margin-bottom: 10px;

">
                <span id="colDiv1tip"  style="cursor:pointer;color:orange;font-size:12px;line-height:35px;">在哪给客户设置价格分类<i style="vertical-align: middle;font-size: 14px;" class="iconfont_new partner_tips_2"></i>
    </span>

            </div>
            <div class="col-sm-6 " style="
    padding: 0;
    margin-bottom: 10px;

">
                <span id="colDiv2tip"  style="cursor:pointer;color:orange;font-size:12px;line-height:35px;">开单时怎么选用<i style="vertical-align: middle;font-size: 14px;" class="iconfont_new partner_tips_2"></i>
    </span>

            </div>

        </div>
        <div class="colDiv1" style="     z-index: 99;
    box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
    background: url(/resources/images/priceway.png);
    position: absolute;
    left: 0;
    display: none;
    bottom: -240px;
    width: 400px;
    height: 280px;"></div>
        <div class="colDiv2" style="    z-index: 99;
    box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
    background: url(/resources/images/useFunction.png);
    position: absolute;
    right: 0;
    bottom: -270px;
    display: none;
    width: 575px;
    height: 310px;"></div>
    </div>
</div>
<div class="priceDetailSet"  style="    padding-top: 5px;
    top: 30%;
    left: 37%;
    right:37%;
    position: absolute;
    width: 440px;
    height: 320px;">
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" onclick="closePrice()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <div  style="     background: url(/resources/images/pricewaynew.png) no-repeat center;
    margin-top: 52px;
    height: 200px;"></div>
        </div>
    </div>
</div>

<div data-options="region:'north'" style="overflow: hidden;height:62px;    border: none !important;"><h4 class="all-text" style="text-indent: 0;margin:10px 10px 10px 10px;border-bottom:none;background:#fdfafa;height:40px;line-height:40px;">
    <div style="position: relative;bottom: 0;display: inline;margin: 16px;">
        <span style="font-size: 12px;color:#767676;">不同服务可以根据 <span style="color:#5cb85c;font-weight: 700">伙伴价格级别（优惠价、标准价、零售价）</span> 填写不同报价；创建销售单时能直接选用预设好的服务与报价啦</span>


        <div id="learnMore" style="display:none;width: 850px;height: 260px;position: absolute;z-index: 999;background-color: #FFF;top: 25px;left: 0px;box-shadow: 1px 3px 3px 0 rgba(0,0,0,.2), 1px 3px 15px 2px rgba(0,0,0,.2);">
            <div class="closeMore" style="" onclick="closeCurDialog('#learnMore')"></div></div>
    </div>

</h4>
    <span id="priceDetailSet" class="pull-right"  style="    cursor: pointer;
    color: #ec7482;
    font-size: 12px;
    border: 1px solid #ec7482;
    margin-right: 10px;
    padding: 3px 20px;
        position: absolute;
    right: 191px;
    top: 15px;
    border-radius: 2px;">如何给客户设价格  <i class="iconfont_new" style="font-size:6px;font-weight:900;">&#xe68b;</i>
    </span>&nbsp;<span id="priceDetail"  style="    cursor: pointer;
    color: #ec7482;
    font-size: 12px;
    border: 1px solid #ec7482;
    margin-right: 10px;
    position: absolute;
    right: 16px;
    top: 15px;
    padding: 3px 20px;
    border-radius: 2px;">为何要设置服务定价 <i class="iconfont_new" style="font-size:6px;font-weight:900;">&#xe68b;</i>
    </span>
</div>
<%--<div data-options="region:'west'" style="width:189px;">--%>
<div style="    width: 189px;position: absolute;left: 0;top: 60px;height: 100%;z-index: 1;border-right: 1px solid #eaeaea;">
    <div  class="west westl" style="position: absolute;left: 0;">
        <h1 class="westH1Left">类目</h1>
        <ul id="leftMenu">
        </ul>
        <div class="addMenu">添加类目</div>
    </div>
    <%--<div  class="west westr" style="position: absolute;right: 0;"><h1 class="westH1Right">二级类目</h1>--%>

        <%--<ul id="rightMenu">--%>
        <%--</ul>--%>
        <%--<div class="addMenu">点击添加</div>--%>
    <%--</div>--%>



</div>
<div data-options="region:'center'" style="overflow: hidden;padding:5px 5px 15px 194px;">
    <div id="tbOrder"  style="    padding:0 10px 10px 10px;
    ">
        <form role="form">
            <div class="row " style="margin:0;">

                <div class="col-xs-2" style="padding-left:1px;">
                    <div class="input-group">
                        <input type="text" class="form-control"

                               onkeypress="if(event.keyCode == 13) {reload('');return false;}"
                               id="searchKey" placeholder="查找当前类目服务定价" style="      width: 282px;
    border-radius: 30px;
    color: #b3b3b3;
    font-size: 12px;
    padding-right: 30px;">
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
          <button type="button" class="btn btn-primary pull-right modifyOrder " style="font-size: 12px;margin-left:15px;height:30px;line-height:1;" onclick="formatAdd();">添加服务内容</button>


            </div>
        </form>
    </div>
    <table id="order"  style="width: 100%;margin-top:50px;" class="easyui-datagrid " toolbar="#tbOrder"
           data-options="remoteSort:false,
fitColumns : true,rownumberWidth:80,fit:true,
           nowrap:true,rownumbers:true,singleSelect:true
     ">
        <thead>
        <tr>

            <th data-options="field:'categoryDesc',width:200,align:'left',formatter: function(value, row) {
    return formatCategoryDesc(row);
    }">物料制作说明</th>
            <th data-options="field:'price1',width:100,formatter: function(value, row) {
            return accounting.formatNumber(value,2);
        }"><span class="youhui">优惠价</span></th>
            <th data-options="field:'price2',width:100,formatter: function(value, row) {
            return accounting.formatNumber(value,2);
        }"><span class="youhui">标准价</span></th>
            <th data-options="field:'price3',width:100,formatter: function(value, row) {
            return accounting.formatNumber(value,2);
        }"><span class="youhui">零散价</span></th>

            <th data-options="field:'priceWay',formatter:priceWayAllFormatter,width:100,editor:{type:'combobox',options:{
                                valueField:'priceWay',
                                textField:'priceWayDesc',
                                data:priceWayAll,
                                required:true
                            }}">计价方式</th>
            <th data-options="field:'priceUnit',width:100,formatter:priceUnitAllFormatter,width:100,editor:{type:'combobox',options:{
                                valueField:'priceUnit',
                                textField:'priceUnitDesc',
                                data:priceUnitAll,
                                required:true
                            }}">计价单位</th>
      <th data-options="field:'isChecked',width:100,align:'center',formatter: function(value, row) {
    return formatOnOff(row);
    }">服务启用开关</th>
            <th data-options="field:'cz',width:80,align:'center',formatter: function(value, row) {
    return formatCaozuo(row);
    }">操作</th>
        </tr>
        </thead>
    </table>

</div>

</body>
</html>