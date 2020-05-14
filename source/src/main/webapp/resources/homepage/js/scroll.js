$(document).ready(function(){
	// 设置滚动监听
	$(window).scroll(function(){
		// 导航栏跟随滚动
		if($(window).scrollTop()>800) {
			$('.heard').css('position','fixed').css('z-index','99');
		}else{
			$('.heard').css('position','relative');
		};
	});
});



