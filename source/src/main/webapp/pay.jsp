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
    <title>支付宝支付测试</title>
</head>
<script src="resources/jquery/jquery-2.1.3.js"></script>
<script src="resources/pingpp/pingpp.js"></script>
<script src="resources/util/jquery.qrcode.min.js"></script>
<script type="text/javascript">
    //var pingpp = require('pingpp-js');
    function buybuybuy() {
        //window.location.href="<c:url value="/pay/orderbooking?product="/>"+$("input[name='product']").val();
        $('#code').qrcode("weixin://wxpay/bizpayurl?pr=DUEC8oW");
    }

    function submit(){
        var paraArray = [];
        for(var i = 0;i<5;i++){
            paraArray.push(Math.floor(Math.random() * 100));
        }

        $.ajax({
            url:"/reg/test",
            type:"post",
            data:{
               "para":paraArray,
                "id":"1"
            },
            dataType:"json",
            /*contentType:"application/json",*/
            traditional: true,
            success:function(data){
            }
        })
    }
/*
    */

    /*
     $.post("/reg/test",{para:paraArray},function(data){

     });
     */
</script>
<body>
    <button onclick="submit()">ajax数组提交测试</button>


    <div style="width: 500px;height: 600px">
        <div id="code">

        </div>
        <div>好多商品思密达</div>
        <div>
            <ul>
                <li><input name="product" value="macbook pro" type="radio"/>macbook pro</li>
                <li><input name="product" value="macbook air" type="radio"/>macbook air</li>
                <li><input name="product" value="nothing" type="radio"/>都要</li>
            </ul>
            <div>
                <button onclick="buybuybuy()">下单GO!</button>
            </div>
        </div>
    </div>
</body>
</html>
