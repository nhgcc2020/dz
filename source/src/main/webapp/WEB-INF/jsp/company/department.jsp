<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script src="/resources/cola-ui/i18n/zh-CN/cola.js?v=40433415fd"></script>

    <link rel="stylesheet" type="text/css" href="/resources/business/order-table.css?v=7367cb39d5">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">         <%--//全局图标样式--%>
    <style>
        i.icon.close:before {
            content: "\f00d";
            font-size: 20px;
        }
    </style>
    <script type="text/javascript">
        cola(function(model) {

            model.describe("pageItems", {
                provider: {
                    url: "<c:url value="/department/info"/>",
                    pageSize: 30
                }
            });
            model.widgetConfig({
                pagerExample: {
                    $type: "Pager",
                    bind: "pageItems"
                },
                deptTable: {
                    $type: "Table",
                    bind: "pageItems",
                    showHeader: true,
                    currentPageOnly: true,
                    columns: [
                        {
                            width: "40px",
                            $type: "select",
                        },{
                        caption: "部门编号",
                        bind: ".deptId",
                        width: "100px"
                    },{
                       bind: ".deptName",
                       caption: "部门名称"
                    }]
                }
            });



            model.set("addDeptM",{deptName:""});

            model.action({
                modDept_open: function(item) {
                    var items = cola.widget("deptTable").getItems();
                    var sltArray = new Array();
                    items.each(function(element,index){
                        if(element.get("selected")){
                            sltArray.push(element);
                        }
                    });

                    if(sltArray.length > 1){
                        $("<div class='tips_contants'>").fadeIn(250).html("不支持多部门修改").delay(2000).fadeOut(250).appendTo('body');
                    }else if(sltArray.length == 0){
                        $("<div class='tips_contants'>").fadeIn(250).html("请选择您需要修改的部门").delay(2000).fadeOut(250).appendTo('body');
                    }else{
                         model.set("modDept",{
                            deptName:sltArray[0].get("deptName"),
                            deptId: sltArray[0].get("deptId")
                         })
                        cola.widget("deptDg").show();
                    }

                },
                modDept_close: function() {
                    cola.widget("deptDg").hide();
                },
                modDept:function(self){
                    self.set("disabled",true);
                    self.set("state","loading");
                    $.ajax({
                        url : "<c:url value="/department/save"/>",
                        async : false, // 注意此处需要同步，因为返回完数据后，下面才能让结果的第一条selected
                        type : "POST",
                        data :  model.get("modDept"),
                        dataType : "json",
                        success : function(data) {
                            if(data == "1"){
                                $("<div class='tips_contants'>").fadeIn(250).html("修改成功").delay(500).fadeOut(250).appendTo('body');
                                //cola.alert("修改成功",{title: "提示", level: "info"});
                                cola.widget("deptDg").hide();
                                model.set("modDept",{deptName:""});
                                model.flush("pageItems");
                                self.set("disabled",false);
                                self.set("state","");

                            }else{
                                $("<div class='tips_contants'>").fadeIn(250).html("修改失败").delay(500).fadeOut(250).appendTo('body');
                                //cola.alert("修改失败",{title: "提示", level: "warning"});
                                cola.widget("deptDg").hide();
                                self.set("disabled",false);
                                self.set("state","");

                            }
                        }
                    });
                },
                addDept_close: function () {
                    cola.widget("addDept").hide();
                },
                addDept_open: function () {
                    cola.widget("addDept").show();
                },
                saveDept: function(self) {

                    self.set("disabled",true);
                    self.set("state","loading");
                    $.ajax({
                        url : "<c:url value="/department/save"/>",
                        async : false, // 注意此处需要同步，因为返回完数据后，下面才能让结果的第一条selected
                        type : "POST",
                        data :  model.get("addDeptM"),
                        dataType : "json",
                        success : function(data) {
                            if(data == "1"){
                                $("<div class='tips_contants'>").fadeIn(250).html("添加成功").delay(500).fadeOut(250).appendTo('body');
                                //cola.alert("添加成功",{title: "提示", level: "info"});
                                cola.widget("addDept").hide();
                                model.set("addDeptM",{deptName:""});
                                model.flush("pageItems");
                                self.set("disabled",false);
                                self.set("state","");

                            }else{
                                $("<div class='tips_contants'>").fadeIn(250).html("添加失败").delay(500).fadeOut(250).appendTo('body');
                                //cola.alert("添加失败",{title: "提示", level: "warning"});
                                cola.widget("addDept").hide();
                                self.set("disabled",fasle);
                                self.set("state","");

                            }
                        }
                    });

                },
                del:function(item){
                    $.ajax({
                        url : "<c:url value="/department/delete"/>",
                        async : false, // 注意此处需要同步，因为返回完数据后，下面才能让结果的第一条selected
                        type : "POST",
                        data :  {deptId:item.get("deptId")},
                        dataType : "json",
                        success : function(data) {
                            if(data == '1'){
                                $("<div class='tips_contants'>").fadeIn(250).html("删除成功").delay(500).fadeOut(250).appendTo('body');
                                //cola.alert("删除成功",{title: "提示", level: "info"});
                                model.flush("pageItems");
                            }else{
                                $("<div class='tips_contants'>").fadeIn(250).html("删除失败").delay(500).fadeOut(250).appendTo('body');
                                //cola.alert("删除失败",{title: "提示", level: "warning"});
                            }
                        }
                    });
                }
            });

        });
    </script>

