<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">
    <title>接受好友申请界面</title>
    <style>.dyz_dialog_title{  background: #cccccc;  line-height: 30px;  padding-left: 20px;  font-weight: 600;  }
    #createOrderPop{
        display: none;
        z-index: 99;
        width: 500px;
        height: 380px;
        position: absolute;
        top: 50%;
        left: 50%;
        background: #fff;
        margin-top: -120px;
        margin-left: -190px;
        box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
    }
    </style>
</head>
<body>
<h4>
    <div c-widget="Button; caption:关闭;click:closeWin;class:blue basic" style="margin-left: 40px"></div>
</h4>
<div c-widget="divider"></div>
<h4 style="text-align: center">
    <span style="font-size: 18px" c-bind="message.msgTitle"></span>
    <br/><br>
    <span style="font-size: 14px" c-bind="message.createTime"></span>
</h4>
<table id="messageTable" style="margin: 30px 0px;">
    <template name="operations">
        <div  style="text-align:center;"  >
            <a c-widget="button; class:primary;click:{{agree(item)}};" c-display="$default==0">同意</a>
            <a c-widget="Label;text:{{item.reason}}" c-display="$default==1"></a>
        </div>
    </template>
</table>

<div class="animated flipInY" id="createOrderPop">
    <p style="    position: relative;
    font-weight: 100;
    text-align: left;
    font-size: 18px;
    margin: 0px auto;
    padding: 15px 20px;
    border-bottom: 1px solid #ccc;" id="menuTitle">同意好友申请</p>
    <span id="closetranform" style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" onclick="hideOrderPop()"><i style="background: url('../../images/close_user.png');width:14px;height: 14px;display: block" alt="点击关闭"></i></span>
    <div style="    width: 500px;
    height: 30px;
    line-height: 30px;
    margin: 60px auto 0;
    font-size: 14px;
    color: #4284d9;
    text-align: center;
    font-weight: 700;"><span class="iconfont_new" style="font-size: 40px;
    font-weight: 300;
    vertical-align: middle;">&#xe6c8;</span>成为好友，供求订单互相同步</div>
    <div style="    width: 500px;
    height: 30px;
    line-height: 30px;
    margin: auto;
    font-size: 12px;
    color: #a5a4a4;
    text-align: center;">用易对账互相记/对账，告别电话、传真、邮件通知、降低沟通成本</div>

    <div style="    margin: 70px auto;
    width: 400px;
    text-align: center;">
        <div c-widget="form" style="margin-top:1rem;">
            <div class="inline field">
                <label style="    width: 100px;
    color: #7e92ab;
    margin-right: 0;"><span style="    color: #7e92ab;
    font-size: 25px;
    vertical-align: bottom;
    font-weight: 200;" class="iconfont_new">&#xe6be;</span>价格级别：</label>
                <div id="radioGroup2" c-widget="RadioGroup;name:brand6;bind:partnerLevel" style="font-size: 12px;display: inline-block"></div>
            </div>
        </div>
    </div>

    <div class="actions" style="padding-bottom:30px;padding-right: 82px;background: none;border-top:none;position: absolute; right: 0; bottom: 0;">
        <div onclick="hideOrderPop()" c-widget="button; caption:取消;" style="width: 90px"></div>
        <div c-widget="button;color:blue;caption:确定;click:sureAgree" style="float: right;width: 90px;margin-left:15px;padding: 0px"></div>
    </div>
</div>

<script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
<script src="/resources/cola-ui/3rd.min.js?v=59f8ac5b1a"></script>
<script src="/resources/cola-ui/semantic.min.js?v=ce263d5009"></script>
<script src="/resources/cola-ui/cola.min.js?v=96274d219a"></script>
<script type="text/javascript">
    function hideOrderPop() {
        $(".window-mask").hide();
        $('#createOrderPop').hide();
    }
    cola(function (model) {
        var message = ${message};
        model.set("messages",[message]);
        model.set("message",message);
        model.set("partnerLevel","2");
        model.describe({
            reason: {
                validators: "required"
            }
        });
        model.action({
            closeWin:function(){
                window.parent.salesOrderList.action("closeRightWin")();
            },
            agree:function(){
//                cola.widget("agreeDio").show();
                $(".window-mask").show();
                $('#createOrderPop').show();
            },
            closeAgree:function(){
                cola.widget("agreeDio").hide();
            },
            sureAgree:function(btn){
                btn.set("disabled",true);
                btn.set("state","loading");
                var partnerLevel = model.get("partnerLevel");
                //根据对方的伙伴分类 来设置我方伙伴分类
                var remarks = model.get("message.remarks");
                var partnerType;
                if(partnerLevel==undefined ){
                    $("<div class='tips_contants'>").fadeIn(250).html("请选择合作级别").delay(3000).fadeOut(250).appendTo('body');
                    btn.set("disabled",false);
                    btn.set("state","");
                    return false;
                }
                $.ajax({
                    url: "<c:url value='/common/message/agree'/>",
                    type: "post",
                    data: {
                        messageId:model.get("message.msgId"),
                        partnerLevel:partnerLevel
                    },
                    success:function(callBack){
                        var data = eval("("+callBack+")");
                        $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(3000).fadeOut(250).appendTo('body');
                        window.location.reload();
//                        cola.model().action("closeAgree")();
                        btn.set("disabled",false);
                        btn.set("state","");
                    },
                    error:function(callBack){
                        //var data = eval("("+callBack+")");

                    }
                })
            }
        });
        model.widgetConfig({
            radioGroup: {
                items: [{
                    label: "既是客户又是供应商",
                    value: "A"
                }, {
                    label: "我的客户",
                    value: "1"
                }, {
                    label: "我的供应商",
                    value: "2"
                }]

            },
            radioGroup2: {
                items: [{
                    label: "优惠价",
                    value: "1"
                }, {
                    label: "标准价",
                    value: "2"
                }, {
                    label: "零散价",
                    value: "3"
                }]

            },
            messageTable: {
                $type: "Table",
                bind: "messages",
                showHeader: true,
                "class": "selectable compact",
                columns: [
                    {
                        caption: "申请企业",
                        bind: ".sendName",
                        align: "center"
                    }, {
                        caption: "申请人",
                        bind: ".adminName",
                        align: "center"
                    }, {
                        caption: "注册手机号",
                        bind: ".adminPhone",
                        align: "center"

                    }, {
                        bind: ".friendStatus",
                        caption: "操作",
                        align: "center",
                        width: "300px",
                        template: "operations"
                    }
                ]
            }
        })
    });
</script>
</body>
</html>