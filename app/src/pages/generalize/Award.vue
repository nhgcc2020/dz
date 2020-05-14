<template>
    <div style="height:100%;overflow: hidden;">
        <div class="x-header">
            <x-header class="head_img" :left-options="{showBack: false}" v-cloak><img class="herder_img" src="../../assets/font-awesome/image/login.jpeg" alt=""> {{datanum.comShortname}}
                <router-link @click.native="Enter" style="color:#fff" slot="right" to="/quit">切换</router-link>
            </x-header>
        </div>
        <div class="big_first">
            <div class="invit" @click="flow">
                <img src="../../assets/font-awesome/image/award.png">
                <p style="margin-top:19px;font-size:16px;color:#666;">邀请好友使用易对账</p>
                <p style="margin-top:16px;font-size:24px;color:#666;">轻松获<span style="color:#ffcc33;font-weight: 900;">奖励</span>，多邀多得</p>
                <p style="font-size:14px;color:#f15822;margin-top:27px; font-weight: 900;">查看奖励规则 <i class="iconfont" style="color:#f15822;font-size:14px;position:relative;top:1px;">&#xe68b;</i></p>
            </div>
            <p @click="invite" class="button">立即邀请</p>
            <div style="margin-left:1000px;" id="id_text">https://www.yiduizhang.com/promoter/{{datanum.userKey}}</div>
            <actionsheet v-model="show" :menus="menus1" :closeOnClickingMenu="false"></actionsheet>
            <div class="alt">
                <p>系统版本过低请手动复制</p>
                <p>https://www.yiduizhang.com/promoter/{{datanum.userKey}}</p>
                <p @click="know">关闭</p>
            </div>
            <div class="cover"></div>
        </div>
    </div>
</template>
<script>
import { XHeader, Actionsheet, TransferDom } from 'vux';
import address from '../../url.js';
import Clipboard from 'clipboard';
import $ from 'jquery';
export default {
    directives: {
        TransferDom
    },
    components: {
        XHeader,
        Actionsheet
    },
    data() {
        return {
            datanum: "",
            show: false,
            menus1: [{
                label: '<span style="color:#000;font-size:14px;">转发给好友</span>',
                type: 'info'
            }, {
                label: '<div style="display: flex;justify-content: center;width:80%;margin:0 auto;"><div style="width:33%;display: inline-block;"><p id="id_copy" data-clipboard-target="#id_text" data-clipboard-action="copy" style="background:#cdcdcd;width:50px; border:none; height:50px;border-radius:50%;line-height:50px;margin:5px auto;"><i class="iconfont" style="color:#fff;font-size:40px;">&#xe6ba;</i></p><p style="color:#999999;font-size:12px;">复制推广链接</p></div><div style="width:33%;display: inline-block;"><p id="weixin" style="background:#03cb0b;width:50px; border:none; height:50px;border-radius:50%;line-height:50px; margin:5px auto;"><i class="iconfont" style="color:#fff;font-size:50px;">&#xe6ce;</i></p><p style="color:#999999;font-size:12px;">微信</p></div><div style="width:33%;display: inline-block;"><p id="QQ" style="background:#02abec;width:50px; border:none; height:50px;border-radius:50%;line-height:50px; margin:5px auto;"><i class="iconfont" style="color:#fff;font-size:40px;">&#xe6d9;</i></p><p style="color:#999999;font-size:12px;">QQ</p></div></div></div>    <div style="display: flex;justify-content: center;width:80%;margin:0 auto;"><div style="width:33%;display: inline-block;"><i id="coshow" class="iconfont" style="color:#03cb0b;font-size:70px;">&#xe6fc;</i><p style="color:#999999;font-size:12px;position:relative;top:-25px;">微信朋友圈</p></div><div style="width:33%;display: inline-block;"></div><div style="width:33%;display: inline-block;"></div></div></div>',
                type: 'info'
            }, {
                label: '<p style="font-size:14px;border:1px solid #ccc;width:90%;height:38px;line-height:38px;margin:0 auto;border-radius:5px;">取消</p>'
            }]
        }
    },
    created() {
        this.getInfo();
    },
    methods: {
        getInfo() {
            var _this = this;
            this.axios.get(address.personal + localStorage.getItem('token'))
                .then(function (data) {
                    if (data.data.code == -1) {
                        _this.$router.push('/login');
                    } else {
                        _this.datanum = data.data.data;
                    }
                })
                .catch(err => {
                })          
        },
        invite() {
            var _this = this;
            this.show = true;
            $("#weixin").click(function () {
                Wechat.share({
                    message: {
                        title: "亲，给你推荐一款广告公司管理软件-易对账！",
                        description: "1分钟注册即可试用，随时随地用APP查账对账，好像挺不错！",
                        thumb: "https://www.yiduizhang.com/images/login/xhdpi.png",
                        media: {
                            type: Wechat.Type.LINK,
                            webpageUrl: "https://www.yiduizhang.com/promoter/" + _this.datanum.userKey
                        } 
                    },
                    scene: Wechat.Scene.SESSION   // share to Timeline 
                }, function () {
                    // alert("Success");成功返回值 
                }, function (reason) {
                    // alert("Failed: " + reason);失败返回值 
                });
            })
             $("#coshow").click(function () {
                Wechat.share({
                    message: {
                        title: "亲，给你推荐一款广告公司管理软件-易对账！",
                        description: "1分钟注册即可试用，随时随地用APP查账对账，好像挺不错！",
                        thumb: "https://www.yiduizhang.com/images/login/xhdpi.png",
                        media: {
                            type: Wechat.Type.LINK,
                            webpageUrl: "https://www.yiduizhang.com/promoter/" + _this.datanum.userKey
                        } 
                    },
                    scene: Wechat.Scene.TIMELINE   // share to Timeline 
                }, function () {
                    // alert("Success");成功返回值
                }, function (reason) {
                    // alert("Failed: " + reason);失败返回值 
                });
            })
            
            $("#QQ").click(function () {
                var args = {};
                args.client = QQSDK.ClientType.QQ;//QQSDK.ClientType.QQ,QQSDK.ClientType.TIM; 
                args.scene = QQSDK.Scene.QQ;//QQSDK.Scene.QQZone,QQSDK.Scene.Favorite 
                args.url = "https://www.yiduizhang.com/promoter/" + _this.datanum.userKey;
                args.title = "亲，给你推荐一款广告公司管理软件-易对账！";
                args.description = "1分钟注册即可试用，随时随地用APP查账对账，好像挺不错！";
                args.image = 'https://www.yiduizhang.com/images/login/xhdpi.png';
                QQSDK.shareNews(function () {
                    // alert('shareNews success');成功返回值 
                }, function (failReason) {
                    // alert(failReason);失败返回值  
                }, args);
            })
        },
        flow() {
            this.$router.push('/flow');
        },
        know() {
            $(".alt").hide();
            $(".cover").hide();
        },
        myselft(){
            this.$router.push('/home/user');
            localStorage.setItem('currentTab', 'User');
        }
    }
}