</head>
<body style="padding:10px 0px">
<div class="v-box">
        <div>
            <h4 class="user_list">
                <div class="field button-right" style="top: -5px;">
                    <%--<div c-widget="button; class:primary; caption:删除;" style="background: #dde1e2;color: #000;"></div>--%>
                    <div c-widget="button; class:primary; caption:修改部门;click:{{modDept_open(item)}}" style="background: #589fe7"></div>
                    <div c-widget="button; class:primary; caption:添加部门; click:{{addDept_open()}}" style="background: #589fe7"></div>
                </div>
            </h4>


            <div class="table_contant" id="deptTable">
                <template name="operations">
                    <div>
                        <a c-widget="link; href:###;click:{{del(item)}}" style="background: #dde1e2;color: #000;">删除</a>
                        <a c-widget="link; href:###;">修改</a>
                        <%--<a c-widget="link; href:###">置顶</a>--%>
                    </div>
                </template>
            </div>
            <div class="page_fix">
                <div id="pagerExample" class="order-Pager"></div>
            </div>

        </div>

</div>
<div id="deptDg" c-widget="Dialog; width: 300px">
    <div class="header">修改部门</div>
    <div class="content">
        <div c-widget="input; placeholder:部门名称; bind:modDept.deptName; width:100%"></div>
    </div>
    <div class="actions">
        <div c-widget="button; caption:取消;click:modDept_close" style="background: #DEE1E2;"></div>
        <div c-widget="button; caption:确认修改;click:modDept ;class:primary;"></div>
    </div>
</div>


<div id="addDept" c-widget="Dialog; width: 300px">
    <div class="header">请输入新的部门名称</div>
    <div class="content">
        <div c-widget="input; placeholder:部门名称;bind:addDeptM.deptName;width:100%"></div>
    </div>
    <div class="actions">
        <div c-widget="button; caption:取消;click:addDept_close" style="background: #DEE1E2;"></div>
        <div c-widget="button; caption:保存;click:saveDept;class:primary"></div>
    </div>
</div>
<script>
    $('.table_contant, .table_contant>table').height($(document.body).height()-98);
    $('.table_contant>table').css('overflow-x','scroll');
    $(window).bind("resize", function(e){
        $('.table_contant, .table_contant>table').height($(document.body).height()-98)
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