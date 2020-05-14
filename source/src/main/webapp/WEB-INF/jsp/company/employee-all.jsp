<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>员工信息</title>
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <link rel="stylesheet" type="text/css" href="/resources/business/order-table.css?v=7367cb39d5">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">
    <style>
        .table_contant{
            overflow-y: auto;
        }
        .allowInp input{
            background: #efeeee !important;
            cursor: not-allowed;
        }
        table tr {
            height: 50px;
        }

        .td_1 {
            width: 200px;
            text-align: center;
            font-weight: bold;
        }

        .td_2 {
            width: 400px;
            padding-left: 50px;
        }

        input[type="checkbox"] {
            visibility: visible;
        }

        table input {
            margin-right: 10px;
        }

        .dyz_dialog_title {
            background: #589fe7;
            line-height: 54px;
            padding-left: 20px;
            font-weight: 600;
            color: #fff;
        }

        i.icon.close:before {
            font-size: 20px;

        }

        #flowShow2Div i.icon.close:before, #flowShow1Div i.icon.close:before {
            color: #ccc;
        }

        .ui.dialog .close-btn {
            top: 1rem;
            right: 1rem;
            background: transparent;
        }

        .ui.blue.buttons .button,
        .ui.blue.button {
            background-color: #589fe7;
        }

        .order-Pager {
            margin: 10px 0px 0px 0px !important;
            float: right;
            border: none !important;
            box-shadow: none !important;
        }

        .fields {
            margin-bottom: 15px;
        }

        .emCls {
            font-style: normal;
            color: red;
            width: 10px;
            font-size: 12px;
            display: inline-block;
        }

        .progress_invite {
            background: url("/resources/images/progress_invite.png") center center no-repeat;
            width: 100%;
            height: 55px;
            margin-bottom: 80px;
        }
    </style>
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
    <script src="/resources/business/util.js?v=cee3a7629a"></script>
    <script src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
    <script src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
    <script src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
    <script src="/resources/cola-ui/i18n/zh-CN/cola.js?v=40433415fd"></script>
    <script>
        var createUrl="/employee/addEmployee";
        var modifyUrl="/employee/modifyPermission";
        var updateUrl="/employee/updateEmployee";
        var inviteUrl="/employee/inviteEmployee";
        var delUrl= "/employee/delEmployee";
        var leaveUrl= "/employee/updateEmployeeByParam";
        var getMenuIdUrl="/employee/getMenuIdInitByIndustry";
        function saveRole() {
            var arr = $("#adjustMent").find("input[type='checkbox']:checked");
            var menuId = "";
            if (!arr && arr.length == 0) {
                return;
            }
            $("#adjustMent").find("input[type='checkbox']:checked").each(function () {
                if (menuId.length > 0) {
                    menuId += ',' + $(this).attr('value');
                } else {
                    menuId += $(this).attr('value');
                }
            });
            $.ajax({
                url: modifyUrl,
                type: "post",
                dataType: "json",
                data: {
                    userKey: $("#selUserKey").val(),
                    menuId: menuId
                },
                success: function (arr) {
                    $("<div class='tips_contants'>").fadeIn(250).html("调整权限设置成功").delay(1000).fadeOut(250).appendTo('body');
                    window.location.reload();
                },
                error: function () {
                    $("<div class='tips_contants'>").fadeIn(250).html("调整权限设置失败").delay(1000).fadeOut(250).appendTo('body');
                }
            })
        }
        function closeAdjust() {
            $("#adjustMent").css({display: 'none'});
            $("#adjustMent").find("input[type='checkbox']").not(':disabled').removeAttr("checked");
        }

        $(function () {
            $.ajax({
                url: getMenuIdUrl,
                type: "post",
                dataType: "json",
                success: function (arr) {
//                    tbRole menuId  menuName
                    if (arr && arr.length > 0) {
                        var arrdt = "";
                        for (var i = 0; i < arr.length; i++) {
                            $("#adjustMent").find("input[value='" + arr[i] + "']").parents("tr").show();
                            var temp = arr[i].menuName;
                            if (temp.indexOf("工作台") >= 0) {
                                arrdt += '  <tr >' +
                                    '<td class="td_1">' + arr[i].menuName + '</td>' +
                                    '   <td class="td_2" field="ck"><input type="checkbox" checked disabled name="ck" value="' + arr[i].menuId + '" id="ck1"  /><label' +
                                    'for="ck1">' + arr[i].menuName + '</label></td> </tr>';
                            } else {
                                arrdt += '  <tr >' +
                                    '<td class="td_1">' + arr[i].menuName + '</td>' +
                                    '   <td class="td_2" field="ck"><input type="checkbox" name="ck" value="' + arr[i].menuId + '" id="ck1"  /><label' +
                                    'for="ck1">' + arr[i].menuName + '</label></td> </tr>';
                            }

                        }
                        $("#tbRole").html(arrdt);
                    }
                }
            })
        });
        //"para":paraArray.join(),
        //"id":"1"
        cola(function (model) {
            /*            model.describe({
             name: {
             validators: "required"
             },
             phone: {
             validators: "required"
             /!*dataType: "int",
             validators: [
             "required", {
             $type: "number",
             min: 16,
             max: 60
             }
             ]*!/
             }
             });*/
            model.describe("pageItems", {
                provider: {
                    url: "/employee/info",
                    pageSize: 100
                }
            });
//            //当前公司的所有部门
//            model.describe("departments", {
//                provider: "/department/select-info"
//            });
//            //当前公司的所有角色
//            model.describe("role", {
//                provider: "/system/role/select-info"
//            });
            model.set(
                "addemployee", {
                    name: "",
                    phone: "",
                    invoiceDate:"",
                    birthday: "",
                    idNumber:"",
                    baseSalary: "",
                    otherRevenue:""
                }
            );
            model.set(
                "employee", {
                    name: "",
                    phone: "",
                    userId: "",
                    entryDate: "",
                    birthday: "",
                    idNumber: "",
                    userKey: "",
                    employeeId: "",
                    baseSalary: "",
                    otherRevenue: ""
                }
            );
            model.set("employee.entryDate", new Date());
            model.widgetConfig({
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
                modDeptDrop: {
                    $type: "Dropdown",
                    items: "{{departments}}",
                    icon: "dropdown icon iconfont",
                    placeholder: "选择部门",
                    popup: "选择部门",
                    change: function (self, arg) {
                        model.set("modDeptId", arg.value);
                    }
                },

//                pagerExample: {
//                    $type: "Pager",
//                    bind: "pageItems"
//                },


            });
            model.action({
                //打开邀请员工窗口
                changeMain: function () {
                    createTable();
                },
                openEmp: function (btn) {
                    $("#reg_tips").hide();

                    cola.widget("addEmpDiv").show();
                },
                createEmp: function (item) {
                    model.set(
                        "employee", {
                            name: item.get("userName"),
                            phone: item.get("userId"),
                            userId: item.get("userId"),
                            entryDate: item.get("entryDate"),
                            birthday: item.get("birthday"),
                            idNumber: item.get("idNumber"),
                            userKey: item.get("userKey"),
                            baseSalary: item.get("baseSalary"),
                            otherRevenue: item.get("otherRevenue")
                        }
                    );
                    $("#reg_tips").hide();
                    cola.widget("createEmpDiv").show();
                },
                openAdjust: function (rowItem) {
                    var menuId = rowItem.get("menuId");
                    var userKey = rowItem.get("userKey");
//                var menuId=$(o).parent().prev("input").data("id");
//                var userKey=$(o).parent().prev("input").data("iu");

                    var arr = menuId.split(",");

                    $("#selUserKey").val(userKey);
                    if(userKey==""){
                        $("<div class='tips_contants'>").fadeIn(250).html("未加入公司不能调整权限！").delay(1000).fadeOut(250).appendTo('body');
                        return;
                    }

                    if (arr && arr.length > 0) {
                        for (var i = 0; i < arr.length; i++) {
                            $("#adjustMent").find("input[value='" + arr[i] + "']").prop("checked", true);
                        }
                    } else {
                        $("#adjustMent").find("input[type='checkbox']").not(':disabled').prop("checked", false);
                    }
                    $("#adjustMent").css({display: 'block'});
                },
                flowShow2: function (btn) {
                    cola.widget("flowShow2Div").show();
                },
                flowShow1: function (btn) {
                    cola.widget("flowShow1Div").show();
                },
                inviteEmp: function (item) {
                    model.set(
                        "invite", {
                            userName: item.get("userName"),
                            userPhone: item.get("userId")
                        }
                    );
                    if(item.get("status")=="3"){
                        $("<div class='tips_contants'>").fadeIn(250).html("该员工已加入企业！").delay(1000).fadeOut(250).appendTo('body');
                        return;
                    }
                    $("#reg_tips").hide();
                    cola.widget("inviteEmpDiv").show();
                },
                leaveEmp: function (item) {
                    model.set(
                        "leaveEmp", {
                            employeeId: item.get("employeeId")
                        }
                    );
                    $("#reg_tips").hide();
                    cola.widget("leaveEmpDiv").show();
                },
                removeEmp: function (item) {
                    console.log(item.get("userKey"));
                    model.set(
                        "removeData", {
                            employeeId: item.get("employeeId")
                        }
                    );
                    cola.widget("removeEmpDiv").show();
                },

                //关闭邀请员工窗口
                closeEmp: function (btn) {
                    $("#reg_tips").hide();
                    cola.widget("addEmpDiv").hide();
                    cola.widget("removeEmpDiv").hide();
                    cola.widget("createEmpDiv").hide();
                    cola.widget("inviteEmpDiv").hide();
                    cola.widget("leaveEmpDiv").hide();
                    cola.widget("flowShow1Div").hide();
                    cola.widget("flowShow2Div").hide();
                },
                createBtnEmp: function (btn) {
                    btn.set("disabled", true);
                    btn.set("state", "loading");
                    var name = model.get("addemployee.name");
                    var phone = model.get("addemployee.phone");
                    if (name == undefined || name == "") {
                        $("<div class='tips_contants'>").fadeIn(250).html("请填写员工姓名！").delay(1000).fadeOut(250).appendTo('body');
                        btn.set("disabled", false);
                        btn.set("state", "");
                        return false;
                    }
                    if (phone == undefined || phone == "") {
                        $("<div class='tips_contants'>").fadeIn(250).html("请填写手机号码！").delay(1000).fadeOut(250).appendTo('body');
                        btn.set("disabled", false);
                        btn.set("state", "");
                        return false;
                    }
                    if (!util.checkPhone(phone)) {
                        $("<div class='tips_contants'>").fadeIn(250).html("手机号码格式错误！").delay(1000).fadeOut(250).appendTo('body');
                        btn.set("disabled", false);
                        btn.set("state", "");
                        return false;
                    }
//                    var invoiceDat=model.get("invoiceDate");
//                    if(!(invoiceDat==null || invoiceDat=="")){
//                        invoiceDat= invoiceDat.Format("yyyy-MM-dd");
//                    }
                    var saveData =  model.get("addemployee").toJSON();

                    $.ajax({
                        url: createUrl,
                        type: "post",
                        data: JSON.stringify(saveData),
                        dataType: "json",
                        contentType: "application/json",
                        success: function (data) {
                            /* var data = eval("(" + callback + ")"); */
                            if (data.code == '1') {
                                /*deptId;*/
                                $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(1000).fadeOut(250).appendTo('body');
//                                model.flush("pageItems");
                                setTimeout(function () {
                                    window.location.reload();
//                                    model.action("closeEmp")();
//                                    btn.set("disabled", false);
//                                    btn.set("state", "");
//                                    model.set("userName", "");
//                                    model.set("userPhone", "");
                                }, 1000);
                            } else {
                                $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(1000).fadeOut(250).appendTo('body');
                                btn.set("disabled", false);
                                btn.set("state", "");
                            }
                        }}
                    );
                    //
                },
                saveBtnEmp: function (btn) {
                    btn.set("disabled", true);
                    btn.set("state", "loading");
                    var name = model.get("employee.name");
                    var phone = model.get("employee.phone");
                    if (name == undefined || name == "") {
                        $("<div class='tips_contants'>").fadeIn(250).html("请填写员工姓名！").delay(1000).fadeOut(250).appendTo('body');
                        btn.set("disabled", false);
                        btn.set("state", "");
                        return false;
                    }
                    if (phone == undefined || phone == "") {
                        $("<div class='tips_contants'>").fadeIn(250).html("请填写手机号码！").delay(1000).fadeOut(250).appendTo('body');
                        btn.set("disabled", false);
                        btn.set("state", "");
                        return false;
                    }
                    if (!util.checkPhone(phone)) {
                        $("<div class='tips_contants'>").fadeIn(250).html("手机号码格式错误！").delay(1000).fadeOut(250).appendTo('body');
                        btn.set("disabled", false);
                        btn.set("state", "");
                        return false;
                    }
//                    var invoicedat1=model.get("employee.invoiceDate");
//                    if(!(invoicedat1==null || invoicedat1=="")){
//                        invoicedat1=new Date(invoicedat1).Format("yyyy-MM-dd");
//                    }

                    var saveData={};
                     saveData=   model.get("employee").toJSON();
                    $.ajax({
                        url: updateUrl,
                        type: "post",
                        data: JSON.stringify(saveData),
                        dataType: "json",
                        contentType: "application/json",
                        success: function (data) {
                            if (data.code == '1') {
                                /*deptId;*/
                                $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(1000).fadeOut(250).appendTo('body');
//                                model.flush("pageItems");
                                setTimeout(function () {
                                    window.location.reload();
//                                    model.action("closeEmp")();
//                                    btn.set("disabled", false);
//                                    btn.set("state", "");
//                                    model.set("employee.name", "");
//                                    model.set("employee.phone", "");
                                }, 1000);
                            } else {
                                $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(1000).fadeOut(250).appendTo('body');
                                btn.set("disabled", false);
                                btn.set("state", "");
                            }
                        }
                    })

                    //
                },
                inviteBtnEmp: function (btn) {
                    btn.set("disabled", true);
                    btn.set("state", "loading");
                    var name = model.get("invite.userName");
                    var phone = model.get("invite.userPhone");
                    if (name == undefined || name == "") {
                        $("<div class='tips_contants'>").fadeIn(250).html("请填写员工姓名！").delay(1000).fadeOut(250).appendTo('body');
                        btn.set("disabled", false);
                        btn.set("state", "");
                        return false;
                    }
                    if (phone == undefined || phone == "") {
                        $("<div class='tips_contants'>").fadeIn(250).html("请填写手机号码！").delay(1000).fadeOut(250).appendTo('body');
                        btn.set("disabled", false);
                        btn.set("state", "");
                        return false;
                    }
                    if (!util.checkPhone(phone)) {
                        $("<div class='tips_contants'>").fadeIn(250).html("手机号码格式错误！").delay(1000).fadeOut(250).appendTo('body');
                        btn.set("disabled", false);
                        btn.set("state", "");
                        return false;
                    }
                    $.post(
                   inviteUrl,
                        {
                            name: name,
                            userId: phone,
                            deptId: "002",
                            roleKey: "003"
                        },
                        function (callBack) {
                            var data = eval("(" + callBack + ")");
                            if (data.code == '1') {
                                /*deptId;*/
                                $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(1000).fadeOut(250).appendTo('body');
                                model.flush("pageItems");
                                setTimeout(function () {
                                    model.action("closeEmp")();
                                    btn.set("disabled", false);
                                    btn.set("state", "");
                                    model.set("invite.userName", "");
                                    model.set("invite.userPhone", "");
                                }, 1000);
                            } else {
                                $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(1000).fadeOut(250).appendTo('body');
                                btn.set("disabled", false);
                                btn.set("state", "");
                            }
                        }
                    );
                    //
                },
                removeBtnEmp: function (btn) {
                    btn.set("disabled", true);
                    btn.set("state", "loading");
                    $.post(
                       delUrl,
                        {
                            employeeId:model.get("removeData.employeeId")
                        },
                        function (callback) {
                            var data = eval("(" + callback + ")");
                            if (data.code == '1') {
                                /*deptId;*/
                                $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(1000).fadeOut(250).appendTo('body');
                                model.flush("pageItems");
                                setTimeout(function () {
                                    model.action("closeEmp")();
                                    btn.set("disabled", false);
                                    btn.set("state", "");
                                }, 1000);
                            } else {
                                $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(1000).fadeOut(250).appendTo('body');
                                btn.set("disabled", false);
                                btn.set("state", "");
                            }
                        }
                    );
                    //
                },
                leaveBtnEmp: function (btn) {
                    btn.set("disabled", true);
                    btn.set("state", "loading");
                    $.ajax({
                        url: leaveUrl+"?employeeId="+model.get("leaveEmp.employeeId")+"&operType=4",
                        type: "put",
                        dataType: "json",
                        contentType: "application/json",
                        success: function (data) {
                            if (data.code == '1') {
                                $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(1000).fadeOut(250).appendTo('body');
                                model.flush("pageItems");
                                setTimeout(function () {
                                    model.action("closeEmp")();
                                    btn.set("disabled", false);
                                    btn.set("state", "");
                                }, 1000);
                            } else {
                                $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(1000).fadeOut(250).appendTo('body');
                                btn.set("disabled", false);
                                btn.set("state", "");
                            }
                        }
                    })
                },

                //打开修改部门弹窗
                modDept: function (btn) {
                    var pageItems = model.get("pageItems");
                    var slt_emp = [];
                    pageItems.each(function (element, index) {
                        if (element.get("selected")) {
                            slt_emp.push(element);
                        }
                    });
                    if (slt_emp.length == 0) {
                        $("<div class='tips_contants'>").fadeIn(250).html("请选择需要调整的员工").delay(1000).fadeOut(250).appendTo('body');
                        return false;
                    }
                    $("#mod_dept_user").children().remove();
                    $(slt_emp).each(function (index) {
                        if (index >= 2) {
                            $("#mod_dept_user").append("<span data-value='" + this.get("userKey") + "'>" + this.get("userName") + "...</span>");

                        } else {
                            $("#mod_dept_user").append("<span data-value='" + this.get("userKey") + "'>" + this.get("userName") + "&nbsp;&nbsp;</span>");
                        }
                    });
                    model.set("slt_emp", JSON.stringify(slt_emp));
                    cola.widget("modDeptDiv").show();
                },
                //关闭修改部门弹窗
                closeModDept: function (btn) {
                    $("#mod_dept_user").children().remove();
                    model.set("slt_emp", "");
                    cola.widget("modDeptDiv").hide();
                },
                //修改员工部门
//                sureModDept: function (btn) {
//                    btn.set("disabled", true);
//                    btn.set("state", "loading");
//                    /*model.get("slt_emp").each(function(element,index){});*/
//                    var slt_userKeys = [];
//                    var slt_emp = eval("(" + model.get("slt_emp") + ")");
//                    $(slt_emp).each(function () {
//                        slt_userKeys.push(this.userKey);
//                    });
//                    $.ajax({
//                        url: "/employee/changeDept",
//                        type: "post",
//                        dataType: "json",
//                        data: {
//                            users: slt_userKeys.join(),
//                            modDeptId: model.get("modDeptId")
//                        },
//                        traditional: true,
//                        success: function (data) {
//                            $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(1000).fadeOut(250).appendTo('body');
//                            if (data.state == "1") {
//                                model.flush("pageItems");
//                                setTimeout(function () {
//                                    model.action("closeModDept")();
//                                }, 1000);
//                            }
//                            btn.set("disabled", false);
//                            btn.set("state", "");
//                        }
//                    })
//                },

                //打开调整角色弹窗
                openModRole: function (btn) {
                    var pageItems = model.get("pageItems");
                    var slt_emp = [];
                    pageItems.each(function (element, index) {
                        if (element.get("selected")) {
                            slt_emp.push(element);
                        }
                    });
                    if (slt_emp.length == 0) {
                        $("<div class='tips_contants'>").fadeIn(250).html("请选择需要调整的员工").delay(1000).fadeOut(250).appendTo('body');
                        return false;
                    }
                    $("#mod_role_user").children().remove();
                    $(slt_emp).each(function (index) {
                        if (index >= 2) {
                            $("#mod_role_user").append("<span data-value='" + this.get("userKey") + "'>" + this.get("userName") + "...</span>");

                        } else {
                            $("#mod_role_user").append("<span data-value='" + this.get("userKey") + "'>" + this.get("userName") + "&nbsp;&nbsp;</span>");
                        }
                    });
                    model.set("slt_emp", JSON.stringify(slt_emp));
                    cola.widget("modRoleDiv").show();
                },
                //关闭调整角色弹窗
                closeModRole: function (btn) {
                    cola.widget("modRoleDiv").hide();
                },
                //确认调整角色
                sureModRole: function (btn) {
                    btn.set("disabled", true);
                    btn.set("state", "loading");

                    var slt_userKeys = [];
                    var slt_emp = eval("(" + model.get("slt_emp") + ")");
                    $(slt_emp).each(function () {
                        slt_userKeys.push(this.userKey);
                    });
                    $.ajax({
                        url: "/employee/changeRole",
                        type: "post",
                        dataType: "json",
                        data: {
                            users: slt_userKeys.join(),
                            modRoleKey: model.get("modRoleKey")
                        },
                        traditional: true,
                        success: function (data) {
                            $("<div class='tips_contants'>").fadeIn(250).html(data.msg).delay(1000).fadeOut(250).appendTo('body');
                            if (data.state == "1") {
                                model.flush("pageItems");
                                setTimeout(function () {
                                    model.action("closeModRole")();
                                }, 1000);
                            }
                            btn.set("disabled", false);
                            btn.set("state", "");
                        }
                    })
                }
            })
            var table = new cola.Table({
//                employeeTable: {
                tag: "employeeTable",
                $type: "table",
                bind: "item in pageItems",
                currentPageOnly: true,
                showHeader: true,
                renderCell: function (self, arg) {
                    if (arg.column._property == "status") {
                        var status = arg.item._data.status;
                    }
                    if (arg.column._property == "userName") {
                        if (arg.item.get("userName") == undefined) {
                            arg.item.set("userName", arg.item.get("remarks"))
                        }
                    }

                    if (arg.column._property == "userPhone") {
                        if (arg.item.get("userPhone") == undefined) {
                            arg.item.set("userPhone", arg.item.get("userId"))
                        }
                    }
                    if (arg.column._property == "roleShow") {

                        var menuId = arg.item.get("menuId");
                        var isAdmin = arg.item.get("isAdmin");
                        var isBoss = arg.item.get("isBoss");
                        var userKey = arg.item.get("userKey");
                        var status = arg.item.get("status");
                        if (isAdmin === "1" || isBoss === "1") {
                            $(arg.dom).html("");
                            return false;
                        } else {
                        }
                    }
                },
                columns: [
//                        {
//                            width: "40px",
//                            $type: "select"
//                        },
                    {
                        caption: "员工姓名",
                        bind: ".userName",
                        align: "center"

                    }, {
                        caption: "手机号码",
                        bind: ".userPhone",
                        width: "150px",
                        align: "center"
                    },
                    /*{
                     caption: "所在部门",
                     bind: ".deptName",
                     align: "center"
                     }, {
                     caption: "角色",
                     bind: ".roleName",
                     align: "center"
                     }, */
                    {
                        caption: "入职日期",
                        bind: ".entryDate",
                        align: "center"

                    },
                    {
                        caption: "加入时间",
                        bind: ".createTime",
                        align: "center"

                    }, {
                        caption: "状态",
                        bind: ".statusView",
                        width: "80px",
                        align: "center"
                    }, {
                        caption: "操作",
                        align: "center",
                        bind: ".roleShow",
                        template: "operations1"
                    }
                ]
            });
            var createTable = function () {
                var businessDescTemplate = $.xCreate({
                    tagName: "div",
                    content: [{
                        tagName: "a",

                        "c-onclick": "openAdjust(item)",
                        style: "color:#589fe7;margin-right:5px;",
                        content: "调整权限{{item.userName}}",
                    }, {
                        tagName: "a",
                        "c-onclick": "createEmp(item)",
                        "c-widget": "link;",
                        style: "color:#589fe7;margin-right:5px;",
                        content: "修改"
                    }, {
                        tagName: "a",
                        "c-onclick": "inviteEmp(item)",
                        "c-widget": "link;",
                        style: "color:#589fe7;margin-right:5px;",
                        content: "邀请员工"
                    }, {
                        tagName: "a",
                        "c-onclick": "leaveEmp(item)",
                        "c-widget": "link;",
                        style: "color:#589fe7;margin-right:5px;",
                        content: "离职"
                    }]
                });
//                , {
//                    tagName: "a",
//                        "c-widget": "link;",
//                        "c-onclick": "removeEmp(item)",
//                        style: "color:#589fe7",
//                        content: "移除员工"
//                }
                table.regTemplate("operations1", businessDescTemplate);
                $("#employeeTable").append(table.getDom());
            }
        });
        $('.table_contant, .table_contant>table').height($(document.body).height() - 100);
        $('.table_contant>table').css('overflow-x', 'scroll');
        $(window).bind("resize", function (e) {
            $('.table_contant, .table_contant>table').height($(document.body).height() - 100)
        });
        cola.on("ready", function () {
            cola.model().action("changeMain")();
        })
        $('.table_contant, .table_contant>table').height($(document.body).height() - 98);
        $('.table_contant>table').css('overflow-x', 'scroll');
        $(window).bind("resize", function (e) {
            $('.table_contant, .table_contant>table').height($(document.body).height() - 98)
        });
        //禁止返回上一页
        window.onload = function () {
            window.history.pushState(null, null, document.URL);
            window.addEventListener('popstate', function () {
                history.pushState(null, null, document.URL);
            });

        };
        $(function () {
            $('.not_tips').popup({
                hoverable: true
            });
//            $("[data-toggle='popover']").popover();
        });
        function jumpNew() {
            window.open("/openPage?pageName=company-main");
        }
    </script>
