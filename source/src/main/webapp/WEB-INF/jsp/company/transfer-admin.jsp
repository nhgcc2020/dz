<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <link rel="stylesheet" type="text/css" href="/resources/business/order-table.css?v=7367cb39d5">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">         <%--//全局图标样式--%>

    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
    <script src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
    <script src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
    <script type="text/javascript">
        cola(function (model) {
            model.describe("employees", {
                provider: "<c:url value="/employee/infoVo"/>"
            });
            //当前公司的所有角色
            model.describe("role", {
                provider: "<c:url value='/system/role/select-info'/>"
            });

            $.post("/employee/getAdmin",{},function(data){
                var admin = eval("("+data+")");
                model.set("adminName",admin.userName);
            });

            model.widgetConfig({
                empList: {
                    $type: "dropdown",
                    items: "{{man in employees}}",
                    openMode: "drop",
                    valueProperty: "salesId",
                    textProperty: "salesName"
                    /*readOnly:true*/
                },
                //修改角色
                modRoleDrop: {
                    $type: "dropdown",
                    items: "{{role}}",
                    openMode: "drop",
                    icon: "dropdown icon iconfont",
                    placeholder: "选择角色",
                    change: function (self, arg) {
                        model.set("modRoleKey", arg.value);
                    }
                },
            });
            model.action({
                //关闭调整角色弹窗
                openModRole:function(btn){
                    cola.widget("modRoleDiv").show();
                },
                //关闭调整角色弹窗
                closeModRole:function(btn){
                    cola.widget("modRoleDiv").hide();
                },
                sure:function (btn) {
                    btn.set("disabled",true);
                    btn.set("state","loading");

                    var value = cola.widget("empList").get("value");
                    if(value == undefined || value == ""){
                        $("<div class='tips_contants'>").fadeIn(250).html("请选择您需要转移的员工").delay(3000).fadeOut(250).appendTo('body');
                        btn.set("disabled",false);
                        btn.set("state","");
                        return false;
                    }
                    $.post("<c:url value='/employee/transferOfRights'/>",
                            {newAdminUserKey:value},
                            function(callback){

                                var data = eval("("+callback+")");
                                if(data.state){
                                    $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(3000).fadeOut(250).appendTo('body');
                                   setTimeout(function(){
                                        window.parent.location.reload();
                                    },2000);
                                }else if(data.type == "needRole"){
                                    //弹窗
                                    model.action("openModRole")();
                                    btn.set("disabled",false);
                                    btn.set("state","");
                                }else{
                                    $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(3000).fadeOut(250).appendTo('body');
                                    btn.set("disabled",false);
                                    btn.set("state","");
                                }
                    });
                },
                sureNext:function(btn){
                    btn.set("disabled",true);
                    btn.set("state","loading");
                    //传值
                    var roleKey = model.get("modRoleKey");
                    if(roleKey == undefined || roleKey == ""){
                        $("<div class='tips_contants'>").fadeIn(250).html("请为当前管理员选择转移权限后的角色").delay(3000).fadeOut(250).appendTo('body');
                        btn.set("disabled",false);
                        btn.set("state","");
                        return false;
                    }
                    var value = cola.widget("empList").get("value");
                    if(value == undefined || value == ""){
                        $("<div class='tips_contants'>").fadeIn(250).html("请选择您需要转移的员工").delay(3000).fadeOut(250).appendTo('body');

                        btn.set("disabled",false);
                        btn.set("state","");
                        return false;
                    }
                    $.post("<c:url value='/employee/transferOfRights'/>",
                            {
                             newAdminUserKey:value,
                             roleKey:roleKey},
                            function(callback){
                                var data = eval("("+callback+")");
                                $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(3000).fadeOut(250).appendTo('body');
                                if(data.state){
                                    setTimeout(function(){
                                        window.parent.location.reload();
                                    },2000);
                                }else{
                                    //弹窗
                                    btn.set("disabled",false);
                                    btn.set("state","");
                                }
                            });
                },

            })
        });
        cola.on("ready", function () {
            $("#empList").find(".dropdown.icon").addClass("iconfont");

        })
    </script>
