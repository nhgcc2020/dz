<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <title>角色权限设置</title>
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/order-table_c.css?v=fbd662cafa">

    <style>
        .ui.secondary.pointing.menu .item{
            padding:0.8rem 0.5rem ;
        }
        .ui.buttons:not(.basic):not(.inverted){
            width: 100%;
        }
        .ui.button{
            padding:0px 15px !important;
        }
        #initTable{
            max-width: 80%;
        }
    </style>

</head>
<body style="padding: 20px">

    <%--这个是加载框，切勿修改--%>
    <%--<div class="loadingssss loading_box"><span></span></div>--%>
    <div class="datagrid-mask-msg loading_box" style="display:block;left:50%"><span></span></div>

<div c-widget="divider"></div>
<div class="ui form">

    <div class="field">
        <div>
            <h4 style="display: inline">友情提示：<br/>
                1. 预先设置好企业里的不同角色所具有的权限，再给个人用户赋予角色，使之具有与该角色相对应的权限，可以方便地管理账户的数据安全性和界面的简单化，也提高了软件的易操作性。<br/>
                2. 请点击以下各类角色的标签，并切换不同的功能页面，以编辑每个角色的权限。 （系统做了些默认的常规设置，修改后保存即可生效）。
            </h4>
        </div>

    </div>

    <div class="field">
        <div id="testBtnGroup"></div>
        <%--<div c-widget="ButtonGroup">
            <div c-widget="Button; caption:老板; class:active blue"></div>
            <div c-widget="Button; caption:合伙人"></div>
            <div c-widget="Button; caption:设计师"></div>
            <div c-widget="Button; caption:业务经理"></div>
            <div c-widget="Button; caption:业务员"></div>
            <div c-widget="Button; caption:财务"></div>
            <div c-widget="Button; caption:出纳"></div>
            <div c-widget="Button; caption:安装工"></div>
        </div>--%>
    </div>

    <div class="add_manger" style="position: absolute; right: 0px;">
        <div c-widget="button; class:primary right floated; caption:添加角色"></div>
        <div c-widget="button; class:primary right floated; caption:编辑角色"></div>
    </div>

    <div id="initTable">

    </div>


    <div class="field" style="padding: 50px 0px">
        <div c-widget="Button; caption:取消" style="background: #DEE1E2;"></div>
        <div c-widget="Button; class:primary; caption:保存;click:save;tag:saveBtn"  style="margin-right:20px"></div>
    </div>
