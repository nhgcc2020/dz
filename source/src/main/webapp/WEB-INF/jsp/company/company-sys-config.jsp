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
    <script type="text/javascript">
        cola(function (model) {
            model.widgetConfig({
                smallRg: {
                    items: ["小规模纳税人（增值税普通发票）"]
                },
                normalRg: {
                    items: ["一般纳税人（增值税专用发票）"]
                },
                loginSettingRg: {
                    items: ["手机号码+密码", "手机号码+密码+短信验证码", "手机号码+密码+微信验证码", "微信扫码登录"]
                }
            });
        });
    </script>
    <meta charset="UTF-8">
    <title></title>
</head>
<body style="margin: 20px">
<div c-widget="divider"></div>

<h4>
    用户可以对自己的系统进行一些自定义。
</h4>

<div c-widget="divider"></div>

<div class="ui form">
    <div class="field" style="font-size: 18px;color: #2E94E1">
        销售订单设置（遵循四舍五入法则）
    </div>

    <div class="field">
        价格
        <div c-widget="Checkbox; label:保留小数点后2位" style="margin:0px 120px;"></div>
        <div c-widget="Checkbox; label:不保留小数点"></div>
    </div>

    <div class="field">
        数量
        <div c-widget="Checkbox; label:保留小数点后2位" style="margin:0px 120px;"></div>
        <div c-widget="Checkbox; label:不保留小数点"></div>
    </div>

    <div class="field">
        税点设置
        <div id="smallRg" c-widget="RadioGroup" style="display: inline;margin-left:86px;"></div>
        <div c-widget="input; placeholder:填入税点数字; width:200px" style="margin-left: 8px"></div>%
    </div>

    <div class="field">
        <div id="normalRg" c-widget="RadioGroup;" style="display: inline;margin-left:146px;"></div>
        <div c-widget="input; placeholder:填入税点数字; width:200px" style="margin-left: 21px"></div>%
    </div>

    <div class="field" style="font-size: 18px;color: #2E94E1">
        用户登录设置（单选项）
    </div>

    <div class="field">
        <div id="loginSettingRg" c-widget="RadioGroup; width:250px; name:loginSetting" style="margin-left: 146px"></div>
    </div>

    <div class="field">
        <div c-widget="button; caption:确定; class:primary; width: 350px"></div>
    </div>

</div>

</body>
</html>