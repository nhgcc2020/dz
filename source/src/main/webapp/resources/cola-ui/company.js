/**角色权限设置
 * Created by ukey on 16/9/2.
 */

$(function(){

    var allData =[];
    //数据查询

    $.ajax({
        url:'../../json/permissionInit.json',
        type:'GET',
        async:false,
        dataType:"json",
        timeout:"10000",
        success:function(data){
            allData = data;
        },
        error:function(){
            alert('没有数据');
        }
    });

    //第一级循环
    for(var n = 0; n < allData.length; n ++){
        var menuList = document.getElementById('menu');
        $("<a class='item' data-tab='"+allData[n].permissionDesc+"'>").html(allData[n].permissionDesc).appendTo(menuList);
        menu_tab();         //鼠标点击事件

        //第二级  客户档案
        for(var j = 0; j < allData[0].permissionInits.length; j++){
            var CustomerTr = document.getElementById('Customer-Profile');
            $('<tr>').append("<td rowspan='"+allData[0].permissionInits.length+"' style='border-right:1px solid #e4e4e4;'><div id='"+
                allData[0].permissionInits[j].pCode+"' class='ui toggle checkbox' style='margin-left: 15px;'><input type='checkbox' tabindex='0' class='hidden'><label>"+
                allData[0].permissionInits[j].permissionDesc+"</label></div></td>").appendTo(CustomerTr);

            //第三级  添加客户档案
            for(var k = 0; k < allData[0].permissionInits[j].permissionInits.length; k++){
                //$("#Customer-Profile tbody tr").eq(j).find("td").eq(1).find("label").html(allData[n].permissionInits[j].permissionInits[k].permissionDesc);
                //console.log(allData[n].permissionInits[j].permissionInits[k].permissionDesc);

                //第四级  添加客户档案
                for(var h = 0; h < allData[0].permissionInits[j].permissionInits[k].permissionInits.length; h++){
                    console.log(allData[0].permissionInits[j].permissionInits[k].permissionDesc);

                    //第五级  添加客户档案
                    for(var m = 0; m < allData[0].permissionInits[j].permissionInits[k].permissionInits[h].permissionInits.length; m++){
                        if(allData[0].permissionInits[j].permissionInits[k].permissionInits[h].permissionInits.length != 0){
                            console.log(allData[n].permissionInits[j].permissionInits[k].permissionInits[h].permissionInits);
                        }
                    }

                }
            }
        }
    }

    //点击导航切换
    function menu_tab(){
        $('#menu').find('a').each(function(){
            $('#menu a:first').addClass("active");
            $(this).bind('click',function(){
                $(this).addClass("active").siblings().removeClass("active");
                var _this = $(this).index();
                $("#permission_tab>div").eq(_this).addClass('active').siblings().removeClass('active');
            })
        })
    };


    var creater_tab = document.createElement("table");
    
});