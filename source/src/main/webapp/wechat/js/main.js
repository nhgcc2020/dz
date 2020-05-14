$(function(){
	//tab切换
	$('.all_statements li').click(function(){
		index = $(this).index();
		$(this).addClass('active').siblings().removeClass('active');
		$('.all_statements_list ul').eq(index).addClass('active').siblings().removeClass('active')  //点击隐藏或者显示
	});

});

//全局参数快递方法
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



// 退出登录

//test
var appid_URL = "wx9d4eb676e912d52b";
var redirect_uri_URL = "http://zstone.ittun.com/wechat/getWechatCode";

//producing
//var appid_URL = "wx3f569c5ced5933fd";
//var redirect_uri_URL = "https://www.yiduizhang.com/wechat/getWechatCode";
