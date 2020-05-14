$(function(){
    $('.product-menus a').click(function(){
        var index = $(this).index();
        $('.product-menus a').removeClass('on').eq(index).addClass('on');
        $('.tabcontent').removeClass('on').eq(index).addClass('on');
    })
})