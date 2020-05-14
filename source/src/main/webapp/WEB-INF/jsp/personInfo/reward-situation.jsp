<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: pxy
  Date: 16/8/22
  Time: 上午10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>奖励情况</title>
    <base href="/">
    <link rel="stylesheet" type="text/css" href="/resources/nprogress/nprogress.css?v=b7ac70ebbe">
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <script src="/resources/nprogress/nprogress.js?v=234c9db3ed"></script>
    <script src="/resources/jquery/jquery-2.1.3.js?v=b11891de95"></script>
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <link rel="stylesheet" type="text/css" href="   /resources/business/global.css?v=76321dbcfe">
    <style>
        .invite_contants_bTitllle{
            height:80px;
            background: rgba(255,153,0,0.7);
            line-height:80px;
            color: #fff;
            font-size:36px;
            text-align: center;
            margin-bottom: 15px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div style="background: #fff; overflow: hidden;">
    <div class="invite_contants_bTitllle">邀请好友使用 ，立获现金奖励</div>
</div>

<div class="invite_contants">
    <div class="invite_list_title">
        奖励情况
    </div>
    <div class="invite_deteal">
        <ul>
            <li>
                <p>奖励总额</p>
                <b id="sumNum"></b>
                <a href="javascript:void(0);" style="color: #FF9900;" id="see_rule">查看活动规则 > ></a>
            </li>
            <li>
                <p>已提现</p>
                <b id="withdraw"></b>
            </li>
            <li>
                <p>账户余额</p>
                <b class="invite_deteal_price" id="balance"></b>
                <p><a href="javascript:void(0);" class="invite_deteal_withdrawal">提现</a></p>
            </li>
            <li>
                <%--<p>已邀请 (<span>20</span>) </p>--%>
                <p>已注册 (<span id="regNum"></span>) </p>
                <p>已付费 (<span id="payNum"></span>) </p>
            </li>
        </ul>
    </div>


    <ul class="invite_title_list">
        <li>奖励情况</li>
        <li>注册列表</li>
        <li>付费列表</li>
    </ul>

    <div class="tableContorl">
        <div class="invite_list_resoult">
            <div class="invite_list_title">
                奖励提成明细
                <select>
                    <option value="全部">全部</option>
                    <option value="全部">已发</option>
                    <option value="全部">未发</option>
                </select>
            </div>
            <table id="rewardRed">
                <%--
                <tr>
                    <td class="invite_list_resoult_cut">-100元</td>
                    <td>上海好啦啦啦文化传媒有限公司</td>
                    <td>邀请时间:2016-08-18</td>
                    <td>注册时间:2016-08-18</td>
                    <td>付费时间:2017-07-21</td>
                </tr>
                --%>
            </table>
        </div>
        <div class="invite_list">
            <table id="regList">
                <tr>
                    <th>真实姓名</th>
                    <th>手机号码</th>
                    <th>所创建的公司</th>
                    <th>注册日期</th>
                    <th>状态</th>
                </tr>
            </table>
        </div>
        <div class="invite_list">
            <table id="padList">
                <tr>
                    <th>真实姓名</th>
                    <th>手机号码</th>
                    <th>所创建的公司</th>
                    <th>注册日期</th>
                    <th>付费日期</th>
                </tr>
                <%--<tr>
                    <td>12301</td>
                    <td>vampire</td>
                    <td>赵大全</td>
                    <td>13611112222</td>
                    <td>上海戴戴帽邮箱公司</td>
                    <td>2017-07-21 17:32:23</td>
                    <td>2017-07-21 17:32:23</td>
                </tr>--%>
            </table>
        </div>
    </div>
</div>

<script>
    $.get("<c:url value="/ydz/user/rewardSituation"/>",{},function (callback) {

        var data = eval("("+callback+")");
        var baseData = data.baseData;
        $("#sumNum").text(baseData.sumNum+"元");
        $("#withdraw").text(baseData.withdraw+"元");
        $("#balance").text(baseData.balance+"元");
        $("#regNum").text(baseData.regNum);
        $("#payNum").text(baseData.payNum);

        $.each(data.rewardRed,function(key,val){
            //奖励情况
            document.getElementById("rewardRed").innerHTML +=
                    "<tr>"
                    +"<td class='invite_list_resoult_add' style='width:15%'>"+val.rewardMoney+"</td>"
                    +"<td style='width:25%'>"+val.comName+"</td>"
                    +"<td style='width:30%'>注册时间:"+val.payedTime+"</td>"
                    +"<td style='width:30%'>付费时间:"+val.payedTime+"</td>"
                    +"</tr>";
            //付费列表
            document.getElementById("padList").innerHTML +=
                    "<tr>"
                    +"<td style='width:15%'>"+val.realName+"</td>"
                    +"<td style='width:20%'>"+val.userId+"</td>"
                    +"<td style='width:25%'>"+val.comName+"</td>"
                    +"<td style='width:25%'>"+val.payedTime+"</td>"
                    +"<td style='width:15%'>"+val.payedTime+"</td>"
                    +"</tr>";
        });

        $.each(data.regList,function(key, val){
            //注册列表
            document.getElementById("regList").innerHTML +=
                    "<tr>"
                    +"<td style='width:15%'>"+val.realName+"</td>"
                    +"<td style='width:20%'>"+val.userId+"</td>"
                    +"<td style='width:25%'>"+val.comName+"</td>"
                    +"<td style='width:25%'>"+val.createTime+"</td>"
                    +"<td style='width:15%'>已注册</td>"
                    +"</tr>";
        });


    })

    $(function () {
        $(".invite_title_list li").eq(0).addClass("active");
        $(".invite_title_list li").click(function(){
            $(this).addClass("active").siblings().removeClass("active");
            var _this = $(this).index();
            $(".tableContorl>div").eq(_this).css("display","block").siblings().css("display","none");
        });

        $("#see_rule").click(function(){
            $.get("/invite/normal/getKey", {}, function (data) {
                $("#inventMsgShow",parent.document).text("链接地址:"+data);
                $("#inventMsg",parent.document).val(data);

                $('.invent_user',parent.document).fadeIn();
                $('.blur_box',parent.document).addClass("blur");
            })
        });

        $(".invite_deteal_withdrawal").click(function(){
            $("<div class='tips_contants'>").fadeIn(250).html("开发中，很快就好").delay(500).fadeOut(250).appendTo('body');
        })
    });

    window.onload = function(){
        history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
    }
</script>
</body>
</html>