var pageMenuUrl="/company/topDropdownComProPrices";// menu请求地址
var pageTbUrl="/company/topDropdownComProPricesLevel";//服务定价表格请求地址

function menuLoad() {
    $.ajax({
        url:pageMenuUrl,
        data:{"partnerKey":$("#clientsDp").val()},
        dataType:"json",
        type:"post",
        success:function(dt){
            console.log(dt);
            var m1="",act="";
//            <li class="active">写真<span mid="0000" pid="写真父" did="写真">修改</span></li>
            for(var i=0;i<dt.length;i++){
                act=i==0?"active":"";
                m1 += "<li pid='"+dt[i].categoryId+"' did='"+(JSON.stringify(dt[i].comProPrices))+"' class='"+act+"'>"+dt[i].categoryDesc+"</li>";
            }
            $("#leftMenu").html(m1);
            menuSecLoad();
//            reload();
        }
    })
}

function menuSecLoad() {

    reload();
}
function reload() {
    if( !$("#leftMenu li.active").attr("pid") || $("#leftMenu li.active").attr("pid")==""){
        $('#order').datagrid('loadData', { total: 0, rows: [] });
        return;}
    var pCode=$("#leftMenu li.active").attr("pid");
    var queryParams= {
        "searchKey":$("#searchKey").val(),
        "pCode":pCode,
        "partnerKey":$("#clientsDp").val()

};
    if(pCode==null || pCode==""){ $('#order').datagrid('loadData', { total: 0, rows: [] });
        return;}
    $.ajax({
        url:pageTbUrl,
        type:'post',
        contentType:'application/x-www-form-urlencoded; charset=UTF-8',
        data:queryParams,
        dataType:"json",
        success:function(dt){

            datagrid=    $('#order').datagrid({
                data : dt
            });
        }
    })
}
function onLoadSuccess(data){
    try{
        if (data.rows.length > 0 ) {
            $(".conTbText").show();
$("#tbOrder").show();
        }else{
            $("#tbOrder").show();
            $(".conTbText").show();
            // $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
        }
    }catch(e){

        // $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
    }

}
function priceWayAllFormatter(value, rowData, rowIndex) {
    if (value == 0) {
        return;
    }

    for (var i = 0; i < priceWayAll.length; i++) {
        if (priceWayAll[i].priceWay == value) {
            rowData.priceWayDesc=priceWayAll[i].priceWayDesc;
            return priceWayAll[i].priceWayDesc;
        }
    }
}
function priceUnitAllFormatter(value, rowData, rowIndex) {
    if (value == 0) {
        return;
    }

    for (var i = 0; i < priceUnitAll.length; i++) {
        if (priceUnitAll[i].priceUnit == value) {
            rowData.priceUnitDesc=priceUnitAll[i].priceUnitDesc;
            return priceUnitAll[i].priceUnitDesc;
        }
    }
}

