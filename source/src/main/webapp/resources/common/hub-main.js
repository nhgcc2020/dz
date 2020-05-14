
//检测高度
function screnHeight(){
    $(".preson-container,#iframepage").height($(document.body).height()-$(".preson-menu").height());	//底部框架的高度
    // $(".preson-container-right").width( $(document.body).width()-$(".preson-container-left").width() );	//右侧框架的高度
    $("#pandect-list").height( $(window).height()-189);		//总揽公司列表高度
};
$(window).bind("resize", function(e){
    screnHeight();
});
//左侧导航切换
function menuClick(){
    $(".preson-container-left-menu li").eq(0).addClass("hover");
    $(".preson-container-left-menu li").click(function(){
        $(this).addClass("hover").siblings().removeClass("hover");
    });
}

//法人代表切换
function choseManger(){
    $(".chose-manger li").click(function(){
        $(this).addClass("active").siblings().removeClass("active");
    })
}

//创建企业
function createCompanyModel(val){
    var creatrCompany =  window.parent.document.getElementById("creatrCompany");
    switch (val){
        case "1":
            $(creatrCompany).fadeIn();
            $(".blur_box",parent.document).addClass("blur");
            break;
        case "2":
            $(creatrCompany).fadeOut();
            $(".blur_box",parent.document).removeClass("blur");
            break;
    }
}
//加入企业
function JionCompany(){
    $(".JionCompanyWin").click(function(){
        $(".blur_box",parent.document).addClass("blur");
        $(".joinCompany1",parent.document).fadeIn();
        $('.main_hide',parent.document).slideUp();
        $(".main_botton",parent.document).children('.main_point').removeClass('active');
    });
    $(".shenqingjiaru",parent.document).click(function(){
        $(".joinCompany1",parent.document).fadeOut();
        $(".joinCompany2",parent.document).fadeIn();
    })
    //以后再说
    $(".yihouzaishuo",parent.document).click(function(){
        $(".blur_box",parent.document).removeClass("blur");
        $(".joinCompany1",parent.document).fadeOut();
        $(".joinCompanyinventNone,parent.document").css("display","block").html("通过邀请码搜索到企业，才能申请加入").css("background","none").css("color","#666");
        $(".joinCompanyDetail",parent.document).css("display","none");
        $(".joinCompanyinventPass",parent.document).css("display","none");
        $("#joinCompanyinventInp",parent.document).val("");
    });

    //立即
    $(".lijishiyonggerenban",parent.document).click(function(){
        $(".joinCompany2",parent.document).fadeOut();
        $(".blur_box",parent.document).removeClass("blur");
    });
    $("#joinCompanyinventInp",parent.document).keyup(function(){
        var regx = /^[A-Z0-9]{10}$/;
        if( !regx.test($(this).val())){
            $(".joinCompanyinventNone",parent.document).html("邀请码错误，未搜索到该企业").css("background","#ff0000").css("color","#fff");
            $("#joinCompanyinventBtn",parent.document).css("background","#e4e4e4").css("color","#666").attr("disabled","disabled");
        }else{
            $("#joinCompanyinventBtn",parent.document).css("background","#2e8ae6").css("color","#fff").removeAttr("disabled").click(function(){
                $.ajax({
                    url:'/ydz/mainframe/mainBanner',
                    type:'GET',
                    async:true,
                    dataType:"json",
                    timeout:"10000",
                    success:function(data){
                        console.log(data);
                        $("#joinCompanyinventBtn",parent.document).css("background","#e4e4e4").css("color","#666").attr("disabled","disabled");
                        $(".joinCompanyinventNone",parent.document).css("display","none");
                        $(".joinCompanyDetail",parent.document).css("display","block");
                        $(".joinCompanyinventPass",parent.document).css("display","block");
                        $.each(data,function(key,val){
                            $(".joinCompanyDetail",parent.document).css("display","block").html("<p>"+val.comName+"</p><p>"+val.comName+"</p><p>"+val.comName+"</p>");
                        })
                    },
                    error:function(){
                        $(".joinCompanyinventNone",parent.document).html("搜索失败").css("background","#69d082").css("color","#fff");
                    }
                });
            });
            $(".joinCompanyinventNone",parent.document).html("点击搜索企业").css("background","#69d082").css("color","#fff");
        }
    });
}
// 邀请奖励
function inventUser(){
    $("#closeInvent").click(function () {
        $(".invent_user").fadeOut(500);
        $(".blur_box").removeClass("blur");
    });
}
// 总揽公司列表
function companyList(){
    $.ajax({
        url:'/ydz/user/ownCompanies',
        type:'GET',
        async:true,
        dataType:"json",
        timeout:"10000",
        success:function(data){
            $("#pandect-list").removeClass("lazy-loding");      //清除懒加载
            $.each(data.companies,function(key, val){
                var CompanyList = document.getElementById("CompanyList");
                if( val.comType == 1 ){
                    CompanyList.innerHTML +=
                        "<li>"
                        +"<h4>个人</h4>"
                        +"<h1>"+val.comName+"</h1>"
                        // +"<p><a href='http://www.baidu.com/'>进入</a></p>"
                        "</li>"
                }else if( val.comType == 2 ){
                    CompanyList.innerHTML +=
                        "<li>"
                        +"<h4>企业</h4>"
                        +"<h1>"+val.comName+"</h1>"
                        // +"<p><a href=''#'>管理企业</a><span>|</span><a href='#'>开展业务</a></p>"
                        "</li>"
                }
            });
        },
        error:function(){
            alert("错了");
        }
    });
}
//禁止返回上一页
window.onload = function(){
    window.history.pushState(null, null, document.URL);
    window.addEventListener('popstate', function () {
        history.pushState(null, null, document.URL);
    });
}