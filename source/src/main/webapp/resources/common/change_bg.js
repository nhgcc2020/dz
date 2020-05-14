// 登录界面根据要求换背景js

$(function () {
    var imgLoadBack_ground = function (url) {
        var img = new Image();
        img.src = url;
        if (img.complete) {
            $(".back_ground").css("background-image","url("+url+")").fadeIn();
        } else {
            img.onload = function () {
                $(".back_ground").css("background-image","url("+url+")").fadeIn();
                img.onload = null;
            };
        };
    };
    var now = new Date(),hour = now.getHours(),day=now.getDay();
    if(day=="6" || day=="0"){
        $(".hope_word").html('<img src="/images/end_word.png" />').show();
        imgLoadBack_ground("/images/login_bg3.jpg");
    }else{
        if(hour < 6 || hour > 19) {
            $(".hope_word").html('<img src="/images/night_word.png" />').show();
            imgLoadBack_ground("/images/night.jpg");
        } else{
            $(".hope_word").html('<img src="/images/hope_word.png?v=1" />').show();
            // http://cn.bing.com/hpwp/fa908c686abab948c3cc64151cbb65d7?intlF=&rdr=1&rdrig=DCF6CE55E0BF4B7FA6B7F610A2B5C663
//            imgLoadBack_ground("/images/regest_bg.jpg?v=1");
            imgLoadBack_ground("/images/login_bg3.jpg?v=1");
        }
    }
    var oStyle = "";
    oStyle += ".hope_word img{height:auto !important;}\n";
    oStyle += "@media only screen and (max-width: 1200px) {.hope_word{display: none;}}\n";
    oStyle += ".back_ground{height:100%;background-size:cover;-webkit-transition:background 1s}.hope_word{position:absolute;top:150px;left:12%;}\n";
    $("head").append("<style>"+oStyle+"</style>");



})