</head>
<body style="padding:0px">
<div class="transfer_admin">
    权限转移<i class="iconfont not_tips" data-html="<div>
    <span style='color:orange' >“法人代表”</span>
    或当前
    <span style='color:orange' >“管理员”</span>可以把管理员身份转移给任何一名员工。转移完毕，当前“管理员”失去所有管理员权限，成为普通员工。
    <span style='color:orange' >“法人代表”</span>永久性拥有管理员权限。
    </div>"></i>
</div>


<%--<div class="Allform">--%>
    <%--<p>--%>
        <%--<span>当前管理员</span>--%>
        <%--<b>大全1A</b>--%>
    <%--</p>--%>
    <%--<p>--%>
        <%--<span>转移管理员</span>--%>
        <%--<select name="" id="Allform_admin">--%>
            <%--<option value="jaja ">alala </option>--%>
            <%--<option value="jaja ">alala </option>--%>
        <%--</select>--%>
    <%--</p>--%>
    <%--<p>--%>
        <%--<span>&nbsp; &nbsp; &nbsp;</span>--%>
        <%--<button>确认转移</button>--%>
    <%--</p>--%>
<%--</div>--%>

<div style="padding:30px 0px 0px 80px;">
    <div class="ui form">
        <div class="field" style="font-size: 14px">
            <div style="width:90px; float: left">当前管理员</div>
            <div style="width:300px" c-bind="adminName"></div><%--${sessionScope.sessionUser.realName}--%>
        </div>
        <div class="inline fields">

                <div style="width:90px; float: left; font-size: 14px; line-height: 37px">转移管理员</div>
                <%--<div c-widget="select; bind:company.comProvince; options:{{employees}}; placeholder:请选择; icon:dropdown iconfont;" style="margin-right: 150px; width:200px"></div>--%>

            <div class="field">
                <div id="empList" style="width:300px"></div>

                <%--<div class="ui selection dropdown" style="vertical-align: bottom;">
                  <input type="hidden">
                   <i class="dropdown icon"></i>
                   <div class="default text">全部客户</div>
                   <div class="menu">
                       <div class="item">张三</div>
                       <div class="item">李四</div>
                       <div class="item">王五</div>
                   </div>
                </div>--%>
            </div>
        </div>
        <div class="inline fields">

            <div style="float: left;color:#999; font-size: 12px; line-height: 18px">如果您是这个企业账号的法人代表兼管理员，转交管理员权限后，您依然拥有最高的管理权限，包括撤换新管理员的权限。
                </div>
        </div>
        <div class="inline fields">

            <div style="float: left; font-size: 12px;color:#999; line-height: 18px">
                如果您是这个企业账号的管理员，转交管理员权限后，您将不再拥有管理权限，并且会被系统要求重新登录且无法再进入企业控制台。</div>
        </div>
        <div class="field">
            <div c-widget="button; caption:确认转移权限;click:sure;class:primary;" style="width: 300px !important; margin-left: 90px !important;" class="tran-btn"></div>
        </div>

    </div>
</div>

<div id="modRoleDiv" c-widget="Dialog; width:450px;closeable:false">
    <div class="content">
        <div class="description">
            <div class="ui header">请选择您的新角色</div>
            <div c-widget="form">
                <div class="field">
                    <div id="modRoleDrop"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="actions">
        <div c-widget="button; caption:取消;click:closeModRole"></div>
        <div c-widget="button;color:blue;caption:确定;click:sureNext"></div>
    </div>
</div>
<script>
    //提示框
    $('.not_tips').popup({
        hoverable  : true
    });
    //禁止返回上一页
    window.onload = function(){
        window.history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
    }
</script>

</body>
</html>