</head>
<body style="padding: 10px 0px">
<input type="hidden" value="" id="selUserKey">
<div class="v-box">

    <h4 class="user_list">
        <%--<span>人员列表暂时只对管理员和法人代表开放，未来会考虑对内部人员开放。</span>--%>
        <div style="padding-left:12px;font-size:12px;color:#767676;"><span style="font-size:16px;">企业员工</span><span
                style="margin-left: 10px;">管理员/法人拥有所有权限</span>
            <span style="margin-left: 10px;cursor: pointer;  color: #ffb02f;" c-onclick="flowShow1()">创建员工流程<i
                    class="iconfont not_tips"></i></span>
            <span style="margin-left: 30px;cursor: pointer;  color: #ffb02f;" c-onclick="flowShow2()">邀请员工流程<i
                    class="iconfont not_tips"></i></span>
        </div>


        <div class="field button-right" style="top: -5px;">


            <div c-widget="button;color:blue;caption:创建员工;click:openEmp" style="background: #589fe7"></div>

            <%--<div c-widget="button;color:blue;caption:调整部门;click:modDept" style="background: #589fe7"></div>--%>
            <%--<div c-widget="button;color:blue;caption:调整角色;click:openModRole" style="background: #589fe7"></div>--%>
        </div>
    </h4>
    <div class="table_contant" id="employeeTable">
        <template name="operations">
            <div>
                <a c-widget="link; href:###">查看编辑权限</a>
                <a c-widget="link; href:###">注销账号</a>
                <%-- <a c-widget="link;"  onclick="openAdjust()" style="color:#589fe7">调整权限</a>--%>
            </div>
        </template>
        <%--<template name="operations1">--%>
        <%--<div>--%>


        <%--</div>--%>
        <%--</template>--%>
    </div>

