<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title></title>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" type="text/css" href="/resources/common/common.css?v=3e10f9c6f9">
    <link rel="stylesheet" type="text/css" href="/resources/common/custom-widget.css?v=317bd77da5">
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=1c43353511">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=ca049c7ec2">

    <style>
        .categoryDescEdit {
            position: relative;
            overflow: hidden;
            margin-right: 15px;
            cursor: pointer
        }

        .categoryDescEdit > span {
            position: absolute;
            top: 1px;
            right: 1px;
            display: none;
            cursor: pointer
        }

        .categoryDescEdit:hover > span {
            display: block
        }

        .ui.widget-table table tbody td > div {
            overflow: hidden;
            padding: .2em .4em
        }

        .ui.input input {
            padding: .5em .3em;
            text-align: left
        }

        .ui.widget-table table thead th {
            background: #fff
        }

        .ui.widget-table > .fixed-footer, .ui.widget-table > .fixed-header {
            z-index: 99
        }

        .closeMore {
            position: absolute;
            top: 0;
            right: 0;
            width: 20px;
            height: 20px;
            text-indent: 0;
            cursor: pointer
        }

        .closeMore:after, .closeMore:before {
            position: absolute;
            top: 50%;
            width: 20px;
            height: 1px;
            background-color: #888;
            content: '';
            -webkit-transform: rotate(45deg);
            transform: rotate(45deg)
        }

        .closeMore:after {
            -webkit-transform: rotate(-45deg);
            transform: rotate(-45deg)
        }

        #learnMore .closeMore:hover {
            -webkit-transform: rotate(90deg)
        }

        .partner_tips_2:before {
            position: relative
        }

        .checkbox, .radio {
            margin: 0
        }

        .items tr td:nth-child(2) input {
            text-align: left
        }

        .items tr td:nth-child(3) input, .items tr td:nth-child(4) input {
            border: none
        }

        .items tr:nth-child(even) td:nth-child(3) input, .items tr:nth-child(even) td:nth-child(4) input {
            background: #f5f7fa
        }

        .ui.list-view .items {
            height: 260px
        }

        .ui.list-view .list.item:hover {
            background: #4284d9;
            color: #fff
        }

        .btn {
            font-size: 9pt
        }

        .btn-default {
            color: #999
        }

        .ui.items-view table tbody tr:nth-child(even) {
            background: 0 0 !important
        }

        .ui.items-view .item {
            cursor: default
        }

        #order .table-wrapper > table thead th:nth-child(1), #order .table-wrapper > table thead th:nth-child(2), #order .table-wrapper > table thead th:nth-child(11), #order .table-wrapper > table thead th:nth-child(12) {
            font-weight: 700
        }

        .pagination table {
            float: right;
            height: 50px;
            line-height: 50px
        }

        .pagination {
            border-radius: 0
        }

        .datagrid .datagrid-pager {
            border-color: #2e8ae6;
            border-top-width: 2px
        }

        .datagrid-header td.datagrid-header-over, .datagrid-row-over {
            background: none;
            color: #000;
            cursor: default
        }

        .datagrid-header, .datagrid-td-rownumber {
            background: #eff1f3
        }

        .datagrid-header {
            border-width: 0
        }

        .datagrid-header .datagrid-cell span {
            font-size: 12px
        }

        .btn-primary, .btn-primary.active, .btn-primary:active, .btn-primary:focus, .btn-primary:hover, .open .dropdown-toggle.btn-primary {
            border-color: #2e8ae6;
            background-color: #2e8ae6
        }

        .datagrid-row-selected {
            background: #d6e8f3;
            color: #000
        }

        .datagrid .panel-body, .window .window-body {
            border: none !important
        }

        .window .window-body {
            padding: 50px 10px 0;
            border-width: 0 !important;
            border-radius: 0;
            background: #fff
        }

        .datagrid-header, .datagrid-header-row, .datagrid-row {
            height: 40px
        }

        .window-shadow {
            background: 0 0
        }

        table, td, th {
            vertical-align: middle
        }

        #msgwindow {
            position: absolute;
            left: 100%;
            z-index: 9999;
            padding: 2%;
            width: 84%;
            height: 100%;
            border: none;
            background: #fff;
            box-shadow: 0 0 7px #999;
            -webkit-transition: all .2s 0s linear;
            transition: all .2s 0s linear
        }

        #taxPointWin {
            width: 700px
        }

        #modifyMenuWin, #taxPointWin, .priceDetailWin {
            position: absolute;
            z-index: 99;
            display: none;
            min-height: 290px;
            border: none;
            background: #fff;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, .2);
            -webkit-transition: all .2s 0s linear;
            transition: all .2s 0s linear
        }

        .h10 {
            clear: both;
            height: 10px
        }

        select option {
            margin: 5px auto;
            height: 30px;
            line-height: 30px
        }

        .btn.smcolor {
            border-color: #2e8ae6;
            background-color: #2e8ae6;
            color: #fff
        }

        .tips_contants {
            position: fixed;
            top: 50%;
            left: 50%;
            z-index: 99999;
            display: none;
            margin-top: -150px;
            margin-left: -150px;
            width: 300px;
            height: 5pc;
            border-radius: 5px;
            background: rgba(0, 0, 0, .8);
            color: #fff;
            text-align: center;
            line-height: 5pc
        }

        .pagination {
            display: none
        }

        .select2-results__options li {
            position: relative
        }

        .datagrid-body .datagrid-cell {
            padding: 0 10px
        }

        .datagrid-htable .datagrid-cell {
            padding-left: 10px
        }

        .datagrid-header .datagrid-cell span {
            color: #666
        }

        .form-control {
            display: block;
            padding: 6px 10px 6px 9pt;
            width: 100%;
            height: 30px;
            background-color: #fff;
            color: #555;
            vertical-align: middle;
            line-height: 1.428571429
        }

        .form-control, .input-group-addon {
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 12px
        }

        .input-group-addon {
            padding: 5px 9pt;
            background-color: transparent !important;
            text-align: center;
            font-weight: 400;
            line-height: 1
        }

        .panel {
            box-shadow: 0 0 0
        }
    </style>
    <style>
        #modifyYdzMenuWin {
            z-index: 12;
        }

        #autoEditOnceWin {
            z-index: 11;
        }

        #deleteYdzWin {
            z-index: 13;
        }

        #versionControlWin {
            z-index: 14;
        }

        #autoEditOnceWin, #modifyYdzMenuWin, #deleteYdzWin, #versionControlWin {
            border: none;
            width: 700px;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
            background: #fff;
            transition: all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
            display: none;
        }

        .ydz_select {
            display: inline-block;
            font-size: 0;
            position: relative;
            vertical-align: middle;
            white-space: nowrap;
        }

        .ydz_select_txt {
            background: none repeat scroll 0 0 #FFF;
            border: 1px solid #f2f2f2;
            cursor: pointer;
            display: inline-block;
            font-size: 12px;
            line-height: 34px !important;
            height: 34px !important;
            overflow: hidden;
            text-align: left;
            border-radius: 3px;
            padding: 0 5px 0 10px;
            text-overflow: ellipsis;
            vertical-align: top;
            white-space: nowrap;
            width: 170px;
        }

        .ydz_select2 {
            cursor: default !important;
            background-color: #fff !important;
        }

        .ydz_select2 ~ .ydz_select_a {
            width: 0;
            height: 0;
            border-left: 4px solid transparent;
            border-right: 4px solid transparent;
            border-top: 5px solid #786f6f;
            position: absolute;
            right: 21px;
            top: 50%;
        }

        .ydz_select_menu {
            background: none repeat scroll 0 0 #FFF;
            /*border: 1px solid #f2f2f2;*/
            border-top: none;
            border-radius: 2px;
            padding: 4px 0;
            display: none;
            border: 1px solid #e0dfdf;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.175);
            overflow-x: hidden;
            overflow-y: auto;

            position: absolute;
            width: 170px;
            z-index: 1000;
        }

        .ydz_select_menu li {
            line-height: 21px;
            padding-bottom: 0 !important
        }

        .ydz_select_menu_ul2 li {
            letter-spacing: 2px;
            position: relative;
            cursor: pointer;
            padding-right: 55px;
            padding-left: 10px;
            /*border-bottom: 1px solid #eaeaea;*/
            overflow: hidden;
            color: #333;
            line-height: 27px;
            -ms-text-overflow: ellipsis;
            white-space: nowrap;
            text-overflow: ellipsis;
            font-size: 14px;
        }

        .open .ydz_select_menu {
            display: block
        }

        .ydz_select_menu_ul {
            max-height: 140px;
            overflow: auto;
        }

        .ydz_select_menu_ul2 {
            height: 265px;
            overflow: auto;
        }

        .autoEdit {
            text-align: center;
            height: 30px;
            clear: both;
            border-top: 1px solid #ccc;
            cursor: pointer;
            line-height: 30px;
        }

        .open .ydz_select_a {
            border-bottom: 5px solid #786f6f;
            border-top: transparent;
        }

        .ydz_select_menu li a {
            clear: both;
            text-align: left;
            color: #323232;
            display: block;
            font-size: 12px;
            line-height: 21px;
            padding: 3px 5px;
            white-space: nowrap
        }

        .requireYdzMenu {
            color: #da4654;
        }

        .ydz_select_menu_ul2 li a {
            clear: both;
            text-align: left;
            color: #323232;
            display: block;
            font-size: 12px;
            line-height: 27px;
            white-space: nowrap
        }

        .ydz_select_menu li a:hover {
            background: none repeat scroll 0 0 #5897fb;
            color: #FFF;
            text-decoration: none
        }

        .ydz_select_menu_ul2 li:hover {
            background: none repeat scroll 0 0 #eff1f3;
            color: #333;
            text-decoration: none
        }

        .ydz_select_menu_ul2 > li > span {
            color: #8cb5e5;
            font-size: 12px;
            position: absolute;
            right: 3px;
            top: 0;
            visibility: hidden;
        }

        .ydz_select_menu_ul2 > li.active {
            background: #eff1f3;
        }

        .ydz_select_menu_ul2 > li:hover > span {
            visibility: visible;
            cursor: pointer;
        }


        .main .fixheader {
            background: #fff;
            height: 55px;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
            border-bottom: 1px solid #dddddd;
            padding: 8px 20px 0 20px;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 10;
            overflow: hidden;
        }

        .main {
            height: 100%;
        }

        .main {
            /*margin-top: 70px;*/
        }
        .form-horizontal .control-label, .form-horizontal .radio, .form-horizontal .checkbox, .form-horizontal .radio-inline, .form-horizontal .checkbox-inline{
            padding-top:0;
        }
        .control-label-mark:before{
            content: '*';
            color:red;
            margin-right:5px;
            font-size:12px;
        }

    </style>
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=ea11ea1d51"></script>
    <script src="/resources/easyui/pace.min.js?v=fe5e2eaca6"></script>
    <script src="/resources/pageConfig.js?v=c1c50d6d4f"></script>
    <script src="/resources/bootstrap/js/bootstrap.min.js?v=6d91d60c6b"></script>
    <script src="/resources/business/base_new.js?v=1191ae2bcdf"></script>
    <script src="/resources/easyui/validate.min.js"></script>
