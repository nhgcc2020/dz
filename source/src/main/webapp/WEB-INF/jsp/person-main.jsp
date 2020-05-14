
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN" style="height: 100%; width: 100%;">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>个人中心</title>
    <link href="/resources/cola-ui/base.css?v=529b4c3d67" rel="stylesheet">
    <style>
        .invent_user_detail_big_title_list li{
            width:248px;
        }
        .preson-container-right{
            height: 100%;
            width:calc(100%-180px);
            overflow: hidden;
            box-sizing: border-box;
            background: #f6f6f6;
            position: relative;
        }
    </style>
</head>
<body style="height: 100%; width: 100%;">

<!--顶部菜单-->
<div class="preson-menu blur_box">
    <div class="preson-menu-logo">个人中心</div>

    <div class="preson-menu-preson">
        <div class="preson-menu-preson-info">
            <img src="${sessionScope.sessionUser.avatarPath}" onerror="this.src = '/upload/logo/default_user.png'" alt="个人中心" />
            <span>您好，</span>
            <span class="company_Name">${sessionScope.sessionUser.realName}</span>
            <%--<i class="iconfont">&#xe68d;</i>--%>
        </div>

        <%--<ul class="preson-menu-preson-logout">--%>
            <%--<li class="iconfont" c-onclick="logout()"><span>退出</span></li>--%>
        <%--</ul>--%>

    </div>
</div>

<!--底部中心-->
<div class="preson-container blur_box">
    <!--左侧菜单-->
    <div class="preson-container-left">
        <ul class="preson-container-left-menu">
            <%--<li>--%>
                <%--<i class="iconfont icon-ydz-zonglan"></i>--%>
                <%--<a href="/openPage?pageName=pandect" target="presonContainer">总览</a>--%>
            <%--</li>--%>
            <li>
                <i class="iconfont icon-ydz-gerenxinxi"></i>
                <a href="/openPage?pageName=personInfo_per-data" target="presonContainer">个人信息</a>
            </li>
            <li>
                <i  class="iconfont icon-ydz-mimaxiugai"></i>
                <a href="/openPage?pageName=personInfo_per-modify-pwd" target="presonContainer">修改密码</a>
            </li>
            <%--<li>--%>
                <%--<i class="iconfont icon-ydz-xiugaishouji"></i>--%>
                <%--<a href="/openPage?pageName=personInfo_per-modify-phone" target="presonContainer">修改手机</a>--%>
            <%--</li>--%>
            <%--<li>--%>
                <%--<i class="iconfont yaoqingjiangli"></i>--%>
                <%--<a href="/openPage?pageName=personInfo_reward-situation" target="presonContainer">邀请奖励</a>--%>
            <%--</li>--%>
        </ul>
        <ul class="preson-container-left-botton">
            <%--<li class="iconfont yaoqingjiangli">
                <a href="#" target="presonContainer">邀请奖励</a>
            </li>--%>
            <li>
                <i class="iconfont xinshoubangzhu"></i>
                <a href="#" >新手帮助</a>
            </li>
            <li class="sever_hotLine">
                <i class="iconfont kefurexian"></i>
                <a>客服热线</a>
                <p>186-1690-0723</p>
            </li>
        </ul>
    </div>

    <!--右侧框架-->
    <div class="preson-container-right">
        <iframe src="/openPage?pageName=personInfo_per-data" id="iframepage" width="100%" name="presonContainer" frameborder="0"></iframe>
    </div>
</div>


