/**
 * Created by pxy on 16/9/2.
 */
//倒计时封装
(function ($) {
    $.fn.countdown_custom = function (n) {
        //var n = 60;  //设置初始时间
        var _this = $(this);
        _this.attr("disabled", "true");
        _this.html(n + "秒后重新获取").css('color', '#999');
        var timer = setInterval(function () {
            if (n == 0) {
                clearInterval(timer); //停止计时器
                _this.removeAttr("disabled"); //启用按钮
                _this.html("重新发送验证码").css('color', '#fff');
            } else {
                n--;
                _this.html(n + "秒后重新获取");
            }
        }, 1000);
    }
})(jQuery);

(function () {
    //工具
    var util = window.util = {
        //解析文件名
        setOrderData: function (file_name) {
            //用于返回的对象
            var file_data = {};
            var new_file_name = file_name.replace(/(厘米|公分)/g, "");
            var ary = new_file_name.match(/([\d\.]+[-x_X\*\s\+]{1,5}){3}/g);
            if (!ary) {
                ary = new_file_name.match(/([\d\.]+[-x_X\*\s\+]{1,5}){2}([\d\.]+)/g);
            }
            if (!ary) {
                ary = new_file_name.match(/([\d\.]+[-x_X\*\s\+]{1,5}){2}/g);
            }
            if (!ary) {
                ary = new_file_name.match(/([\d\.]+[-x_X\*\s\+]{1,5}[\d\.]+)/g);
            }
            if (ary) {
                var str = ary.toString().replace(/[-x_X\*\s\+]{1,5}/g, "-");
                ary = str.split('-');
                file_data.name = file_name;
                file_data.length = (ary[0] / 100);
                file_data.width = (ary[1] / 100);
                if (ary[2]) {
                    file_data.number = ary[2];
                }
                else {
                    file_data.number = 1;
                }
                return file_data;
            }
            // alert('暂未获取到匹配的数据');
        },
        // 判断年份是否为润年 @param {Number} year
        isLeapYear: function (year) {
            return (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0);
        },
        //获取某一年份的某一月份的天数 @param {Number} year @param {Number} month
        getMonthDays: function (year, month) {
            return [31, null, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month] || (this.isLeapYear(year) ? 29 : 28);
        },
        //校验手机号
        checkPhone: function (phone) {
            var myreg = /^1[34578]\d{9}$/;
            // var myreg = /^(((13[0-9]{1})|(17[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;


            // if (!myreg.test(phone)) {
            //     return false;
            // } else {
            //     return true;
            // }
            //暂时去掉手机格式验证
            if(phone.length==11){
                return true;
            }else{
                return false;
            }
        },
        //校验密码 目前仅为长度校验
        checkPwd: function (pwd) {
            var pa = /^(\w){6,20}$/;
            if (!pa.test(pwd)) {
                return false;
            } else {
                return true;
            }
        }


    }
})();