$(function () {
    var clipboard = new Clipboard("#id_copy");
    clipboard.on("success", function (e) {
        $(".alart").fadeIn(250).delay(500).fadeOut(250);
        e.clearSelection();
    });
    clipboard.on("error", function (e) {
        $(".alart").text("复制失败").fadeIn(250).delay(500).fadeOut(250);
        setTimeout(function () {
            $(".alt").fadeIn(250);
            $(".cover").fadeIn(250);
        }, 1000);
    })
})
</script>
<style scoped>
html {
    font-family: "微软雅黑";
}

.big_first {
    background: #fff;
}

.invit {
    margin-top:3rem;
    width: 100%;
    text-align: center;
}
.invit>img{
    width: 160px;
    height: 148px;
}
.button {
    position: fixed;
    bottom: 94px;
    width: 80%;
    height: 40px;
    background: #4284d9;
    left: 10%;
    color: #fff;
    text-align: center;
    line-height: 40px;
    border-radius: 20px;
}
.alt{
    display: none;
    position: absolute;
    top: 20%;
    width: 70%;
    margin: 0 auto;
    left: 15%;
    right: 15%;
    background: #fff;
    border-radius: 0.5rem;
    z-index: 1100;
}
.alt p:nth-child(1){
    text-align: center;
    padding-top: 1rem;
}
.alt p:nth-child(2){
    font-size: 0.9rem;
    padding: 1rem;
    word-wrap:break-word;
}
.alt p:nth-child(3){
    padding:0.5rem 0;
    text-align: center;
    color: #4284d9;
    border-top: 1px solid #ccc;
}
.cover {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 110%;
    opacity: 0.2;
    z-index: 500;
    background: #000;
    display: none;
}
.herder_img{
  height: 26px;
  width: 26px;
  border-radius: 50%;
  margin-top:8px;
  margin-right:14px;
  float: left;
}
.foot{
    position: fixed;
    bottom: 0;
    height: 52px;
    width: 100%;
    border-top: 1px solid #dedede;
}
.foot ul{
    display: flex;
    justify-content: center;
}
.foot ul li{
    width: 33%;
    text-align: center;
    height: 52px;
}
.vux-header {
    background: #4284d9;
}
</style>
