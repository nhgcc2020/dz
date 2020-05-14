<template>
    <div>
        <div class="x-header">
            <back-header>
                <p class="title">回款分布</p>
            </back-header>
        </div>
        <div class="searching">
            <p @click="select">
                <span>{{value1}}</span> -
                <span>{{value2}}</span>
                <i style="color:#2e8ae6;" class="iconfont">&#xe68d;</i>
            </p>
            <div class="side">
                <ul>
                    <li @click="chose(0)">全部时间段</li>
                    <li @click="chose(1)">上月</li>
                    <li @click="chose(2)" class="default">本月</li>
                    <li @click="chose(3)">第一季度</li>
                    <li @click="chose(4)">第二季度</li>
                    <li @click="chose(5)">第三季度</li>
                    <li @click="chose(6)">第四季度</li>
                    <li @click="chose(7)">上半年</li>
                    <li @click="chose(8)">下半年</li>
                    <li @click="chose(9)">今年</li>
                    <li @click="chose(10)">去年</li>
                </ul>
                <div @click="custom" style="height:50px;line-height:50px;text-align:center;border-top:1px solid #e9e9e9;">自定义时间</div>
            </div>
        </div>
        <div class="overall">
            <span style="margin-top:24px;width:49%;">
                <p style="font-size:14px;color:#999;">合计对账单金额</p>
                <p style="font-size:20px;color:#ee6877;">&yen; {{sumRangeTotalPrice | money}}</p>
            </span>
            <span style="margin-top:28px;width:2%; border-left:2px solid #f2f2f2;height:47px;"></span>
            <span style="margin-top:24px;width:49%;">
                <p style="font-size:14px;color:#999;">合计实收金额</p>
                <p style="font-size:20px;color:#ee6877;">&yen; {{sumRangeRecpayMoney | money}}</p>
            </span>
        </div>
        <div @click="screen" class="cell-title">
            <span style="float:right;width:20px;height:20px;line-height:6px;margin-top:20px;margin-left:5px;">
                <i style="color:#2e8ae6;font-size:12px;display:block;" :class="{'iconfont':true,'screen-icon':icon}">&#xe68e;</i>
                <i style="color:#2e8ae6;font-size:12px;" :class="{'iconfont':true,'screen-icon':!icon}">&#xe68d;</i>
            </span>
            <span>收款账户</span>
            <span class="title-r">实收金额</span>
        </div>
        <div>
            <div class="sare_time" v-for="(n,index) in news" key="index">
                <router-link tag="div" to="">
                    <ul class="sare_ul">
                        <li class="sare_one" v-cloak>
                            <div>
                                <p>{{n.accountPayee}}</p>
                                <p>
                                    <span style="color:#989898;">{{n.sumTotalPrice | money}}（账单）</span>
                                </p>
                            </div>
                            <p class="sare-r">{{n.sumRecpayMoney | money}}</p>
                        </li>
                        <li class="sare_two" v-cloak>
    
                        </li>
                        <li class="sare_three" v-cloak></li>
                    </ul>
                </router-link>
            </div>
        </div>
        <div class="foot">
            <ul style="width:100%;position:absolute;top:10px;z-index:1000;background:#fff;">
                <li @click.stop="quit()" :class="{ line: isShow }">
                    <div>开始时间</div>
                    <div>{{value3}}</div>
                </li>
                <li @click="quit()" :class="{ line: !isShow }">
                    <div>结束时间</div>
                    <div>{{value4}}</div>
                </li>
            </ul>
            <div v-if="show4">
                <datetime-view v-if="isShow" v-model="value3"></datetime-view>
                <datetime-view v-if="!isShow" :start-date="value3" end-date="2030-01-01" v-model="value4"></datetime-view>
            </div>
            <div class="last">
                <span @click="cancel()" style="color:#999999;">取消</span>
                <span @click="confirm()">确定</span>
            </div>
        </div>
        <div v-if="showding" class="la-timer" style="position: absolute;top:45%;left:45%;">
            <div></div>
        </div>
        <div class="error_tips">没有数据...</div>
        <div v-show="show1" @click="select" class="cover"></div>
        <div v-show="show2" @click="cancel" class="covs"></div>
    </div>
