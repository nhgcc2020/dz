<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>消息中心</title>
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <link rel="stylesheet" type="text/css" href="/resources/business/order-table.css?v=7367cb39d5">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">
    <style>
        .table-link-temp{
            padding:0px 0px;
            color: #2e8ae6 !important;
        }
        .table-link-temp:hover{
            border: none;
            border-bottom: 1px solid #2e8ae6;
            border-radius: 0px;
            background: transparent;
        }
    </style>
</head>
<body style="padding: 10px;">
<div class="all-message">
    全部消息 <span>(电脑端的消息可与短信同步。如果您需要系统类通知之外的短信服务（主要是交易提醒），您可以到短信服务中心去开通。</span>
</div>
<div class="field" style="position: relative;">
    <div c-widget="ButtonGroup">
        <div c-widget="#operations; caption:系统通知;tag:op;userData:01;class:basic grey;"></div>
        <div c-widget="#operations; caption:交易提醒;tag:op;userData:02;class:basic grey;"></div>
        <div c-widget="#operations; caption:安全消息;tag:op;userData:03;class:basic grey;"></div>
        <div c-widget="#operations; caption:活动消息;tag:op;userData:04;class:basic grey;"></div>
        <div c-widget="#operations; caption:订阅消息;tag:op;userData:05;class:basic grey;"></div>
        <div c-widget="#operations; caption:其它消息;tag:op;userData:06;class:basic grey;"></div>
        <div c-widget="#operations; caption:申请加入;tag:op;userData:07;class:basic grey;"></div>
        <div c-widget="#operations; caption:好友申请;tag:op;userData:08;class:active blue;"></div>
    </div>
    <div class="button-right" style="top: 0px;">
        <div c-widget="button; class:primary; caption:删除;" style="background: #dde1e2;color: #000;"></div>
        <div c-widget="button; class:primary; caption:标记已读;"></div>
    </div>
</div>
<div class="table_contant">
    <div class="loadingssss loading_box"><span></span></div>
    <div id="messageTable">
        <template name="oddNumbersTemplate">
            <div>
                <a c-widget="link;bind:$default;href:###;content:{{$default}};click:{{showOrderDetail(item)}}" class="table-link-temp"></a>
            </div>
        </template>
    </div>
</div>
<div id="rightWin" c-widget="Sidebar; direction:right;" class="segment">
    <iframe style="width: 100%;height: 100%" src=""></iframe>
</div>
<script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
<script src="/resources/cola-ui/3rd.min.js?v=59f8ac5b1a"></script>
<script src="/resources/cola-ui/semantic.min.js?v=ce263d5009"></script>
<script src="/resources/cola-ui/cola.min.js?v=96274d219a"></script>
<script type="text/javascript">
    cola(function (model) {
        model.set("para","08");
        model.describe("messages", {
            provider: {
                url: "<c:url value='/common/message/messageList?parameter='/>"+model.get("para"),
                pageSize: 15,
                complete:function(){
                    $(".loading_box").removeClass("loadingssss");
                }
            }
        });

        /*model.set("messages_bak",[
         {
         title: "有员工申请加入您公司",
         sender: "易对账",
         sendTime: "2016-05-5 15:16:23"
         }
         ])*/

        model.widgetConfig({
            operations: {
                $type: "button",
                click: function(self, arg) {
                    var ops = cola.tag("op");
                    model.set("para",self.get("userData"));
                    model.describe("messages", {
                        provider: {
                            url: "<c:url value='/common/message/messageList'/>",
                            parameter:model.get("para"),
                            pageSize: 15
                        }
                    });
                    model.flush("messages");
                    for(var i = 0; i < ops.length; i++) {
                        var op = ops[i]

                        op.get$Dom().removeClass("active blue");
                        op.get$Dom().addClass("basic grey");
                    }

                    self.get$Dom().removeClass("basic grey");
                    self.get$Dom().addClass("active blue");
                }

            },
//            messagePager: {
//                $type: "Pager",
//                bind: "pageItems"
//            },
            messageTable: {
                $type: "Table",
                bind: "item in messages",
                showHeader: true,
                currentPageOnly: true,
                "class": "selectable compact",
                /*itemDoubleClick:function (self,arg) {
                 var messageId = arg.item._data.msgId
                 console.info(messageId);
                 window.location.href="<c:url value='/common/message/detail?messageId='/>"+messageId;
                 },*/
                columns: [
                    {
                        $type: "select"
                    },
                    {
                        caption: "标题内容",
                        bind: ".msgTitle",
                        align: "center",
                        template: "oddNumbersTemplate"
                    },
                    {
                        caption: "发送人",
                        bind: ".sendName",
                        align: "center"

                    }, {
                        caption: "发送时间",
                        bind: ".createTimeStr",
                        align: "center"
                    },{
                        caption:" 状态",
                        bind:".status",
                        align: "center"
                    }

                ]
            }
        });

        $('.table_contant, .table_contant>table').height($(document.body).height()-140);
        $('.table_contant>table').css('overflow-x','scroll');
        $(window).bind("resize", function(e){
            $('.table_contant, .table_contant>table').height($(document.body).height()-140)
        });

        model.action({
            //详情部分
            showOrderDetail:function(item){
                var messageId = item.get("msgId");


                var url = "/common/message/detail?messageId=" + messageId;
                $("#rightWin").find("iframe").attr("src",url);
                var width =  $(window).width() -290;
                cola.widget("rightWin").set("size",width);
                cola.widget("rightWin").show();
                $(".ui.dimmer.active").remove();

                /*console.info(messageId);
                 window.location.href="<c:url value='/common/message/detail?messageId='/>"+messageId;*/
            },
            //关闭详情窗口
            closeRightWin:function () {
                cola.widget("rightWin").hide();
                $("#rightWin").find("iframe").attr("src","");
                //移除点击背景颜色
                $(".table-link-temp").removeClass("clikcBTn")}
        });

        window.salesOrderList = model;

    });
</script>
</body>
</html>