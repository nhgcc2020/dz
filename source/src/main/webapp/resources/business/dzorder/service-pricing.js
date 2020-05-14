//  此页面加载数据入口  reload() 方法
//   加载 左侧菜单方法入口  menuLoad(); 先执行此方法  在执行 reload()
// 触发表格事件只能通过 二级菜单  和搜索图标

//一级菜单名称   二级菜单名称

// 修改服务单价数据方法   saveTable
// fwdjId 1 代表添加  0  代表修改  pCode, tier

var pageMenuUrl="/company/listComProPrice";// menu请求地址
var pageTbUrl="/company/listComProPrice";//服务定价表格请求地址
var pageInsertMenuUrl="/company/insertNewComProPrice";//菜单栏目插入保存地址
var pageSaveMenuUrl="/company/updateComProPrice";//菜单栏目更新保存地址
var pageDeleteMenuUrl="/company/deleteComProPrice";//菜单栏目删除
var servPageConfig={}; //页面元素临时保存数据
var pageConfigConUrl="/company/config/get"; //配置信息获取
//    var pageSaveServiceUrl="/company/listComProPrice";//添加修改服务定价内容
function menuLoad() {
    $.ajax({
        url:pageMenuUrl,
        dataType:"json",
        success:function(dt){
            var m1="",act="",failcls="";
//            <li class="active">写真<span mid="0000" pid="写真父" did="写真">修改</span></li>
            for(var i=0;i<dt.length;i++){
                act=i==0?"active":"";
                failcls=dt[i].isChecked=="1"?"":"fail";
                m1 += "<li pid='"+dt[i].categoryId+"' did='"+(JSON.stringify(dt[i].comProPrices))+"' class='"+act+" "+failcls+"'>"+dt[i].categoryDesc+"<span mid='"+dt[i].categoryId+"' pid='"+dt[i].pCode+"' cid='"+dt[i].isChecked+"' did='"+dt[i].categoryDesc+"' style='right: 36px;' csid='d'>删除</span>"+"<span csid='x' mid='"+dt[i].categoryId+"' pid='"+dt[i].pCode+"' cid='"+dt[i].isChecked+"' did='"+dt[i].categoryDesc+"'>修改</span></li>";
            }
            $("#leftMenu").html(m1);
            menuSecLoad();
        }
    })
}

function menuSecLoad() {
    reload();
}


function  closePrice() {
    $(".window-mask").hide();
    $(".priceDetailWin,.priceDetailSet").css({display:'none'});
}