</div>
<div id="addEmpDiv" c-widget="Dialog; width:660px;height:510px;closeable:true">
    <div class="dyz_dialog_title">创建企业员工</div>
    <div class="content" style="padding-top:40px;">
        <div c-widget="form" style="width: 420px;margin: auto">
            <div class="fields">
                <div style="width: 120px;">
                    <span class="fontSize14A" style="margin-left:-10px;"><em class="emCls">*</em>员工姓名</span>
                </div>
                <div style="width:300px;" c-widget="input;bind:addemployee.name;placeholder:请填写员工姓名"></div>
            </div>
            <div class="fields">
                <div style="width: 120px;">
                    <span class="fontSize14A" style="margin-left:-10px;"><em class="emCls">*</em>手机号码</span>
                </div>
                <div style="width:300px;" c-widget="input;bind:addemployee.phone;maxlength:11;placeholder:请填写手机号码"></div>
            </div>
            <div class="fields">
                <div style="width: 120px;">
                    <span class="fontSize14A">入职时间</span>
                </div>
                <div style="width:300px;"
                     c-widget="DatePicker;bind:addemployee.entryDate;placeholder:请选择入职时间;tag:invoiceDate;icon:iconfount calendar iconfont;"></div>
            </div>
            <div class="fields">
                <div style="width: 120px;">
                    <span class="fontSize14A">出生日期</span>
                </div>
                <div style="width:300px;"
                     c-widget="DatePicker;bind:addemployee.birthday;placeholder:请选择出生日期;tag:invoiceDate1;icon:iconfount calendar iconfont;"></div>
            </div>
            <div class="fields">
                <div style="width: 120px;">
                    <span class="fontSize14A">身份证号码</span>
                </div>
                <div style="width:300px;" c-widget="input;bind:addemployee.idNumber;placeholder:请填写身份证号码;"></div>
            </div>
            <div class="fields">
                <div style="width: 120px;">
                    <span class="fontSize14A">基本工资</span>
                </div>
                <div style="width:300px;" c-widget="input;bind:addemployee.baseSalary;placeholder:请填写基本工资"></div>
            </div>
            <div class="fields">
                <div style="width: 120px;">
                    <span class="fontSize14A">其他补贴</span>
                </div>
                <div style="width:300px;" c-widget="input;bind:addemployee.otherRevenue;placeholder:例如：电话费"></div>
            </div>

            <div class="reg_tips" style="margin-bottom: 1rem;display: none">
                该手机用户<span style="color:red">已注册</span>,让他通过<span style="color:#2e8ae6;cursor: pointer"
                                                                  onclick="jumpNew()">内部邀请码</span>自主加入
            </div>
        </div>

        <div style="position: absolute;
    bottom: 10px;
    right: 10px;">
            <div c-widget="button;color:blue;caption:保存;click:createBtnEmp"
                 style="float: right;width: 80px;padding: 0px"></div>
            <div c-widget="button; caption:取消;click:closeEmp" style="    margin-right: 10px;
    float: right;
    width: 80px;
    padding: 0;"></div>
        </div>
    </div>
