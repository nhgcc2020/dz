<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>欢迎使用易对账</title>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script src="/resources/common/vue.min.js?v=32e8fb7bee"></script>
    <script src="/resources/pageConfig.js?v=d1935279f7"></script>
    <script src="/resources/cola-ui/china_city.js?v=bef170068c"></script>
    <%--选择使用场景--%>
    <style>
        html{margin:0;padding:0;border:0;}*{font-family:"microsoft yahei","\5FAE\8F6F\96C5\9ED1";}body,div,span,object,iframe,h1,h2,h3,h4,p,blockquote,pre,a,address,code,b,em,img,dl,dt,dd,ol,ul,li,fieldset,form,label,footer,header,hgroup,nav,section,input{margin:0;padding:0;border:0;}em,i,strong{font-style:normal;}
        ul,ol,li{list-style-type:none;}
        .registerCon   p,.registerCon h2,.registerCon h3{
            color:#fff;

            font-weight: normal;
        }
        li.active .mask,li:hover .mask{
            display: none;
        }
        button {
            cursor: pointer;
        }
        ul{
            position: relative;
        }
        .registerCon ul,li{
            float:left;
        }

        .tips_contants {
            position: fixed;
            top: 50%;
            left: 50%;
            z-index: 99999;
            display: none;
            margin-top: -150px;
            margin-left: -150px;
            width: 300px;
            height: 80px;
            border-radius: 5px;
            background: rgba(0, 0, 0, .8);
            color: #fff;
            text-align: center;
            line-height: 80px
        }
        .creatr-company-foot p{
            color:#333;
            font-size:14px;
        }
        .creatr-company-foot p input{
            height: 40px;
            line-height: 40px;
        }
        .successTip p{
            text-align: center;
        }
        /*#container {*/
        /*perspective: 50px;*/
        /*-webkit-perspective: 50px;*/
        /*-moz-perspective: 50px;*/
        /*-ms-perspective: 50px;*/

        /*transform-origin: 50% 100%;*/
        /*-webkit-transform-origin: 50% 100%;*/
        /*-moz-transform-origin: 50% 100%;*/
        /*-ms-transform-origin: 50% 100%;*/

        /*}*/




        /***********华丽分割线*************/
        .creatr-company-from{
            top:0;
            margin-top:100px;
        }
        .taxPointWin{
            border: none;
            z-index: 9999;

            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);

            background: #fff;
            transition:all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
            left:50%;
            /*display: none;*/
        }
        .personalInfo{
            border: none;

            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);

            background: #fff;
            transition:all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
            left:50%;
            /*display: none;*/
        }
        .btnEnter{
            width: 100px;
            height: 30px;
            background: #2e8ae6;
            color: #fff;
            border: none;
            line-height: 25px;
            text-align: center;
            margin: 15px 0px 0px;
            outline: none;
            font-size: 14px;
            border-radius: 3px;
        }
        .closetranform img{transition:transform 0.4s ease-in-out;}.closetranform img:hover{-webkit-transform:rotate(360deg);-moz-transform:rotate(360deg);transform:rotate(360deg);transition:transform 0.4s ease-out;}


                                                                  .tranform{transition:transform 0.4s ease-in-out;
                                                                      transform: rotate(90deg);-webkit-transform: rotate(90deg);
                                                                  }
                                                                  .tranform:hover{
                                                                      -webkit-transform:rotate(360deg);-moz-transform:rotate(360deg);transform:rotate(360deg);
                                                                  }