$(function(){
    $("#colDiv1tip").hover(function () {
        $(".colDiv1").show();
    },function () {
        $(".colDiv1").hide();
    })
    $("#colDiv2tip").hover(function () {
        $(".colDiv2").show();
    },function () {
        $(".colDiv2").hide();
    })
    $("#priceDetail").click(function () {
        $(".window-mask").show();
        $(".priceDetailWin").css({display:'block'});
    })
    $("#priceDetailSet").click(function () {
        $(".window-mask").show();
        $(".priceDetailSet").css({display:'block'});
    })
    $("#leftMenu + div").on("click",function () {
        //一级菜单栏目添加 1a 添加   0a 修改   1b   0b
//    closeModifyMenu  menu1  menu2  menuId
        $(".deletetip").addClass("hide");
        $(".addtip").removeClass("hide");
        $(".window-mask").show();
        $("#switchMenu").attr("disabled",false);
        $("#saveMenu").text("保存");
        $("#menuTitle").text("添加类目");
        $("#menuId").val("1a");
        $("#pCode").val("0");
        $("#menu1").val("").attr("disabled",false);
        $("#menuv1").val("");
        $("#menuv2").val("");
        $("#menu2").val("").hide();
        $("#switchMenu").prop("checked",true);
        $(".requireMenu").addClass("hide");
        $("#modifyMenuWin").css({display:'block'});
    })

    $("#leftMenu").on("click","li>span",function (e) {
        //一级菜单栏目修改
        $(".window-mask").show();

        // 修改和删除区分值的显示
        if($(this).attr("csid")=="d"){
            $("#menuTitle").text("删除类目");
            $("#menuId").val("da");
            $("#menu1").attr("disabled",true);
            $("#switchMenu").attr("disabled",true);
            $("#saveMenu").text("删除");
            $(".deletetip").removeClass("hide");
            $(".addtip").addClass("hide");
        }else{
            $(".deletetip").addClass("hide");
            $(".addtip").removeClass("hide");
            $("#menuTitle").text("修改类目");
            $("#saveMenu").text("保存");
            $("#menuId").val("0a");
            $("#menu1").attr("disabled",false);
            $("#switchMenu").attr("disabled",false);
        }



        $("#pCode").val("0");
        $("#menuv1").val($(this).attr("mid"));
        $("#menu1").val($(this).attr("did"));
        $("#menu2").val("").hide();
        $("#menuv2").val("");

        if($(this).attr("cid")=="1"){
            $("#switchMenu").prop("checked",true);
        }else{
            $("#switchMenu").prop("checked","");}
        // 控制类目启用开关
        $(".requireMenu").addClass("hide");
        $("#modifyMenuWin").css({display:'block'});
        e.stopPropagation();
    })
    $("#leftMenu").on("click","li",function () {
        //一级菜单栏目添加  需要请求切换二级菜单  并把表格默认切换二级菜单第一个的数据
        $(this).addClass("active").siblings().removeClass("active");
        $("#searchKey").val("");
        menuSecLoad();
    })



})
// 1a  添加一级菜单  1b 添加二级菜单 0a 修改一级菜单 0b 修改二级菜单 da删除一级菜单
function saveMenu(o) {
    var type=$("#menuId").val();
    var pCode=$("#pCode").val();
    var menu1=$("#menu1").val();
    var menu2=$("#menu2").val();
    var menuv1=$("#menuv1").val();
    var menuv2=$("#menuv2").val();
    var tier="",categoryId="",categoryDesc="",url="";
    var isChecked="1";
    if(type=="1a"){
        tier="1";
        categoryId=menuv1;
        categoryDesc=menu1;
        url=pageInsertMenuUrl;
        if ($("#switchMenu").is(':checked')) {
            isChecked="1";
        }else{isChecked="0";
        }
    }else if(type=="0a"){
        tier="1";
        categoryId=menuv1;
        categoryDesc=menu1;
        url=pageSaveMenuUrl;
        if ($("#switchMenu").is(':checked')) {
            isChecked="1";
        }else{isChecked="0";
        }
    }else if (type=="da"){
        tier="1";
        categoryId=menuv1;
        categoryDesc=menu1;
        url=pageDeleteMenuUrl;
        if ($("#switchMenu").is(':checked')) {
            isChecked="1";
        }else{isChecked="0";
        }
    }
    // else if(type=="0b"){
    //     url=pageSaveMenuUrl;
    //     tier="2";
    //
    //     categoryId=menuv2;categoryDesc=menu2;
    // }else if(type=="1b"){
    //     tier="2";
    //     categoryId=menuv2;categoryDesc=menu2;
    //     url=pageInsertMenuUrl;
    // }
    if($.trim(categoryDesc)=="" && type != "da"){
        $(".requireMenu").removeClass("hide");
        return;
    }
    var queryParams= {
        "categoryDesc":categoryDesc,
        "categoryId":categoryId,
        "pCode":pCode,
        "isChecked":isChecked,
        "tier":tier
    };
    $(o).attr("disabled",true);
    $.ajax({
        url:url,
        type:'post',
        contentType:'application/x-www-form-urlencoded; charset=UTF-8',
        data:queryParams,
        dataType:"json",
        success:function(dt){
            $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(1000).fadeOut(250).appendTo('body');
            setTimeout(function () {
                window.location.reload()
            },2000);
        }
    })
}