</head>

<body class="modal-page" style="padding:0!important;">
<div
        style="    padding: 70px 50px 0 0;" class="main"
>




    <div class="fixheader">
        <button type="button" onclick="saveAll(this)" class="btn btn-primary copyMain " style="width:90px;margin:4px 8px 10px 0px">保存
        </button>
        <button type="button"  onclick="backPage()" class="btn  cancelOpp"
                style="font-size:14px;height:30px;margin:5px 8px 10px 20px;background:#fff;color:#7e92ab;padding:0;">
            <i class="iconfont_new " style="font-size:26px;position:relative;top:4px;"></i>取消
        </button>
    </div>


    <div class="row" style="margin-bottom: 20px;margin-left: 25px;line-height: 30px;width: 580px;">
        <h1 class="" style="    color: #4284d6;
    font-size: 16px;
    margin-bottom: 40px;
    /*margin-left: -25px;*/
    margin-top: 20px;
    font-weight: 700;">新建媒体</h1>


        <form class="form-horizontal" role="form" id="projectForm" style="margin-left: 60px;">
            <div class="form-group">
                <label style="padding-right:0;width:90px;" class="col-xs-2 control-label control-label-mark">媒体名称 :</label>
                <div class="col-xs-10 ">
                    <input  name="mediaDesc" id="mediaDesc" class="form-control" style="" type="text"
                            placeholder="请填写">
                </div>
            </div>
            <div class="form-group">
                <label style="padding-right:0;width:90px;" class="col-xs-2 control-label control-label-mark">媒体类型 :</label>
                <div class="col-xs-10" style="">
                    <input name="mediaType" value="" type="hidden" >
                    <input type="text" style="" did="1" class="form-control ydz_select2" readonly name="mediaTypeDesc"
                           placeholder="请选择"/><span class="ydz_select_a"></span>
                </div>
            </div>
            <div class="form-group">
                <label style="padding-right:0;width:90px;" class="col-xs-2 control-label control-label-mark">表现形式 :</label>
                <div class="col-xs-10 ">
                    <input name="showType" value="" type="hidden" >
                    <input type="text" style="" did="2" class="form-control ydz_select2" readonly name="showTypeDesc"
                           placeholder="请选择"/><span class="ydz_select_a"></span>
                </div>
            </div>
            <div class="form-group">
                <label style="padding-right:0;width:90px;" class="col-xs-2 control-label">备注 :</label>
                <div class="col-xs-10 ">
                    <textarea name="remarks" id="remarks" rows="4" id="" class="form-control" style="" type="text"
                              placeholder="请填写"></textarea>
                </div>
            </div>
            <div style="display: none;"><input type="submit" id="subMain">提交</div>
        </form>


    </div>