</template>
<script>
import BackHeader from '../common/BackHeader';
import { DatetimeView, XButton, Popup, TransferDom } from 'vux'
import address from '../url.js';
import $ from 'jquery';
export default {
    components: {
        BackHeader, DatetimeView, XButton, Popup
    },
    directives: {
        TransferDom
    },
    data() {
        return {
            news: [],
            value1: "",
            value2: "",
            time: "",
            year: "",
            month: "",
            month1: "",
            days1: "",
            days2: "",
            sort: "desc",
            day: "",
            value3: "",
            value4: "",
            index: "2",
            sumRangeTotalPrice: "0.00",
            sumRangeRecpayMoney: "0.00",
            showding: true,
            icon: true,
            show1: false,
            show2: false,
            show4: false,
            isShow: true,
            scrollData: {
                noFlag: false //暂无更多数据显示
            }
        }
    },
    created() {
        this.getTime();
        this.getInfo(this.value1, this.value2);
    },
    methods: {
        getTime() {
            this.time = new Date();
            this.year = this.time.getFullYear();
            if (this.time.getMonth() > 9) {
                this.month = this.time.getMonth();
            } else {
                this.month = "0" + this.time.getMonth();
            }
            if (this.time.getMonth() >= 9) {
                this.month1 = this.time.getMonth() + 1;
            } else {
                this.month1 = "0" + (this.time.getMonth() + 1);
            }
            this.day = this.time.getDate();
            this.days1 = new Date(this.year, this.month, 0);
            this.days2 = new Date(this.year, this.month + 1, 0);
            this.value1 = this.year + "-" + this.month1 + "-01";
            this.value2 = this.year + "-" + this.month1 + "-" + this.days2.getDate();
            this.value4 = this.year + "-" + this.month1 + "-" + this.day;
        },
        getInfo(value1, value2) {
            var _this = this;
            var params = "startTime=" + value1 + "&endTime=" + value2;
            this.axios.post(address.returned + localStorage.getItem('token'), params)
                .then(function (data) {
                    _this.showding = false;
                    if (data.data.rows.length == 0) {
                        $(".error_tips").fadeIn(250).delay(500).fadeOut(250);
                        _this.sumRangeRecpayMoney = "0.00";
                        _this.sumRangeTotalPrice = "0.00";
                    } else {
                        _this.sumRangeRecpayMoney = data.data.rangeAmount.sumRangeRecpayMoney;
                        _this.sumRangeTotalPrice = data.data.rangeAmount.sumRangeTotalPrice;
                        _this.news = data.data.rows;
                    }
                })
                .catch(err => {

                })
        },
        select() {
            this.show1 = !this.show1;
            var _this = this;
            $("div.side").slideToggle("fast");
        },
        chose(index) {
            var _this = this;
            this.index = index;
            $("div.side").slideUp("fast");
            _this.show1 = false;
            $(".side li").eq(index).addClass("default").siblings().removeClass("default");
            $(".side div").removeClass("default");
            switch (index) {
                case 0:
                    _this.value1 = "2017-01-01";
                    _this.value2 = _this.year + "-12-31";
                    break;
                case 1:
                    if (_this.month == 0) {
                        _this.value1 = _this.year - 1 + "-12-01";
                        _this.value2 = _this.year - 1 + "-12-31";
                    } else {
                        _this.value1 = _this.year + "-" + _this.month + "-01";
                        _this.value2 = _this.year + "-" + _this.month + "-" + _this.days1.getDate();
                    }
                    break;
                case 2:
                    _this.value1 = _this.year + "-" + _this.month1 + "-01";
                    _this.value2 = _this.year + "-" + _this.month1 + "-" + _this.days2.getDate();
                    break;
                case 3:
                    _this.value1 = _this.year + "-01-01";
                    _this.value2 = _this.year + "-03-31";
                    break;
                case 4:
                    _this.value1 = _this.year + "-04-01";
                    _this.value2 = _this.year + "-06-30";
                    break;
                case 5:
                    _this.value1 = _this.year + "-07-01";
                    _this.value2 = _this.year + "-09-30";
                    break;
                case 6:
                    _this.value1 = _this.year + "-10-01";
                    _this.value2 = _this.year + "-12-31";
                    break;
                case 7:
                    _this.value1 = _this.year + "-01-01";
                    _this.value2 = _this.year + "-06-30";
                    break;
                case 8:
                    _this.value1 = _this.year + "-07-01";
                    _this.value2 = _this.year + "-12-31";
                    break;
                case 9:
                    _this.value1 = _this.year + "-01-01";
                    _this.value2 = _this.year + "-12-31";
                    break;
                case 10:
                    _this.value1 = _this.year - 1 + "-01-01";
                    _this.value2 = _this.year - 1 + "-12-31";
                    break;
            }
            _this.news = [];
            _this.getInfo(_this.value1, _this.value2);
        },
        quit() {
            this.isShow = !this.isShow;
        },
        custom() {
            this.value3 = this.value1;
            this.show2 = true;
            this.show4 = true;
            $(".foot").slideDown("fast");
            $("div.side").slideUp("fast");
            this.show1 = false;
            $(".side div").addClass("default");
            $(".side li").removeClass("default");
        },
        cancel() {
            $(".foot").slideUp("fast");
            this.show2 = false;
            $("div.side").slideDown("fast");
            this.show1 = true;
            this.show4 = false;
        },
        confirm() {
            $(".foot").slideUp("fast");
            this.show2 = false;
            this.show4 = false;
            this.value1 = this.value3;
            this.value2 = this.value4;
            this.news = [];
            this.getInfo(this.value1, this.value2);
        },
        screen() {
            this.icon = !this.icon
            if (this.icon) {
                this.news.sort(this.compare("sumRecpayMoney"));
            } else {
                this.news.sort(this.descending("sumRecpayMoney"));
            }
        },
        compare(property) {
            return function (obj1, obj2) {
                var num1 = obj1[property];
                var num2 = obj2[property];
                return num1 - num2;
            }
        },
        descending(property) {
            return function (obj1, obj2) {
                var num1 = obj1[property];
                var num2 = obj2[property];
                return num2 - num1;
            }
        }
    }
}
</script>
<style scoped>
.sare_time {
    background: #fff;
    border-bottom: 1px solid #F6F6F6;
}

