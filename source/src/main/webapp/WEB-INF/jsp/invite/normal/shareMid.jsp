<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>邀请注册</title>
    <style type="text/css">
        html,body{
            width: 100%;
            margin: 0px;
            padding: 0px;
            position: relative
        }
        .select{
            height: 580px;
            width: 100%;
            overflow: hidden;
        }
        .select2{
            background: #2e8ae6;
        }

        .select4{
            background: #3dcc74;
        }
        .select6{
            background: #ee8e52;
        }
        .pcimg{
            margin: 0px auto;
        }
        .pcimg img{
            width: 100%;
            height: auto;
        }
        @media only screen and (min-width: 1000px) {
            .mobile{
                display: none;
            }
            .pcimg{
                width: 1000px;
            }
        }
        @media only screen and ( min-width : 721px) and ( max-width : 999px){
            .pcimg{
                width: 100%;
            }
        }
        @media only screen and ( max-width : 720px){
            .pc{
                display: none;
            }
            .mobile img{
                width: 100%;
            }
        }
    </style>
</head>
<body>
<div class="pc">
    <div class="select1 select">
        <div class="pcimg">
            <img src="/images/activity/pc1.png" onclick="window.location.href='${url}'" alt="" />
        </div>
    </div>
    <div class="select2 select">
        <div class="pcimg">
            <img src="/images/activity/pc2.png" alt="" />
        </div>
    </div>
    <div class="select3 select">
        <div class="pcimg">
            <img src="/images/activity/pc3.png" alt="" />
        </div>
    </div>
    <div class="select4 select">
        <div class="pcimg">
            <img src="/images/activity/pc4.png" alt="" />
        </div>
    </div>
    <div class="select5 select">
        <div class="pcimg">
            <img src="/images/activity/pc5.png" alt="" />
        </div>
    </div>
    <div class="select6 select">
        <div class="pcimg">
            <img src="/images/activity/pc6.png" alt="" />
        </div>
    </div>
    <div class="select7 select">
        <div class="pcimg">
            <img src="/images/activity/pc7.png" alt="" />
        </div>
    </div>
</div>

<div class="mobile">
    <img src="/images/activity/m01.png" onclick="window.location.href='${url}'" alt="" />
    <img src="/images/activity/m02.png" alt="" />
    <img src="/images/activity/m03.png" alt="" />
    <img src="/images/activity/m04.png" alt="" />
    <img src="/images/activity/m05.png" alt="" />
    <img src="/images/activity/m06.png" alt="" />
    <img src="/images/activity/m07.png" alt="" />
</div>
</body>
</html>
