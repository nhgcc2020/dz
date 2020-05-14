<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
    <script src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
    <script src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
</head>
<body style="padding: 5rem 5rem 0 5rem">
    <div id="tool">
        <div c-widget="ButtonGroup">
            <div c-widget="Button; caption:今年"></div>
            <div c-widget="Button; caption:全部"></div>
        </div>

            <div id="startTime"></div>
            <div id="endTime"></div>
            <label>
                当前系统许可到期时间：
            </label>
            <label style="color: red;margin-left: 5rem ">2016-07-08 </label>
    </div>
    <div id="page">
        <div id="pagingTable"></div>

        <div c-widget="Pager; bind:pageItems">
            <a page-code="|<" class="item"></a>
            <a page-code="<" class="item"></a>
            <a page-code="info" class="item"></a>
            <a page-code=">" class="item"></a>
            <a page-code=">|" class="item"></a>
        </div>
    </div>
    <script type="text/javascript">
        cola(function(model) {
            /*model.describe("pageItems", {
                provider: {
                    url: "http://www.cola-ui.com/data/items",
                    pageSize: 5
                }
            });*/

            model.widgetConfig({
                startTime:{
                    $type:"DatePicker"

                },
                endTime:{
                    $type:"DatePicker"

                },
                //交易记录列表
                pagingTable: {
                    $type: "table",
                    bind: "item in pageItems",
                    showHeader: true,
                    currentPageOnly: true,
                    columns: [{
                        bind: ".id",
                        caption: "序号"
                    }, {
                        caption: "交易时间"
                    }, {
                        bind: ".originalPrice",
                        caption: "交易单号"
                    }, {
                        bind: ".title2",
                        caption: "交易类型"
                    }, {
                        bind: ".title3",
                        caption: "交易金额"
                    }, {
                        bind: ".title4",
                        caption: "实付金额"
                    }, {
                        bind: ".title5",
                        caption: "代金券"
                    }, {
                        bind: ".title6",
                        caption: "服务时长"
                    }, {
                        bind: ".title7",
                        caption: "到期时间"
                    }]
                }
            })
        })
    </script>
</body>
</html>
