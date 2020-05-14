<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
    <script src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
    <script src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
    <script src="/resources/cola-ui/i18n/zh-CN/cola.js?v=40433415fd"></script>
    <script src="/resources/cola-ui/company.js?v=0bd2ddc8c6"></script>           <%--//数据接收主要js--%>
    <style>
        #permission_tab>div{
            display: none;
        }
        #permission_tab>div.active{
            display: block;
        }
        #Customer-Profile td{
            border-right:none;
            border-left:none;
            padding-left:0px;
            padding-right:0px;
        }
        #Customer-Profile td{
            border-right:none;
            border-left:none;
            padding-left:0px;
            padding-right:0px;
        }
        #Customer-Profile td{
            border-right:none;
            border-left:none;
            padding-left:0px;
            padding-right:0px;
            width:14.28%;
        }
        .table-center{
            text-align: center;
        }
    </style>
    <script type="text/javascript">
        cola(function (model) {

            model.describe("ps", {
                provider: "permissionInit.json"
            });

            var data = ["P1-0301010301", "1-BD01","P1-BD010101"];
            for(var i = 0; i < data.length; i++) {
                $("#" + data[i]).checkbox("check");
            }

            //动态生成
//            model.get("ps", function(ps) {
//                var $firstCategory = $(".ui.pointing.secondary.menu");
//                ps.each(function (p, i) {
//                    var active = ""
//                    if (i === 0) active = " active"
//                    var item = $("<a class='item" + active + "' data-tab='" + p.get("uid") + "'>" + p.get("permissionDesc") + "</a>");
//                    var tab = $("<div class='ui tab" + active + "' data-tab='" + p.get("uid") + "'></div>");
//                    tab.data("c", p);
//                    $firstCategory.append(item);
//                    $firstCategory.after(tab);
//
//                    var table = $("<table class='ui table structured celled'></table>");
//                    var tbody = $("<tbody></tbody>");
//                    table.append(tbody);
//                    tab.append(table);
//                    var secord = p.get("permissionInits");
//                    secord.each(function(s) {
//                        var third = s.get("permissionInits");
//
//                        var tr = $("<tr></tr>");
//                        var td = $("<td width='150px' rowspan='"+ (third.entityCount || 1) +"' class='center aligned'>"
//                                        + "<div style='margin-bottom: 10px'>"+ s.get("permissionDesc") +"</div>"
//                                        + "<div class='ui toggle checkbox'>"
//                                                + "<input type='checkbox' c-onchange='change'>"
//                                                + "<label></label>"
//                                        + "</div>"
//                                 + "</td>");
//                        tr.append(td);
//
//
//                        tbody.append(tr);
//
//                        if (s.get("permissionDesc") == "统计分析") {
//                            td.attr("rowspan", 1);
//
//                            td = $("<td></td>");
//                            third.each(function(t, i) {
//                                td.append( "<div style='width: 150px; display: inline-block; padding-left: 20px'>" + t.get("permissionDesc") + "</div>");
//                            });
//                            tr.append(td);
//                        }  else {
//                            third.each(function(t, i) {
//                                td = $("<td></td>");
//                                td.append( "<div style='width: 150px; display: inline-block; padding-left: 20px'>" + t.get("permissionDesc") + "</div>");
//                                if (i == 0) {
//                                    tr.append(td);
//                                } else {
//                                    tr = $("<tr></tr>");
//                                    tr.append(td);
//                                    tbody.append(tr);
//                                }
//                                var four = t.get("permissionInits");
//                                four.each(function(f) {
//                                    var radio = $("<div class='ui radio checkbox' style='width: 150px'>"
//                                            +    "<input type='radio' name='"+ t.get("uid") +"'>"
//                                            +    "<label>"+ f.get("permissionDesc") +"</label>"
//                                            +    "</div>");
//                                    td.append(radio);
//                                });
//
//
//                            });
//                        }
//
//                        if (third.entityCount == 0) {
//                            tr.append("<td></td>")
//                        }
//
//                    });

//                });
//                $(".menu .item").tab();
//
//            });

            $(".menu .item").tab();

            $(".ui.toggle.checkbox").checkbox({
                onChecked: function() {
                    $("." + $(this).attr("category")).checkbox("set enabled");
                },
                onUnchecked: function () {
                    $("." + $(this).attr("category")).checkbox("set disabled");
                }
            });

            model.action({
                savePermission : function(){
                  //todo 有空试试model 中的 entity 和 entityList实现
                  var myArray1 = new Array();

                  var checkboxes = $('.ui.checkbox')
                  checkboxes.each(function(index,element){
                     /* if(!$(element).checkbox("is radio") && $(element).checkbox("is checked")){
                          myArray1.push($(element).attr("id"));
                      }
                      $(element).checkbox("is radio") &&
                      */
                      if( $(element).checkbox("is checked")){
                         myArray1.push($(element).attr("id"));
                      }
                  })

                    $.post("<c:url value="/permission/savePermission"/>",{codeStr : JSON.stringify(myArray1)},function(callback){
                        console.info(callback);
                    });
                  //console.info(myArray1);
                  /*var myArray2 = new Array();
                  $(myArray1).each(function(index,element){
                      var $tds = $("#"+element).parents("td").next();
                      $tds.each(function(i){
                           $(this)
                      })

                  })*/

                }

            })
        });
    </script>