</div>
<div id="createEmpDiv" c-widget="Dialog; width:660px;height:510px;closeable:true">
    <div class="dyz_dialog_title createEmpDiv">修改企业员工</div>
    <div class="content" style="padding-top:40px;">
        <div c-widget="form" style="width: 420px;margin: auto">
            <div class="fields">
                <div style="width: 120px;">
                    <span class="fontSize14A" style="margin-left:-10px;"><em class="emCls">*</em>员工姓名</span>
                </div>
                <div style="width:300px;" c-widget="input;bind:employee.name;placeholder:请填写员工姓名"></div>
            </div>
            <div class="fields">
                <div style="width: 120px;">
                    <span class="fontSize14A" style="margin-left:-10px;"><em class="emCls">*</em>手机号码</span>
                </div>
                <div style="width:300px;"
                     c-widget="input;bind:employee.phone;class:allowInp;maxlength:11;readonly;disabled;placeholder:请填写手机号码"></div>
            </div>
            <div class="fields">
                <div style="width: 120px;">
                    <span class="fontSize14A">入职时间</span>
                </div>
                <div style="width:300px;"
                     c-widget="DatePicker;bind:employee.entryDate;placeholder:请选择入职时间;tag:invoiceDate;icon:iconfount calendar iconfont;"></div>
            </div>
            <div class="fields">
                <div style="width: 120px;">
                    <span class="fontSize14A">出生日期</span>
                </div>
                <div style="width:300px;"
                     c-widget="DatePicker;bind:employee.birthday;placeholder:请选择出生日期;tag:invoiceDate1;icon:iconfount calendar iconfont;"></div>
            </div>
            <div class="fields">
                <div style="width: 120px;">
                    <span class="fontSize14A">身份证号码</span>
                </div>
                <div style="width:300px;" c-widget="input;bind:employee.idNumber;placeholder:请填写身份证号码;"></div>
            </div>
            <div class="fields">
                <div style="width: 120px;">
                    <span class="fontSize14A">基本工资</span>
                </div>
                <div style="width:300px;" c-widget="input;bind:employee.baseSalary;placeholder:请填写基本工资"></div>
            </div>
            <div class="fields">
                <div style="width: 120px;">
                    <span class="fontSize14A">其他补贴</span>
                </div>
                <div style="width:300px;" c-widget="input;bind:employee.otherRevenue;placeholder:例如：电话费"></div>
            </div>


        </div>

        <div style="position: absolute;
    bottom: 10px;
    right: 10px;">
            <div c-widget="button;color:blue;caption:保存;click:saveBtnEmp"
                 style="float: right;width: 80px;padding: 0px"></div>
            <div c-widget="button; caption:取消;click:closeEmp" style="    margin-right: 10px;
    float: right;
    width: 80px;
    padding: 0;"></div>
        </div>
    </div>
