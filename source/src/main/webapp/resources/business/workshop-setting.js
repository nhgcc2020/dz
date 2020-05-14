var listWkurl='/order/workingassigntask/listWorkshops';//工作车间列表
var updateWkUrl="/order/workingassigntask/settingWorkshopProcedureForProductService"; //修改工作空间url
var createWkUrl="/order/workingassigntask/insertWorkshops"; //创建工作空间url

var pageMenuUrl="/order/workingassigntask/listWorkshopProcedureForProductService";// menu请求地址
var pageTbUrl="/company/listComProPrice";//服务定价表格请求地址
var pageInsertMenuUrl="/company/insertNewComProPrice";//菜单栏目插入保存地址
var pageSaveMenuUrl="/company/updateComProPrice";//菜单栏目更新保存地址
var pageConfigConUrl="/company/config/get"; //配置信息获取
var pageConfigUpdateConUrl="/company/config/update"; //配置信息获取    {key:XXX,value:XXX}
var selectDtRow;//全局选中行


var orderTableWs={
    formatStatus:function (value,row){
        var item = JSON.stringify(row);
        return "<span style='cursor:pointer;color: #4284d9;' onclick='openProReq()'>关联业务内容</span>"+"<span style='cursor:pointer;color: #4284d9;margin-left:10px;' onclick='modifyWk("+item+")'>修改</span>";
    },
    menuSecLoad:  function () {

    if( !$("#leftMenu li.active").attr("pid") || $("#leftMenu li.active").attr("pid")==""){
        $('#order').datagrid('loadData', { total: 0, rows: [] });
        return;}
    var pCode=$("#leftMenu li.active").attr("pid");
    var queryParams= {
        "pCode":pCode,
        "tier":"2",
        "searchKey":$("#searchKey").val()
    };
    if(pCode==null || pCode==""){ $('#order').datagrid('loadData', { total: 0, rows: [] });
        return;}
    $.ajax({
        url:pageMenuUrl,
        data:queryParams,
        type:'post',
        contentType:'application/x-www-form-urlencoded; charset=UTF-8',
        dataType:"json",
        success:function(dt){

            $('#order').datagrid({
                data : dt.data
            });
        }
    })
},
    guanlianGx: function (o){
// $("#order").datagrid("getRows")[0].isChecked="0";
    var rindex=  $(o).parents("tr").index();
    // var ev=arguments.callee.caller.arguments[0] || window.event;
    // if($(ev.target).val()=="undefined"){return;}
    $('#order').datagrid('updateRow',{index:0,row:{
        "isChecked":"1"
    }});
    $('#order').datagrid("reload");
    var dt=$('#order').datagrid("getRows").length;
    console.log("ischecked");
},
    closeProReq: function (){
    $(".window-mask").hide();
    $("#topBarPR").hide();
},
    reloadWk: function (){

    $.ajax({
        url:listWkurl,
        dataType:"json",
        success:function(dt){
            $('#orderWk').datagrid({
                data : dt.data
            });
        }
    })
},
    formatProcedure:function (value){
        var tarr={};
        for(var l=0;l<wkListType.length;l++){
            var obj=wkListType[l];
            tarr[obj.id]=obj.text;
        }
        if(value && value !=""){
          var ar=value.split(","),html="";
          for(var k=0;k<ar.length;k++){
              html+= '<span class="labelCon">'+tarr[ar[k]]+'</span>';
          }
          return html;
        }
        return '';
    },
    closeTaxPoint:function (){
    $(".window-mask").hide();
    $("#taxPointWin").css({display:'none'});
},

    relateWkShop:function (value,row) {

        var item = JSON.stringify(row);


        if(row.workingProcedure=="" ||row.workingProcedure==null){
            return "<span class='namebd' style='cursor:pointer;color: #4284d9;' onclick='modifyWk("+item+",this)'>点击关联工序</span>";
        }else{
            return "<div style='cursor:pointer;' onclick='modifyWk("+item+",this)'>"+orderTableWs.formatProcedure(row.workingProcedure)+"</div>";
        }

    },
    saveTable: function (o) {
        orderTableWs.saveAll(o);
},
    saveTableAll:function (o) {
        var rows=$('#order').datagrid('getRows');
        var arr=[];
        var le=$("#gxWaySel").select2("data");
        for(var k=0;k<le.length;k++){
            arr.push(le[k].id);
        }
        var rowsTp=[];
        var gi=0;
        for(var m=selectDtRow;m<rows.length;m++){
            rowsTp[gi]=rows[m];
            rowsTp[gi].workingProcedure=arr.join(",");
            rowsTp[gi].createTime=null;
            gi++;
        }
        if($("#gxWaySel").val()=="" || $("#gxWaySel").val()==null ){   $("<div class='tips_contants'>").fadeIn(250).html("请选择工序").delay(1000).fadeOut(250).appendTo('body');return;}

        $(o).attr("disabled",true);
        orderTableWs.closeTaxPoint();
        $.ajax({
            url:updateWkUrl,
            type:'post',
            contentType:'application/json',
            data: JSON.stringify(rowsTp),
            dataType:"json",
            success:function(dt){
                $(o).attr("disabled",false);
                if(dt.code=="1"){
                    $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(1000).fadeOut(250).appendTo('body');
                    orderTableWs.menuSecLoad();
                }else{
                    $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(1000).fadeOut(250).appendTo('body');
                }
            },
            error:function(){
                $(o).attr("disabled",false);
                $("<div class='tips_contants'>").fadeIn(250).html("保存失败").delay(1000).fadeOut(250).appendTo('body');
            }
        })
        // items

    },
    saveAll:function (o) {
        if($("#gxWaySel").val()=="" || $("#gxWaySel").val()==null ){   $("<div class='tips_contants'>").fadeIn(250).html("请选择工序").delay(1000).fadeOut(250).appendTo('body');return;}
        var le=$("#gxWaySel").select2("data");
        var arr=[];
        var row=$('#order').datagrid('getRows')[selectDtRow];
        for(var k=0;k<le.length;k++){
            arr.push(le[k].id);
        }
        row.workingProcedure=arr.join(",");
        row.createTime=null;
        var rowsTp=[];
        rowsTp[0]=row;
        $(o).attr("disabled",true);
        $.ajax({
            url:updateWkUrl,
            type:'post',
            contentType:'application/json',
            data: JSON.stringify(rowsTp),
            dataType:"json",
            success:function(dt){
                $(o).attr("disabled",false);
                if(dt.code=="1"){
                    orderTableWs.closeTaxPoint();
                    $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(1000).fadeOut(250).appendTo('body');

                    orderTableWs.menuSecLoad();
                }else{
                    $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(1000).fadeOut(250).appendTo('body');
                }
            },
            error:function(){
                $(o).attr("disabled",false);
                $("<div class='tips_contants'>").fadeIn(250).html("保存失败").delay(1000).fadeOut(250).appendTo('body');
            }
        })
    }
}

