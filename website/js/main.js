$(document).ready(function(){
	
	//首页导航
	$('.top-heard li').mousemove(function(){
		$(this).children('span').stop(true).animate({
			width:"75%",
		},300);
	});

	$('.top-heard li').mouseleave(function(){
		$(this).children('span').stop(true).animate({
			width:"0",
		},300);
	});

	//登录
	$('.heard-login li:first').mousemove(function(){
		$(this).children('span').stop(true).animate({
			width:"75%",
		},300);
	});

	$('.heard-login li:first').mouseleave(function(){
		$(this).children('span').stop(true).animate({
			width:"0",
		},300);
	});
	
	//首页多页签
	(function(){
		var index = 0;
		$('.Service-list li').click(function(){
			index = $(this).index();
			$(this).addClass('active').siblings().removeClass('active');	//点击添加类名
			$('.Service-content li').eq(index).stop(true).slideDown().siblings().stop(true).slideUp();  //点击隐藏或者显示
			//服务列表置顶
			$(window.parent.document.body).animate({
				scrollTop:($('#introduce').offset().top)+90,
			},500);
		});
		// 设置定时
		var mytime = setInterval(play,4000);
		function play(){
			index++;
			index%=6;   //index 除以6取余
			$('.Service-list li').eq(index).addClass('active').siblings().removeClass('active');	//点击添加类名
			$('.Service-content li').eq(index).stop(true).slideDown().siblings().stop(true).slideUp();  //点击隐藏或者显示
		}
		//鼠标悬停
		$('.Service-list').mousemove(function(){
			clearInterval(mytime);
		});
		//鼠标移出
		$('.Service-list').mouseleave(function(){
			mytime = setInterval(play,4000);
		});
	})();

	// 二维码显示隐藏
	$('.wechat').click(function(){
		$('.modal').stop(true).slideDown();
		$('.modal').click(function(){
			$('.modal').stop(true).slideUp();
		})
	})
	
	// 手机端
	$('.menu').click(function(){   //网站菜单点击隐藏
		$('.hide_menu').stop(true).slideDown();
	});
	
	// 菜单点击隐藏
	$('.mobile_close').click(function(){
		$('.hide_menu').stop(true).slideUp();
	})

	//服务列表
	$('.index_content ul:first').css('display','block');
	$('.index_content h2').click(function(){
		$(this).next('ul').slideDown().siblings('ul').slideUp();
		var _this = $(this).index()/2+1;
		$(window.parent.document.body).animate({
			scrollTop:($('.index_content').offset().top+_this*37),
		},1000);
	});

	//banner切换 已被移走,就首页用而其他地方调用


	//注册
	$(".reg_btn").click(function(){
		/*$(".Regbox").fadeIn();
		$(".hide_menu").fadeOut();*/
		dialogType = "1";
		window.location.href="/register.jsp";
	});

	//登录
	$(".login_btn").click(function(){
		/*$(".Loginbox").fadeIn();
		$(".hide_menu").fadeOut();*/
		dialogType = "2";
		window.location.href="/login.jsp";
	});
	
	//修改密码
	$("#forget_pass").click(function(){
		$(".Loginbox").fadeOut();
		$(".findPassword").fadeIn();
	});
	
	//已有账号
	$("#have_member").click(function(){
		$(".Regbox").fadeOut();
		$(".Loginbox").fadeIn();
	});
	
	//没有账号
	$("#no_member").click(function(){
		$(".Loginbox").fadeOut();
		$(".Regbox").fadeIn();
	});
	
	//关闭窗口
	$(".Reg_box_close").click(function(){
		$(".Regbox").fadeOut();
		$(".Loginbox").fadeOut();
		$(".findPassword").fadeOut();
	});
	//公众号展示二维码
	$("#codeShow").hover(function(){
        indexTimeCtrl = setTimeout(function(){
                $("#qr_code").fadeIn();
            },
            200);
	},function(){
        clearTimeout(indexTimeCtrl);
        $("#qr_code").fadeOut();
	});
    var indexTimeCtrl;
	$("#codeClose").click(function(){
	$("#codeShow,#qr_code").remove();	
	});
	
	
	var LoginBox =  window.parent.document.getElementById("Loginbox");
	$(".index-login").click(function(){
		$(LoginBox).fadeIn();
	});
});