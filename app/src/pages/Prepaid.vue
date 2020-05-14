<template>
    <div style="height:100%;">
        <div class="x-header">
            <back-header>
                <p class="title">预存款总览</p>
            </back-header>
        </div>
        <div class="big_first">
            <div class="rental">
                <p>
                    <span>
                        <img src="../assets/font-awesome/image/prepaid.png">
                    </span>
                </p>
                <p style="margin-top:10px;">
                    总余额
                </p>
                <p style="font-size:20px;">
                    &yen; <span style="font-family:'arial';font-size:22px;">{{totalMoney | filmoney}}</span>
                </p>
            </div>
            <div class="count_title">
                <div style="flex:1;">
                    <i style="font-size:30px;color:#37affd;position:relative;top:5px;right:7px;" class="iconfont">&#xe70c;</i>预存款用户</div>
                <div>
                    <i style="font-size:30px;color:#ff6600;position:relative;top:5px;right:5px;" class="iconfont">&#xe704;</i>余额</div>
            </div>
            <div style="background:#fff;height:calc(100% - 230px);overflow:auto;">
                <ul class="consumer">
                    <router-link tag="li" :to="{ name: 'prest', params: {'partnerShortname':n.partnerShortname,'partnerKey':n.partnerKey}}" v-for="(n,index) in news" key="index">
                        <div><span style="display:inline-block;width:30px;height:30px;line-height:30px;text-align:center;border-radius:50%;border:1px solid #f2f2f2;color:#37affd;">{{index+1}}</span>&nbsp;&nbsp;&nbsp;</div>
                        <div style="flex:1;border-bottom:1px solid #f9f9f9;font-size:16px;color:#333;">
                            {{n.partnerShortname}}
                        </div>
                        <div style="font-family:'arial';font-size:18px;color:#ff6600;border-bottom:1px solid #f9f9f9;padding-right:24px;">
                            {{n.balanceMoney | filmoney}}
                        </div>
                    </router-link>
                </ul>
                <div style="text-align:center;font-size:14px;color:#ccc;margin:10px 0 30px 0;">请通过电脑端为用户充值</div>
            </div>
        </div>
        <div v-if="showding" class="la-timer" style="position: absolute;top:45%;left:45%;z-index:999;">
            <div></div>
        </div>
        <div class="error_tips">没有数据...</div>
    </div>
</template>
<script>
import BackHeader from '../common/BackHeader';
import address from '../url.js';
import $ from 'jquery';
export default {
    components: {
        BackHeader
    },
    data() {
        return {
            news: [],
            totalMoney: 0,
            showding:true
        }
    },
    created() {
        this.getInfo();
    },
    methods: {
        getInfo() {
            this.axios.get(address.prepaid + localStorage.getItem('token') + "&page=1&rows=500")
                .then((data) => {
                    this.showding = false;
                    if (data.data.length == 0) {
                        $(".error_tips").fadeIn(250).delay(500).fadeOut(250);
                    } else {
                        this.news = data.data;
                        for (var i = 0; i < this.news.length; i++) {
                            this.totalMoney += this.news[i].balanceMoney;
                        }
                    }
                })
                .catch(err => {

                })
        }
    }
}
</script>
<style scoped>
.big_first {
    background: #fff;
}

header {
    background: #f26628!important;
}

.rental {
    height: 165px;
    background: #f26628;
}

.rental>p {
    text-align: center;
    color: #fff;
    font-size: 14px;
}

.rental>p:nth-child(1)>span {
    margin-top: 2px;
    display: inline-block;
    width: 80px;
    height: 80px;
    border-radius: 50%;
    border: 2px solid #fec600;
}

.rental>p img {
    margin-top: 15px;
    width: 50px;
    height: 50px;
    border-radius: 50%;
}

.count_title {
    display: flex;
    box-sizing: border-box;
    padding: 0 24px 0 18px;
    font-size: 14px;
    color: #333;
    line-height: 36px;
}

.consumer {
    box-sizing: border-box;
    padding-left: 21px;
}

.consumer li {
    line-height: 62px;
    display: flex;
}

.consumer>li div:nth-child(2) p {
    line-height: normal;
}

.icon {
    font-size: 30px;
    color: #37affd;
    position: relative;
    top: 2px;
    padding: 3px;
    border: 1px solid #f2f2f2;
    border-radius: 50%;
}

.error_tips {
    position: absolute;
    height: 4rem;
    line-height: 4rem;
    top: 50%;
    width: 70%;
    margin: 0 auto;
    left: 15%;
    right: 15%;
    background: #000;
    border-radius: 0.5rem;
    z-index: 1100;
    opacity: 0.7;
    display: none;
    color: #fff;
    text-align: center;
}
</style>
