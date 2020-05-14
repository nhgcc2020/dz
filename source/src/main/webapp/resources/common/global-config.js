//var dz_url = "https://test.yiduizhang.com/";
//var dz_url = "https://www.yiduizhang.com/";
var dz_url = "http://zstone.ittun.com/";



//关闭父集页面的所有下拉框
function bodyClick(){
    $("body").bind('click',function(){
        $('.main_hide',parent.document).slideUp();
        $(".main_botton",parent.document).children('.main_point').removeClass('active');
        $('.reg_loding',parent.document).slideUp();
        $(".user-name",parent.document).children('.username_point').removeClass('active');
    });
}

// 禁止刷新
document.onkeydown = function (e) {
    //F5禁用
    if (e.keyCode == 116) {
        e.keyCode = 0;
        return false;
    }
    //win键禁用
    if (e.keyCode == 91 &&  e.keyCode == 82) {

        e.keyCode = 0;
        return false;
    }
    // ctrl+r 刷新
    if (e.keyCode == 82 && e.ctrlKey  ) {
        e.keyCode = 0;
        return false;
    }
    //shift禁用
    if (e.keyCode == 16) {
        e.keyCode = 0;
        return false;
    }
}