<!--创建企业-->
<div class="creatr-company" id="creatrCompany">
    <div class="creatr-company-from">

        <div class="creatr-company-hrear">
            <img src="/images/chose-style1.jpg" alt="">
            <p>创建企业</p>
        </div>

        <div class="creatr-company-foot">
            <p>我的角色</p>
            <ul class="chose-manger">
                <li class="active">法人代表</li>
                <li>管理员</li>
            </ul>
            <p>企业全称</p>
            <p><input type="text" placeholder="营业执照上的公司全称（在线支付需实名认证）"></p>
            <p>简称或品牌</p>
            <p><input type="text" placeholder="公司简称或品牌名称"></p>
            <p>所在区域</p>
            <p>
                <select name="" id="">
                    <option value="上海">上海</option>
                    <option value="上海">上海</option>
                    <option value="上海">上海</option>
                    <option value="上海">上海</option>
                </select>
                <select name="" id="">
                    <option value="徐家汇">徐家汇</option>
                    <option value="徐家汇">徐家汇</option>
                    <option value="徐家汇">徐家汇</option>
                    <option value="徐家汇">徐家汇</option>
                </select>
                <select name="" id="">
                    <option value="上海">上海</option>
                    <option value="上海">上海</option>
                    <option value="上海">上海</option>
                    <option value="上海">上海</option>
                </select>
            </p>
        </div>
        <div class="reatr-company-footer">
            <ul>
                <li><button onclick="createCompanyModel('2')">以后再说</button></li>
                <li><button>创建</button></li>
            </ul>
        </div>
    </div>
</div>

<%--加入企业--%>
<div class="joinCompany joinCompany1">
    <div class="creatr-company-from">
        <div class="creatr-company-hrear">
            <img src="../../images/chose-style2.jpg" alt="">
            <p>加入企业</p>
        </div>

        <div class="joinCompanyContainer">
            <div class="joinCompanyperson">申请人：我是金老伯</div>
            <div class="joinCompanyinventCode">员工邀请码</div>
            <p class="joinCompanyinventInp"><input type="text" id="joinCompanyinventInp"><button id="joinCompanyinventBtn" disabled>搜索企业</button></p>
            <div class="joinCompanyDetail">
                <p>上海仁石科技有限公司</p>
                <p>金仁波</p>
                <p>18621619311</p>
            </div>
            <div class="joinCompanyinventNone">通过邀请码搜索到企业，才能申请加入</div>
            <div class="joinCompanyinventPass">已加入该企业</div>
        </div>

        <div class="joinCompanyBtn">
            <button class="yihouzaishuo">以后再说</button>
            <button class="shenqingjiaru">申请加入</button>
        </div>

    </div>
</div>
<div class="joinCompany joinCompany2">
    <div class="creatr-company-from">
        <div class="creatr-company-hrear">
            <img src="../../images/chose-style2.jpg" alt="">
            <p>加入企业</p>
        </div>

        <div class="joinCompanyContainer">
            <div class="joinCompanyDetail1">
                <p>上海仁石科技有限公司</p>
                <p>金仁波</p>
                <p>18621619311</p>
            </div>
            <div class="joinCompanySceccess">
                <p>申请成功</p>
                <p>企业管理员会尽快审核，审核结果会以短信形式通知您。<br>
                    请注意查收！</p>
            </div>
        </div>

        <div class="joinCompanyBtn">
            <button class="lijishiyonggerenban">立即使用个人版</button>
        </div>

    </div>
</div>