</div>
<div class="window-mask"
     style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:1;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>
<div id="datagrid-mask-msg" class="frame_box datagrid-mask-msg" style="display:block;left:50%"><span></span></div>

<div id="autoEditOnceWin"
     style="    padding-top: 5px;
    top: 50%;
    left: 50%;
    position: fixed;
    margin-top:-175px;
    margin-left:-150px;
    width: 300px;
    height: 350px;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 18px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;"
       id="fuwuTitle">
        编辑自定义分类 </p>

    <span class="autoEditWinClose"
          style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"><img
            src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">

        <ul class="ydz_select_menu_ul2">

            <li><a rel="现金" href="javascript:;">现金</a><span csid="d">删除</span><span csid="m"
                                                                                    style="right: 36px;">修改</span></li>
            <li><a rel="现金" href="javascript:;">现金</a><span>删除</span><span style="right: 36px;">修改</span></li>
            <li><a rel="现金" href="javascript:;">现金</a><span>删除</span><span style="right: 36px;">修改</span></li>

        </ul>
        <div class="autoEdit autoEditTwice">添加自定义分类</div>

    </div>
</div>
<div id="modifyYdzMenuWin"
     style="      padding-top: 5px;
    top: 50%;
    left: 50%;
    position: fixed;
        margin-top:-176px;
    margin-left:-150px;
    width: 300px;
    height: 250px;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 18px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;"
       id="menuTitle">修改自定义分类</p>
    <span class="autoEditWinClose2"
          style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"><img
            src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <div style="    margin-top: 50px;line-height: 30px;position: relative;text-align: right;">
            <div class="form-group">
                <label style="    padding-right: 0;
    text-align: left;" class="col-sm-4 control-label">自定义分类:</label>
                <div class="col-sm-7 " style="
    padding: 0;
    margin-bottom: 10px;
    text-align: right;">
                    <input type="text" class="form-control" maxlength="40" id="menu1" placeholder="请输入分类名称"/>
                </div>
            </div>
            <div style="clear: both;" class="col-sm-12 hide requireYdzMenu">类型不能为空</div>
        </div>
        <div style="clear: both; padding-bottom: 20px; position:absolute;bottom:10px;right:30px;">
            <button type="button" class="btn  btn-default autoEditWinClose2" style="width:92px;">取消</button>
            <button type="button" class="btn btn-primary" style="margin-left:14px;width:92px;font-size:12px;"
                    id="saveYdzMenu">保存
            </button>
        </div>
    </div>