</div>
<div id="inviteEmpDiv" style="background: #fafafa;" c-widget="Dialog; width:660px;height:430px;closeable:true">
    <div class="dyz_dialog_title createEmpDiv">邀请员工使用系统</div>
    <div class="content" style="padding-top:40px;background: #fafafa">
        <div class="progress_invite"></div>
        <div c-widget="form" style="width: 420px;margin: auto">
            <div class="fields">
                <div style="width: 120px;">
                    <span class="fontSize14A" style="margin-left:-10px;"><em class="emCls">*</em>员工姓名</span>
                </div>
                <div c-bind="invite.userName" style="width:300px;line-height: 36px;" >*****************</div>
                <%--<div style="width:300px;" c-bind="invite.userName"></div>--%>
                <%--<div c-widget="input;bind:invite.userName;placeholder:请填写员工姓名"></div>--%>
            </div>
            <div class="fields">
                <div style="width: 120px;">
                    <span class="fontSize14A" style="margin-left:-10px;"><em class="emCls">*</em>手机号码</span>
                </div>
                <div style="width:300px;" c-widget="input;bind:invite.userPhone;class:allowInp;readonly;maxlength:11;placeholder:请填写手机号码"></div>
            </div>
            <%-- <div class="field">
                 <div id="deptDrop"></div>
             </div>
             <div class="field">
                 <div id="role_drop"></div>
             </div>--%>
            <div id="reg_tips" style="margin-bottom: 1rem;text-align:center;display: none">
                该手机用户<span style="color:red">已注册</span>,让他通过<span style="color:#2e8ae6;cursor: pointer"
                                                                  onclick="jumpNew()">内部邀请码</span>自主加入
            </div>
        </div>

        <div style="position: absolute;
    bottom: 10px;
    right: 10px;">
            <div c-widget="button;color:blue;caption:发送;click:inviteBtnEmp"
                 style="float: right;width: 80px;padding: 0px"></div>
            <div c-widget="button; caption:取消;click:closeEmp" style="    margin-right: 10px;
    float: right;
    width: 80px;
    padding: 0;"></div>
        </div>
    </div>
