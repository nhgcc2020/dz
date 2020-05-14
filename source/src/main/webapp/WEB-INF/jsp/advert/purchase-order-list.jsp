<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>采购订单</title>
    <meta name="renderer" content="webkit">
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
    <style>
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
            height:40px;
            line-height: 40px;
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
            /*padding:9px 2%;*/
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
            text-align: center !important;
        }
        .tips_contants{position:fixed;top:50%;left:50%;z-index:99999;display:none;margin-top:-150px;margin-left:-150px;width:300px;height:80px;border-radius:5px;background:rgba(0,0,0,.8);color:#fff;text-align:center;line-height:80px}

        .pagination{
            display: none;
        }
        /*    .datagrid-header td,.datagrid-body td{
                padding:5px;
            }*/

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
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
    <script src="/resources/easyui/jquery.easyui.min.js?v=0e0e0cc31b"></script>
    <script src="/resources/easyui/locale/easyui-lang-zh_CN.js?v=af8a82977a"></script>
    <script src="/resources/bootstrap/js/bootstrap.min.js?v=9e25e8e29e"></script>
    <script src="/resources/bootstrap/bootstrap-datetimepicker.js?v=ca317bd7f1"></script>
    <script src="/resources/business/base_new.js?v=9ac481258d"></script>
    <script src="/resources/pageConfig.js?v=d1935279f7"></script>
    <script src="/resources/business/dzorder/purchase-order/purchase-order.js?v=563679c96b"></script>
</head>
<body class="easyui-layout" style="border:none !important;" >
<div  id="msgwindow"   style="border:none;" ></div>
<%--遮罩--%>
<div class="window-mask" style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:999;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>

<div  data-options="region:'north'" style="border:none !important;padding:10px;margin-right: 10px;overflow: hidden;" >
<div c-widget="ButtonGroup;">
    <div class="btn-group" id="btnGrpOp">
        <button type="button" data-s="04" onclick="cgx(this,'4');" class="order4 btn btn-default smcolor">待对账订单</button>
        <button type="button" data-s="05" onclick="cgx(this,'5');" class="order5 btn btn-default ">已对账订单</button>
        <button type="button" data-s="CC" onclick="cgx(this,'6');" class="order6 btn btn-default ">已作废订单</button>
        <button type="button" data-s="" onclick="cgx(this,'');" class="order btn btn-default ">全部订单</button>
    </div>

    <div class="h10"></div>
    <form role="form">
        <div class="row" style="margin:0;">
            <div class="col-xs-2" style="width:150px;padding:0 5px 0 0">
                <select class="form-control input-xs" id="customerDat">
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
                            <input type="text"  class="form-control" id="datetimepickers" data-format="yyyy-MM-dd" placeholder="">
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
                            <input type="text"  class="form-control" id="datetimepickere"  data-format="yyyy-MM-dd"  placeholder=""  >
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
            <button type="button" class="btn btn-primary pull-right modifyOrder hide" style="margin-left:15px;height:30px;line-height:1;" onclick="modifyOrder()">修改</button>
            <button type="button" id="" class="btn btn-primary pull-right generatorBill hide" style="height:30px;line-height:1;" onclick="openTaxPoint()">生成对账单</button>
        </div>
    </form>
</div>
</div>
<div  data-options="region:'center'" style="border:none !important;padding:10px;width: 100%;" >
    <table id="order"  style="width: 100%;" class="easyui-datagrid order"
           data-options="remoteSort:false,
           nowrap:true,singleSelect:false,checkOnSelect:false,fit:true">
    </table>
</div>

    <div style="font-weight: bolder;position: fixed;bottom:10px;left:30px; line-height: 50px; overflow: hidden;">
        <span class="total_all">本页合计:</span>
        行小计金额(元)：
        <span style="color: red;margin-right: 15px;" id="order2PagerPrice" >0.00</span>
        订单数(笔)：
        <span style="color: red;margin-right: 15px;" id="order2PagerNum" >0</span>
    </div>
<div id="topBarPR" class="topbarPrCss" style="height: 700px;width:100%;" >
    <%--这个是加载框，切勿修改--%>
    <article style="    text-align: left;
    font-size: 1.6rem;
    padding: 1.2rem;
    margin: 1.2rem;">
        <div class="col-xs-6" style="top:-15px;">
            <button type="button" class="btn "  onclick="closeProReq()" style="background: #DEE1E2;">返回</button>
        </div>
    </article>

    <div class="" style="width: 100%;
    height: 600px;clear: both;
    padding: 0 13px;">
        <table id="orderPg"  style="width:100%;margin-top:50px;    height: 600px;" class="easyui-datagrid "
               data-options="remoteSort:false,
           nowrap:true,singleSelect:true,checkOnSelect:false">
        </table>
    </div>
</div>
<div id="taxPointWin"  style="padding-top:5px;top:50%;left:50%;margin-left:-330px; margin-top:-286px;position:absolute; width: 660px;height:568px;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 22px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;">
        生成对账单</p>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" onclick="closeTaxPoint()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <p style="  width: 500px;margin: 20px auto;font-size: 12px;position: relative;text-align: center;color: #999; background: #f5f5f5;line-height: 30px;height: 30px;">通过对账单和供应商做确认，确认无误后再付款</p>
        <span class="customerjc" style="position:relative;text-align:center;margin: 0 auto;font-size:22px;font-weight:normal;color:#44ae80;height: 30px;line-height: 30px;" data-title="供应商简称" id="partnerShortname"></span>
        <div style="    width: 360px;margin: 20px auto 25px;height: 30px;line-height: 30px;position: relative;text-align: right;">
            <span style="color: #666;font-size: 14px;font-weight: 700;float: left;"> 订单总数(笔)：<em style="font-family:Arial;font-weight: 100;    font-style: normal; font-size: 22px;"  id="numIndex"></em></span>
            <span style=" color: #666;font-size: 14px;font-weight: 700;" >订单总金额：<em style="font-family: Arial;font-style: normal      ;font-weight: 100; font-size: 22px;" id="totalPrice"></em></span>
            <i style="color: #2e8ae6;font-size: 12px;margin-left: 10px;position: absolute;right: -70px;font-style: normal;cursor: pointer;" onclick="addShuiDian()" id="shuidainBtn">添加税点</i>
        </div>
        <input type="hidden" name="depositRequestedHid" id="depositRequestedHid">
        <input type="hidden" name="totalPriceHid" id="totalPriceHid">
        <input type="hidden" name="receivePriceHid" id="receivePriceHid">
        <%--<input type="hidden" name="taxPriceHid" id="taxPriceHid">--%>
        <%--<input type="hidden" name="totalPriceWithTaxHid" id="totalPriceWithTaxHid">--%>
        <div id="shuiDianCtrl" style="display:none;clear:both;border:1px solid #ccc;width:400px;padding:20px 20px 0 20px;margin:0 auto;">
            <p style="width:360px;margin:0 auto ;height:35px;
            clear:both;"><span style="float:left;color:#666;font-size:14px;">税率：</span><span style="float:right;color:#666;font-size:26px;">
                    <input type="text" style="font-size:14px;border:1px solid #ccc;text-indent: 10px;border-radius:2px;width:60px;height:25px;vertical-align:middle"
                           onkeyup="inputCalMoney(this)"
                           maxlength="2" id="taxRateView"
                           id="rateNum"  value="0"><i style="font-family: Arial;font-style:normal;margin-left:5px;font-size: 16px;">%</i></span></p>
            <p style="width:360px;margin:0 auto ;height:35px;
            clear:both;"><span style="float:left;color:#666;font-size:14px;">税额：</span>
                <span   style=";float:right;color:#666;font-size:16px;" id="taxPrice"></span></p>
            <p style="width:360px;margin:0 auto ;height:35px;
            clear:both;"><span style="float:left;color:#666;font-size:14px;">对账总金额（含税）：
        </span><span  style="font-family: Arial;font-style:normal;float:right;color:#666;font-size:16px;" id="totalPriceWithTax"></span></p>
        </div>
        <div style="margin:-1px auto;width:400px;border-top:1px solid #ccc"></div>
        <div style="      width: 400px; margin: 0 auto; padding: 30px 20px 0; position: relative;">
            <p style="text-align: right;  height: 30px;  color: #666;font-size: 14px;font-weight: 700;" ><span style="float:left;">预付总金额：</span><em style="font-family: Arial;font-style:normal;font-size: 22px;font-weight: 100">-</em>
                <em style="font-family: Arial;font-style:normal;font-size: 22px;font-weight: 100" id="depositRequested"></em></p>
            <p style="text-align: right; height: 30px;   margin-top:15px; color: #666;font-size: 14px;font-weight: 700;" >
                <span style="float:left;">应付总金额：</span><em style="font-weight:100;font-family: Arial; font-style:normal;font-size: 22px;color:#ff0000;" id="receivePrice"></em></p>
        </div>

        <div style="clear: both;margin: 20px 0 20px 280px; padding-bottom: 20px; position:absolute;bottom:10px;right:80px;">
            <button type="button" class="btn  btn-default"  onclick="closeTaxPoint()" style="width:100px;">取消</button>
            <button type="button" class="btn btn-primary" style="margin-left:15px;width:100px;font-size:12px;" onclick="batchGenerateBill(this)">生成对账单</button>
        </div>
    </div>
</div>

<script>
    function modifyOrderIframe(pno) {
                var App = window.parent.App;
                var config = {
                    path: "/ydz/purchaseorder/updatePage?purchaseNo=" +pno
                };
                App.open(config.path, config);
    }
</script>
</body>
</html>
