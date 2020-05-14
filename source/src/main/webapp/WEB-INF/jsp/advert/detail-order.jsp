<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <script src="/resources/cola-ui/cola-ext.js?v=ab24bf6495"></script>
    <script src="/common/growingio.js"></script>

    <script type="text/javascript">
        cola(function (model) {

            model.describe("orders", {
                provider: "salesOrderDetail.json"
            });

            model.get("orders", function(orders) {
                orders.each(function(order) {
                    var path = "order" + order.get("businessType")
                    var temp = model.get(path);
                    if (!temp) {
                        temp = [];
                        model.set(path, temp);
                        temp = model.get(path)
                    }
                    temp.insert(order.toJSON());
                });
            });

            console.log(model)

            model.describe("tables", {
                provider: "tables.json"
            })

            var needTables = ["table1", "table2"]

            var tables = model.get("tables", "sync");

            tables = tables.toJSON()
            for(var i = 0; i < needTables.length; i++) {
                var tableId = needTables[i];
                $("#tableContainer")
                        .append("<table id='"+ tableId +"' style='margin: 50px 0px 10px 0px;'></table>")
                        .append("<table style='float: right'><tr><td>小计金额</td><td style='width: 100px;text-align: right'>1200.00</td></tr></table>");
                tables[tableId].$type = "ext.Table";
                model.widgetConfig(tableId, tables[tableId]);

            }


            $(".ui.search.selection.dropdown").dropdown();
        });
    </script>
</head>
<body style="padding: 10px;overflow: hidden">

<h4 style="line-height: 50px;height: 34px;padding-left: 20px">
    订单详情页
    <div c-widget="ButtonGroup" style="float:right">
        <div c-widget="#operations; caption:删除;tag:op;userData:order6" style="background: #dde1e2;color: #000;"></div>
        <div c-widget="#operations; caption:收款; class: active blue; tag:op;userData:order5"></div>
        <div c-widget="#operations; caption:修改;tag:op;userData:order6"></div>
        <div c-widget="#operations; caption:打印;tag:op;userData:order7"></div>
    </div>
</h4>

<div style="padding: 20px;border: 1px rgb(204, 204, 204) solid;box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.349019607843137);">

    <h4 style="text-align: center">
        上海百世龙腾广告装饰有限公司  <span style="margin-left: 15px">销售订单</span>
    </h4>

    <div c-widget="divider"></div>
    <div style="float: right; width:150px;height: 75px;background-color: red"></div>


    <div class="ui form" style="margin-right: 150px">
        <div class="inline fields">
            <div class="field" style="width:300px">
                <label>客户名称</label>
                <label style="margin-left: 30px">浙江好拉文化传媒有限公司</label>
            </div>
            <div class="field">
                <label>销售代表</label>
                <label  style="margin-left: 30px">赵石磊</label>
            </div>
        </div>
        <div class="inline fields">
            <div class="field" style="width:300px">
                <label>联系姓名</label>
                <label style="margin-left: 30px">金仁波</label>
                <label style="margin-left: 30px">18621619311</label>
            </div>
            <div class="field">
                <label>单据号码</label>
                <label style="margin-left: 30px">10001</label>
            </div>
        </div>
        <div class="inline fields">
            <div class="field" style="width:300px">
                <label>订单日期</label>
                <label style="margin-left: 30px">2016-04-21</label>
            </div>
            <div class="field">
                <label>项目名称</label>
                <label style="margin-left: 30px">好拉文化传媒上市庆典</label>
            </div>
        </div>
    </div>

    <div c-widget="divider"></div>

    <div class="ui form">
        <div id="tableContainer" class="field" style="margin-bottom: 30px;">

        </div>
        <div c-widget="divider"></div>
        <div class="fields">
            <div class="sixteen wide field">
                <div style="float: right; margin-top: 50px">
                    <table>
                        <tr>
                            <td style="width: 80px;text-align: right">小计金额</td>
                            <td style="width: 150px;text-align: right">1200.00</td>
                        </tr>
                        <tr>
                            <td style="width: 80px;text-align: right">优惠或折扣</td>
                            <td style="width: 150px;text-align: right">-120.00</td>
                        </tr>
                        <tr>
                            <td style="width: 80px;text-align: right">合计金额</td>
                            <td style="width: 150px;text-align: right">1080.00</td>
                        </tr>

                    </table>

                    <div c-widget="divider"></div>

                    <table>
                        <tr>
                            <td style="width: 80px;text-align: right">预收金额</td>
                            <td style="width: 150px;text-align: right"></td>
                        </tr>

                        <tr>
                            <td style="width: 80px;text-align: right">应收金额</td>
                            <td style="width: 150px;text-align: right">1080.00</td>
                        </tr>
                    </table>

                </div>

                <p>
                    <br/>
                    <br/>
                <span style="text-decoration: underline">
                    备注：送货到 火车站附近的汉庭酒店大堂 联系人 张小姐  电话186-9898-8888
                </span>
                    <br/>
                    <br/>
                    <br/>
                    制单人：当前用户   <span style="margin: 0px 15px">制单时间：2015-10-14</span>      系统唯一流水号-XS2015082612345678
                </p>

            </div>

        </div>

    </div>

    <div c-widget="divider"></div>



</div>

</body>
</html>