// 修改服务单价数据
function saveTable() {
    if($.trim($("#categoryDesc").val())==""){
        $(".requireMenu").removeClass("hide");
        return;
    }
    var type=$("#fwdjId").val();//1 添加  0 修改
    var url="",isck="";
    if($("#leftMenu li.active").hasClass("fail")){
        isck="0";
    }else{
        isck= servPageConfig.isChecked;
    }
    if(type=="1"){
        url=pageInsertMenuUrl;
    }else{
        url=pageSaveMenuUrl;
    }
    var queryParams= {
        "price1":$("#priceyh").val(),
        "price2":$("#pricebz").val(),
        "price3":$("#pricels").val(),
        "categoryDesc":$("#categoryDesc").val(),
        "priceWay":$("#priceWaySel").val(),
        "priceWayDesc":$("#priceWaySel option:selected").text(),
        "priceUnit":$("#priceUnitSel").val(),
        "priceUnitDesc":$("#priceUnitSel option:selected").text(),
        "categoryId": $("#fwdjcid").val(),
        "tier":"2",
        "isChecked":isck,
        "pCode":$("#leftMenu li.active").attr("pid")
    };
    $.ajax({
        url:url,
        type:'post',
        contentType:'application/x-www-form-urlencoded; charset=UTF-8',
        data:queryParams,
        dataType:"json",
        success:function(dt){
            if(dt.status=="1"){


                $.ajax({
                    url: pageConfigConUrl,
                    type: 'GET',
                    dataType: "json",
                    success: function (d) {
                        var dr=d.data;
                        if(dr.length>0){
                            for(var i=0;i<dr.length;i++){
                                if (dr[i].configKey=="ASSIGN_WORKING"){
                                    if(dr[i].configValue=="1"){
                                        $("<div class='tips_contants'  style='line-height: 40px'>").fadeIn(250).html(dt.msg+"<br>请到派工配置添加相应服务工序,以便顺利派工").delay(3000).fadeOut(250).appendTo('body');
                                    }else{
                                        $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(1000).fadeOut(250).appendTo('body');

                                    }
                                }
                            }

                        }else{
                            $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(1000).fadeOut(250).appendTo('body');
                        }
                        setTimeout(function () {
                            reload();
                        }, 3000);
                        closeTaxPoint();
                    }
                });


            }else{
                $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(1000).fadeOut(250).appendTo('body');
            }
        },
        error:function(){
            $("<div class='tips_contants'>").fadeIn(250).html("保存失败").delay(1000).fadeOut(250).appendTo('body');
        }
    })
}

