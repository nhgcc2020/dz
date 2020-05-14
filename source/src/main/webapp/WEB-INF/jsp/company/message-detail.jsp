<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
    <script src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
    <script src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>

    <script type="text/javascript">
        cola(function (model) {
            /*model.set("messages",[
                {
                    applicant: "金仁波",
                    mobilePhone: "易对账",
                    email: " 61357715@qq.com",
                    applyDate: " 2015-09-09"
                }
            ]);*/
            var message = "${message}";

            model.get("message",function(data){
                if(data.get("type") == "07"){
                   $("#buttonBox").show();
                }
            })
            model.action({
                openDiv:function(){
                    cola.widget("d4").show();
                },
                refuse:function(){

                }

            });
            model.widgetConfig({
                messageTable: {
                    $type: "Table",
                    bind: "messages",
                    showHeader: true,
                    "class": "selectable compact",
                    columns: [
                        {
                            caption: "申请人",
                            bind: ".applicant",
                            align: "center"
                        },
                        {
                            caption: "注册手机号",
                            bind: ".mobilePhone",
                            align: "center"

                        },
                        {
                            caption: "电子邮件",
                            bind: ".email",
                            align: "center"
                        },
                        {
                            caption: "申请日期",
                            bind: ".applyDate",
                            align: "center"
                        },
                        {
                            caption: "操作",
                            align: "center",
                            width: "200px",
                            template: "operations"
                        }
                    ]
                }
            });
        });
    </script>

</head>
<body style="margin: 20px">

<h4>
    全部消息
    <div c-widget="Button; caption:返回上级; class:blue basic" style="margin-left: 40px" onclick="window.location.href='<c:url value="/common/message/messageListPage"/>'"></div>
</h4>

<div c-widget="divider"></div>

<h4 style="text-align: center">
    <span style="font-size: 18px" c-bind="message.msgTitle"></span>
    <br/><br>
    <span style="font-size: 14px" c-bind="message.createTime"></span>
</h4>

<div c-widget="divider"></div>


<div style="border: 1px solid #DEDEDF;margin: 0 auto;width: 70%;padding:1rem;font-size: 1.25rem">
        <article c-bind="message.msgContent">
        </article>
        <div style="margin-top: 3rem;display: none; text-align: center; " id="buttonBox">
            <div c-widget="button; class:primary; caption:同意;click:openDiv"></div>
            <div c-widget="button; class:secondary; caption:拒绝;click:refuse" style="background: #ee8e52;"></div>
        </div>
</div>


<div id="d4" c-widget="Dialog; ">
    <div class="header">选择</div>
    <div class="content">
        <div style="padding: 2rem">
            <div style="padding:1rem 0rem;border-bottom:1px #999999 solid;margin-bottom: 1em;font-size: 1.15rem;">邀请公司同事</div>
            <div>注意：此处无法单独为个人的调整权限，如果需要，请后续前往“角色权限设置”功能下进行修改或添加新的角色类。</div>

            <div style="padding: 1rem;">
                <form id="employeeForm" method="post">
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
                                <select name="deptId" c-options="department"></select>
                            </div>
                        </div>

                        <div class="fields">
                            <div style="min-width: 90px;">
                                <span style="color: red;font-size: 1.2rem;">*</span><span style="line-height: 2.5rem;">选择角色</span>
                            </div>
                            <div class="field three wide" style="padding-right: 0%">
                                <select name="roleId" c-options="role"></select>
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
    </div>
    <div class="actions">
        <div c-widget="button; caption:取消"></div>
        <div c-widget="button; caption:确定"></div>
    </div>
</div>




</body>
</html>