</div>
<div id="leaveEmpDiv" style="background: #fafafa;" c-widget="Dialog; width:360px;height:250px;closeable:true">
    <div class="dyz_dialog_title createEmpDiv">删除</div>
    <div class="content" style="padding-top:40px;background: #fafafa">
        <div class="" style="    text-align: center;
    position: relative;
    margin: 0 auto;
    font-size: 16px;
    font-weight: normal;
    color: #44ae80;
    height: 30px;
    line-height: 30px;">确定要操作么，执行后员工将会被彻底删除 </div>
        <div style="position: absolute;
    bottom: 10px;
    right: 10px;">
            <div c-widget="button;color:blue;caption:确定;click:leaveBtnEmp"
                 style="float: right;width: 80px;padding: 0px"></div>
            <div c-widget="button; caption:取消;click:closeEmp" style="    margin-right: 10px;
    float: right;
    width: 80px;
    padding: 0;"></div>
        </div>
    </div>
</div>
<div id="removeEmpDiv" c-widget="Dialog; width:335px;height:190px;closeable:true">
    <div class="dyz_dialog_title createEmpDiv">移除员工</div>
    <div class="content" style="padding-top:10px;margin: auto">
        <div c-widget="form" style="width: 335px;margin: auto">
            <div class="fields" style="    margin-top: 1rem;
    text-align: center;
    font-size: 16px;
    margin-bottom: .5rem;
    display: block;">
                <span style="">确认要移除此员工？</span>
            </div>
            <div class="fields" style="    margin-bottom: 1rem;
    text-align: center;
    display: block;font-size:12px;
    color: #ffb02f;">
                <span style="">被移除的员工不影响历史订单数据</span>
            </div>
        </div>
        <div style="position: absolute;
    bottom: 10px;
    right: 10px;">
            <div c-widget="button;color:blue;caption:确认;click:removeBtnEmp"
                 style="float: right;width: 80px;padding: 0px"></div>
            <div c-widget="button; caption:取消;click:closeEmp" style="    margin-right: 10px;
    float: right;
    width: 80px;
    padding: 0;"></div>
        </div>
    </div>