function reload() {

    if( !$("#leftMenu li.active").attr("pid") || $("#leftMenu li.active").attr("pid")==""){
        $('#order').datagrid('loadData', { total: 0, rows: [] });
        return;}
    var pCode=$("#leftMenu li.active").attr("pid");
    var queryParams= {
        "searchKey":$("#searchKey").val(),
        "pCode":pCode,
        "tier":"2"
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
                data : dt,
                onLoadSuccess:onLoadSuccess,
                // onAfterEdit: function (rowIndex, rowData, changes) {
                //     console.info(rowData);
                //     editRow = undefined;
                // },
                // onClickCell:function(index,field,value){
                // }

                /*,
                 onDblClickRow: function (rowIndex, rowData) {

                 return;
                 //双击开启编辑行
                 console.log(editRow);
                 if (editRow != undefined) {
                 datagrid.datagrid("endEdit", editRow);
                 }
                 if (editRow == undefined) {
                 datagrid.datagrid("beginEdit", rowIndex);

                 editRow = rowIndex;
                 }
                 }*/
            });
        }
    })
}
function deleteServLast(o) {




    var d=servPageConfig.delConData;
    console.log(d);
    var queryParams= {
        "categoryDesc":d.categoryDesc,
        "categoryId":d.categoryId,
        "pCode":d.pCode,
        "isChecked":d.isChecked,
        "tier":"2"
    };
    $(o).attr("disabled",true);
    $.ajax({
        url:pageDeleteMenuUrl,
        type:'post',
        contentType:'application/x-www-form-urlencoded; charset=UTF-8',
        data:queryParams,
        dataType:"json",
        success:function(dt){
            $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(1000).fadeOut(250).appendTo('body');
            setTimeout(function () {
                window.location.reload()
            },2000);
        }
    })

}
function formatDelLast(rowData) {
    $(".window-mask").show();
    $('#deleteWin').show();
    $(".customerjcName").text(rowData.categoryDesc);
    servPageConfig.delConData=rowData;
    // $("#fuwuTitle").text("修改服务定价");
    // $("#fwdjId").val("0");
    // $("#fwdjcid").val(rowData.categoryId);
    // $("#taxPointWin").css({display:'block'});
    // $("#categoryDesc").val(rowData.categoryDesc);
    // $("#priceWaySel").select2({
    //     placeholder: "选择计价方式",
    //     minimumResultsForSearch: Infinity,
    //     data: dataPriceWayAll
    // }).val(rowData.priceWay).trigger("change");
    // $("#priceUnitSel").select2({
    //     placeholder: "选择计价单位",
    //     minimumResultsForSearch: Infinity,
    //     data: dataPriceUnitAll
    //
    // }).val(rowData.priceUnit).trigger("change");
    //
    // $("#pricebz").val(rowData.price2);
    // $("#pricels").val(rowData.price3);
    // $("#priceyh").val(rowData.price1);
}
 function  formatEditLast(rowData) {


     // var f;
     // if(field=="isChecked"){
     //     if(value=="1"){
     //         f=0
     //     }else{f=1}
     //     datagrid.datagrid('updateRow',{
     //         index: index,
     //         row: {
     //             isChecked: f
     //         }
     //     });
     // }else
     $(".requireMenu").addClass("hide");
         $(".window-mask").show();
     var ht='<span class="descSec">当前类目 : &nbsp;'+$("#leftMenu li.active>span:first").attr("did")+'&nbsp;&nbsp;请谨慎选择服务类目</span>';
     $("#fuwuTitle").html("修改服务定价"+ht);
         $("#fwdjId").val("0");
         $("#fwdjcid").val(rowData.categoryId);
         $("#taxPointWin").css({display:'block'});
         $("#categoryDesc").val(rowData.categoryDesc);
     servPageConfig.isChecked=rowData.isChecked;
//                            $("#priceWaySel").val(rowData.priceWay);
//                            $("#priceUnitSel").val(rowData.priceUnit);

         $("#priceWaySel").select2({
             placeholder: "选择计价方式",
             minimumResultsForSearch: Infinity,
             data: dataPriceWayAll
         }).val(rowData.priceWay).trigger("change");
         $("#priceUnitSel").select2({
             placeholder: "选择计价单位",
             minimumResultsForSearch: Infinity,
             data: dataPriceUnitAll

         }).val(rowData.priceUnit).trigger("change");

         $("#pricebz").val(rowData.price2);
         $("#pricels").val(rowData.price3);
         $("#priceyh").val(rowData.price1);
 }