.titleMarg{
    /*margin-bottom: 60px;*/
}
        .successTip li{
    margin-top:20px;
    /*margin-top:-50px;*/

}
        .suceCon{
            height: 150px;
                position: relative;
            transition:all 0.2s 0s linear;
            /*box-shadow:0px -11px 20px 0px rgba(0, 0, 0, 0.2);*/
            /* border: 1px solid #ccc; */
            /*box-shadow: 1px 0px 10px 2px rgba(0, 0, 0, 0.2);*/
            width: 800px;
        }
        .suceCon:hover{
            transition:all 0.2s 0s linear;
            box-shadow:1px -2px 20px 0px rgba(0, 0, 0, 0.2);
            /*box-shadow: 0px -7px 20px 3px rgba(21, 117, 146, 0.37)*/
        }
        .btnHover:hover{
            transition:all 0.2s 0s linear;
            box-shadow: 0px 4px 12px 0px rgb(29, 104, 180);
        }
        .successTip  input[type="radio"]{
            opacity: 0;
            position: absolute;
            top: 10px;
            left: 10px;
            cursor: pointer;
            width: 50px;
            height: 40px;

        }

                                                             .successTip  input[type="radio"]~.selected {
                                                                 display: none;
                                                                 -webkit-user-select: none;
                                                               }
        .successTip  input[type="radio"]~.unselect {
            display: block;
            -webkit-user-select: none;
        }
        .successTip    input[type="radio"]:checked~.selected {
            display: block;
        }
        .successTip   input[type="radio"]:checked~.unselect {
            display: none;
        }
        /*label::before {*/
            /*content: "";*/
            /*display: inline-block;*/
            /*width: 15px;*/
            /*height: 15px;*/
            /*background: #EEE;*/
            /*vertical-align: middle;*/
            /*-webkit-border-radius: 50%;*/
            /*margin-right: 5px;*/
            /*-webkit-box-sizing: border-box;*/
            /*background: #fff;*/
            /*border: 1px solid #e4e4e4;*/
        /*}*/
        .suceCon span{
            font-size: 12px;
        }
        .successTip li{
            cursor: pointer;

        }

        .btnEnter:disabled{
            background: #C0C1C2;
            cursor: default;
        }
        @-webkit-keyframes textShake {
            0%{
                -webkit-transform:translate(0, 2px);
            }
            25%{
                -webkit-transform:translate(0, -10px);
            }
            50%{
                -webkit-transform:translate(0, 2px);
            }
            75%{
                -webkit-transform:translate(0, -8px);
            }
            100%{
                -webkit-transform:translate(0, 0);
            }
        }

        .textShake{
            -webkit-transform: translate3d(0, 0, 0);
            animation-duration:3s;animation-fill-mode:both;animation-name:textShake;
        }
    </style>
</head>
<body style="background: #000;" >

