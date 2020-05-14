<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>员工申请</title>
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
    <script src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
    <script src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
    <script src="/resources/cola-ui/cola-ext.js?v=ab24bf6495"></script>
    <style>
        .tips_contants{
            height: 80px;
            line-height: 80px;
            width:300px;
            text-align: center;
            background: rgba(0,0,0,0.8);
            color: #fff;
            position: absolute;
            top:50%;
            margin-top:-150px;
            left:50%;
            margin-left: -150px;
            border-radius: 5px;
            display: none;
            z-index: 10000;
        }
    </style>
    <script type="text/javascript">
        cola(function (model) {
            var message = ${message};
            model.set("messages",[message]);
            model.set("message",message);
            model.describe({
                reason: {
                    validators: "required"
                }
            });
            //当前公司的所有部门
            model.describe("departments", {
                provider: "/department/select-info"
            });
            //当前公司的所有角色
            model.describe("role", {
                provider: "/system/role/select-info"
            });

            model.widgetConfig({
                /*deptDrop: {
                    $type: "Dropdown",
                    items: "{{departments}}",
                    icon: "dropdown icon iconfont",
                    placeholder: "选择部门",
                    popup: "选择部门",
                   change: function (self, arg) {
                        model.set("deptId", arg.value);
                    }
                },
                role_drop: {
                    $type: "dropdown",
                    items: "{{role}}",
                    openMode: "drop",
                    icon: "dropdown icon iconfont",
                    placeholder: "选择角色",
                    change: function (self, arg) {
                        model.set("roleKey", arg.value);
                    }
                },*/
                messageTable: {
                    $type: "ext.Table",
                    bind: "messages",
                    showHeader: true,
                    "class": "selectable compact",
                    columns: [
                        {
                            caption: "申请人",
                            bind: ".sendName",
                            align: "center"
                        },
                        {
                            caption: "注册手机号",
                            bind: ".sendPhone",
                            align: "center"

                        },
                        {
                            bind: ".friendStatus",
                            caption: "操作",
                            align: "center",
                            width: "200px",
                            template: "operations"
                        }
                    ]
                }
            });
            model.action({
                closeWin:function(){
                    window.parent.salesOrderList.action("closeRightWin")();
                },
                openYes:function(item){

                    cola.widget("addEmpDiv").show();
                },
                closeYes:function () {
                    cola.widget("addEmpDiv").hide();
                },
                //同意申请操作
                sureYes:function (btn) {
                    btn.set("disabled",true);
                    btn.set("state","loading");

                    /*var deptId = model.get("deptId");
                    var roleKey = model.get("roleKey");

                    if(deptId == undefined || deptId == ""){
                        $("<div class='tips_contants'>").fadeIn(250).html("请选择部门！").delay(1000).fadeOut(250).appendTo('body');
                        btn.set("disabled", false);
                        btn.set("state", "");
                        return false;
                    }
                    f(roleKey == undefined || roleKey == ""){
                        $("<div class='tips_contants'>").fadeIn(250).html("请选择角色！").delay(1000).fadeOut(250).appendTo('body');
                        btn.set("disabled", false);
                        btn.set("state", "");
                        return false;
                    }*/

                    $.post("/common/message/agreeEmp",
                            {
                                deptId:"002",
                                roleKey:"003",
                                userKey:model.get("message.sendKey"),
                                msgId:model.get("message.msgId")
                            },
                            function(callback){
                                var data = eval("("+callback+")");
                                if(data.state == "1"){
                                    $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(3000).fadeOut(250).appendTo('body');
                                    setTimeout(function(){
                                        btn.set("disabled",false);
                                        btn.set("state","");
                                        window.location.reload();
                                    },2000);
                                }else{
                                    btn.set("disabled",false);
                                    btn.set("state","");
                                    $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(3000).fadeOut(250).appendTo('body');

                                }

                            }
                    )
                },
                //打开拒绝申请弹窗
                openRefuseEmp:function(){
                    cola.widget("refuseDiv").show();

                },
                //关闭拒绝申请弹窗
                closeRefuseEmp:function(){
                    cola.widget("refuseDiv").hide();
                },
                //拒绝申请操作
                refuseEmp:function(btn){
                    btn.set("disabled",true);
                    btn.set("state","loading");
                    //var reason = $.trim(model.get("reason"));
                    //
                    $.post("/common/message/refuseEmp",
                           {
                               userKey:model.get("message.sendKey"),
                               msgId:model.get("message.msgId"),
                               reason:model.get("reason")
                           },
                           function(callback){
                               var data = eval("("+callback+")");
                               if(data.state == "1"){
                                   $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(3000).fadeOut(250).appendTo('body');
                                   setTimeout(function(){
                                       btn.set("disabled",false);
                                       btn.set("state","");
                                       window.location.reload();
                                   },2000);
                               }else{
                                   btn.set("disabled",false);
                                   btn.set("state","");
                                   $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(3000).fadeOut(250).appendTo('body');

                               }
                    })
                }
                //

            })
        });
    </script>