function formatAdd(){
    $(".requireMenu").addClass("hide");
    $(".window-mask").show();
    var ht='<span class="descSec">当前类目 : &nbsp;'+$("#leftMenu li.active>span:first").attr("did")+'&nbsp;&nbsp;请谨慎选择服务类目</span>';
    $("#fuwuTitle").html("添加服务定价"+ht);
    $("#fwdjId").val("1");
    $("#fwdjcid").val("");
    $("#taxPointWin").css({display:'block'});

    $("#categoryDesc").val("");

    $("#priceWaySel").val("");
    $("#priceUnitSel").val("");

    $("#priceWaySel").select2({
        placeholder: "选择计价方式",
        minimumResultsForSearch: Infinity,
        data: dataPriceWayAll
    })
    $("#priceUnitSel").select2({
        placeholder: "选择计价单位",
        minimumResultsForSearch: Infinity,
        data: dataPriceUnitAll

    })

    $("#pricebz").val("");
    $("#pricels").val("");
    $("#priceyh").val("");

    return;


    //添加时先判断是否有开启编辑的行，如果有则把开户编辑的那行结束编辑

    if (editRow != undefined) {
        var ed = datagrid.datagrid('getEditor', {index:editRow,field:'categoryDesc'});
//            $(ed.target).datebox('setValue', '5/4/2012');
        $(ed.target).val("22");
        return ;
        datagrid.datagrid("endEdit", editRow);
    }
    //添加时如果没有正在编辑的行，则在datagrid的第一行插入一行
    if (editRow == undefined) {
        datagrid.datagrid("insertRow", {
            index: 0, // index start with 0
            row: {
                "categoryDesc":"",
                "priceWay":"02",
                "priceUnit":"01",
                "price1":"",
                "price2":"",
                "price3":"",
                "isChecked":"1"
            }
        });
        //将新插入的那一行开户编辑状态
        datagrid.datagrid("beginEdit", 0);
        //给当前编辑的行赋值
        editRow = 0;
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
function  formatOnOff(row) {
    //
    var act= $("#leftMenu li.active").hasClass("fail");
    if(row.isChecked=="1"){
        return ' <div style="width: 50px;    display: inline-block;" class="checkbox checkbox-slider--b-flat checkbox-slider-md "><label><input onclick="checkChange(this)" value="1" checked type="checkbox"><span></span></label></div>'
    }else{
        if(act){
            return ' <div title="无法启用,所属类目已停用,请先启用类目再启用服务" style="width: 50px;    display: inline-block;" class="checkbox checkbox-slider--b-flat checkbox-slider-md"><label><input   value="0" disabled type="checkbox"><span></span></label></div>'
        }
        return ' <div  style="width: 50px;    display: inline-block;" class="checkbox checkbox-slider--b-flat checkbox-slider-md"><label><input onclick="checkChange(this)"  value="0" type="checkbox"><span></span></label></div>'
    }
}
function  formatCaozuo(row) {
    var changeItem = JSON.stringify(row);
        return "<span onclick='formatEditLast("+changeItem+")' style='    vertical-align: middle;font-size: 24px;color: #999;margin-right: 10px' class='iconfont_new'>&#xe6e6;</span><span onclick='formatDelLast("+changeItem+")'  style='    vertical-align: middle;font-size: 24px;color: #999;' class='iconfont_new'>&#xe6f1;</span>"

}
function formatCategoryDesc(row){
    if(row.isChecked=="1"){
        return ' <div style="cursor:default;" class="categoryDescEdit">'+row.categoryDesc+'</div>'
    }
// <span style="    vertical-align: middle;font-size: 20px;color: #4284d9;" class="iconfont_new">&#xe6e6;</span>
    return ' <div class="categoryDescEdit" style="cursor:default;color:#999">'+row.categoryDesc+'</div>'
}
function checkChange(o) {
    $(".window-mask").show();
    var url= pageSaveMenuUrl,f="";
    var rindex=  $(o).parents("tr").index();
  var pageCheckbox=  $('#order').datagrid('getRows')[rindex];
    if(pageCheckbox.isChecked=="1"){
        f=0
    }else{f=1}
    $('#order').datagrid('getRows')[rindex].isChecked=f;
     var   queryParams= {
            "price1":pageCheckbox.price1,
            "price2":pageCheckbox.price2,
            "price3":pageCheckbox.price3,
            "categoryDesc":pageCheckbox.categoryDesc,
            "priceWay":pageCheckbox.priceWay,
            "priceWayDesc":pageCheckbox.priceWayDesc,
            "priceUnit":pageCheckbox.priceUnit,
            "priceUnitDesc":pageCheckbox.priceUnitDesc,
            "categoryId":pageCheckbox.categoryId,
            "tier":"2",
            "isChecked":f,
            "pCode":pageCheckbox.pCode
        };
    $.ajax({
        url:url,
        type:'post',
        contentType:'application/x-www-form-urlencoded; charset=UTF-8',
        data:queryParams,
        dataType:"json",
        success:function(dt){
            if(dt.status=="1"){
                closeTaxPoint();
                $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(1000).fadeOut(250).appendTo('body');
                    reload();
            }else{
                $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(1000).fadeOut(250).appendTo('body');
            }
            $(".window-mask").hide();
        },
        error:function(){
            $(".window-mask").hide();
            $("<div class='tips_contants'>").fadeIn(250).html("保存失败").delay(1000).fadeOut(250).appendTo('body');
        }
    })
}
function formatReject(){
    editRow = undefined;
    datagrid.datagrid("rejectChanges");
    datagrid.datagrid("unselectAll");
}
function formatSave(){
    if (editRow != undefined) {
        datagrid.datagrid("endEdit", editRow);
    }
}
function formatDelete(){
    //删除时先获取选择行
    var rows = datagrid.datagrid("getSelections");
    //选择要删除的行
    if (rows.length > 0) {
        /*            $.messager.confirm("提示", "你确定要删除吗?", function (r) {
         if (r) {
         var ids = [];
         for (var i = 0; i < rows.length; i++) {
         ids.push(rows[i].ID);
         }
         //将选择到的行存入数组并用,分隔转换成字符串，
         //本例只是前台操作没有与数据库进行交互所以此处只是弹出要传入后台的id
         alert(ids.join(','));
         }
         });*/
    }
    else {
        $.messager.alert("提示", "请选择要删除的行", "error");
    }
}

function formatEdit(){
    //修改时要获取选择到的行
    var rows = datagrid.datagrid("getSelections");
    //如果只选择了一行则可以进行修改，否则不操作
    if (rows.length == 1) {
        //修改之前先关闭已经开启的编辑行，当调用endEdit该方法时会触发onAfterEdit事件
        if (editRow != undefined) {
            datagrid.datagrid("endEdit", editRow);
        }
        //当无编辑行时
        if (editRow == undefined) {
            //获取到当前选择行的下标
            var index = datagrid.datagrid("getRowIndex", rows[0]);
            //开启编辑
            datagrid.datagrid("beginEdit", index);
            //把当前开启编辑的行赋值给全局变量editRow
            editRow = index;
            //当开启了当前选择行的编辑状态之后，
            //应该取消当前列表的所有选择行，要不然双击之后无法再选择其他行进行编辑
            datagrid.datagrid("unselectAll");
        }
    }
}
var datagrid; //定义全局变量datagrid
var editRow = undefined; //定义全局变量：当前编辑的行
function onLoadSuccess(data){
    try{
        $(".datagrid-header-rownumber").text("序号");
        if (data.rows.length > 0 ) {
            $("[data-toggle='tooltip']").tooltip();
        }else{
            $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
        }
    }catch(e){

        $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
    }

}
function closeTaxPoint() {
    $(".window-mask").hide();
    $("#taxPointWin,#deleteWin").css({display:'none'});
}
function closeModifyMenu() {
    $(".window-mask").hide();
    $("#modifyMenuWin").css({display:'none'});
}
function formatMoney(row1,row2) {
    var fontc="";
    if(row1=="0"){
        fontc="fontColor3c";
    }
    return '<div class=\'font12 '+fontc+'\'>'+row1+'&nbsp;笔</div >'+'<div class=\'font18 '+fontc+'\'>'+row2+'</div>' ;
}function formatStatus(value,row){
//    if(value==="5"){
//        return 	 '<a class="acolor" data-kid='+row.partnerKey+'  data-pid='+row.tel1+' data-cid='+row.contacterName+' data-id='+row.partnerName+' data-did='+row.partnerAttr+' href=\'##\' onclick=showOverFlow(this)>加好友</a>' ;
//    }else{
    return '<span style="color: #b3b3b3;">'+partnerStatusConfig[value]+'</span>';
//    }
}
var partnerStatusConfig = {
    "0": "非好友",
    "1": "互为好友",
    "2": "申请中",
    "3": "已拒绝",
    "4": "待申请",
    "5": "待邀请",
    "6": "邀请中"
};
$(function () {
    menuLoad("");//初始化grid数据
$("#menu1").blur(function () {
    if($.trim($(this).val())!=""){
        $(".requireMenu").addClass("hide");
    }
})
});
