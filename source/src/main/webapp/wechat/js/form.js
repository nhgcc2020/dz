/**
 * Created by ukey on 16/8/26.
 */


//倒计时封装
(function($){
    $.fn.countdown= function (timeout_id) {
        var n = 120;  //设置初始时间
        var _this = $(this);
        _this.attr("disabled", "true");
        _this.text(n + "秒后重新获取").css('color','#999');
        var timer = setInterval(function(){
            if (n == 0) {
                clearInterval(timer); //停止计时器
                _this.removeAttr("disabled"); //启用按钮
                _this.text("重新发送验证码").css('color','#2e8ae6');
            }else{
                n--;
                _this.text(n + "秒后重新获取").css('color','#999');
            }
        },1000);
    };
})(jQuery);


$(function(){
    var regPassworld = /^[0-9A-Za-z]{6,20}$/;  //密码长度
    var regPhone = /^(((13[0-9]{1})|(17[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;  //验证手机号码

    //验证手机号码
    $('#phone-verification').blur(function(){
        if(!reg.test($("#phone-verification").val())){
            $('.tip_hide').fadeIn().html('手机号码不正确').delay(2000).fadeOut();
        }else{
            $('.tip_hide').hide();
        }
    });


    //验证手机号码2
    $('#phone-verification-sec').blur(function(){
        var regPhone = /^(((13[0-9]{1})|(17[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
        if(!regPhone.test($("#phone-verification").val())){
            $('.tip_hide').fadeIn().html('手机号码不正确').delay(2000).fadeOut();

        }else{
            $('.tip_hide').hide();
        }
    });

    //设置新密码new-password.html
    function check_password(){
        $('#new-possworld , #re-possworld').blur(function(){
            if($('#new-possworld').val()=="" && $('#re-possworld').val()==""){
                $('.tip_hide').html('密码不能为空').fadeIn().delay(2000).fadeOut();
                return false;
            }
            if(!regPassworld.test($('#new-possworld'))){
                $('.tip_hide').html('密码不符合要求').fadeIn().delay(2000).fadeOut();
                return false;
            }
            if( $('#new-possworld').val() != $('#re-possworld').val()){
                $('.tip_hide').html('两次密码不一致').fadeIn().delay(2000).fadeOut();
                return false;
            }
            if($('#new-possworld').val()!="" && $('#re-possworld').val()!="" && $('#new-possworld').val() != $('#re-possworld').val() && regPassworld.test($('#new-possworld'))){
                $('#finshed').removeAttr('disabled').css('background','#2e8ae6');
                return ture;
            }
        })
    }
    check_password();
});