</div>
    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
    <script src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
    <script src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
    <script type="text/javascript">
    cola(function (model) {
    $(".loading_box").removeClass("datagrid-mask-msg");
    var config = {
    add:"添加",
    query:"查看",
    update:"修改",
    delete:"删除",
    create:"创建",
    cancel:"撤销",
    pay:"付款"
    };
    var configOptions = {
    add:[
    {key:"1",value:"允许添加",width:150,style:"width: 150px"},
    {key:"0",value:"禁止添加",width:150,style:"width: 150px"}
    ],
    query:[
    {key:"S",value:"仅自己创建的",width:150,style:"width: 150px"},
    {key:"D",value:"所属部门创建的",width:150,style:"width: 150px"},
    {key:"C",value:"全公司创建的订单",width:150,style:"width: 150px"},
    {key:"0",value:"禁止查看",width:150,style:"width: 150px"}
    ],
    update:[
    {key:"S",value:"仅自己创建的",width:150,style:"width: 150px"},
    {key:"D",value:"所属部门创建的",width:150,style:"width: 150px"},
    {key:"C",value:"全公司创建的订单",width:150,style:"width: 150px"},
    {key:"0",value:"禁止修改",width:150,style:"width: 150px"}
    ],
    delete:[
    {key:"S",value:"仅自己创建的",width:150,style:"width: 150px"},
    {key:"D",value:"所属部门创建的",width:150,style:"width: 150px"},
    {key:"C",value:"全公司创建的订单",width:150,style:"width: 150px"},
    {key:"0",value:"禁止删除",width:150,style:"width: 150px"}
    ],
    create:[
    {key:"S",value:"仅自己创建的",width:150,style:"width: 150px"},
    {key:"D",value:"所属部门创建的",width:150,style:"width: 150px"},
    {key:"C",value:"全公司创建的订单",width:150,style:"width: 150px"},
    {key:"0",value:"禁止创建",width:150,style:"width: 150px"}
    ],
    cancel:[
    {key:"S",value:"仅自己创建的",width:150,style:"width: 150px"},
    {key:"D",value:"所属部门创建的",width:150,style:"width: 150px"},
    {key:"C",value:"全公司创建的订单",width:150,style:"width: 150px"},
    {key:"0",value:"禁止撤销",width:150,style:"width: 150px"}
    ],
    pay:[
    {key:"1",value:"允许付款操作",width:150,style:""},
    {key:"0",value:"禁止付款操作",width:150,style:"width: 150px"}
    ]
    };

    function intiTable(menus) {
    var initTable = $("#initTable");
    initTable.empty();
    var $firstCategory = $("<div class='ui pointing secondary menu'></div>");
    initTable.append($firstCategory);

    menus.each(function(first,a){
    var active = "";
    if (a === 0) active = " active";
    //最上一层 表头
    var item = $("<a class='item" + active + "' data-tab='" + first.get("menuId") + "'>" + first.get("menuName") + "</a>");
    var tab = $("<div class='ui tab" + active + "' data-tab='" + first.get("menuId") + "'></div>");
    var table = $("<table class='ui table structured celled'></table>");
    var tbody = $("<tbody></tbody>");
    table.append(tbody);
    tab.append(table);
    tab.data("c", first);
    $firstCategory.append(item);
    $firstCategory.after(tab);

    //第二层的菜单
    var secondMenus = first.get("menus");
    //第一列 同为最上一层
    var tr = $("<tr></tr>");
    var td = $("<td width='150px' rowspan='"+ (secondMenus.entityCount + 1 || 1) +"' class='left aligned'>"
    + "<div style='margin-bottom: 10px'>"+ first.get("menuName") +"</div>"
    + "</td>");
    var toggle = new cola.Toggle({
    value:first.get("isChecked"),
    userData:first,
    click:function(self,arg){
    var value = self.get("value");
    self.set("userData.isChecked",value);
    }
    });

    td.append(toggle.getDom());
    tr.append(td);
    tbody.append(tr);

    //开始第二层循环
    //
    var colClass = "colspan='4'";
    var colNum = 0;
    secondMenus.each(function(second,b){
    if(second.get("menus").entityCount > 0){
    colClass = "";
    colNum = colNum +1;
    }
    });
    var colFlag = false;
    if(secondMenus.entityCount != colNum){
    colFlag = true;
    }

    secondMenus.each(function (second,b) {
    //第三层的菜单 start
    var tr = $("<tr></tr>");
    var td = $("<td width='150px' class='left aligned'>"
    + "<div style='margin-bottom: 10px'>"+ second.get("menuName") +"</div>"
    + "</td>");
    var toggle = new cola.Toggle({
    value:second.get("isChecked"),
    userData:second,
    click:function(self,arg){
    var value = self.get("value");
    self.set("userData.isChecked",value);
    }
    });
    td.append(toggle.getDom());
    tr.append(td);
    tbody.append(tr);
    //第三层的菜单 end
    //开始第三层循环

    var thirdMenus = second.get("menus");
    if(thirdMenus.entityCount == 0){
    var tdFather = $("<td></td>");
    var tableInner = $("<table class='ui table structured celled'></table>");
    var tbodyInner = $("<tbody></tbody>");
    var permissionVOs = second.get("permissionVOs");
    if(permissionVOs.entityCount == 0 && colFlag){
    tr.append(tdFather);
    tdFather.append(tableInner);
    tableInner.append(tbodyInner);
    }
    permissionVOs.each(function(third,c){
    if(c==0){
    tr.append(tdFather);
    tdFather.append(tableInner);
    tableInner.append(tbodyInner);
    }
    var label = second.get("resourceDesc");
    var menuId = second.get("menuId");
    var codeValue = config[third.get("permissionCode")];
    var optionAry = configOptions[third.get("permissionCode")];
    var span_option = $("<div  style='width: 150px; display: inline-block; padding-left: 20px'>"
    +    "<label>"+ label+codeValue +"</label>"
    +    "</div>");
    var trInner = $("<tr></tr>");
    var tdInner = $("<td  style='border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px'></td>")
    trInner.append(tdInner);
    tdInner.append(span_option);
    //optionAry[i].value
    for(var i=0;i<optionAry.length;i++){
    var flag = false;
    if(third.get("permissionValue") == optionAry[i].key){
    flag = true;
    }
    var $radio = new cola.RadioButton({
    name:menuId+third.get("permissionCode"),
    value:optionAry[i].key,
    label:optionAry[i].value,
    width:optionAry[i].width,
    checked:flag,
    userData:third,
    click:function(a,b){
    var permissionValue  = a.get("userData.permissionValue");
    var value = a.get("value");
    if(permissionValue != value){
    //
    //先赋值
    a.set("userData.permissionValue",value);
    //然后重组字符串
    var permission_Array = a.get("userData").parent;
    var parent_per = permission_Array.parent;
    var permissionVos = "";
    permission_Array.each(function(element,index){
    if (index == 0) {
    permissionVos = element.get("permissionCode") + ":" + element.get("permissionValue");
    } else {
    permissionVos = permissionVos + "," + element.get("permissionCode") + ":" + element.get("permissionValue");
    }
    });
    parent_per.set("permission",permissionVos);
    //
    }
    }
    });
    tdInner.append($radio.getDom());
    }
    tbodyInner.append(trInner);
    })
    }
    else{
    var tdFather = $("<td></td>");
    var tableInner = $("<table class='ui table structured celled'></table>");
    var tbodyInner = $("<tbody></tbody>");
    thirdMenus.each(function (third,c) {
    if(c==0){
    tr.append(tdFather);
    tdFather.append(tableInner);
    tableInner.append(tbodyInner);
    }
    var fourthMenus = third.get("menus");
    //
    var trInner = $("<tr></tr>");
    var tdInner = $("<td width='150px' class='left aligned'>"
    + "<div style='margin-bottom: 10px'>"+ third.get("menuName") +"</div>"
    + "</td>");
    var toggle = new cola.Toggle({
    value:third.get("isChecked"),
    userData:third,
    click:function(self,arg){
    var value = self.get("value");
    self.set("userData.isChecked",value);
    }
    });
    tdInner.append(toggle.getDom());
    trInner.append(tdInner);
    tbodyInner.append(trInner);
    })
    }

    })
    });
    $(".menu .item").tab();
    };
    //system/role/role-permission/query
    model.describe("menus", {
    provider: {
    url: "<c:url value='/system/role/role-permission/query'/>",
    complete:function(){
    $(".loding_big_box").fadeOut();

    }
    }
    });
    var menusObj =  model.get("menus","sync");
    //渲染页面
    function draw(menusObj) {
    //1.角色按钮组的初始化渲染
    var btnItems = [];
    var roles = menusObj.get("roles");
    //
    roles.each(function(element,index){
    var btn = {
    $type:"Button",
    state:index==0?"active":"",
    caption:element.get("roleValue"),
    userData:element,
    tag:element.get("roleKey"),
    click:function(self,arg){
    //校验 start
    var postCheckArray = new Array;
    var menus = model.get("menus.roleMenus");
    menus.each(function (element, index) {
    console.log(element.state+" "+element.get("menuId"));
    if(element.state == "modified"){
    postCheckArray.push(convert(element));
    }
    var secondMenus = element.get("menus");
    secondMenus.each(function (second, b) {
    if(second.state == "modified"){
    postCheckArray.push(convert(second));
    }
    })
    });
    //校验 end
    if(postCheckArray.length > 0){
    $("<div class='tips_contants'>").fadeIn(250).html("当前角色有未保存的修改，请先保存").delay(3000).fadeOut(250).appendTo('body');
    }else{
    var cSaveBtn = cola.tag("saveBtn");
    cSaveBtn.set("disabled",true);
    var roleKey = self.get("userData.roleKey");
    $(".loding_big_box").fadeIn();
    $("#initTable").empty();
    $.post( "/system/role/role-permission/query",
    {roleKey:roleKey},
    function(data){
    model.set("menus",data);
    var menus = model.get("menus.roleMenus");
    intiTable(menus);
    cSaveBtn.set("disabled",false);
    $(".loding_big_box").fadeOut();
    });
    }
    }
    };
    btnItems.push(btn);
    });
    var btnG = new cola.ButtonGroup({
    tag:"roleBtnGroup",
    items: btnItems
    });
    $("#testBtnGroup").append(btnG.getDom());
    //2.权限表格渲染
    var menus = menusObj.get("roleMenus");
    intiTable(menus);
    }
    //调用渲染
    draw(menusObj);

    /*model.widgetConfig({
    createCustomerRg: {
    items: [
    "允许添加",
    "禁止添加"
    ]
    }
    });*/
    //提交数据的格式转化
    function convert(element) {
    var roleKey = element.get("roleKey");
    var menuId = element.get("menuId");
    var resourceId = element.get("resourceId");
    var isChecked = element.get("isChecked");
    var permission = element.get("permission");
    var obj = {
    "roleKey":roleKey,
    "menuId":menuId,
    "resourceId":resourceId,
    "isChecked":isChecked,
    "permission":permission
    };
    return obj;
    }

    model.action({
    change_radio:function (item) {
    },
    change: function() {
    var value = $()
    alert("sss");
    },
    save:function (btn) {
    btn.set("disabled",true);
    btn.set("state","loading");
    var postArray = new Array;
    var menus = model.get("menus.roleMenus");

    menus.each(function (element, index) {
    /*if (!element.get("isChecked")) {
    postArray.push(convert(element));
    return true;
    }*/
    if(element.state == "modified"){
    postArray.push(convert(element));
    }
    var secondMenus = element.get("menus");
    secondMenus.each(function (second, b) {
    if(second.state == "modified"){
    postArray.push(convert(second));
    }
    })
    });
    $.ajax({
    url: "<c:url value='/system/role/role-permission/saveAndUpdate'/>",
    type: "post",
    data: JSON.stringify(postArray),
    dataType: "json",
    contentType: "application/json",
    success: function (callBack) {

    if(callBack == "1"){
    $("<div class='tips_contants'>").fadeIn(250).html("保存成功").delay(3000).fadeOut(250).appendTo('body');
    btn.set("disabled",false);
    btn.set("state","");
    setTimeout(function(){
    window.location.reload();
    },1000);
    }else {
    btn.set("disabled",false);
    btn.set("state","");
    }


    }
    })
    }
    });

    $(".ui.toggle.checkbox").checkbox({
    onChecked: function() {
    $(this).parents("td").next().dimmer({
    opacity: 0.2
    })
    $(this).parents("td").next().dimmer("hide");
    },
    onUnchecked: function () {
    $(this).parents("td").next().dimmer("show");
    }
    });

    $(".menu .item").tab();
    });
    </script>
</body>
</html>