</div>
<div id="flowShow2Div" c-widget="Dialog; width:590px;height:190px;closeable:true">
    <div class="dyz_dialog_title createEmpDiv" style="color:#666;background: #fff;">邀请员工流程</div>
    <div class="content" style="padding:0;margin: auto">
        <div style="    background: url('/resources/images/flowinvite2.png') center center no-repeat;
    width: 100%;
    height: 39px;
    margin-top: 40px;"></div>


    </div>
</div>
<div id="flowShow1Div" c-widget="Dialog; width:590px;height:190px;closeable:true">
    <div class="dyz_dialog_title createEmpDiv" style="color:#666;background: #fff;">创建员工流程</div>
    <div class="content" style="padding:0;margin: auto">

        <div style="    background: url('/resources/images/flowinvite1.png') center center no-repeat;
    width: 100%;
    height: 39px;
    margin-top: 40px;"></div>
    </div>
</div>
<div id="adjustMent"
     style="width: 100%;height: 100%;background:#fff;position:absolute;top:0;cursor:pointer;display:none;">
    <div style="float: left; font-size:22px; margin-top:10px; margin-left:10px;">设置员工权限</div>
    <div style="margin: 50px auto;width: 600px;">
        <div style="height: 50px;line-height: 50px;/*border-bottom: 1px solid #ccc*/;">
            <%--<div style="float: left;">设置员工权限</div>--%>
            <div c-widget="button;color:blue; caption:保存;" onclick="saveRole()"
                 style="float:left;margin-top:8px;"></div>
            <div c-widget="button; caption:取消;" onclick="closeAdjust()"
                 style="float:left;margin-top:8px; margin-left:0.25rem;"></div>
        </div>
        <%--<div style="line-height: 50px;padding-left:50px;">员工：</div><span></span>--%>
        <table id="tbRole" border="1" cellspacing="0" cellpadding="0" style=" margin:0 auto; border:1px solid #ccc;">
            <%--//["1-00","1-04","1-01","1-CP","1-BDC"]--%>


        </table>
    </div>
