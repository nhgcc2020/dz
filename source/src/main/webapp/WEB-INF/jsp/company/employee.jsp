<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.min.css?v=c509be79d3">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.min.css?v=294128f84a">
    <link rel="stylesheet" type="text/css" href="/resources/business/order-table.css?v=7367cb39d5">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">
    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script src="/resources/cola-ui/3rd.min.js?v=59f8ac5b1a"></script>
    <script src="/resources/cola-ui/semantic.min.js?v=ce263d5009"></script>
    <script src="/resources/cola-ui/cola.min.js?v=96274d219a"></script>
    <style>
        .ui.button {
            cursor: pointer;
            display: inline-block;
            min-height: 1em;
            outline: none;
            border: none;
            vertical-align: baseline;
            background: #E0E1E2 none;
            color: rgba(0, 0, 0, 0.6);
            font-family: Arial, "Microsoft YaHei", '宋体';
            margin: 0em 0.25em 0em 0em;
            font-size: 12px !important;
            height: 30px;
            line-height: 30px;
            padding:0px 30px;
            text-transform: none;
            text-shadow: none;
            font-weight: bold;
            font-style: normal;
            text-align: center;
            text-decoration: none;
            border-radius: 0.28571429rem;
            box-shadow: 0px 0px 0px 1px transparent inset, 0px 0em 0px 0px rgba(34, 36, 38, 0.15) inset;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            -webkit-transition: opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, box-shadow 0.1s ease, background 0.1s ease;
            transition: opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, box-shadow 0.1s ease, background 0.1s ease;
            will-change: '';
            -webkit-tap-highlight-color: transparent;
        }
    </style>
</head>
<body style="padding: 10px">
<div class="v-box">

        <div>
            <h4 class="user_list">
                <%--<span>人员列表暂时只对管理员和法人代表开放，未来会考虑对内部人员开放。</span>--%>
                <div class="field button-left" style="top: -5px;">
                    <button class="ui button" style="padding:0 15px; color:#fff; background-color:#4284d9;"  onclick="openCompany()" >管理员工</button>
                </div>
                <div class="field button-right" style="top: -5px;">
                    <%--<div c-widget="button; class:primary; caption:刷新;" onclick="window.location.reload()"></div>--%>
                    <%--<div c-widget="button; class:primary; caption:添加成员;" onclick="window.location.href='<c:url value="/employee/toAdd"/>'"></div>--%>
                    <%--<div c-widget="button; class:primary; caption:查看;"></div>
                    <div c-widget="button; class:primary; caption:编辑;" ></div>
                    <div c-widget="button; class:primary; caption:权限;"></div>
                    <div c-widget="button; class:primary; caption:注销账号;"></div>--%>
                    <%--<button class="ui button" style="padding:0 15px;" data-html="--%>
                        <%--<div>你是企业创建者，可以通过'<span style='color:orange' >管理企业</span>'入口进入企业中心去完善企业资料、创建部门或添加员工</div>--%>
                        <%--">邀请员工</button>--%>

                    <%--<button class="ui button" style="padding:0 15px;" data-html="
                        <div style='width:258px'>你是企业创建者，可以通过'<span style='color:orange' >管理企业</span>'入口进入<span style='color:orange' >企业中心</span>去<span style='color:orange' >创建部门或员工</span></div>
                        <div style='float:right'><a onclick='openCompany()'  href='javascript:void(0)'>马上创建 > </a></div>
                        ">调整部门</button>
                    <div c-widget="button; class:primary; caption:调整角色;"></div>--%>
                </div>
            </h4>
            <div class="table_contant" id="employeeTable">
                <template name="operations">
                    <div>
                        <a c-widget="link; href:###">查看编辑权限</a>
                        <a c-widget="link; href:###">注销账号</a>
                    </div>
                </template>
            </div>
        <%--    <div class="page_fix">
                <div id="pagerExample" class="order-Pager"></div>
            </div>--%>
        </div>


</div>
<script type="text/javascript">
    function openCompany(){
        window.open('/openPage?pageName=company-main#employee');
    }
    cola(function(model) {

        model.describe("pageItems", {
            provider: {
                url: "<c:url value="/employee/info"/>",
                pageSize: 15
            }
        });

        model.widgetConfig({
            /*              pagerExample: {
             $type: "Pager",
             bind: "pageItems"
             },*/
            employeeTable: {
                $type: "table",
                bind: "item in pageItems",
                currentPageOnly: true,
                showHeader: true,
                renderCell:function (self,arg) {
                    if(arg.column._property == "status"){
                        var status = arg.item._data.status;
                        console.info(arg.dom);
                        console.info($(arg.dom).text());
                    }
                    if(arg.column._property == "userName"){
                        if(arg.item.get("userName") == undefined){
                            arg.item.set("userName",arg.item.get("remarks") )
                        }
                    }

                    if(arg.column._property == "userPhone"){
                        //debugger
                        if(arg.item.get("userPhone") == undefined){
                            arg.item.set("userPhone",arg.item.get("userId") )
                        }
                    }
                },
                columns: [
                    {
                        width: "40px",
                        $type: "select",
                    },{
                        caption: "员工姓名",
                        bind: ".userName",
                        align: "center"

                    },{
                        caption: "手机号码",
                        bind: ".userPhone",
                        align: "center"
                    },
                    /*{
                     caption: "所在部门",
                     bind: ".deptName",
                     align: "center"
                     },{
                     caption: "角色",
                     bind: ".roleName",
                     align: "center"

                     },*/
                    {
                        caption: "加入时间",
                        bind: ".createTimeStr",
                        align: "center"

                    },{
                        caption: "状态",
                        bind: ".statusView",
                        align: "center"
                    }
                ]
            }
        });
    });
    $('.button').popup({
        hoverable  : true
    });
    $('.table_contant, .table_contant>table').height($(document.body).height()-100);
    $('.table_contant>table').css('overflow-x','scroll');
    $(window).bind("resize", function(e){
        $('.table_contant, .table_contant>table').height($(document.body).height()-100)
    });
</script>
</body>
</html>
