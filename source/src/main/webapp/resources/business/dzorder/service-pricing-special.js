//  此页面加载数据入口  reload() 方法
//   加载 左侧菜单方法入口  menuLoad(); 先执行此方法  在执行 reload() customerLoad()

// 参数：String pCode,String partnerKey


var pageMenuUrl="/company/listComProPrice";// menu请求地址
var pageTbUrl="/company/listComPartnerProPriceLevel";//服务定价表格请求地址
var pageInsertMenuUrl="/company/insertNewComProPrice";//菜单栏目插入保存地址
var pageSaveMenuUrl="/company/updateComProPrice";//菜单栏目更新保存地址
var pageCustSaveMenuUrl="/company/addListComPartnerProPrice";//为公司的客户初始化创建专有价格
var pageCustomerUrl="/company/listComPartnerWithProPrice";//获取公司的专有客户服务定价中的所有专有客户列表，结果去重，按新建顺序
var pageSelUrl="/company/listComCustomers ";//获取公司的客户列表下拉框用于设置专有服务价
var pageUpdateComPartnerUrl="/company/updateComPartnerProPrice";//修改专有客户服务定价
function closeTaxPoint() {
    $(".window-mask").hide();
    $("#taxPointWin").css({display:'none'});
}
function  closePrice() {
    $(".window-mask").hide();
    $(".priceDetailWin").css({display:'none'});
}
function customerLoad() {
    $.ajax({
        url:pageCustomerUrl,
        dataType:"json",
        success:function(dt){
            console.log(dt);
            var m1="",act="";
            for(var i=0;i<dt.length;i++){
                act=i==0?"active":"";
                m1 += "<li pid='"+dt[i].partnerKey+"'  class='"+act+"'>"+dt[i].partnerShortname+"</li>";
            }
            $("#customerMenu").html(m1);
            menuLoad();
        }
    })
}