function reload (){
    orderTableWs.menuSecLoad();
}
function testHard1 (btn) {
    var currentItem = $("#order").datagrid("getSelected");
    if(currentItem==null){  $("<div class='tips_contants'>").fadeIn(250).html("请先选择一条物料制作说明").delay(2000).fadeOut(250).appendTo('body');return;}

    var rowIndex=globVar.con;
    if($('#createOrder').datagrid('getRows')[rowIndex].businessDesc !=""){
        $('#createOrder').datagrid('updateRow',{index:rowIndex,row:{
            "requirements":currentItem.categoryDesc,
            "unit":currentItem.priceUnitDesc,
            "priceWay":currentItem.priceWay,
            "priceWayDesc":currentItem.priceWayDesc,
            "unitPrice":currentItem.unitPrice
        }});
        autocompleteFun();
        formula(rowIndex);
    }

    $(".window-mask").hide();
    $("#topBarPR").hide();
}
    function msg(content){
        $("#msgwindow").html(content).addClass("activ");
    }
    function showOverFlow(obj){
//        partnerName  partnerAttr tel1  contacterName partnerKey
//        data-kid='+row.partnerKey+'data-pid='+row.tel1+' data-cid='+row.contacterName+' data-id='+row.partnerName+' data-did='+row.partnerAttr+';
        var partner=$(obj);
        var partnerAttr = partner.data("did");
        //1 公司
        if (partnerAttr == "1") {
            $("#inviteCom").html(partner.data("id"));
        } else {
            $("#inviteCom").html("个人伙伴");
        }
        $("#sendPhone").html(partner.data("pid"));
        $("#inviteName").html(partner.data("cid"));
        $("#partnerKeyPop").val(partner.data("kid"));
        $("#orderProcedure").css({display:'block'});
//        $("#orderProcedure").addClass(" flipInY").removeClass("flipOutY");
        $(".window-mask").show();
//        flipInY flipOutY
    }
    function closeOverFlow(){
//        $("#orderProcedure").addClass(" flipOutY").removeClass("flipInY");//css({display:'none'});
        $("#orderProcedure").css({display:'none'});//css({display:'none'});
        $("#sendPhone").val("");
        $("#partnerKeyPop").val("");
        $("#sendMsgBtn").prop("disabled", true);
        $(".window-mask").hide()
    }
    function onLoadSuc(data){
        try{
            if (data.rows.length > 0 ) {
                $("[data-toggle='tooltip']").tooltip();
            }else{
                $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
            }
        }catch(e){

        }

    }

    function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null)return unescape(r[2]);
        return null;
    }

    $(function () {
        orderTableWs.reloadWk("");//初始化grid数据
        $(".createWorkShop").click(function () {
            $(".window-mask").show();
            $("#fuwuTitle").html("创建工作车间");
            $("#taxPointWin").css({display:'block'});
            $("#wkshopDesc").val("");
            $("#fwdjId").val("");
            $("#gxWaySel").select2({
                placeholder: "请按照制作先后顺序添加工序",
                minimumResultsForSearch: Infinity,
                closeOnSelect: false,
                // maximumSelectionLength:5,
                data: wkListType
            }).val("").trigger("change");

        })
    });
