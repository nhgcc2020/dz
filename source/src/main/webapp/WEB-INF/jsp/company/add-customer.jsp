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
    <script type="text/javascript">
        cola(function (model) {

            model.set("company", {
                comId: "Y2D68Z",
                comName: "上海好拉文化传媒有限公司",
                comNickName: "好拉传媒",
                comLogoPath: "../images/companylogo.png",
                comType: "有限公司",
                areaCode: "0572",
                comTel: "66887799"
            });
            model.set({
                customerCategory:[
                    {
                        key: "VIP客户",
                        text: "VIP客户"
                    },
                    {
                        key: "重点客户",
                        text: "重点客户"
                    },
                    {
                        key: "普通客户",
                        text: "普通客户"
                    }

                ],
                customerStatus:[
                    {
                        key: "潜在客户",
                        text: "潜在客户"
                    },
                    {
                        key: "合作客户",
                        text: "合作客户"
                    },
                    {
                        key: "流失客户",
                        text: "流失客户"
                    }

                ]
            })
            $("#addCustomerDialog").modal("show");
        });
    </script>
</head>
<body>

<div id="addCustomerDialog" class="ui test long scrolling small modal">
    <div class="header">
        新增客户
    </div>
    <div class="image content" style="height: 680px">
        <div class="ui form">
            <div class="inline field">
                <label style="width: 80px"><span style="color: red">*</span>简称或品牌</label>
                <div c-widget="input;placeholder:外界通称 如：仁石科技或易对账（小于8汉字）;width:400px"></div>
            </div>
            <div class="inline field">
                <label style="width: 80px"><span style="color: red">*</span>助记代码</label>
                <div c-widget="input;placeholder:如：RSKJ;width:400px"></div>
            </div>
            <div class="inline field">
                <label style="width: 80px"><span style="color: red">*</span>客户分类</label>
                <div c-widget="select;options:{{customerCategory}};width:400px"></div>
            </div>
            <div class="inline field">
                <label style="width: 80px"><span style="color: red">*</span>客户状态</label>
                <div c-widget="select;options:{{customerStatus}};width:400px"></div>
            </div>

            <div c-widget="divider"></div>

            <div class="inline fields">
                <div class="field">
                    <label style="width: 80px"><span style="color: red">*</span>联系姓名</label>
                    <div c-widget="input;placeholder:请输入姓名;width:400px"></div>
                </div>

            </div>
            <div class="inline fields">
                <div class="field">
                    <label style="width: 80px"><span style="color: red">*</span>联系电话</label>
                    <div c-widget="input;placeholder:常用手机号或短号;width:193px"></div>
                </div>
                <div class="field">
                    <div c-widget="input;placeholder:备用手机号或短号;width:193px"></div>
                </div>
            </div>
            <div class="field">
                <p style="margin-left: 85px">（类似微信，当客户注册时，系统会提醒他加你为友好企业）</p>
            </div>

            <div c-widget="divider"></div>

            <div class="inline field">
                <label style="width: 80px">客户全称</label>
                <div c-widget="input;placeholder:不能超过20个汉字 如：上海仁石科技有限公司;width:400px"></div>
            </div>
            <div class="inline field">
                <label style="width: 80px"></span>所属部门</label>
                <div c-widget="select;placeholder:全公司（默认）;width:400px"></div>
            </div>
            <div class="inline field">
                <label style="width: 80px">公司地址</label>
                <div c-widget="input;width:400px"></div>
            </div>

            <div class="field">
                <div c-widget="checkbox;label:免费发送邀请短信：（内容如下）"></div>
                <p style="margin:15px 15px 15px 15px">
                    【易对账】上海好拉文化传媒有限公司的张思远邀请你一同使用“易对账”软件进行往来业务对账，点击链接http://web.yiduizhang.com/user/djksahdhffhrh进行注册。或者在电脑上访问www.yiduizhang.com免费注册后使用更便利。加我们的企业对账号DFH878或者我的手机号（18621619311注：管理员手机号）就可以成为
                </p>
            </div>

        </div>
    </div>
    <div class="actions">
        <div c-widget="button;caption:取消" style="float:left"></div>
        <div c-widget="button;class:primary;caption:保存并新增"></div>
        <div c-widget="button;class:primary;caption:保存"></div>

    </div>
</div>

</body>
</html>