<%--&lt;%&ndash;邀请奖励&ndash;%&gt;--%>
<%--<div class="invent_user">--%>
    <%--<div class="invent_user_detail">--%>
        <%--<div class="invent_user_detail_big_title">邀请朋友使用，获得现金奖励！<span id="closeInvent"></span></div>--%>
        <%--<div class="invent_user_detail_big_title_title">--%>
            <%--被邀请人自注册起30天成为付费会员，您即可获得 <i>100<span>元</span></i>奖励--%>
            <%--<p><a target="_blank" href="/openPage?pageName=person-main&&tab=1">查看我的奖励 >></a></p>--%>
        <%--</div>--%>
        <%--<div class="invent_user_detail_big_title_link"></div>--%>
        <%--<div class="invent_user_detail_text">Copyright@2016 上海仁石科技版权所有</div>--%>
        <%--<input type="text" value="" id="inventMsg">--%>
        <%--<ul class="invent_user_detail_big_title_list">--%>
            <%--<li class="invent_user_detail_big_title_list1" id="inventMsgBtn">--%>
                <%--<h4>方法一</h4>--%>
                <%--<p>复制邀请链接 <br>通过微信或QQ发给好友注册</p>--%>
                <%--<img src="../../images/u44.png" alt="复制链接">--%>
                <%--<p>复制链接</p>--%>
            <%--</li>--%>
            <%--<li class="invent_user_detail_big_title_list2">--%>
                <%--<h4>方法二</h4>--%>
                <%--<p>打开微信或QQ扫描二维码</p>--%>
                <%--<div id="wechat_code"></div>--%>
                <%--<p>分享给好友注册</p>--%>
            <%--</li>--%>
            <%--<li class="invent_user_detail_big_title_list3">--%>
                <%--<h4>方法三</h4>--%>
                <%--<p>邀请客户、供应商注册</p>--%>
                <%--<p>直接创建生意伙伴</p>--%>
                <%--<p>即可发送短信邀请</p>--%>
                <%--<button onclick="openPartner()">立即邀请</button>--%>
            <%--</li>--%>
        <%--</ul>--%>
        <%--&lt;%&ndash;<div class="invent_user_detail_title">&ndash;%&gt;--%>
        <%--&lt;%&ndash;<div class="invent_user_detail_s_title">邀请奖励条款：</div>&ndash;%&gt;--%>
        <%--&lt;%&ndash;<p>1. 被邀请人自注册之日起30天内成为付费会员，邀请人可获得100元现金奖励！</p>&ndash;%&gt;--%>
        <%--&lt;%&ndash;<p>2. 本条款的解释权归本公司所有。</p>&ndash;%&gt;--%>
        <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
        <%--&lt;%&ndash;<div class="invent_user_detail_title">&ndash;%&gt;--%>
        <%--&lt;%&ndash;<div class="invent_user_detail_s_title">邀请方式：</div>&ndash;%&gt;--%>
        <%--&lt;%&ndash;<p>1. 在添加合作伙伴时，可以勾选向该用户“发送短信邀请”项。<button c-onclick="openCust()">添加合作伙伴</button></p>&ndash;%&gt;--%>
        <%--&lt;%&ndash;<p>2. 复制链接到好友的QQ或微信上邀请好友注册。</p>&ndash;%&gt;--%>
        <%--&lt;%&ndash;<p style="text-indent: 2rem;" ><span id="inventMsgShow"></span> <input type="text" value="" id="inventMsg"> <button id="inventMsgBtn">复制邀请链接</button></p>&ndash;%&gt;--%>
        <%--&lt;%&ndash;<p>3. 扫描下方二维码分享给微信好友或朋友圈邀请好友注册。</p>&ndash;%&gt;--%>
        <%--&lt;%&ndash;<div class="code_invent" id="wechat_code"></div>&ndash;%&gt;--%>
        <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
        <%--&lt;%&ndash;<button class="knowBtn">我知道啦</button>&ndash;%&gt;--%>
    <%--</div>--%>
<%--</div>--%>

<script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
<script src="/resources/common/hub-main.js?v=6efb77a8a4"></script>
<script src="/resources/util/jquery.qrcode.min.js?v=05f0b1d7d4"></script>

<script>
    screnHeight();	//检测高度
//    presonClick();  //法人头像
    menuClick();		//左侧导航切换
    choseManger();	//法人代表切换3
    inventUser(); //关闭邀请奖励

    //全局参数快递方法
    function GetRequest() {
        var url = location.search; //获取url中"?"符后的字串
        var theRequest = new Object();
        if (url.indexOf("?") != -1) {
            var str = url.substr(1);
            strs = str.split("&");
            for(var i = 0; i < strs.length; i ++) {
                theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]);
            }
        }
        return theRequest;
    }
    //打开邀请奖励
    var tab = GetRequest().tab;
//    switch (tab){
//        case "1" :
//            $(".preson-container-left-menu li").removeClass("hover");
//            $(".preson-container-left-menu li").eq(2).addClass("hover");
//            $("#iframepage").attr("src","/openPage?pageName=personInfo_reward-situation");
//            break;
//    }

    $.get("/invite/normal/getKey2",{},function(data){
        $('#wechat_code').qrcode({width: 100, height: 100, text: data});
    });
</script>

</body>
</html>