.vux-header {
    background: #4284d9;
}

.sare_ul {
    position: relative;
    padding-left: 1.1rem;
    height: 6rem;
}

.sare_ul li {
    padding-top: 1.5rem;
    position: relative;
}

.sare_two span:nth-child(2) {
    float: right;
    margin-right: 1.2rem;
    font-size: 1.1rem;
    color: #d80404;
    margin-top: -0.3rem;
}

.sare_two {
    height: 1.3rem;
    margin-top: -.5rem;
    margin-bottom: .5rem;
    font-size: 0.9rem;
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

.searching {
    position: relative;
    background: #f2f2f7;
    padding-top: 49px;
}

.searching>p {
    height: 50px;
    text-align: center;
    line-height: 50px;
}

.overall {
    height: 100px;
    display: flex;
    justify-content: center;
    background: #fff;
    margin-bottom: 12px;
}

.overall>span {
    display: inline-block;
    text-align: center;
}

.yo-scroll {
    top: 290px !important;
}

.side {
    width: 100%;
    position: absolute;
    display: none;
    top: 100px;
    background: #fff;
    z-index: 200;
    height: 300px;
    color: #666;
}

.side ul {
    height: 250px;
    overflow: scroll;
}

.side ul li {
    height: 50px;
    line-height: 50px;
    text-align: center;
}

.default {
    color: #509ce8;
}

.cover,
.covs {
    position: fixed;
    top: 100px;
    left: 0;
    width: 100%;
    height: 100%;
    opacity: 0.2;
    z-index: 100;
    background: #000;
}

.covs {
    top: 0px;
    z-index: 1000;
}

.foot {
    height: 300px;
    display: none;
    width: 100%;
    position: fixed;
    bottom: 0;
    background: #fff;
    z-index: 1100;
}

.foot ul {

    display: flex;
    justify-content: center;
}

.foot li {
    display: inline-block;
    width: 50%;
    text-align: center;
    box-sizing: border-box;
    padding: 0px 40px 5px;
}

.foot li div:nth-child(1) {
    font-size: 12px;
    color: #ccc;
}

.foot li div:nth-child(2) {
    color: #999;
    font-size: 0.9rem;
}

.line div:nth-child(1) {
    color: #a8a8a8 !important;
}

.line div:nth-child(2) {
    border-bottom: 2px solid #2e8ae6;
    box-sizing: border-box;
    padding-bottom: 10px;
    color: #000 !important;
}

.last {
    position: absolute;
    bottom: 0;
    width: 100%;
    display: flex;
    height: 50px;
    line-height: 50px;
    justify-content: center;
    border-top: 1px solid #e9e9e9;
    background: #fff;
}

.last span {
    display: inline-block;
    width: 50%;
    text-align: center;
}

.cell-title {
    line-height: 50px;
    background: #fff;
    padding: 0 1rem 0;
    border-bottom: 1px solid #e7e7e7;
}

.title-r {
    float: right;
}

.sare-r {
    color: red;
    position: absolute;
    top: 2rem;
    right: 1rem;
    font-size: 18px;
}

.screen-icon {
    color: #cdcdcd !important;
}
</style>

