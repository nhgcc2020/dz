
var join_company = {};
$(function () {
    $.ajax({
        url: App.prop("service.user.detail"),
        type: "post",
        dataType: "json",
        contentType: "application/json",
        success: function (dt) {
            $(".realNameCls").text(dt.realName);
            $(".comShortnameCls").text(dt.comShortname);
            $(".comNameCls").text(dt.comName);
            $(".comIdCls").text(dt.comId);
            $(".realNameCls").text(dt.realName);
        }, error: function () {
        }
    });
})
function logout() {
    $("<div class='tips_contants'>").fadeIn(250).html("系统正在退出").appendTo('body');
    setTimeout(function () {
        window.location.href = App.prop("service.logout");
    }, 1000)

    return $.ajax({
        type: "POST",
        url: App.prop("service.logout")
    }).done(function (result) {
        $("<div class='tips_contants'>").fadeIn(250).html("系统正在退出").appendTo('body');
        setTimeout(function () {
            return window.location.reload();
            //						return window.location.reload();
        }, 1000)
    }).fail(function () {
        window.location.reload()
        alert("退出失败，请检查网络连接！");
    });
}
function salesOrderAdd() {
    $.ajax({
        url: '/ydz/mainframe/validOrderCount',
        type: 'GET',
        dataType: "json",
        success: function (data) {
            if (data.balanceOrderCount <= 0) {
                $(".stroke").text(data.freeOrderCount)
                  $(".alart_one").show();
                $(".cover").show();
            } else {
                var config = {
                    menuUrl: "/ydz/salesorder/toAdd"
                };
                // icon 必须固定 否则触发不了销售点击事件
                $("#headerLeftMenu li[data-icon='icon-ydz-menu-cash-sale']").click();
                mainConfigUrl(config);
            }
        }
    })
}

function xiaoxiliebiao() {
    var config = {
        menuUrl: "/openPage?pageName=company_message-list"
    };
    mainConfigUrl(config, 1);
}

//  跳转记录的地址
function sessionSave(key, value) {
    sessionStorage.setItem(key, value);
}
// 获取session里地址
function sessionGet(data) {
    return sessionStorage.getItem(data);
}
// 清除session里地址
function sessionRemove(key) {
    return sessionStorage.removeItem(key);
}
