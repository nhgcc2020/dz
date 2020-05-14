
Date.prototype.Format = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "h+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
};
var orderUtil ={
     dateConfig:[
        {key:"ld30",show:"全部时间段"},
        {key:"zt00",show:"昨天"},
        {key:"dt00",show:"今天"},
        {key:"pm00",show:"上月"},
        {key:"tm1",show:"本月"},
        {key:"ty0103",show:"第一季度"},
        {key:"ty0406",show:"第二季度"},
        {key:"ty0709",show:"第三季度"},
        {key:"ty1012",show:"第四季度"},
        {key:"ty0106",show:"上半年"},
        {key:"ty0712",show:"下半年"},
        {key:"ty0112",show:"今年"},
        {key:"ly0112",show:"去年"},
        {key:"ly0106",show:"去年上半年"},
        {key:"ly0712",show:"去年下半年"}
    ],
    dpDateCompute:function(code,num){
        var nowDate = new Date;
        var beforeDate = null;
        var year = null;
        var beforeMonth = null;
        var prefix = null;
        var suffix = null;
        switch(code){
            case "ld":
                var dayNumMS = 86400*1000*num;
                var beforeDateMS = nowDate.getTime() - dayNumMS;
                beforeDate = "";
                // beforeDate = new Date(beforeDateMS).Format("yyyy-MM-dd");
                nowDate ="";
                break;
                case "dt":
                beforeDate = new Date().Format("yyyy-MM-dd");
                nowDate =new Date().Format("yyyy-MM-dd");
                break;
                case "pm":
                beforeDate = getPreMonth(0);
                nowDate =getPreMonth(1);
                break;
                case "zt":
                     var day1 = new Date();
                     day1.setTime(day1.getTime()-24*60*60*1000);
                    beforeMonth=day1.getMonth()+1;
                    if(beforeMonth<10){beforeMonth="0"+beforeMonth};
                     var s1 = day1.getFullYear()+"-" +beforeMonth+ "-" + day1.getDate();
                beforeDate = s1;
                nowDate =s1;
                break;
            case "tm":
                year  = nowDate.getFullYear();
                beforeMonth = nowDate.getMonth() + 1;
                if(beforeMonth<10){beforeMonth="0"+beforeMonth};
                beforeDate = year+"-"+beforeMonth+"-01";
                var  day = new Date(year,beforeMonth,0);
                 nowDate = year + '-' + beforeMonth + '-' + day.getDate();    //获取月份的最后一天
                // nowDate = new Date().Format("yyyy-MM-dd");
                break;
            case "lm":
                year  = nowDate.getFullYear();
                var month = nowDate.getMonth();
                beforeMonth = nowDate.getMonth()+1-num;
                beforeDate = year+"-"+beforeMonth+"-01";
                nowDate =  year+"-"+month+"-"+window.util.getMonthDays(year,month-1);
                break;
            case "ty":
                prefix = num.substring(0,2);
                suffix = num.substring(2,4);
                year  = nowDate.getFullYear();
                beforeDate = year+"-"+prefix+"-01";
                nowDate =  year+"-"+suffix+"-"+window.util.getMonthDays(year,suffix-1);
                break;
            case "ly":
                prefix = num.substring(0,2);
                suffix = num.substring(2,4);
                year  = nowDate.getFullYear() - 1;
                beforeDate = year+"-"+prefix+"-01";
                nowDate =  year+"-"+suffix+"-"+window.util.getMonthDays(year,suffix-1);
                break;
        }
        var callback = {
            beforeDate:beforeDate,
            nowDate:nowDate
        };
        return callback;
    }

};

function getPreMonth(type) {
    var arr = new Date().Format("yyyy-MM-dd").split('-');
    // var arr = new String("2014-01-01").split('-');
    var year = arr[0]; //获取当前日期的年份
    var month = arr[1]; //获取当前日期的月份
    var day = arr[2]; //获取当前日期的日
    var days = new Date(year, month, 0);
    days = days.getDate(); //获取当前日期中月的天数
    var year2 = year;
    var month2 = parseInt(month) - 1;
    if (month2 == 0) {//如果是1月份，则取上一年的12月份
        year2 = parseInt(year2) - 1;
        month2 = 12;
    }
    var day2 = day;
    var days2 = new Date(year2, month2, 0);
    days2 = days2.getDate();
    if (month2 < 10) {
        month2 = '0' + month2;//月份填补成2位。
    }
    var t2 ="";
    if(type==0){
        t2=year2 + '-' + month2 + '-' + "01";
    }else{
        t2=year2 + '-' + month2 + '-' + days2;
    }

    return t2;
}