function menuLoad() {
    if( !$("#customerMenu li.active").attr("pid") || $("#customerMenu li.active").attr("pid")==""){return;}
    $.ajax({
        url:pageMenuUrl,
        dataType:"json",
        success:function(dt){
            console.log(dt);
            var m1="",act="",failcls="";
//            <li class="active">写真<span mid="0000" pid="写真父" did="写真">修改</span></li>
            for(var i=0;i<dt.length;i++){
                act=i==0?"active":"";
                failcls=dt[i].isChecked=="1"?"":"fail";
                m1 += "<li pid='"+dt[i].categoryId+"' did='"+(JSON.stringify(dt[i].comProPrices))+"' class='"+act+" "+failcls+"'>"+dt[i].categoryDesc+"</li>";
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

$(function(){
    $("#priceDetail").click(function () {
        $(".priceDetailWin").css({display:'block'});
    })
    $("#customerMenu + div").on("click",function () {
        //一级菜单栏目添加 1a 添加   0a 修改   1b   0b
//    closeModifyMenu  menu1  menu2  menuId
        $(".window-mask").show();
        $("#menuTitle").text("添加专供客户");
        $("#menuId").val("1a");
        $("#pCode").val("0");
        $("#menu1").val("").attr("disabled",false);
        $("#menuv1").val("");
        $("#menuv2").val("");
        $("#menu2").val("").hide();
        $("#modifyMenuWin").css({display:'block'});
    })

    $("#customerMenu").on("click","li",function () {
        //一级菜单栏目添加  需要请求切换二级菜单  并把表格默认切换二级菜单第一个的数据
        $(this).addClass("active").siblings().removeClass("active");
        $("#searchKey").val("");
        menuLoad();
    })
    $("#leftMenu").on("click","li",function () {
        //一级菜单栏目添加  需要请求切换二级菜单  并把表格默认切换二级菜单第一个的数据
        $(this).addClass("active").siblings().removeClass("active");
        $("#searchKey").val("");
        menuSecLoad();
    })
})

// saveCustomer 修改菜单栏目
function saveCustomer(o) {
    if($("#customerWaySel").val()==""){return;}
    $(o).attr("disabled",true);
    $.ajax({
        url:pageCustSaveMenuUrl,
        type:'post',
        contentType:'application/x-www-form-urlencoded; charset=UTF-8',
        data:{"partnerKey":$("#customerWaySel").val()},
        dataType:"json",
        success:function(dt){
            window.location.reload();
        },
        error:function (d) {
            $("<div class='tips_contants'>").fadeIn(250).html("保存出错").delay(1000).fadeOut(250).appendTo('body');
            $(o).attr("disabled",false);
        }
    })
}

// 修改服务单价数据
function saveTable() {
    $.ajax({
        type: "POST",
        contentType:'application/x-www-form-urlencoded; charset=UTF-8',
        url: pageUpdateComPartnerUrl,
        dataType: "json",
        data:{
            "categoryId":$("#categoryId").val(),
            "unitPrice":$("#pricezg").val(),
            "partnerKey":$("#customerMenu li.active").attr("pid")
        },
        success: function (dt) {
            closeTaxPoint();
            $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(1000).fadeOut(250).appendTo('body');
            reload()
        },
        error:function () {
            $("<div class='tips_contants'>").fadeIn(250).html("修改出错").delay(1000).fadeOut(250).appendTo('body');
        }
    })
}

function reload() {

    if( !$("#customerMenu li.active").attr("pid") || $("#customerMenu li.active").attr("pid")==""){
        $('#order').datagrid('loadData', { total: 0, rows: [] });
        return;}


    var pCode=$("#leftMenu li.active").attr("pid");
    var queryParams= {

        "partnerKey":$("#customerMenu li.active").attr("pid"),
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

                onClickCell:function(index,field,value){
//                        if (editRow != undefined) {
//                            datagrid.datagrid("endEdit", editRow);
//                        }
                    var f;
                    if(field=="categoryDesc"){
                        var rowData = datagrid .datagrid('getData').rows[index];
                        $(".window-mask").show();
                        $("#taxPointWin").css({display:'block'});
                        if(rowData.isChecked=="1"){
                            $(".requireshow").addClass("hide");
                        }else{
                            $(".requireshow").removeClass("hide");
                        }

                        $("#categoryDesc").val(rowData.categoryDesc);
                        $("#categoryId").val(rowData.categoryId);
                        $("#pricezg").val(rowData.unitPrice);
                    }
                }

            });
        }
    })
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
}    function priceUnitAllFormatter(value, rowData, rowIndex) {
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
});        var dataPriceUnitAll = $.map(priceUnitAll, function (obj) {
    obj.text =obj.priceUnitDesc; // replace name with the property used for the text
    obj.id =  obj.priceUnit; // replace name with the property used for the text

    return obj;
});
function  formatOnOff(row) {
    if(row.isChecked=="1"){
        return ' <div class="checkbox checkbox-slider--b-flat "><label><input onclick="checkChange(this)" value="1" checked type="checkbox"><span></span></label></div>'
    }else{
        return ' <div class="checkbox checkbox-slider--b-flat "><label><input onclick="checkChange(this)"  value="0" type="checkbox"><span></span></label></div>'
    }
}
function formatCategoryDesc(row){

    if(row.isChecked=="1"){
        return ' <div class="categoryDescEdit">'+row.categoryDesc+'<span style="    vertical-align: middle;font-size: 20px;color: #4284d9;" class="iconfont_new">&#xe6e6;</span><span style="font-size:12px;right:1px;color: #4284d9;">修改</span></div>'
    }
//
    return ' <div class="categoryDescEdit" style="color:#999">'+row.categoryDesc+'<span style="    vertical-align: middle;font-size: 20px;color: #4284d9;" class="iconfont_new">&#xe6e6;</span><span style="font-size:12px;color: #4284d9;right:1px;">修改</span></div>'
}
function checkChange(o) {
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
    if (!datagrid.datagrid('getChanges').length) {
        return;
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
        editRow = undefined
        $(".datagrid-header-rownumber").text("序号");
        // $(".datagrid-header-inner #priceRef .datagrid-cell-c4-refUnitPrice ").text("价格");
        if (data.rows.length > 0 ) {
        }else{
            $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
        }
    }catch(e){

        $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
    }

}
function closeTaxPoint() {
    $(".window-mask").hide();
    $("#taxPointWin").css({display:'none'});
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
    customerLoad();
    customerSel();
});
function customerSel(){
    $.ajax({
        type: "POST",
        url: pageSelUrl,
        dataType: "json",
        success: function (dt) {
            var dataPriceWayAll = $.map(dt, function (obj) {
                obj.text = obj.myComShortname; // replace name with the property used for the text
                obj.id = obj.partnerKey; // replace name with the property used for the text
                return obj;
            });
            $("#customerWaySel").select2({
                placeholder: "选择客户",
                data: dataPriceWayAll
            })
            $("#customerWaySel").on("select2:select", function (evt) {  if (!evt) {
                var args = "{}";
            } else {
                $("#partnerShortname").html(evt.params.data.partnerShortname);
//                    console.log(evt.params.data.myComShortname);
            }});
        }
    })
}
function customerSelChange(o) {
    $("#partnerShortname").html($(o).find("option:selected").text());
}