</div>

<%--调整部门--%>

<%--调整角色--%>
<%--<div id="modDeptDiv" c-widget="Dialog; width:450px;closeable:false">--%>
<%--<div class="content">--%>
<%--<div class="description">--%>
<%--<div class="ui header">调整部门</div>--%>

<%--<div c-widget="form">--%>
<%--<div id="mod_dept_user" class="field">--%>

<%--</div>--%>
<%--<div class="field">--%>
<%--<div id="modDeptDrop"></div>--%>
<%--</div>--%>
<%--</div>--%>

<%--</div>--%>
<%--</div>--%>
<%--<div class="actions">--%>
<%--<div c-widget="button; caption:取消;click:closeModDept"></div>--%>
<%--<div c-widget="button;color:blue; caption:确定;click:sureModDept"></div>--%>
<%--</div>--%>
<%--</div>--%>
<%--<div id="modRoleDiv" c-widget="Dialog; width:450px;closeable:false">--%>
<%--<div class="content">--%>
<%--<div class="description">--%>
<%--<div class="ui header">调整角色</div>--%>
<%--<div c-widget="form">--%>
<%--<div id="mod_role_user" class="field"></div>--%>
<%--<div class="field">--%>
<%--<div id="modRoleDrop"></div>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<%--<div class="actions">--%>
<%--<div c-widget="button; caption:取消;click:closeModRole"></div>--%>
<%--<div c-widget="button;color:blue;caption:确定;click:sureModRole"></div>--%>
<%--</div>--%>
<%--</div>--%>


</body>
</html>