</head>
<body style="padding: 20px">
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
        <div c-widget="ButtonGroup;width:55%">
            <div c-widget="Button; caption:老板; class:active blue"></div>
            <div c-widget="Button; class:basic;color:grey; caption:合伙人;"></div>
            <div c-widget="Button; class:basic;color:grey; caption:设计师"></div>
            <div c-widget="Button; class:basic;color:grey; caption:业务经理"></div>
            <div c-widget="Button; class:basic;color:grey; caption:业务员"></div>
            <div c-widget="Button; class:basic;color:grey; caption:财务"></div>
            <div c-widget="Button; class:basic;color:grey; caption:出纳"></div>
            <div c-widget="Button; class:basic;color:grey; caption:安装工"></div>
        </div>
        <div c-widget="button; class:primary right floated; caption:添加角色"></div>
        <div c-widget="button; class:primary right floated; caption:编辑角色"></div>
    </div>

    <div class="ui pointing secondary menu" id="menu"></div>


    <div id="permission_tab">

        <div class="ui tab active" data-tab="377" style="width: 95%">
            <table class="ui table structured celled" id="Customer-Profile">
                <tbody>

                            <tr>
                                <td rowspan="4" style="border-right:1px solid #e4e4e4;">
                                    <div id="1-BD01" class="ui toggle checkbox" style="margin-left: 15px;"><input category="customer" type="checkbox" tabindex="0" class="hidden"><label>客户档案</label></div>
                                </td>
                                <td><div id="P1-BD0101" class="table-center">添加客户档案</div></td>
                                <td>
                                    <div id="P1-BD010101" class='ui radio checkbox customer'><input type="radio" name="379"><label>允许添加</label></div>
                                </td>
                                <td>
                                    <div id="P1-BD010102" class="ui radio checkbox customer"><input type="radio" name="379"><label>禁止添加</label></div>
                                </td>
                                <td>
                                    <div id="P1-BD010102" class="ui radio checkbox customer"><input type="radio" name="379"><label>禁止添加</label></div>
                                </td>
                                <td>
                                    <div id="P1-BD010102" class="ui radio checkbox customer"><input type='radio' name='379'><label>禁止添加</label></div>
                                </td>
                                <td>
                                    <div id="P1-BD010102" class="ui radio checkbox customer"><input type="radio" name="379"><label>禁止添加</label></div>
                                </td>
                            </tr>
                            <tr>
                            <td><div id="P1-BD0102"" class="table-center">查看客户列表</div></td>
                                <td>
                                    <div id="P1-BD010201" class="ui radio checkbox customer"><input type="radio" name="382"><label>仅自己创建的</label></div>
                                </td>
                                <td>
                                    <div id="P1-BD010202" class="ui radio checkbox customer"><input type="radio" name="382"><label>所属部门创建的</label></div>
                                </td>
                                <td>
                                    <div id="P1-BD010203" class="ui radio checkbox customer"><input type="radio" name="382"><label>全公司的客户档案</label></div>
                                </td>
                                <td>
                                    <div id="P1-BD010204" class="ui radio checkbox customer"><input type="radio" name="382"><label>禁止查看</label></div>
                                </td>
                                <td></td>
                        </tr>
                        <tr>
                            <td><div id="P1-BD0103" class="table-center">修改客户档案</div></td>
                            <td>
                                <div id="P1-BD010301" class="ui radio checkbox customer"><input type="radio" name="387"><label>仅自己创建的</label></div>
                            </td>
                            <td>
                                <div id="P1-BD010302" class="ui radio checkbox customer"><input type="radio" name="387"><label>所属部门创建的</label></div>
                            </td>
                            <td>
                                <div id="P1-BD010303" class="ui radio checkbox customer"><input type="radio" name="387"><label>全公司的客户档案</label></div>
                            </td>
                            <td>
                                <div id="P1-BD010304" class="ui radio checkbox customer"><input type="radio" name="387"><label>禁止修改</label></div>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td><div id="P1-BD0104" class="table-center">删除客户档案</div></td>
                            <td>
                                <div id="P1-BD010401" class="ui radio checkbox customer"><input type="radio" name="392"><label>仅自己创建的</label></div>
                            </td>
                            <td>
                                <div id="P1-BD010402" class="ui radio checkbox customer"><input type="radio" name="392"><label>所属部门创建的</label></div>
                            </td>
                            <td>
                                <div id="P1-BD010403" class="ui radio checkbox customer"><input type="radio" name="392"><label>全公司的客户档案</label></div>
                            </td>
                            <td>
                                <div id="P1-BD010404" class="ui radio checkbox customer"><input type="radio" name="392"><label>禁止删除</label></div>
                            </td>
                            <td></td>
                        </tr>

                </tbody>
            </table>
        </div>

        <!--协同接单 start-->
        <div class="ui tab" data-tab="1-01">
            <table class="ui table structured celled">
                <tbody>
                <tr>
                    <td width="150px" rowspan="2" >
                        <div id="1-0101" class="ui toggle checkbox"><input  category="1-0101" type="checkbox" tabindex="0" class="hidden"><label>业务处理</label></div>
                    </td>
                    <td>
                        <div style="width: 150px; display: inline-block; padding-left: 20px">
                            <div id="P1-010101" class="ui toggle checkbox 1-0101"><input type="checkbox" tabindex="0" class="hidden"><label>订单处理</label></div>
                        </div>
                        <div style="width: 150px; display: inline-block; padding-left: 20px">
                            <!--<div id="P1-01010101" class="ui toggle checkbox">--><label>订单确认</label><!--<input type="checkbox" tabindex="0" class="hidden" name="427">--><!--</div>-->
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 0px;">
                        <table>
                            <tr>
                                <td style="border-right: 0px" rowspan="2">
                                    <div style="width: 150px; display: inline-block; padding-left: 20px">
                                        <div id="P1-010102" class="ui toggle checkbox 1-0101"><input type="checkbox" tabindex="0" class="hidden"><label>对账结算</label></div>
                                    </div>
                                </td>
                                <td style="border-right: 0px;border-left: 0px;padding-left: 15px">
                                    <div style="width: 150px; display: inline-block;">
                                        <!--<div id="P1-01010201" class="ui toggle checkbox">--><label>对账单查看</label><!--<input type="checkbox" tabindex="0" class="hidden"></div>-->
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div style="width: 150px; display: inline-block; ">
                                        <!--<div id="P1-01010202" class="ui toggle checkbox">--><label>对账单付款</label><!--<input type="checkbox" tabindex="0" class="hidden"></div>-->
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="150px" rowspan="1" >
                        <div id="1-0102" class="ui toggle checkbox"><input type="checkbox" tabindex="0" class="hidden"><label>统计分析</label></div>
                    </td>
                    <td>
                        <div id="P1-010201" style="width: 150px; display: inline-block; padding-left: 20px">订单统计与分析</div>
                        <div id="P1-010202" style="width: 150px; display: inline-block; padding-left: 20px">供应商统计与分析</div>
                        <div id="P1-010203" style="width: 150px; display: inline-block; padding-left: 20px">付款统计与分析</div>
                        <div id="P1-010204" style="width: 150px; display: inline-block; padding-left: 20px">收到发票记录</div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <!--协同接单 end-->

        <!--销售管理 start-->
        <div class="ui tab" data-tab="1-02">
            <table class="ui table structured celled">
                <tbody>
                <tr>
                    <td width="150px" rowspan="2" >
                        <div id="1-0201" class="ui toggle checkbox"><input type="checkbox" tabindex="0" class="hidden" ><label>业务处理</label></div>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td style="border-right: 0px" rowspan="5">
                                    <div style="width: 150px; display: inline-block; padding-left: 20px">
                                        <div id="1-020101" class="ui toggle checkbox"><input type="checkbox" tabindex="0" class="hidden"><label>订单处理</label></div>
                                    </div>
                                </td>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-02010101" style="width: 150px; display: inline-block; padding-left: 20px">添加销售订单</div>
                                    <div id="P1-0201010101" class="ui radio checkbox" style="width: 150px"><input type="radio" name="494"><label>允许添加</label></div>
                                    <div id="P1-0201010102" class="ui radio checkbox" style="width: 150px"><input type="radio" name="494"><label>禁止添加</label></div>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-02010102" style="width: 150px; display: inline-block; padding-left: 20px">查看销售订单</div>
                                    <div id="P1-0201010201" class="ui radio checkbox" style="width: 150px"><input type="radio" name="494"><label>仅自己创建的</label></div>
                                    <div id="P1-0201010202" class="ui radio checkbox" style="width: 150px"><input type="radio" name="494"><label>所属部门创建的</label></div>
                                    <div id="P1-0201010203" class="ui radio checkbox" style="width: 150px"><input type="radio" name="494"><label>全公司创建的订单</label></div>
                                    <div id="P1-0201010204" class="ui radio checkbox" style="width: 150px"><input type="radio" name="494"><label>禁止查看</label></div>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-02010103" style="width: 150px; display: inline-block; padding-left: 20px">修改销售订单</div>
                                    <div id="P1-0201010301" class="ui radio checkbox" style="width: 150px"><input type="radio" name="494"><label>仅自己创建的</label></div>
                                    <div id="P1-0201010302" class="ui radio checkbox" style="width: 150px"><input type="radio" name="494"><label>所属部门创建的</label></div>
                                    <div id="P1-0201010303" class="ui radio checkbox" style="width: 150px"><input type="radio" name="494"><label>全公司创建的订单</label></div>
                                    <div id="P1-0201010304" class="ui radio checkbox" style="width: 150px"><input type="radio" name="494"><label>禁止修改</label></div>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-02010104" style="width: 150px; display: inline-block; padding-left: 20px">删除销售订单</div>
                                    <div id="P1-0201010401" class="ui radio checkbox" style="width: 150px"><input type="radio" name="494"><label>仅自己创建的</label></div>
                                    <div id="P1-0201010402" class="ui radio checkbox" style="width: 150px"><input type="radio" name="494"><label>所属部门创建的</label></div>
                                    <div id="P1-0201010403" class="ui radio checkbox" style="width: 150px"><input type="radio" name="494"><label>全公司创建的订单</label></div>
                                    <div id="P1-0201010404" class="ui radio checkbox" style="width: 150px"><input type="radio" name="494"><label>禁止删除</label></div>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-02010105" style="width: 150px; display: inline-block; padding-left: 20px">创建对账单</div>
                                    <div id="P1-0201010501" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-02010105"><label>仅自己创建的</label></div>
                                    <div id="P1-0201010502" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-02010105"><label>所属部门创建的</label></div>
                                    <div id="P1-0201010503" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-02010105"><label>全公司创建的订单</label></div>
                                    <div id="P1-0201010504" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-02010105"><label>禁止创建</label></div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td style="border-right: 0px" rowspan="5">
                                    <div style="width: 150px; display: inline-block; padding-left: 20px">
                                        <div id="1-020102" class="ui toggle checkbox"><input type="checkbox" tabindex="0" class="hidden"><label>对账结算</label></div>
                                    </div>
                                </td>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-02010201" style="width: 150px; display: inline-block; padding-left: 20px">对账单查看</div>
                                    <div id="P1-0201020101" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-02010201"><label>仅自己创建的</label></div>
                                    <div id="P1-0201020102" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-02010201"><label>所属部门创建的</label></div>
                                    <div id="P1-0201020103" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-02010201"><label>全公司创建的订单</label></div>
                                    <div id="P1-0201020104" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-02010201"><label>禁止查看</label></div>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-02010202" style="width: 150px; display: inline-block; padding-left: 20px">对账单撤销</div>
                                    <div id="P1-0201020201" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-02010202"><label>仅自己创建的</label></div>
                                    <div id="P1-0201020202" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-02010202"><label>所属部门创建的</label></div>
                                    <div id="P1-0201020203" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-02010202"><label>全公司创建的订单</label></div>
                                    <div id="P1-0201020204" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-02010202"><label>禁止撤销</label></div>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-02010203" style="width: 150px; display: inline-block; padding-left: 20px">对账单付款</div>
                                    <div id="P1-0201020301" class="ui radio checkbox"><input type="radio" name="P1-02010203"><label>允许付款操作<span style="color: red"> （重要！！！即有权限在系统里进行收款操作）</span></label></div>
                                    <div id="P1-0201020302" class="ui radio checkbox"><input type="radio" name="P1-02010203"><label>禁止付款操作</label></div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>


                <tr>
                    <td width="150px" rowspan="1" >
                        <div id="1-0202" class="ui toggle checkbox"><input type="checkbox" tabindex="0" class="hidden"><label>统计分析</label></div>
                    </td>
                    <td>
                        <div id="P1-020201" style="width: 150px; display: inline-block; padding-left: 20px">订单统计与分析</div>
                        <div id="P1-020202" style="width: 150px; display: inline-block; padding-left: 20px">客户统计与分析</div>
                        <div id="P1-020203" style="width: 150px; display: inline-block; padding-left: 20px">收款记录与分析</div>
                        <div id="P1-020204" style="width: 150px; display: inline-block; padding-left: 20px">开出发票记录</div>
                        <div id="P1-020205" style="width: 150px; display: inline-block; padding-left: 20px">提成统计与分析</div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <!--销售管理 end-->

        <!--采购管理 end-->
        <div class="ui tab" data-tab="1-03">
            <table class="ui table structured celled">
                <tbody>
                <tr>
                    <td width="200px" rowspan="2" >
                        <div id="1-0301" class="ui toggle checkbox"><input type="checkbox" tabindex="0" class="hidden" ><label>外协加工业务处理</label></div>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td style="border-right: 0px" rowspan="5">
                                    <div style="width: 150px; display: inline-block; padding-left: 20px">
                                        <div id="1-030101" class="ui toggle checkbox"><input type="checkbox" tabindex="0" class="hidden"><label>订单处理</label></div>
                                    </div>
                                </td>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-03010101" style="width: 150px; display: inline-block; padding-left: 20px">添加采购订单</div>
                                    <div id="P1-0301010101" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010101"><label>允许添加</label></div>
                                    <div id="P1-0301010102" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010101"><label>禁止添加</label></div>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-03010102" style="width: 150px; display: inline-block; padding-left: 20px">查看采购订单</div>
                                    <div id="P1-0301010201" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010102"><label>仅自己创建的</label></div>
                                    <div id="P1-0301010202" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010102"><label>所属部门创建的</label></div>
                                    <div id="P1-0301010203" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010102"><label>全公司创建的订单</label></div>
                                    <div id="P1-0301010204" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010102"><label>禁止查看</label></div>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-03010103" style="width: 150px; display: inline-block; padding-left: 20px">修改采购订单</div>
                                    <div id="P1-0301010301" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010103"><label>仅自己创建的</label></div>
                                    <div id="P1-0301010302" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010103"><label>所属部门创建的</label></div>
                                    <div id="P1-0301010303" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010103"><label>全公司创建的订单</label></div>
                                    <div id="P1-0301010304" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010103"><label>禁止修改</label></div>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-03010104" style="width: 150px; display: inline-block; padding-left: 20px">删除采购订单</div>
                                    <div id="P1-0301010401" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010104"><label>仅自己创建的</label></div>
                                    <div id="P1-0301010402" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010104"><label>所属部门创建的</label></div>
                                    <div id="P1-0301010403" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010104"><label>全公司创建的订单</label></div>
                                    <div id="P1-0301010404" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010104"><label>禁止删除</label></div>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-03010105" style="width: 150px; display: inline-block; padding-left: 20px">创建对账单</div>
                                    <div id="P1-0301010501" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010105"><label>仅自己创建的</label></div>
                                    <div id="P1-0301010502" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010105"><label>所属部门创建的</label></div>
                                    <div id="P1-0301010503" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010105"><label>全公司创建的订单</label></div>
                                    <div id="P1-0301010504" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010105"><label>禁止创建</label></div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td style="border-right: 0px" rowspan="5">
                                    <div style="width: 150px; display: inline-block; padding-left: 20px">
                                        <div id="1-030102" class="ui toggle checkbox"><input type="checkbox" tabindex="0" class="hidden"><label>对账结算</label></div>
                                    </div>
                                </td>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-03010201" style="width: 150px; display: inline-block; padding-left: 20px">对账单查看</div>
                                    <div id="P1-0301020101" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010201"><label>仅自己创建的</label></div>
                                    <div id="P1-0301020102" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010201"><label>所属部门创建的</label></div>
                                    <div id="P1-0301020103" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010201"><label>全公司创建的订单</label></div>
                                    <div id="P1-0301020104" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010201"><label>禁止查看</label></div>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-03010202" style="width: 150px; display: inline-block; padding-left: 20px">对账单撤销</div>
                                    <div id="P1-0301020201" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010202"><label>仅自己创建的</label></div>
                                    <div id="P1-0301020202" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010202"><label>所属部门创建的</label></div>
                                    <div id="P1-0301020203" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010202"><label>全公司创建的订单</label></div>
                                    <div id="P1-0301020204" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03010202"><label>禁止撤销</label></div>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-03010203" style="width: 150px; display: inline-block; padding-left: 20px">对账单付款</div>
                                    <div id="P1-0301020301" class="ui radio checkbox"><input type="radio" name="P1-03010203"><label>允许付款操作<span style="color: red"> （重要！！！即有权限在系统里进行收款操作）</span></label></div>
                                    <div id="P1-0301020302" class="ui radio checkbox"><input type="radio" name="P1-03010203"><label>禁止付款操作</label></div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="200px" rowspan="2" >
                        <div id="1-0302" class="ui toggle checkbox"><input type="checkbox" tabindex="0" class="hidden" ><label>商品采购业务处理</label></div>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td style="border-right: 0px" rowspan="4">
                                    <div style="width: 150px; display: inline-block; padding-left: 20px">
                                        <div id="1-030201" class="ui toggle checkbox"><input type="checkbox" tabindex="0" class="hidden"><label>订单处理</label></div>
                                    </div>
                                </td>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-03020101" style="width: 150px; display: inline-block; padding-left: 20px">查看采购订单</div>
                                    <div id="P1-0302010101" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03020101"><label>仅自己创建的</label></div>
                                    <div id="P1-0302010102" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03020101"><label>所属部门创建的</label></div>
                                    <div id="P1-0302010103" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03020101"><label>全公司创建的订单</label></div>
                                    <div id="P1-0302010104" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03020101"><label>禁止查看</label></div>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-03020102" style="width: 150px; display: inline-block; padding-left: 20px">修改采购订单</div>
                                    <div id="P1-0302010201" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03020102"><label>仅自己创建的</label></div>
                                    <div id="P1-0302010202" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03020102"><label>所属部门创建的</label></div>
                                    <div id="P1-0302010203" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03020102"><label>全公司创建的订单</label></div>
                                    <div id="P1-0302010204" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03020102"><label>禁止修改</label></div>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-03020103" style="width: 150px; display: inline-block; padding-left: 20px">删除采购订单</div>
                                    <div id="P1-0302010301" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03020103"><label>仅自己创建的</label></div>
                                    <div id="P1-0302010302" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03020103"><label>所属部门创建的</label></div>
                                    <div id="P1-0302010303" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03020103"><label>全公司创建的订单</label></div>
                                    <div id="P1-0302010304" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03020103"><label>禁止删除</label></div>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-03020104" style="width: 150px; display: inline-block; padding-left: 20px">创建对账单</div>
                                    <div id="P1-0302010401" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03020104"><label>仅自己创建的</label></div>
                                    <div id="P1-0302010402" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03020104"><label>所属部门创建的</label></div>
                                    <div id="P1-0302010403" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03020104"><label>全公司创建的订单</label></div>
                                    <div id="P1-0302010404" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03020104"><label>禁止创建</label></div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td style="border-right: 0px" rowspan="5">
                                    <div style="width: 150px; display: inline-block; padding-left: 20px">
                                        <div id="1-030202" class="ui toggle checkbox"><input type="checkbox" tabindex="0" class="hidden"><label>对账结算</label></div>
                                    </div>
                                </td>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-03020201" style="width: 150px; display: inline-block; padding-left: 20px">对账单查看</div>
                                    <div id="P1-0302020101" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03020201"><label>仅自己创建的</label></div>
                                    <div id="P1-0302020102" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03020201"><label>所属部门创建的</label></div>
                                    <div id="P1-0302020103" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03020201"><label>全公司创建的订单</label></div>
                                    <div id="P1-0302020104" class="ui radio checkbox" style="width: 150px"><input type="radio" name="P1-03020201"><label>禁止查看</label></div>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-03020202" style="width: 150px; display: inline-block; padding-left: 20px">对账单撤销</div>
                                    <div id="P1-0302020201" class="ui radio checkbox" style="width: 150px"><input type="radio" name="494"><label>仅自己创建的</label></div>
                                    <div id="P1-0302020202" class="ui radio checkbox" style="width: 150px"><input type="radio" name="494"><label>所属部门创建的</label></div>
                                    <div id="P1-0302020203" class="ui radio checkbox" style="width: 150px"><input type="radio" name="494"><label>全公司创建的订单</label></div>
                                    <div id="P1-0302020204" class="ui radio checkbox" style="width: 150px"><input type="radio" name="494"><label>禁止撤销</label></div>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-right: 0px;border-left: 0px;border-top: 0px;padding-left: 15px">
                                    <div id="P1-03020203" style="width: 150px; display: inline-block; padding-left: 20px">对账单付款</div>
                                    <div id="P1-0302020301" class="ui radio checkbox"><input type="radio" name="P1-03020203"><label>允许付款操作<span style="color: red">（重要！！！即有权限在系统里进行收款操作）</span></label></div>
                                    <div id="P1-0302020302" class="ui radio checkbox"><input type="radio" name="P1-03020203"><label>禁止付款操作</label></div>

                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr>
                    <td width="200px" rowspan="1" >
                        <div id="1-0303" class="ui toggle checkbox"><input type="checkbox" tabindex="0" class="hidden"><label>统计分析</label></div>
                    </td>
                    <td>
                        <div id="P1-030301" style="width: 150px; display: inline-block; padding-left: 20px">订单统计与分析</div>
                        <div id="P1-030302" style="width: 150px; display: inline-block; padding-left: 20px">客户统计与分析</div>
                        <div id="P1-030303" style="width: 150px; display: inline-block; padding-left: 20px">收款记录与分析</div>
                        <div id="P1-030304" style="width: 150px; display: inline-block; padding-left: 20px">开出发票记录</div>
                        <div id="P1-030305" style="width: 150px; display: inline-block; padding-left: 20px">提成统计与分析</div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

    </div>
    <div class="field" style="padding: 50px 0px">
        <div c-widget="Button; caption:取消" style="background: #DEE1E2;"></div>
        <div c-widget="Button; class:primary; caption:保存;click:savePermission" style="margin-right:20px"></div>
    </div>
</div>
</body>
</html>