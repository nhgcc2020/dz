$(function(){
    // 返回顶部
    $(window).scroll(function () {
        // 导航栏跟随滚动
        if ($(window).scrollTop() > 800) {
            $('#crest').show();
        } else {
            $('#crest').hide();
        };
        $("#crest").click(function () {
            var i = $(window).scrollTop()
             var a =  setInterval(function () {
                    i = i - 100;
                    $(window).scrollTop(i);
                    if(i<0){
                        clearInterval(a);
                    }
                }, 10)
        })
    });
    $("#login").click(function(){
        window.location.href="/login.jsp";
    })
    $("#register").click(function(){
        window.location.href="/register.jsp";
    })
})