</div>
<div id="deleteYdzWin"
     style="    padding-top: 5px;
    top: 50%;
    left: 50%;
    position: fixed;
         margin-top:-176px;
    margin-left:-150px;
    width: 300px;
    height: 206px;">
    <p style="    position: relative;
    font-weight: 100;
    text-align: left;
    font-size: 18px;
    margin: 0px auto;
    padding: 5px 20px;
    border-bottom: 1px solid #ccc;">
        删除自定义分类</p>
    <span class="closetranform" style="    position: absolute;
    top: 20px;
    right: 1px;
    display: block;
    height: 30px;
    width: 30px;
    cursor: pointer;"><i
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
            <button type="button" class="btn  btn-default closetranform" style="width:92px;">取消</button>
            <button type="button" class="btn btn-primary" style="margin-left:12px;width:92px;font-size:12px;"
                    id="deleteYdzMenu">确认
            </button>
        </div>
    </div>
</div>
<div class="ydz_select_menu">
    <ul class="ydz_select_menu_ul recpayAccountList">
    </ul>
    <div class="autoEdit autoEditOnce">编辑自定义分类</div>
</div>

<script>

    (function(window,$,undefined){

        var objSelMenu;// 临时保存页面共享下拉框的对象
        var kehuselDat=[],kehuselDat2=[],objSelType,kehuUrl,addUrl,updateUrl,delUrl,queryParamsUpdate={},queryParamsSel={};
        var kehuselUrl="/ydz/common/listComSettingClass?settingClass=MEDIA_TYPE";//媒体
        var kehuselUrl2="/ydz/common/listComSettingClass?settingClass=MEDIA_SHOW";//表现形式
        var kehuAddUrl="/ydz/common/insertComSettingClass";//媒体
        var kehuAddUrl2="/ydz/common/insertComSettingClass";//表现形式
        var kehuDelUrl="/ydz/common/deleteComSettingClass?settingClass=MEDIA_TYPE&typeCode=";//媒体
        var kehuDelUrl2="/ydz/common/deleteComSettingClass?settingClass=MEDIA_SHOW&typeCode=";//表现形式
        var kehuUpateUrl="/ydz/common/updateComSettingClass";//媒体
        var kehuUpateUrl2="/ydz/common/updateComSettingClass";//表现形式
        var  reloadUrl= "/ydz/purchaseorder/listPagePurchaseOrder";//列表数据
        var mediaNo = '${mediaNo}';// 商机号
        window.backPage=function () {
            var turl = "/openPage?pageName=media_media-resource-list";
            window.location.href = turl;
        }
        window.saveAll=function (o) {
            var urlNew=null,type=null;
            if(mediaNo=="" || mediaNo==null){
                urlNew="/ydz/mediaresource/insertMediaResource";
                type="post";
            }else{
                urlNew="/ydz/mediaresource/updateMediaResource";
                type="put";
            }
            var $that=$(o);
            var param={
                "mediaDesc":$('input[name="mediaDesc"]').val(), //媒体名称
                "mediaType": $('input[name="mediaType"]').val(), //媒体类型编码
                "mediaTypeDesc": $('input[name="mediaTypeDesc"]').val(), //媒体类型名称
                "remarks": $('textarea[name="remarks"]').val(), //备注
                "showType": $('input[name="showType"]').val(), //表现形式编码
                "mediaNo": mediaNo, //媒体资源编码
                "showTypeDesc": $('input[name="showTypeDesc"]').val() //表现形式名称
            };
            $that.attr("disabled", true);
            $.ajax({
                url:urlNew ,
                type:type,
                contentType: 'application/json',
                data: JSON.stringify(param),
                dataType: "json",
                success: function (dt) {
                    $.mytoast({text: dt.msg, time: 1000});
                    $that.attr("disabled", false);
                    setTimeout(function () {
                            window.location.href = "/openPage?pageName=media_media-resource-list";
                    }, 1000);
                },error:function () {
                    $that.attr("disabled", false);
                }
            })
        }
        function selectOptOppFun() {
            $(".ydz_select2").off("click").on("click", function (e) {
//              页面有几个可编辑下拉框,就有几个分支，数据不一致
                if($(this).attr("did")=="1"){
                    oppProjectFun(kehuselDat);
                    kehuUrl=kehuselUrl;
                    objSelType="1";
                    addUrl=kehuAddUrl,delUrl=kehuDelUrl,updateUrl=kehuUpateUrl;
                    queryParamsSel.settingClass="MEDIA_TYPE";  //自定义的类型参数 可修改
                    queryParamsUpdate.settingClass="MEDIA_TYPE";//自定义的类型参数 可修改
                }  else if($(this).attr("did")=="2"){
                    queryParamsSel.settingClass="MEDIA_SHOW";//自定义的类型参数 可修改
                    queryParamsUpdate.settingClass="MEDIA_SHOW";//自定义的类型参数 可修改
                    oppProjectFun(kehuselDat2);
                    kehuUrl=kehuselUrl2;
                    objSelType="2";
                    addUrl=kehuAddUrl2,delUrl=kehuDelUrl2,updateUrl=kehuUpateUrl2;
                }
                e.stopPropagation();
                var o = $(this).offset();
                var t = o.top + $(this).outerHeight();
                var l = o.left;
                $(".ydz_select_menu").css({
                    "display": "block",
                    "top": t,
                    "left": l,
                    "width": $(this).outerWidth(),
                    "z-index": 1000
                });
//            if ($(this).hasClass("open")) {
//                $(this).removeClass("open");
//                $(".ydz_select_menu").hide();
//                objSelMenu=null;
//            } else {
                $(".ydz_select_menu").show();
                objSelMenu = $(this);
                $(this).addClass("open");
//            }
            });
        }

        function initselOption(url,type){
            $.ajax({
                url: url,
                dataType: "json",
                success: function (projectTp) {
                    if(type=="1"){
                        kehuselDat=projectTp;
                    }else if(type=="2"){
                        kehuselDat2=projectTp;
                    }
                    oppProjectFun(projectTp);
                },
                error: function () {
                    kehuselDat=[],kehuselDat2=[];
                    oppProjectFun([]);
                }
            });

        }

        function oppProjectFun(data) {
            var returnopt = function (data, type) {
                var opt = "";
                for (var i = 0; i < data.length; i++) {
                    var dt = data[i];
                    var dtn = "";
                    if (type == 4) {
                        opt += '<li><a rel="' + dt.typeCode + '" href="javascript:;">' + dt.typeDesc + '</a></li>';
                    } else if (type == 5) {

                        opt += ' <li><a rel="' + dt.typeCode + '" href="javascript:;">' + dt.typeDesc + '</a><span nid="' + dt.typeDesc + '" cid="' + dt.typeCode + '" nid="' + dt.typeDesc + '" csid="d">删除</span><span cid="' + dt.typeCode + '" nid="' + dt.typeDesc + '" style="right: 36px;">修改</span></li>';
                    }
                }
                return opt;
            }
            $(".recpayAccountList").empty().html(returnopt(data, 4));
            $(".ydz_select_menu_ul2").empty().html(returnopt(data, 5));
        }
        $(function () {
            new FormValidator('projectForm', [{
                name: 'caseDesc',
                display: '请填写媒体名称',
                rules: 'required'
            }], function (errors, evt) {
                if (errors.length > 0) {
                    $.mytoast({text: errors[0].display});
//                    $(".copyMain").attr("disabled", false);
                } else {
                    if (evt && evt.preventDefault) {
                        evt.preventDefault();
                    } else if (event) {
                        event.returnValue = false;
                    }
//                    var urlCz = "";
//                    if (contractNo == null || contractNo == "") {
//                        urlCz = "/ydz/contract/addContract";
//                    } else {
//                        urlCz = "/ydz/contract/updateContract";
//                    }
//                    $.ajax({
//                        url: urlCz,
//                        dataType: "json",
//                        type: "post",
//                        contentType: "application/json",
//                        data: JSON.stringify(readyData()),
//                        success: function (d) {
//                            if (d.code == "1") {
//                                $.mytoast({text: d.msg});
//                                setTimeout(function () {
//                                    window.location.href = "/openPage?pageName=project_project-contract-list";
//                                }, 2000);
//                            }
//                            $(".copyMain").attr("disabled", false);
//                        }, error: function () {
//                            $(".copyMain").attr("disabled", false);
//                        }
//                    });
                }
            })
            selectOptOppFun();
            initselOption(kehuselUrl,1);
            initselOption(kehuselUrl2,2);

            if(mediaNo=="" || mediaNo==null){

            }else{
                $.ajax({
                    url: "/ydz/mediaresource/getMediaResourcesDetais?mediaNo=" + mediaNo ,
                    type: 'GET',
                    dataType: "json",
                    success: function (dt) {

//                            initPageTwoData(dt);
//                            initSelData(dt);

                            $("#mediaDesc").val(dt.mediaDesc);
                            $("input[name='mediaType']").val(dt.mediaType);
                            $("input[name='mediaTypeDesc']").val(dt.mediaTypeDesc);
                            $("input[name='showType']").val(dt.showType);
                            $("input[name='showTypeDesc']").val(dt.showTypeDesc);
                            $("#remarks").val(dt.remarks);
                    }
                });
            }


            $(".ydz_select_menu_ul").on("click", "li", function () {
                if (objSelMenu) {
                    objSelMenu.val($(this).find("a").text());
                }
            })
            $(".autoEditOnce").on("click", function () {
                $("#autoEditOnceWin").show();
                $(".window-mask").show();
//            $("#autoEditOnceWin").draggable({ cursor: "move", containment: "parent"});
            })
            $(".autoEditTwice").on("click", function () {
                $("#menuTitle").text("添加自定义分类");
                $("#menu1").val("");
                $(".requireYdzMenu").hide();
                $("#modifyYdzMenuWin").show();
                $("#saveYdzMenu").unbind("click").bind("click", function () {
                    var $that=$(this);
                    var menu2 = $("#menu1").val();
                    if ($.trim(menu2) == "") {
                        $(".requireYdzMenu").show().removeClass("hide");
                        return;
                    } else {
                        $(".requireYdzMenu").hide().addClass("hide");
                    }
                    queryParamsSel.typeDesc=menu2;
                    $that.attr("disabled", true);
                    $.ajax({
                        url:addUrl ,
                        type: 'post',
                        contentType: 'application/json',
                        data: JSON.stringify(queryParamsSel),
                        dataType: "json",
                        success: function (dt) {
                            $.mytoast({text: dt.msg, time: 1000});
                            $("#menu1").val("");
                            $("#modifyYdzMenuWin").hide();
                            initselOption(kehuUrl,objSelType);
                            $that.attr("disabled", false);
                        },error:function () {
                            $that.attr("disabled", false);
                        }
                    })

                })
            })
            $(".ydz_select_menu_ul2").on("click", "li>span", function (e) {
                var $th = $(this);
                if ($th.attr("csid") == "d") {
                    $("#deleteYdzWin").css({display: 'block'});
                    $("#deleteYdzMenu").attr("cid", $th.attr("cid"));
                    $("#deleteYdzMenu").off().on("click", function () {
                        var $that=$(this);
                        $that.attr("disabled", true);
                        $.ajax({
                            url:  delUrl+ $th.attr("cid"),
                            dataType: "json",
                            type: "delete",
                            success: function (dt) {
                                $.mytoast({text: dt.msg, time: 1000});
                                $("#deleteYdzWin").css({display: 'none'});
                                initselOption(kehuUrl,objSelType);
                                $that.attr("disabled", false);
                            },error:function () {
                                $that.attr("disabled", false);
                            }
                        })
                    })
                } else {
                    $("#menuTitle").text("修改自定义分类");
                    $("#menu1").val($th.attr("nid"));
                    $(".requireYdzMenu").hide();
                    $("#modifyYdzMenuWin").css({display: 'block'});
                    $("#saveYdzMenu").attr("cid", $th.attr("cid"));
                    $("#saveYdzMenu").unbind("click").bind("click", function () {
                        var $that=$(this);
                        $that.attr("disabled", true);
                        var menu2 = $("#menu1").val();
                        if ($.trim(menu2) == "") {
                            $(".requireYdzMenu").show().removeClass("hide");
                            $that.attr("disabled", false);
                            return;
                        } else {
                            $(".requireYdzMenu").hide().addClass("hide");
                        }

                        queryParamsUpdate.typeCode=$th.attr("cid");
                        queryParamsUpdate.typeDesc=menu2;

                        $.ajax({
                            url: updateUrl,
                            type: 'put',
                            contentType: 'application/json',
                            data: JSON.stringify(queryParamsUpdate),
                            dataType: "json",
                            success: function (dt) {
                                $.mytoast({text: dt.msg, time: 1000});
                                $("#menu1").val("");
                                $("#modifyYdzMenuWin").css({display: 'none'});
                                initselOption(kehuUrl,objSelType);
                                $that.attr("disabled", false);
                            },error:function () {
                                $that.attr("disabled", false);
                            }
                        })
                    })
                }
                e.stopPropagation();
            })
            $(".copyMain").click(function () {
                $(".copyMain").attr("disabled", true);
                $("#subMain").click();
            })
            $(".autoEditWinClose").on("click", function () {
                $("#autoEditOnceWin,#modifyYdzMenuWin,#deleteYdzWin").hide();
                $(".window-mask").hide();
            })
            $(".autoEditWinClose2").on("click", function () {
                $("#modifyYdzMenuWin").hide();

            })
            $(".closetranform").on("click", function () {
                $("#deleteYdzWin").hide();
            })
            $(document).bind('click', function () {
                $(".ydz_select2").removeClass("open");
                $(".ydz_select_menu").hide();
            });
            $(".ydz_select_menu").on("click", "li", function () {
                if (objSelMenu) {
                    objSelMenu.val($(this).find("a").text());
                    objSelMenu.prev().val($(this).find("a").attr("rel"));
                }
            })
        })

        var param = getRequestParam.GetRequest();
        var yucunKuan = 0, yucunKuanSubmit = true;

        function openDt(obj) {
            oppColumnFun.openReceivablesWin($(obj).attr("data-id"));
        }

    })(window,jQuery);
</script>


</body>

</html>