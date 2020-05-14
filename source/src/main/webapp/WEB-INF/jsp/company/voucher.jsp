<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>代金卷</title>
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <link rel="stylesheet" type="text/css" href="/../resources/business/order-table.css?v=7367cb39d5">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">
    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
    <script src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
    <script src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
    <script src="/../resources/cola-ui/i18n/zh-CN/cola.js?v=40433415fd"></script>

</head>
<body style="padding:10px">
<div class="loading_box"><span></span></div>
    <div id="tool">
       <%-- <div id="selectStatic" c-widget="icon:dropdown icon iconfont"></div>--%>
           <div class="ui selection dropdown" style="vertical-align: bottom;">
               <input id="status_slt" type="hidden">
               <i class="dropdown icon"></i>
               <div class="default text">全部代金券</div>
               <div class="menu">
                   <div class="item" data-value="">全部代金券</div>
                   <div class="item" data-value="0">未使用</div>
                   <div class="item" data-value="1">已使用</div>
                   <div class="item" data-value="2">已过期</div>
               </div>
           </div>
        <div c-widget="button; class:primary; caption:查询;click:query" style="margin-left: 5px"></div>
        <label style="color: red">每张代金券只能使用一次，未使用部分不返还。</label>
    </div>


    <div class="table_contant">
        <div id="pagingTable"></div>
    </div>

    <div class="page_fix">
        <div id="pagingPager" class="order-Pager"></div>
    </div>

    <script type="text/javascript">
        cola(function(model) {
            model.describe("pageItems", {
                provider: {
                    url: "<c:url value='/payment/listVoucher'/>",
                    pageSize: 15,
                    complete:function(){
                        $(".loading_box").removeClass("loadingssss");
                    }
                }
            });

            model.action({
                query:function(){
                    var status = status_slt.value;
                    $(".loading_box").addClass("loadingssss");
                    model.describe("pageItems", {
                        provider: {
                            url: "<c:url value='/payment/listVoucher'/>",
                            pageSize: 15,
                            parameter:status,
                            complete:function(){
                                $(".loading_box").removeClass("loadingssss");
                            }
                        }
                    });
                    model.flush("pageItems");
                }
            });

            model.widgetConfig({
                startTime:{
                    $type:"DatePicker"
                },

                endTime:{
                    $type:"DatePicker"
                },

                pagingPager: {
                    $type: "Pager",
                    bind: "pageItems"
                },

                //交易记录列表
                pagingTable: {
                    $type: "table",
                    bind: "item in pageItems",
                    showHeader: true,
                    currentPageOnly: true,
                    columns: [/*{
                        bind: ".id",
                        caption: "序号"
                    },*/
                    {
                        bind: ".voucherNo",
                        caption: "编码",
                        align:"center",
                        width:"120px"
                    }, {
                        caption: "名称",
                        bind: ".voucherName",
                        width:"100px"
                    }, {
                        bind: ".voucherDesc",
                        caption: "使用说明",
                        align: "left",
                        width:"500px"
                    }, {
                        bind: ".voucherMoney",
                        caption: "面值(元)",
                        align: "right",
                        width:"100px"
                    }, {
                        bind: ".periodDay",
                        caption: "有效期(天)",
                        align: "center",
                        width:"70px"
                    },{
                        bind: ".startDate",
                        caption: "生效时间",
                        align: "center",
                        width:"70px"
                    }, {
                        bind: ".endDate",
                        caption: "失效时间",
                        align: "center",
                        width:"70px"
                    }, {
                        bind: ".statusValue",
                        caption: "状态",
                        align: "center",
                        width:"70px"
                    }, {
                        bind: ".useDate",
                        caption: "使用日期",
                        align: "center",
                        width:"70px"
                    }]
                },
                selectStatic: {
                    $type: "select",
                    width:"200px",
                    options: [{
                        value: "0",
                        text: "未使用"
                    }, {
                        value: "1",
                        text: "已使用"
                    }, {
                        value: "2",
                        text: "已过期"
                    }]
                }
            })
            $(".ui.dropdown").dropdown();

            $('.table_contant, .table_contant>table').height($(document.body).height()-90);
            $('.table_contant>table').css('overflow-x','scroll');
            $(window).bind("resize", function(e){
                $('.table_contant, .table_contant>table').height($(document.body).height()-90)
            });
        })
    </script>
</body>
</html>