<div id="app">
    <div id="container"  style=" width: 100%;
    filter: blur(5px);
    height: 100%;
    opacity: .6;
    left: 0;
    border: none;
    position: fixed;
    background: url(/images/page/chooseScene.jpg) 100% 100% / cover;
    top: 0;"></div>
    <%--<div id="bg" style="background: rgb(65, 120, 129);width:100%;height: 100%;position:fixed;left:0;top:0;z-index:0;">--%>
    <div id="registerApp" style="    width: 684px;padding-top: 88px;left: 50%;top: 0;text-align: center;position: absolute;margin-left: -300px;" class="registerCon hide">
        <div v-if="showFlag" >
            <%--text-shadow:0px 0px 1px #fff;--%>
            <h2 style="line-height: 50px;font-size: 38px; letter-spacing: 10px;" class="animated fadeInLeft">个人账户注册成功</h2>
            <h3 style="font-size: 18px;line-height: 40px; letter-spacing: 5px;" class="animated fadeInLeft">如果你需要销售开单、采购记账，请选择左下方开通公司</h3>
            <div style="margin:50px 10px;">
                <ul>
                    <li style="position: relative;margin-right: 52px;"  @mouseenter="enterLi($event)" @mouseleave="leaveLi($event)" class="active animated slideInDown" >
                        <%--box-shadow: 0px 0px 20px 0px #fff;--%>
                        <div style="background: #fff;text-align:center;border-radius: 5px;width:280px;">
                            <img class="comImgTran" style="margin:36px auto 20px;width:80px;height: 80px;border-radius: 40px;"  src="/images/default_company.png"/>
                            <p style="color:#333;font-size: 18px;">开通公司，记账对账</p>
                            <div style="height: 1px; background: #f1f0f0;width:200px;margin:24px  auto;"></div>
                            <p style="    width: 200px;
    color: #999;
    font-size: 14px;height: 35px;
    margin: 0 auto;">销售开单，采购记账，管客户</p>
                            <p style="    width: 200px;
    color: #999;
    font-size: 14px;
    margin: 0 auto;">管报价，管员工，APP查账</p>
                            <a style="border-radius: 20px;
    user-select: none;cursor: pointer;
    display: inline-block;
    -webkit-user-select: none;
    height: 44px;
    line-height: 44px;
    color: #fff;
    border: none;
    font-size: 14px;
    width: 220px;
    background: #4284d9;
    margin: 40px auto 46px;" v-on:click="regOpen">作为公司管理者，立即开通</a>
                        </div>
                        <a style="position:absolute;width:100%;height:100%;top:0;left:0;background: #000;opacity: 0.3;" class="mask"></a>
                    </li>


                    <li style="position: relative;margin-left: 52px;"   @mouseenter="enterLi($event)" @mouseleave="leaveLi($event)" class=" animated fadeInDown" >
                        <%--box-shadow: 0px 0px 20px 0px #fff;--%>
                        <div style="background: #fff;text-align:center;border-radius: 5px;width:280px;">
                            <img class="comImgTran" style="margin:36px auto 22px;width:80px;height: 80px;border-radius: 40px;"  src="/images/page/personalTx.png"/>
                            <p style="color:#333;font-size: 18px;">使用个人版，成为推广大使</p>
                            <div style="height: 1px; background: #f1f0f0;width:200px;margin:24px  auto;"></div>
                            <p style="    width: 200px;
    color: #999;
    font-size: 14px;height: 35px;
    margin: 0 auto;">邀请好友注册使用易对账</p>
                            <p style="    width: 200px;
    color: #999;
    font-size: 14px;
    margin: 0 auto;">奖励拿不停</p>
                            <a style="
    user-select: none;cursor: pointer;
    display: inline-block;
    -webkit-user-select: none;
    height: 40px;
    line-height: 40px;
    color: #4284d9;
    border: none;
    font-size: 14px;
    width: 200px;
    margin: 40px auto 46px;" 　v-on:click="marketOpen($event)" >作为个人，立即推广 > </a>
                        </div>
                        <a style="position:absolute;width:100%;height:100%;top:0;left:0;background: #000;opacity: 0.3;" class="mask"></a>
                    </li>

                </ul>
            </div>
        </div>
    </div>

    <%--</div>--%>

    <div id="comApp" class=" hide" style="height: 100%;width:100%;position: absolute;">
        <div class="creatr-company-from createComCon animated fadeInDown" v-if="comBoxFlag">

            <span v-on:click="create('2')" class="iconfont_new tranform" style="    font-size: 58px;
    color: rgb(255, 255, 255);
    position: absolute;
    right: -100px;
    top: -12px;
    ">&#xe6a0;</span>

            <div class="creatr-company-hrear">
                <img src="/images/chose-style1.jpg" alt="">
                <p>创建企业</p>
            </div>

            <div class="creatr-company-foot">
                <p>我的角色</p>
                <ul class="chose-manger">
                    <%----%>
                    <li v-for='(item,index) in dataManager'  :data-value="item.value" :class="{active:iscur==index}" @click="iscur=index" v-text="item.name" ></li>
                </ul>
                <p>企业全称</p>
                <p><input type="text" id="comName" placeholder="营业执照上的公司全称"></p>
                <p>简称或品牌</p>
                <p><input type="text" id="comShortname" placeholder="简称或品牌"></p>
                <p>所在区域</p>
                <p>
                    <select name="province" id="province" v-model="selectedProvince">
                        <option selected value="">请选择省份</option>
                        <option v-for="option in provOptions" v-bind:value="option.provinceId">
                            {{ option.provinceName }}
                        </option>
                    </select>
                    <select name="city" id="city" placeholder="请选择城市" v-model="selectedCity" >
                        <option selected value="">请选择城市</option>
                        <option v-for="optCity in cityOptions" v-bind:value="optCity.cityId">
                            {{optCity.cityName}}
                        </option>
                    </select>
                    <select name="country" id="country" v-model="selectedCountry">

                        <option selected value="">请选择区域</option>
                        <option v-for="optCuntry in countryOptions" v-bind:value="optCuntry.countryId">
                            {{optCuntry.countryName}}
                        </option>
                    </select>
                </p>
            </div>
            <div class="reatr-company-footer">
                <ul>
                    <li>
                        <button v-on:click="create('2')" 　style="width:100px;color:#666">取消</button>
                    </li>
                    <li>
                        <button  v-on:click="save($event)" style="width:168px;">创建企业，开始记对账</button>
                        <%--<button onclick="save_company(this)">创建</button>--%>
                    </li>
                </ul>
            </div>
        </div>
        <div class="creatr-company-from creatr_box2 animated  zoomIn" v-if="comBox2Flag">
            <div class="creatr-company-hrear">
                <img src="/images/chose-style1.jpg" alt="">
                <p>创建企业</p>
            </div>

            <div class="joinCompanyContainer">
                <div class="joinCompanyDetail1">
                    <p >{{result.comName}}</p>
                    <p >{{result.adminName}}</p>
                    <p >{{result.adminPhone}}</p>
                </div>
                <div class="joinCompanySceccess">
                    <p>创建成功</p>
                    <%--企业管理员会尽快审核，审核结果会以短信形式通知您。--%>
                    <p>您的企业对账号为:<span >{{result.comId}}</span><br>
                        客户或供应商可以通过企业对账号来申请成为您的好友！</p>
                </div>
            </div>

            <div class="joinCompanyBtn">
                <button v-on:click="typeOpen" class="">开启体验之旅</button>
            </div>

        </div>

        <div v-if="comBox4Flag" class="successTip" style="margin:20px auto;width:1000px;height: 865px;">

            <p style="height: 70px;
    line-height: 70px;">
                <img src="/images/default_company.png" style="width:46px;height: 46px;border-radius: 23px;">
                <span style="    font-size: 22px;
    color: #fff;        font-size: 20px;
    color: rgb(255, 255, 255);
    margin-left: 32px;
    margin-left: 22px;">企业创建成功，请选择一种公司类型，完成企业开通</span>
            </p>
            <div style="padding:20px 100px 0;background: #f2f2f2;margin:20px 0;" class="con">
                <div style="text-align: center;">
                    <%--<p style="margin-bottom: 20px;"><img src="/images/page/step.png"></p>--%>

                    <p class="titleMarg" style="height:40px;line-height:40px;color:#ff5505;font-size:14px;text-align: center;">
                        本软件的大部分功能(采购管理/费用等)<span class="textShake" style="display:inline-block;margin:0 10px;font-size: 22px;color:#ff0000">永久免费使用</span>。  仅销售管理功能需付费使用（50笔销售单内试用）</p>
                    <ul>
                        <li v-on:click="radioSel" aid="1A" did="小型广告设计工作室">
                            <span style="   position: absolute;
    left: 24px;
    top: 117px;
    width: 120px;

    z-index: 99;
    height: 38px;
    color:#f2f2f2;
     font-size: 12px;
    line-height: 38px;
    background: rgb(46, 138, 230);
    ">小型广告设计工作室</span>
                            <div class="suceCon" style=" background: url(/images/page/designgg.png?v1) 20px center no-repeat #fff;">
                             <div style="    position: absolute;
    top: 40px;
    right: 34px;">
                                <input type="radio" name="typeRd">
                                <i class="iconfont_new selected" style="color:#2e8ae6;font-size: 46px;">&#xe67d;</i>
                                <i class="iconfont_new unselect" style="color:#2e8ae6;font-size: 46px;">&#xe684;</i>
                                 <span>选择</span>
                             </div>
                            </div>
                        </li>
                        <li v-on:click="radioSel" aid="1B"　did="综合型广告传媒公司"><div class="suceCon" style=" background: url(/images/page/zhonghegg.png?v1) 20px center no-repeat #fff;" >
                                <span style="    position: absolute;
    left: 24px;
    top: 97px;
    width: 120px;
    z-index: 99; color:#f2f2f2;
     font-size: 12px;
    height: 38px;    line-height: 38px;
    background: rgb(46, 138, 230);">综合型广告传媒公司</span>
                           <div style="    position: absolute;
    top: 40px;
    right: 34px;">
                                <input type="radio" name="typeRd">
                                <i class="iconfont_new selected" style="color:#2e8ae6;font-size: 46px;">&#xe67d;</i>
                                <i class="iconfont_new unselect" style="color:#2e8ae6;font-size: 46px;">&#xe684;</i>
                                <span>选择</span>
                            </div>
                        </div></li>
                        <li v-on:click="radioSel" aid="1C"　did="广告加工制作企业"><div class="suceCon" style=" background: url(/images/page/processgg.png?v1) 20px center no-repeat #fff;" >
                                     <span style="    position: absolute;
    left: 24px;
    top: 97px;
    width: 120px;
    z-index: 99;
    height: 38px; color:#f2f2f2;
     font-size: 12px;    line-height: 38px;
    background: rgb(46, 138, 230);">广告加工制作企业</span>
                            <div style="    position: absolute;
    top: 40px;
    right: 34px;">
                                <input type="radio" name="typeRd">
                                <i class="iconfont_new selected" style="color:#2e8ae6;font-size: 46px;">&#xe67d;</i>
                                <i class="iconfont_new unselect" style="color:#2e8ae6;font-size: 46px;">&#xe684;</i>
                                <span>选择</span>
                            </div>
                        </div></li>
                        <li v-on:click="radioSel" aid="1D"　did="数码图文快印店"><div class="suceCon" style=" background: url(/images/page/tuwengg.png?v1) 20px center no-repeat #fff;"  >
                            <span style="    position: absolute;
    left: 24px;
    top: 97px;
    width: 120px;
    z-index: 99; color:#f2f2f2;
     font-size: 12px;
    height: 38px;    line-height: 38px;
    background: rgb(46, 138, 230);">数码图文快印店</span>
                            <div style="    position: absolute;
    top: 40px;
    right: 34px;">
                                <input type="radio" name="typeRd">
                                <i class="iconfont_new selected" style="color:#2e8ae6;font-size: 46px;">&#xe67d;</i>
                                <i class="iconfont_new unselect" style="color:#2e8ae6;font-size: 46px;">&#xe684;</i>
                                <span>选择</span>
                            </div>
                        </div></li>

                    </ul>
                    <button v-on:click="successOpen" class="btnHover" style="text-align: center;outline:none;margin:30px auto;border-radius: 24px;background:#2e8ae6;border:none;color:#fff;width:100px;height: 30px;">下一步</button>
                </div>
            </div>
        </div>
        <div  v-if="comBox5Flag" class=" taxPointWin  "  style="    height:480px;
            width:520px;
        ;margin-left:-260px;padding-top:5px;margin-top:100px;position:absolute; ">

            <%--<span class="closetranform" style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" v-on:click="comOpen"><img src="/images/close_user.png" alt="点击关闭"></span>--%>
                <span v-on:click="comOpen" class="iconfont_new tranform" style="    font-size: 58px;
    color: rgb(255, 255, 255);
    position: absolute;
    right: -100px;
    top: -12px;
    ">&#xe6a0;</span>

            <div style="text-align: center;margin: 0 auto;">
                <img class="comImgTran" style="margin:44px auto 26px;width:120px;height: 120px;border-radius: 60px;"  src="/images/default_company.png"/>
                <p style="font-size: 18px;color:#333;">您选择了，<span style="color:#f15822" >{{result.comType}}</span></p>
                <p style="font-size: 14px;color:#666;margin:16px auto 30px;">公司类型关系到功能和收费模式，确定后将无法再更改</p>
                <div>
                    <button type="button" v-on:click="startOpen" class="btnEnter openOnce" style="margin-bottom:20px;cursor:pointer;width:212px;height:38px;font-size:14px;" >我已确定，立即开通</button>
                </div>
                <a style="font-size: 14px;margin:22px auto;color:#4284d9;cursor:pointer;" v-on:click="comOpen">选错了，重新选择公司类型 > </a>

            </div>
        </div>
        <%--<div  v-if="comBox6Flag" class=" taxPointWin animated swing"  style="    height:480px;--%>
            <%--width:520px;--%>
        <%--;margin-left:-260px;padding-top:5px;margin-top:100px;position:absolute; ">--%>

            <%--<span class="closetranform" style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" v-on:click="comOpen"><img src="/images/close_user.png" alt="点击关闭"></span>--%>
            <%--<div style="text-align: center;margin: 0 auto;">--%>
                <%--<img class="comImgTran" style="margin:44px auto 26px;width:120px;height: 120px;border-radius: 60px;"  src="/images/default_company.png"/>--%>
                <%--<p style="font-size: 18px;color:#333;">您选择了，<span style="color:#f15822" >{{result.comType}}</span></p>--%>
                <%--<p style="font-size: 14px;color:#666;margin:16px auto 30px;">公司类型关系到功能和收费模式，确定后将无法再更改</p>--%>
                <%--<div>--%>
                    <%--<button type="button" v-on:click="startOpen" class="btnEnter" style="margin-bottom:20px;cursor:pointer;width:212px;height:38px;font-size:14px;" >我已确定，立即开通</button>--%>
                <%--</div>--%>
                <%--<a style="font-size: 14px;margin:22px auto;color:#4284d9;cursor:pointer;" v-on:click="comOpen">选错了，重新选择公司类型 > </a>--%>

            <%--</div>--%>
        <%--</div>--%>

        <div  v-if="comBox7Flag" class=" taxPointWin animated bounce"  style="    height:600px;
            width:540px;
        ;margin-left:-260px;padding-top:5px;margin-top:100px;position:absolute; ">

            <%--<span class="closetranform" style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" v-on:click="comOpen"><img src="/images/close_user.png" alt="点击关闭"></span>--%>
            <div style="text-align: center;margin: 0 auto;">
                <img class="comImgTran" style="margin:30px auto 30px;width:200px;height: 200px;border-radius: 100px;"  src="/images/chose-style2.jpg"/>
                <p style="font-size: 28px;color:#f15822;">企业开通成功，祝生意兴隆！</p>
                <p style="font-size: 14px;color:#666;margin:16px auto 30px;">
                    <i class="iconfont_new" style="font-size: 30px;
    vertical-align: middle;">&#xe6d4;</i>
                    <span>恭喜您还获得折扣代金券，７天内订购易对账享受优惠</span>
                </p>
                <div>
                    <button type="button" v-on:click="mainOpen" class="btnEnter" style="margin:134px auto 100px;cursor:pointer;width:200px;height:36px;font-size:14px;" >立即免费体验</button>
                </div>

            </div>
        </div>


        <%--<div  v-if="comBox3Flag"  style="   height: 480px;--%>
    <%--width: 520px;--%>
    <%--margin-left: -260px;--%>
    <%--padding-top: 5px;--%>
    <%--margin-top: 100px;--%>
    <%--position: absolute;--%>
    <%--background: #fff;"  class="personalInfo  " >--%>
            <%--<p style="position:relative; text-align: center; font-size: 22px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;">--%>
                <%--个人版介绍</p>--%>
            <%--&lt;%&ndash;<span class="closetranform" style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" v-on:click="close"><img src="/images/close_user.png" alt="点击关闭"></span>&ndash;%&gt;--%>
            <%--<span v-on:click="close" class="iconfont_new tranform" style="    font-size: 58px;--%>
    <%--color: rgb(255, 255, 255);--%>
    <%--position: absolute;--%>
    <%--right: -100px;--%>
    <%--top: -12px;--%>
    <%--">&#xe6a0;</span>--%>
            <%--<div style="text-align: center;margin: 0 auto;">--%>
                <%--<img class="comImgTran" style="margin:44px auto 26px;width:120px;height: 120px;border-radius: 60px;"  src="/images/page/personalTx.png"/>--%>
                <%--<p style="font-size: 20px;color:#333;">成为易对账推广大使</p>--%>
                <%--<p style="font-size: 14px;color:#666;margin:16px auto 24px;">邀请好友来使用，奖励拿不停</p>--%>
                <%--<div>--%>
                    <%--<button type="button" v-on:click="marketOpen($event)" class="btnEnter" style="margin-bottom:22px;cursor:pointer;width:280px;height:38px;font-size:14px;" >我知道了，去看看活动规则</button>--%>
                <%--</div>--%>
                <%--<a style="font-size: 14px;margin:22px auto;color:#4284d9;cursor:pointer;" v-on:click="regOpen">如需销售开单、采购记账，需开通企业版 > </a>--%>

            <%--</div>--%>
        <%--</div>--%>

    </div>
    <%--创建企业--%>
    <script>
        var app= new Vue({
            el: '#app',
            data: {
                result: {},
                iscur:0,
                dataManager:[{"name":"法人代表",value:"boss"},{"name":"管理员",value:"admin"}],
                comBoxFlag: false,
                comBox3Flag: false,
                comBox4Flag: false,
                comBox5Flag: false,
                comBox6Flag: false,
                comBox7Flag: false,
                comBox2Flag:false,
                showFlag:false,
                selectedProvince:"",
                selectedCity:"",
                initCountry:"",
                selectedCountry:"",
                provOptions:ProvinceJson,
                cityJson:CityJson,
                countryJson:CountryJson,
                cityOptions:[],
                countryOptions:[]
            },
            mounted:function () {
            },
            watch:{
                selectedProvince:function (val) {
                    var that=this;
                    //设置市级select 的内容
                    var B=[];
                    that.selectedCountry="";
                    that.selectedCity=that.initCountry;
//                    alert(that.selectedCity);
                    for (var j = 0; j < that.cityJson.length; j++) {
                        if (that.cityJson[j].provinceId ==val) {
//                       city_slt.append("<option value=" + CityJson[j].cityId + ">" + CityJson[j].cityName + "</option>");
                            B.push(that.cityJson[j]);
                        }
                    }
                    that.cityOptions=B;
                    that.initCountry="";
                },
                selectedCity:function (val) {
                    var that=this;
                    //设置市级select 的内容
                    var B=[];
                    that.selectedCountry="";
                    for (var k = 0; k < that.countryJson.length; k++) {
                        if (that.countryJson[k].cityId == val) {
                            B.push(that.countryJson[k]);
                        }
                    }
                    that.countryOptions=B;
                }

            },
            created:function () {

            },

            ready: function() {



//                localStorage.Pool =  JSON.stringify([]); //初始化发票池
            },
            methods: {
//                getProv:function (val) {
//
//                },
//                getCountry:function (val) {
//
//                },

                initDt: function() {
                    var that =this ;
//                $.ajax({
//                    type: 'get',
//                    url: that.apiUrl,
//                    success:function(data){
//                        if(data.ret_code==200) {
//                            that.result = data.result;
//                        }},
//                    error:function(data){
//                    }
//                })
                    var province_slt = $("#province");
                    var city_slt = $("#city");
                    var country_slt = $("#country");
//                for (var i = 0; i < ProvinceJson.length; i++) {
//                    province_slt.append("<option value=" + ProvinceJson[i].provinceId + ">" + ProvinceJson[i].provinceName + "</option>");
//                }
//                that.provOptions
                    //选中省

                    //选中市
//                city_slt.change(function () {
//                    var currentCountry = $(this).val();
//                    $("#country option:gt(0)").remove();
//                    //设置县级select 的内容
//                    for (var k = 0; k < CountryJson.length; k++) {
//                        if (CountryJson[k].cityId == currentCountry) {
//                            country_slt.append("<option value=" + CountryJson[k].countryId + ">" + CountryJson[k].countryName + "</option>");
//                        }
//                    }
//                });


//                    that.selectedProvince=data.region_id;

//                    that.selectedCity=data.city_id;
                    $.ajax({
                        url: '/reg/getLocation',
                        type: 'GET',
//                    timeout:"6000",
                        dataType: "json",
                        success: function (data) {
                            that.initCountry=data.city_id;
                            that.selectedProvince=data.region_id;
                            that.selectedCity=data.city_id;
                        }
                    });
                },
                enterLi:function (e) {
//                var target=e.target;
                    var btn=e.currentTarget;
//                var t=$(this).hasClass("active")?"acitve":"";
                    $(btn).addClass("active").siblings().removeClass("active");
//                $(this).removeClass("fadeInDown animated "+t).addClass('bounce animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
//                    $(this).removeClass("bounce");
//                });
                },
                leaveLi:function (e) {
//                var btn=e.currentTarget;
                },
                regOpen: function() {
                    $("#comApp").removeClass("hide");
                    this.showFlag=false;
                    this.comBox3Flag=false;
                    this.comBoxFlag=true;
                    this.initDt();
                },
                comOpen: function() {
                    this.result.comType="";
                    this.result.industryId="";
                    this.comBox4Flag=true;
                    this.comBox5Flag=false;
                },
                personalOpen: function() {
                    $("#comApp").removeClass("hide");
                    this.showFlag=false;
                    this.comBox3Flag=true;
//                    this.initDt();
                },
                close: function() {
                    this.showFlag=true;
                    this.comBox3Flag=false;
                    this.comBoxFlag=false;

//                    this.initDt();
                },
                successOpen: function() {
                    var d=this.result.comType;
                    if(!d ||d==""){
                        tipsPop("请选择公司类型");
                        return;
                    }
                    this.comBox5Flag=true;
                    this.comBox4Flag=false;

//                    this.initDt();
                },
                startOpen: function(event) {
                    var that=this,btn=event.currentTarget;
//                    this.initDt(); 我已确定，立即开通
                    $(btn).attr("disabled", "disabled").html("正在开通...");
                    var industryId =  that.result.industryId;
                    $.ajax({
                        url: '/payment/upgradeTrialVersion',
                        type: 'GET',
                        async: true,
                        dataType: "json",
                        data: {industryId: industryId},
                        success: function (data) {
                            if (data.state == true) {
                                $(btn).removeAttr("disabled").html("我已确定，立即开通");
                                that.comBox7Flag=true;
                                that.comBox6Flag=false;
                            }
                        },
                        error: function () {
                            $(btn).removeAttr("disabled").html("我已确定，立即开通");
                            tipsPop("升级失败");
                        }
                    });
                },
                typeOpen: function() {
                    this.comBox4Flag=true;
                    this.comBox2Flag=false;
//                    this.initDt();
                },
                radioSel:function (event) {
                    var that=this,btn=event.currentTarget;
                    that.result.comType=$(btn).attr("did");
                    that.result.industryId=$(btn).attr("aid");
                    $(btn).find("input[type='radio']").prop('checked', true);
                },
                mainOpen: function() {
                    window.location.href = "/login/tomain"
                },
                marketOpen: function(event) {
                    var btn=event.currentTarget;
                    $(btn).attr("disabled",true);
                    $.post(
                        "/reg/toBePromoter",
                        function (data) {
                                    window.location.href="/login/tomain";
                        }
                    )


                },
                save:     function (event) {
                    var that=this,btn=event.currentTarget;
                    $(btn).css({"pointer-events": "none"}).html("创建中...");
                    var bossOrAdmin = $(".chose-manger").find(".active").data("value");
                    var comName = $.trim($("#comName").val());
                    if (comName == "") {
                        $(btn).css({"pointer-events": "auto"}).html("创建企业，开始记对账");
                        tipsPop("请填写企业全称");
                        return false;
                    }
                    var comShortname = $.trim($("#comShortname").val());
                    if (comShortname == "") {
                        $(btn).css({"pointer-events": "auto"}).html("创建企业，开始记对账");
                        tipsPop("请填写企业简称");
                        return false;
                    }
                    var province = $("#province").val();
                    if (province == "" || province == null) {
                        $(btn).css({"pointer-events": "auto"}).html("创建企业，开始记对账");

                        tipsPop("请选择省");
                        return false;
                    }
                    var city = $("#city").val();
                    if (city == "" || city == null) {
                        $(btn).css({"pointer-events": "auto"}).html("创建企业，开始记对账");
                        tipsPop("请选择市");
                        return false;
                    }
                    var country = $("#country").val();
                    if (country == "" || country == null) {
                        $(btn).css({"pointer-events": "auto"}).html("创建企业，开始记对账");
                        tipsPop("请选择区/县");
                        return false;
                    }
                    $.post(
                        "/reg/saveCom",
                        {
                            bossOrAdmin: bossOrAdmin,
                            comName: comName,
                            comShortname: comShortname,
                            comProvince: province,
                            comCity: city,
                            comCountry: country
                        },
                        function (data) {

                            if (data.state) {
//                            $.get("/company/openPerson", {userKey_person: data.userKey_person, comType: "1"}, function (data) {
//                            });
                                <%--cola.model().set("create_company", {--%>
                                <%--comName: comName,--%>
                                <%--adminName: '${sessionScope.sessionUser.realName}',--%>
                                <%--adminPhone: '${sessionScope.sessionUser.userId}',--%>
                                <%--comId: data.comId--%>
                                <%--});--%>
//                            $(".createComCon").fadeOut();
                                <%--that.result.comName=comName;--%>
                                <%--that.result.adminName='${sessionScope.sessionUser.realName}';--%>
                                <%--that.result.adminPhone='${sessionScope.sessionUser.userId}';--%>
                                <%--that.result.comId=data.comId;--%>

                                setTimeout(function () {
//                                    that.comBoxFlag = false;
//                                that.comBox2Flag = true;
//                                    that.comBox4Flag=true;
                                    window.location.href="/login/tomain";
                                },2000);

//                                this.comBox2Flag=false;
                            } else {

                                tipsPop(data.msg);
                                $(btn).css({"pointer-events": "auto"}).html("创建企业，开始记对账");

                            }
                        }
                    )
                },
                create:  function (val) {
                    switch (val) {
                        case "1":
//                        $(".createComCon").fadeIn();
                            this.comBoxFlag = false;
                            //默认省市



                            break;
                        case "2":
//                        $.post("/company/openPerson", {}, function (data) {
//                        });
//                        $(".createComCon").fadeOut();
//                        $("#comApp").removeClass("hide");

//                            $("#registerApp").removeClass("hide");
                            if(iscreate){
                                window.location.href="/login/tomain";
                            }else{
                                this.comBoxFlag=false;
                                this.showFlag=true;
                            }

                            break;
                        //点击创建个人
                        case "3":
                            $.post(
                                "/company/openPerson", {}, function (data) {
                                    if (data == "1") {
                                        window.location.reload();
//                            $(".chose-style").fadeOut();
                                    } else {
                                        alert("请重新登录");
                                    }
                                });
                            break;
                    }
                }
            }
        });

        //   app.comBox2Flag=true;
        //   app.comBoxFlag=true;
        //创建企业

        //    createCompanyModel("1");
        //创建公司



    </script>

</div>
<%--页面的脚本设置--%>
<script>

var gType="${type}",iscreate=false;
var tp=getRequestParam.GetRequest().tp;
//alert(gType);
if(tp && tp=="create"){
    iscreate=true;
}
//gType="await";

    if(gType==="await"){

        // $("#comApp,.registerCon").removeClass("hide");

        $("#registerApp").removeClass("hide");
//    $("#comApp").removeClass("hide");
        app.showFlag=true;
//    app.comBox4Flag=true;
    }else if(gType==="choose-industry"){
        $("#registerApp").addClass("hide");
    $("#comApp").removeClass("hide");
        app.showFlag=false;
    app.comBox4Flag=true;
    }else if(iscreate){
        $("#registerApp").addClass("hide");
        $("#comApp").removeClass("hide");
        app.showFlag=false;
        app.comBoxFlag=true;
        app.initDt();
    }
//app.comBox7Flag=true;




    window.onload = function () {
        //禁止返回上一页
        window.history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
    }

    // tips提示框
    function tipsPop(h) {
        $(".tips_contants").empty();
        $("<div class='tips_contants'>").fadeIn(250).html(h).delay(1000).fadeOut(250).appendTo('body');
    }

</script>
</body>
</html>