function modifyWk(item,o) {
    $(".window-mask").show();
    selectDtRow=$(o).parents("tr").index();
    $("#fuwuTitle").html("关联制作工序");
    $("#taxPointWin").css({display:'block'});

    $("#gxWaySel").select2({
        placeholder: "请按照制作先后顺序添加工序",
        minimumResultsForSearch: Infinity,
        closeOnSelect: false,
        // maximumSelectionLength:5,
        data: wkListType
    }).val(item.workingProcedure.split(",")).trigger("change");
}





function menuLoad() {
    $.ajax({
        url:pageMenuUrl,
        dataType:"json",
        data:{"pCode":"0","tier":"1"},
        success:function(d){
            var dt=d.data;
            console.log(dt);
            var m1="",act="",failcls="";
//            <li class="active">写真<span mid="0000" pid="写真父" did="写真">修改</span></li>
            for(var i=0;i<dt.length;i++){
                act=i==0?"active":"";
                failcls=dt[i].isChecked=="1"?"":"fail";
                m1 += "<li pid='"+dt[i].categoryId+"' did='"+(JSON.stringify(dt[i].comProPrices))+"' class='"+act+" "+failcls+"'>"+dt[i].categoryDesc+"</li>";
            }
            $("#leftMenu").html(m1);
            orderTableWs.menuSecLoad();
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
        }
    }catch(e){
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

$(function(){
    menuLoad();//初始化grid数据
    $("#leftMenu").on("click","li",function () {
        //一级菜单栏目添加  需要请求切换二级菜单  并把表格默认切换二级菜单第一个的数据
        $(this).addClass("active").siblings().removeClass("active");
        $("#searchKey").val("");
        orderTableWs.menuSecLoad();
    })
    $.ajax({
        url: pageConfigConUrl,
        type: 'GET',
        dataType: "json",
        success: function (dt) {
            var d=dt.data;
            if(d.length>0){
                for(var i=0;i<d.length;i++){
                   if (d[i].configKey=="ASSIGN_WORKING"){
                        if(d[i].configValue=="1"){
                            $(".assignDesDef").prop("checked",true);
                        }else{
                            $(".assignDesDef").prop("checked",false);
                        }
                    }
                }

            }
        }
    });
    $(".assignDesDef").on("click",function () {
        var t=$(this).is(":checked")?"1":"0";
        $.ajax({
            url: pageConfigUpdateConUrl,
            type: 'GET',
            data:{"key":"ASSIGN_WORKING","value":t},
            dataType: "json",
            success: function (dt) {
            }
        });
    })
})
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

var Menucss2="#topBarPR .datagrid-body td,#topBarPR .datagrid-header td{border-width:0;border-style:solid;border-color:#e4e4e4}.datagrid-body td{border-bottom:1px solid #eae8e8 !important;}.pagination-btn-separator{display:none}.nav-tabs>li>a{color:#3f3e3e;border:none}.nav-tabs,.nav-tabs>li.active>a,.nav-tabs>li.active>a:focus,.nav-tabs>li.active>a:hover{border:none;font-size:14px}.nav-tabs>li.active>a,.nav-tabs>li.active>a:focus,.nav-tabs>li.active>a:hover{color:#2e8ae6;padding-bottom:5px}.nav-tabs>li>a:hover{border:none}.nav>li>a:focus,.nav>li>a:hover{text-decoration:none;background:none!important}#order .table-wrapper>table thead th:nth-child(1){text-align:left}.qqhover:hover,.telhover:hover{color:#2e8ae6!important}.datagrid-cell,.datagrid-cell-group,.datagrid-cell-rownumber,.datagrid-header-rownumber,.remarkbd{font-size:9pt}.remarkbd{height:30px;margin-top:10px;line-height:30px;padding-top:5px;color:#b3b3b3;border-top:1px solid #f2f2f2;text-overflow:ellipsis;overflow:hidden}.contactbd,.namebdsml{color:#b3b3b3;font-size:9pt}.namebdsml{margin-left:15px}.qqhover,.telhover{margin-left:8px;vertical-align:middle}.contacthover{margin-right:20px}.tooltip{border:none!important;background:transparent!important}.tooltip-arrow{display:none}.tooltip-inner{opacity:1;color:#666;background-color:#ffc;border:1px solid #fc0}.font12{color:#999;margin-bottom:10px;font-size:9pt}.font18{font-size:18px;color:#000}.fontColor3c{color:#ccc}#msgwindow{border:none;z-index:9999;width:84%;height:100%;left:100%;box-shadow:0 0 7px #999;padding:2%;background:#fff;transition:all .2s 0s linear;-webkit-transition:all .2s 0s linear;position:absolute}.datagrid-body{overflow-x:hidden}#navCondition li{margin-right:10px}.datagrid-header td{text-align:center}.datagrid-td-rownumber{background:#fff}.nav-tabs{position:relative}.nav-tabs li:nth-child(2).active~.block{transform:translate(120px,0)}.datagrid-body td{text-align:center}.select2-container--default .select2-results>.select2-results__options{max-height:200px}.select2-container .select2-selection--single .select2-selection__rendered,.select2-container--default .select2-selection--single{text-align:left}.westH1Left,.westH1Right{font-weight:700;text-align:center;font-size:1pc;margin-bottom:5px;padding:10px 0;background:#e6f0f5;color:#6b9cdf}.westr{margin:0 10px 5px 5px}.west ul>li{letter-spacing:2px;position:relative;padding-left:10px;padding-right:25px;border-bottom:1px solid #eaeaea;height:55px;overflow:hidden;line-height:55px;-ms-text-overflow:ellipsis;white-space:nowrap;text-overflow:ellipsis;font-size:14px}.west{width:170px;height:100%}.west ul>li>span{color:#8cb5e5;font-size:9pt;position:absolute;right:3px;top:0;visibility:hidden}.west ul>li.active{background:#eff1f3}.west ul>li:hover>span{visibility:visible;cursor:pointer}.west .addMenu{text-align:center;padding:0;color:#ccc;height:40px;font-size:9pt;cursor:pointer;line-height:40px;border-bottom:1px solid #dedede}#leftMenu,#rightMenu{overflow:auto;max-height:calc(100% - 30px)}.panel-body,.panel-header{border-color:#eaeaea;border-left:0}.datagrid-pager,.datagrid-toolbar{background:#fff}";
loadStyleString(Menucss2);