var dataPriceWayAll = $.map(priceWayAll, function (obj) {
    obj.text = obj.priceWayDesc; // replace name with the property used for the text
    obj.id = obj.priceWay; // replace name with the property used for the text
    return obj;
});
var dataPriceUnitAll = $.map(priceUnitAll, function (obj) {
    obj.text =obj.priceUnitDesc; // replace name with the property used for the text
    obj.id =  obj.priceUnit; // replace name with the property used for the text

    return obj;
});
$(function(){

    $("#leftMenu").on("click","li",function () {
        //一级菜单栏目添加  需要请求切换二级菜单  并把表格默认切换二级菜单第一个的数据
        $(this).addClass("active").siblings().removeClass("active");
        $("#searchKey").val("");
        menuSecLoad();
    })

})
function loadWTScript(a, b) {
    var c = document.createElement("script");
    c.type = "text/javascript",
        c.async = !0,
        c.src = a,
        dcsReady(c, b),
        document.getElementsByTagName("head")[0].appendChild(c)
}
function dcsReady(a, b) {
    a.readyState ? a.onreadystatechange = function() { ("loaded" == a.readyState || "complete" == a.readyState) && (a.onreadystatechange = null, b())
        }: a.onload = function() {
            b()
        }
}
// 动态加载css脚本
function loadStyleString(cssText) {
    var style = document.createElement("style");
    style.type = "text/css";
    try{
        // firefox、safari、chrome和Opera
        style.appendChild(document.createTextNode(cssText));
    }catch(ex) {
        // IE早期的浏览器 ,需要使用style元素的stylesheet属性的cssText属性
        style.styleSheet.cssText = cssText;
    }
    document.getElementsByTagName("head")[0].appendChild(style);
}
var Menucss = ".categoryDescEdit{position:relative;overflow:hidden;margin-right:15px;cursor:pointer}.categoryDescEdit>span{position:absolute;top:1px;right:1px;display:none;cursor:pointer}.categoryDescEdit:hover>span{display:block}.ui.widget-table table tbody td>div{overflow:hidden;padding:.2em .4em}.ui.input input{padding:.5em .3em;text-align:left}.ui.widget-table table thead th{background:#fff}.ui.widget-table>.fixed-footer,.ui.widget-table>.fixed-header{z-index:99}.closeMore{position:absolute;top:0;right:0;width:20px;height:20px;text-indent:0;cursor:pointer}.closeMore:after,.closeMore:before{position:absolute;top:50%;width:20px;height:1px;background-color:#888;content:'';-webkit-transform:rotate(45deg);transform:rotate(45deg)}.closeMore:after{-webkit-transform:rotate(-45deg);transform:rotate(-45deg)}#learnMore .closeMore:hover{-webkit-transform:rotate(90deg)}.partner_tips_2:before{position:relative}.checkbox,.radio{margin:0}.items tr td:nth-child(2) input{text-align:left}.items tr td:nth-child(3) input,.items tr td:nth-child(4) input{border:none}.items tr:nth-child(even) td:nth-child(3) input,.items tr:nth-child(even) td:nth-child(4) input{background:#f5f7fa}.ui.list-view .items{height:260px}.ui.list-view .list.item:hover{background:#4284d9;color:#fff}.btn{font-size:9pt}.btn-default{color:#999}.ui.items-view table tbody tr:nth-child(even){background:0 0!important}.ui.items-view .item{cursor:default}#order .table-wrapper>table thead th:nth-child(1),#order .table-wrapper>table thead th:nth-child(2),#order .table-wrapper>table thead th:nth-child(11),#order .table-wrapper>table thead th:nth-child(12){font-weight:700}.pagination table{float:right;height:50px;line-height:50px}.pagination{border-radius:0}.datagrid .datagrid-pager{border-color:#2e8ae6;border-top-width:2px}.datagrid-header td.datagrid-header-over,.datagrid-row-over{background:none;color:#000;cursor:default}.datagrid-header,.datagrid-td-rownumber{background:#eff1f3}.datagrid-header{border-width:0}.datagrid-header .datagrid-cell span{font-size:12px}.btn-primary,.btn-primary.active,.btn-primary:active,.btn-primary:focus,.btn-primary:hover,.open .dropdown-toggle.btn-primary{border-color:#2e8ae6;background-color:#2e8ae6}.datagrid-row-selected{background:#d6e8f3;color:#000}.datagrid .panel-body,.window .window-body{border:none!important}.window .window-body{padding:50px 10px 0;border-width:0!important;border-radius:0;background:#fff}.datagrid-header,.datagrid-header-row,.datagrid-row{height:40px}.window-shadow{background:0 0}table,td,th{vertical-align:middle}#msgwindow{position:absolute;left:100%;z-index:9999;padding:2%;width:84%;height:100%;border:none;background:#fff;box-shadow:0 0 7px #999;-webkit-transition:all .2s 0s linear;transition:all .2s 0s linear}#taxPointWin{width:700px}#modifyMenuWin,#taxPointWin,.priceDetailWin{position:absolute;z-index:99;display:none;min-height:290px;border:none;background:#fff;box-shadow:1px 3px 10px 2px rgba(0,0,0,.2);-webkit-transition:all .2s 0s linear;transition:all .2s 0s linear}.h10{clear:both;height:10px}select option{margin:5px auto;height:30px;line-height:30px}.btn.smcolor{border-color:#2e8ae6;background-color:#2e8ae6;color:#fff}.tips_contants{position:fixed;top:50%;left:50%;z-index:99999;display:none;margin-top:-150px;margin-left:-150px;width:300px;height:5pc;border-radius:5px;background:rgba(0,0,0,.8);color:#fff;text-align:center;line-height:5pc}.pagination{display:none}.select2-results__options li{position:relative}.datagrid-body .datagrid-cell{padding:0 10px}.datagrid-htable .datagrid-cell{padding-left:10px}.datagrid-header .datagrid-cell span{color:#666}.form-control{display:block;padding:6px 10px 6px 9pt;width:100%;height:30px;background-color:#fff;color:#555;vertical-align:middle;line-height:1.428571429}.form-control,.input-group-addon{border:1px solid #ccc;border-radius:4px;font-size:12px}.input-group-addon{padding:5px 9pt;background-color:transparent!important;text-align:center;font-weight:400;line-height:1}.panel{box-shadow:0 0 0}";
var Menucss2="#topBarPR .datagrid-body td,#topBarPR .datagrid-header td{border-width:0;border-style:solid;border-color:#e4e4e4}.datagrid-body td{border-bottom:1px solid #eae8e8 !important;}.pagination-btn-separator{display:none}.nav-tabs>li>a{color:#3f3e3e;border:none}.nav-tabs,.nav-tabs>li.active>a,.nav-tabs>li.active>a:focus,.nav-tabs>li.active>a:hover{border:none;font-size:14px}.nav-tabs>li.active>a,.nav-tabs>li.active>a:focus,.nav-tabs>li.active>a:hover{color:#2e8ae6;padding-bottom:5px}.nav-tabs>li>a:hover{border:none}.nav>li>a:focus,.nav>li>a:hover{text-decoration:none;background:none!important}#order .table-wrapper>table thead th:nth-child(1){text-align:left}.qqhover:hover,.telhover:hover{color:#2e8ae6!important}.datagrid-cell,.datagrid-cell-group,.datagrid-cell-rownumber,.datagrid-header-rownumber,.remarkbd{font-size:9pt}.remarkbd{height:30px;margin-top:10px;line-height:30px;padding-top:5px;color:#b3b3b3;border-top:1px solid #f2f2f2;text-overflow:ellipsis;overflow:hidden}.namebd{height:40px;line-height:30px;font-size:14px;color:#000}.contactbd,.namebdsml{color:#b3b3b3;font-size:9pt}.namebdsml{margin-left:15px}.qqhover,.telhover{margin-left:8px;vertical-align:middle}.contacthover{margin-right:20px}.tooltip{border:none!important;background:transparent!important}.tooltip-arrow{display:none}.tooltip-inner{opacity:1;color:#666;background-color:#ffc;border:1px solid #fc0}.font12{color:#999;margin-bottom:10px;font-size:9pt}.font18{font-size:18px;color:#000}.fontColor3c{color:#ccc}#msgwindow{border:none;z-index:9999;width:84%;height:100%;left:100%;box-shadow:0 0 7px #999;padding:2%;background:#fff;transition:all .2s 0s linear;-webkit-transition:all .2s 0s linear;position:absolute}.datagrid-body{overflow-x:hidden}#navCondition li{margin-right:10px}.datagrid-header td{text-align:center}.datagrid-td-rownumber{background:#fff}.nav-tabs{position:relative}.nav-tabs li:nth-child(2).active~.block{transform:translate(120px,0)}.nav-tabs li:nth-child(1)~.block{position:absolute;bottom:3px;left:10px;width:90pt;height:2px;background-color:#2e8ae6;transition:all .3s}.datagrid-body td{text-align:center}.select2-container--default .select2-results>.select2-results__options{max-height:200px}.select2-container .select2-selection--single .select2-selection__rendered,.select2-container--default .select2-selection--single{text-align:left}.westH1Left,.westH1Right{font-weight:700;text-align:center;font-size:1pc;margin-bottom:5px;padding:10px 0;background:#e6f0f5;color:#6b9cdf}.westl{margin:0 5px 5px 10px}.westr{margin:0 10px 5px 5px}.west ul>li{letter-spacing:2px;position:relative;padding-left:10px;padding-right:25px;border-bottom:1px solid #eaeaea;height:55px;overflow:hidden;line-height:55px;-ms-text-overflow:ellipsis;white-space:nowrap;text-overflow:ellipsis;font-size:14px}.west{width:170px;height:100%}.west ul>li>span{color:#8cb5e5;font-size:9pt;position:absolute;right:3px;top:0;visibility:hidden}.west ul>li.active{background:#eff1f3}.west ul>li:hover>span{visibility:visible;cursor:pointer}.west .addMenu{text-align:center;padding:0;color:#ccc;height:40px;font-size:9pt;cursor:pointer;line-height:40px;border-bottom:1px solid #dedede}#leftMenu,#rightMenu{overflow:auto;max-height:calc(100% - 170px)}.panel-body,.panel-header{border-color:#eaeaea;border-left:0}.datagrid-pager,.datagrid-toolbar{background:#fff}";
loadStyleString(Menucss2);
loadStyleString(Menucss);
