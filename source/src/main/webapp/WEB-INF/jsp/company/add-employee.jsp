<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
    <script src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
    <script src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
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
            z-index: 9999;
        }
    </style>
    <script type="text/javascript">
        cola(function(model) {
           model.describe("department", {
                provider: "/department/select-info"
           });
           model.describe("role", {
                provider: "/system/role/select-info"
           });

           model.action({
                testAction:function (btn) {

                    btn.set("disabled",true);
                    btn.set("state","loading");

                    var url = "/employee/inviteEmployee";

                    var value1 = cola.widget("deptDrop").get("value");
                    var value2 = cola.widget("roleDrop").get("value");

                    if(value1 == undefined || value1 == ""){
                        $("<div class='tips_contants'>").fadeIn(250).html("请选择部门").delay(1000).fadeOut(250).appendTo('body');
                    }

                    if(value2 == undefined || value2 == ""){
                        $("<div class='tips_contants'>").fadeIn(250).html("选择角色").delay(1000).fadeOut(250).appendTo('body');
                    }

                    $("input[name='deptId']").val(value1);
                    $("input[name='roleKey']").val(value2);

                    var form_data = $("#employeeForm").serialize();
                    $.post(url,form_data,function (data) {

                        if(data=='0'){
                            $("<div class='tips_contants'>").fadeIn(250).html("添加失败").delay(1000).fadeOut(250).appendTo('body');
                            btn.set("disabled",false);
                            btn.set("state","");
                            //alert("失败");
                        }else{
                            $("<div class='tips_contants'>").fadeIn(250).html("添加成功！").delay(1000).fadeOut(250).appendTo('body');
                            setTimeout(function(){
                                window.location.href="/employee/empPage";
                            },1000);
                            //alert("邀请连接为:"+data);
                        }
                    })
                    //console.info(model.get("department"));
                }
           })
            model.widgetConfig({
                //部门下拉框
                deptDrop:{
                    $type: "dropdown",
                    items: "{{department}}",
                    openMode: "drop",
                    valueProperty:"value",
                    textProperty:"text",
                    change:function (self,arg) {

                    }
                },
                //角色下拉框
                roleDrop:{
                    $type: "dropdown",
                    items: "{{role}}",
                    openMode: "drop",
                    valueProperty:"value",
                    textProperty:"text",
                    change:function (self,arg) {

                    }
                }
            })
        });
    </script>
    <meta charset="UTF-8">
    <title></title>
</head>
<body>

<div style="padding: 2rem">
    <div style="padding:1rem 0rem;border-bottom:1px #999999 solid;margin-bottom: 1em;font-size: 1.15rem;">邀请公司同事</div>
    <div>注意：此处无法单独为个人的调整权限，如果需要，请后续前往“角色权限设置”功能下进行修改或添加新的角色类。</div>

    <div style="padding: 1rem;">
        <form id="employeeForm" method="post">
        <input type="hidden" name="roleKey" value="" />
        <input type="hidden" name="deptId" value="" />

            <div class="ui form">
            <div class="fields">
                <div style="min-width: 90px;">
                    <span style="color: red;font-size: 1.2rem;">*</span><span style="line-height: 2.5rem;">成员姓名</span>
                </div>
                <div class="field three wide">
                    <div c-widget="Input;name:remarks;value:"></div>
                </div>
            </div>
            <div class="fields">
                <div style="min-width: 90px;">
                    <span style="color: red;font-size: 1.2rem;">*</span><span style="line-height: 2.5rem;">联系手机</span>
                </div>
                <div class="field three wide">
                    <div c-widget="Input;name:userId;value:"></div>
                </div>
            </div>


            <div class="fields">
                <div style="min-width: 90px;">
                    <span style="color: red;font-size: 1.2rem;">*</span><span style="line-height: 2.5rem;">选择部门</span>
                </div>
                <div class="field three wide">
                    <div id="deptDrop"></div>
                   <%--<select name="deptId" c-options="department"></select>--%>
                </div>
            </div>

            <div class="fields">
                <div style="min-width: 90px;">
                    <span style="color: red;font-size: 1.2rem;">*</span><span style="line-height: 2.5rem;">选择角色</span>
                </div>
                <div class="field three wide" style="padding-right: 0%">
                    <div id="roleDrop"></div>
                    <%--<select name="roleId" c-options="role"></select>--%>
                </div>
                <div style="margin-left: 5px">
                    <div c-widget="button;class:basic">查看角色权限</div>
                </div>
            </div>

            <a c-widget="button;class:basic" style="width: 180px;margin-top: 2rem; background: #dde1e2 !important; box-shadow:none;" href="<c:url value="/employee/empPage"/>">取消</a>
            <a c-widget="button;class:blue;click:testAction" style="width: 180px;margin-top: 2rem" >发送短信邀请</a>
        </div>
        </form>
    </div>
</div>

</body>
</html>