</head>
<body>

<h4>
    <div c-widget="Button; caption:关闭;click:closeWin;class:blue basic" style="margin-left: 40px"></div>
</h4>

<div c-widget="divider"></div>

<h4 style="text-align: center">
    <span style="font-size: 18px" c-bind="message.msgTitle"></span>
    <br/>
    <span style="font-size: 14px" c-bind="message.createTime"></span>
</h4>


<table id="messageTable" style="margin: 30px 0px;">
    <template name="operations">
        <div  style="text-align:center;">
            <div c-display="$default==0">
                <a c-widget="button; class:primary;click:{{openYes(item)}}">同意</a>
                <a c-widget="button; class:primary;click:openRefuseEmp" style="background: #ee8e52;">拒绝</a></div>
            <div c-display="$default==1">
                <a c-widget="Label;text:{{item.reason}}" ></a>
            </div>
        </div>
        <%--<div  style="text-align:center;" c-display="$default==0" >
            <a c-widget="button; class:primary;click:{{openYes(item)}}">同意</a>
            <a c-widget="button; class:primary;click:openRefuseEmp" style="background: #ee8e52;">拒绝</a>
        </div>
        <div  style="text-align:center;" c-display="$default==1" >
            <a c-widget="Label;text:{{item.reason}}" ></a>
        </div>--%>
    </template>
</table>


<div id="addEmpDiv" c-widget="Dialog; width:450px;closeable:false">
    <div class="content">
        <div class="description">
            <div class="ui header" style="text-align;">是否同意申请</div>
            <%--<div class="ui form">
                <div class="inline field">
                    <label style="width: 80px;margin-left:8px">分配部门</label>
                    <div id="deptDrop"></div>
                </div>
                <div class="inline field">
                    <label style="width: 80px;margin-left:8px">分配角色</label>
                    <div id="role_drop"></div>
                </div>
            </div>--%>
        </div>
    </div>
    <div class="actions">
        <div c-widget="button; caption:取消;click:closeYes"></div>
        <div c-widget="button;color:blue;caption:确定;click:sureYes"></div>
    </div>
</div>

<div id="refuseDiv" c-widget="Dialog; width:450px;closeable:false">
    <div class="content">
        <div class="description">
            <div class="ui header">拒绝申请</div>
            <div class="ui form">
                <div class="inline field">
                    <textarea style="display: inline-block" placeholder="拒绝原由:此内容只用于内部查看" rows="3" cols="2" c-bind="reason"></textarea>
                </div>
            </div>
        </div>
    </div>
    <div class="actions">
        <div c-widget="button; caption:取消;click:closeRefuseEmp"></div>
        <div c-widget="button;color:blue;caption:确定;click:refuseEmp"></div>
    </div>
</div>

</body>
</html>