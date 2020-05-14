<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ydz
  Date: 2016/8/3
  Time: 11:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>支付宝支付</title>
</head>
<script src="resources/jquery/jquery-2.1.3.js"></script>
<script src="resources/pingpp/pingpp.js"></script>
<script type="text/javascript">
    //var pingpp = require('pingpp-js');
    function GetRequest() {
        var url = location.search; //获取url中"?"符后的字串
        var theRequest = new Object();
        if (url.indexOf("?") != -1) {
            var str = url.substr(1);
            strs = str.split("&");
            for(var i = 0; i < strs.length; i ++) {
                theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]);
            }
        }
        return theRequest;
    }
    pingpp.createPayment(GetRequest().aaa, function(result, err){
        console.log(result);
        console.log(err.msg);
        console.log(err.extra);
        if (result == "success") {
            // 只有微信公众账号 wx_pub 支付成功的结果会在这里返回，其他的支付结果都会跳转到 extra 中对应的 URL。
        } else if (result == "fail") {
            // charge 不正确或者微信公众账号支付失败时会在此处返回
        } else if (result == "cancel") {
            // 微信公众账号支付取消支付
        }
    });



    function buybuybuy() {
        $.post("<c:url value="/aliPay/orderbooking"/>",{"product":$("input[name='product']").val()},function (charge) {

            pingpp.createPayment(charge, function(result, err){
                console.log(result);
                console.log(err.msg);
                console.log(err.extra);
                if (result == "success") {
                    // 只有微信公众账号 wx_pub 支付成功的结果会在这里返回，其他的支付结果都会跳转到 extra 中对应的 URL。
                } else if (result == "fail") {
                    // charge 不正确或者微信公众账号支付失败时会在此处返回
                } else if (result == "cancel") {
                    // 微信公众账号支付取消支付
                }
            });
        })
        var charge = {
            "id": "ch_WbfbXL5uzDm5qnfDiPrXnfzH",
            "object": "charge",
            "created": 1476278862,
            "livemode": true,
            "paid": false,
            "refunded": false,
            "app": "app_KCqjj9anjv14COOy",
            "channel": "alipay_pc_direct",
            "order_no": "1476278860235t0e0mga",
            "client_ip": "127.0.0.1",
            "amount": 100,
            "amount_settle": 100,
            "currency": "cny",
            "subject": "Your Subject",
            "body": "Your Body",
            "time_paid": null,
            "time_expire": 1476365262,
            "time_settle": null,
            "transaction_no": null,
            "refunds": {
                "object": "list",
                "url": "/v1/charges/ch_WbfbXL5uzDm5qnfDiPrXnfzH/refunds",
                "has_more": false,
                "data": []
            },
            "amount_refunded": 0,
            "failure_code": null,
            "failure_msg": null,
            "metadata": {},
            "credential": {
                "object": "credential",
                "alipay_pc_direct": {
                    "service": "create_direct_pay_by_user",
                    "_input_charset": "utf-8",
                    "return_url": "dev.yizuizhang.com",
                    "notify_url": "https://api.pingxx.com/notify/charges/ch_WbfbXL5uzDm5qnfDiPrXnfzH",
                    "partner": "2088221170120107",
                    "out_trade_no": "1476278860235t0e0mga",
                    "subject": "Your Subject",
                    "body": "Your Body",
                    "total_fee": "1.00",
                    "payment_type": 1.0,
                    "seller_id": "2088221170120107",
                    "it_b_pay": "1d",
                    "sign": "i6obpHejzXbkBpDp1E0bje4Fb/nMcW8QekKOS0OYcl1IDIyRHrwbFW/Hg9eiwtgaCU2ph3tP89ovqNy+ogeCd5TiG2I2/UGx2gAyyppnnmhSGR6oHO4w1rdD0JMRLbttDxym/6JYsdc4swxlMCEZox+eedMb8i9RwHHRSkzWJgk=",
                    "sign_type": "RSA"
                }
            },
            "extra": {
                "success_url": "dev.yizuizhang.com"
            },
            "description": null
        }

    }
</script>
<body>

</body>
</html>
