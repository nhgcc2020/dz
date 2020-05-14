<template>
    <div style="overflow: hidden;">
        <div class="x-header">
            <back-header>
                <p class="title">合同列表</p>
            </back-header>
        </div>
        <div class="quit_time">
            <span @click="sort" :class="{pitch:show}">{{count}}
                <i v-if="!show" class="iconfont">&#xe68d;</i>
                <i v-if="show" style="color:#4284d9;" class="iconfont">&#xe68e;</i>
            </span>&nbsp;
            <span @click="client" :class="{pitch:show1}">{{clientele | character}}
                <i v-if="!show1" class="iconfont">&#xe68d;</i>
                <i v-if="show1" class="iconfont" style="color:#4284d9;">&#xe68e;</i>
            </span>&nbsp;
            <span @click="select" :class="{pitch:show2}">
                <span v-if="!value1">全部时间段</span>
                <span v-if="value1">
                    <span>{{value1}}</span> -
                    <span>{{value2}}</span>
                </span>
                <i v-if="!show2" class="iconfont">&#xe68d;</i>
                <i v-if="show2" style="color:#4284d9;" class="iconfont">&#xe68e;</i>
            </span>
        </div>
        <div class="tasking">
            <p @click="checked(0,'')" class="pitch">全部销售</p>
            <p @click="checked(index+1,p.employeeId)" v-for="(p,index) in operator" key="index">{{p.realName}}</p>
        </div>
        <ul class="anchor">
            <li @click="stage(0)" class="pitch">执行中</li>
            <li @click="stage(1)">已完成</li>
            <li @click="stage(2)">意外终止</li>
            <li @click="stage(3)">合同作废</li>
        </ul>
        <div class="side">
            <ul>
                <li @click="chose(0)" class="pitch">全部时间段</li>
                <li @click="chose(1)">上月</li>
                <li @click="chose(2)">本月</li>
                <li @click="chose(3)">第一季度</li>
                <li @click="chose(4)">第二季度</li>
                <li @click="chose(5)">第三季度</li>
                <li @click="chose(6)">第四季度</li>
                <li @click="chose(7)">上半年</li>
                <li @click="chose(8)">下半年</li>
                <li @click="chose(9)">今年</li>
                <li @click="chose(10)">去年</li>
            </ul>
            <div @click="custom($event)" style="height:50px;line-height:50px;text-align:center;border-top:1px solid #e9e9e9;">自定义时间</div>
        </div>
        <div class="returned" v-if="this.count=='执行中'">
            待回款总额：
            <span style="font-family:'arial';font-size:18px;">{{bottomInfo.sumWaitforContractMoney | filmoney}}</span>
        </div>
        <v-scroll :on-refresh="onRefresh" :on-infinite="onInfinite" :dataList="scrollData" v-if="this.count=='执行中'" style=" top: 149px;">
            <ul v-for="(n,index) in news" key="index" class="ul_count">
                <router-link tag="li" :to="'/bargainDetails/'+n.contractNo" style="line-height:42px;height:42px;border-bottom:1px solid #f2f2f2;">
                    <div style="flex:1;position:relative;">
                        <i style="font-size:30px;position:absolute;top:0px;color:#999;" class="iconfont">&#xe70c;</i>
                        <span style="margin-left:34px;">{{n.partnerShortname}}</span>
                    </div>
                    <div>
                        <i style="color:#999;font-size:14px;display:inline-block;" class="iconfont">&#xe68b;</i>
                    </div>
                </router-link>
                <li style="position:relative;margin-top:10px;">
                    <div style="flex:1;">
                        <i style="font-size:30px;color:#999;position:absolute;top:-10px;" class="iconfont">&#xe723;</i>
                        <span style="font-size:14px;color:#333;margin-left:34px;line-height:30px;">{{n.contractDesc}}</span>
                    </div>
                    <div>
                        <span style="display:inline-block;line-height:30px;width:30px;border-radius:50%;background:#4284d9;font-size:12px;text-align:center;color:#fff;">{{n.salesName | spenderName}}</span>
                    </div>
                </li>
                <li v-if="!n.latestChat" style="position:relative;margin-top:7px;">
                    <div>
                        <i style="font-size:30px;color:#999;position:absolute;top:-15px;" class="iconfont">&#xe6ee;</i>
                        <span style="font-size:12px;color:#ccc;margin-left:34px;">无跟进记录</span>
                    </div>
                </li>
                <li v-if="n.latestChat" style="position:relative;margin-top:7px;">
                    <div>
                        <i style="font-size:30px;color:#999;position:absolute;top:-15px;color:#4284d9;" class="iconfont">&#xe6ee;</i>
                        <span style="font-size:12px;color:#999;margin-left:34px;">
                            <span style="color:#4284d9;">{{n.latestChat | chatone}}：</span>{{n.latestChat | chattwo}}</span>
                    </div>
                </li>
                <li style="margin:9px 0 11px 0;text-align:right;color:#999;font-size:12px;display:block;">合同日期：&nbsp;{{n.startDate}}&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;{{n.endDate}}</li>
                <li style="height:42px;border-top:1px solid #f2f2f2;display:flex;align-items:center;">
                    <span style="font-size:12px;color:#999;flex:1;">签约金额 &nbsp;&nbsp;&nbsp;
                        <span style="font-size:18px;font-family:'arial';" :class="{alterone:n.contractMoney!=0}">{{n.contractMoney | filmoney}}</span>
                    </span>
                    <span style="font-size:12px;color:#999;">待回款金额 &nbsp;&nbsp;&nbsp;
                        <span style="font-size:18px;font-family:'arial';" :class="{altertwo:n.waitforContractMoney!=0}">{{n.waitforContractMoney | filmoney}}</span>
                    </span>
                </li>
            </ul>
        </v-scroll>
        <v-scroll :on-refresh="onRefresh" :on-infinite="onInfinite" :dataList="scrollData" v-if="this.count!='执行中'" style=" top: 96px;">
            <ul v-for="(n,index) in news" key="index" class="ul_count">
                <router-link tag="li" :to="'/bargainDetails/'+n.contractNo" style="line-height:42px;height:42px;border-bottom:1px solid #f2f2f2;">
                    <div style="flex:1;position:relative;">
                        <i style="font-size:30px;position:absolute;top:0px;color:#999;" class="iconfont">&#xe70c;</i>
                        <span style="margin-left:34px;">{{n.partnerShortname}}</span>
                    </div>
                    <div>
                        <i style="color:#999;font-size:14px;display:inline-block;" class="iconfont">&#xe68b;</i>
                    </div>
                </router-link>
                <li style="position:relative;margin-top:10px;">
                    <div style="flex:1;">
                        <i style="font-size:30px;color:#999;position:absolute;top:-10px;" class="iconfont">&#xe723;</i>
                        <span style="font-size:14px;color:#333;margin-left:34px;line-height:30px;">{{n.projectTypeDesc}}</span>
                    </div>
                    <div>
                        <span style="display:inline-block;line-height:30px;width:30px;border-radius:50%;background:#4284d9;font-size:12px;text-align:center;color:#fff;">{{n.salesName | spenderName}}</span>
                    </div>
                </li>
                <li v-if="!n.latestChat" style="position:relative;margin-top:7px;">
                    <div>
                        <i style="font-size:30px;color:#999;position:absolute;top:-15px;" class="iconfont">&#xe6ee;</i>
                        <span style="font-size:12px;color:#ccc;margin-left:34px;">无跟进记录</span>
                    </div>
                </li>
                <li v-if="n.latestChat" style="position:relative;margin-top:7px;">
                    <div>
                        <i style="font-size:30px;color:#999;position:absolute;top:-15px;color:#4284d9;" class="iconfont">&#xe6ee;</i>
                        <span style="font-size:12px;color:#999;margin-left:34px;">
                            <span style="color:#4284d9;">{{n.latestChat | chatone}}：</span>{{n.latestChat | chattwo}}</span>
                    </div>
                </li>
                <li style="margin:9px 0 11px 0;text-align:right;color:#999;font-size:12px;display:block;">合同日期：&nbsp;{{n.startDate}}&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;{{n.endDate}}</li>
                <li style="height:42px;border-top:1px solid #f2f2f2;display:flex;align-items:center;">
                    <span style="font-size:12px;color:#999;flex:1;">签约金额 &nbsp;&nbsp;&nbsp;
                        <span style="font-size:18px;font-family:'arial';" :class="{alterone:n.contractMoney!=0}">{{n.contractMoney | filmoney}}</span>
                    </span>
                    <span style="font-size:12px;color:#999;">已回款金额 &nbsp;&nbsp;&nbsp;
                        <span style="font-size:18px;font-family:'arial';" :class="{altertwo:n.returnedContractMoney!=0}">{{n.returnedContractMoney | filmoney}}</span>
                    </span>
                </li>
            </ul>
        </v-scroll>
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
            <div v-if="show3">
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
        <div v-show="show" class="cover" @click="conceal"></div>
        <div v-show="show1" class="covs" @click="conceal"></div>
        <div v-show="show2" class="cvs" @click="conceal"></div>
    </div>
</template>
<script>
import BackHeader from '../common/BackHeader';
import address from '../url.js';
import $ from 'jquery';
import VScroll from '../common/VScroll';
import { mapState, mapGetters } from 'vuex';
import { DatetimeView, TransferDom } from 'vux';
export default {
    computed: mapState(['design']),
    components: {
        BackHeader, DatetimeView, VScroll
    },
    directives: {
        TransferDom
    },
    data() {
        return {
            news: [],
            show: false,
            showding: true,
            show1: false,
            show2: false,
            show3: false,
            render: false,
            isShow: true,
            totalPage: "",
            bottomInfo:"",
            pageNo: 1,
            count: "执行中",
            operator: "",
            index: "01",
            salesId: "",
            value1: "",
            value2: "",
            value3: "",
            value4: "",
            clientele: "全部销售",
            scrollData: {
                noFlag: false //暂无更多数据显示
            }
        }
    },
    created() {
        this.getTime();
        this.getInfo(this.pageNo, this.index, this.salesId, this.value1, this.value2);
    },
    mounted() {
        if (this.count == "执行中") {
            $(".quit_time>span").eq(0).css("color", "#f26628");
        } else {
            $(".quit_time>span").eq(0).css("color", "#01a09a");
        }
    },
    methods: {
        getTime() {
            var _this = this;
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
            this.value3 = "2017-01-01";
            if (this.day > 9) {
                this.value4 = this.year + "-" + this.month1 + "-" + this.day;
            } else {
                this.value4 = this.year + "-" + this.month1 + "-0" + this.day;
            }
            this.axios.get(address.operator + localStorage.getItem('token'))
                .then(data => {
                    this.operator = data.data.data;
                })
                .catch(err => {

                })

        },
        getInfo(pageNo, orderSection, salesId, value1, value2) {
            var params = "&page=" + pageNo + "&rows=10&status=" + orderSection + "&salesId=" + salesId + "&startTime=" + value1 + "&endTime=" + value2;
            this.axios.get(address.Bargain + localStorage.getItem('token') + params)
                .then(data => {
                    this.render = true;
                    this.totalPage = data.data.totalPage;
                    if (data.data.rows.length == 0) {
                        $(".error_tips").fadeIn(250).delay(500).fadeOut(250);
                        this.showding = false;
                        this.bottomInfo = data.data.bottomInfo;
                        this.news = [];
                    } else {
                        this.bottomInfo = data.data.bottomInfo;
                        this.news = this.news.concat(data.data.rows);
                        this.showding = false;
                    }
                })
                .catch(err => {

                })
        },
        onRefresh(done) {
            this.showding = true;
            this.news = [];
            this.pageNo = 1;
            this.getInfo(this.pageNo, this.index, this.salesId, this.value1, this.value2);
            done(); // call done
        },
        onInfinite(done) {
            this.pageNo++;
            let more = this.$el.querySelector('.load-more')
            if (this.totalPage < this.pageNo) {
                more.style.display = 'none'; //隐藏加载条
                //走完数据调用方法
                this.scrollData.noFlag = true;
                setTimeout(function () {
                    this.scrollData.noFlag = false;
                }.bind(this), 1000);
            } else {
                this.showding = true;
                this.getInfo(this.pageNo, this.index, this.salesId, this.value1, this.value2);
                more.style.display = 'none'; //隐藏加载条 
            }
            done();
        },
        chose(index) {
            var _this = this;
            switch (index) {
                case 0:
                    _this.value1 = "";
                    _this.value2 = "";
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
            this.show2 = false;
            this.showding = true;
            $(".side>div").removeClass("pitch");
            $(".side").slideUp("fast");
            $(".side li").eq(index).addClass("pitch").siblings().removeClass("pitch");
            this.news = [];
            this.pageNo = 1;
            this.getInfo(this.pageNo, this.index, this.salesId, this.value1, this.value2);
        },
        stage(i) {
            $(".anchor").slideUp("fast");
            this.show = false;
            this.index = "0" + (i + 1);
            $(".anchor li").eq(i).addClass("pitch").siblings().removeClass("pitch");
            this.count = $(".anchor>.pitch").text();
            if (i == 0) {
                $(".quit_time>span").eq(0).css("color", "#f26628");
            } else if (i == 1) {
                $(".quit_time>span").eq(0).css("color", "#01a09a");
            } else {
                $(".quit_time>span").eq(0).css("color", "#ff9900");
            }
            this.showding = true;
            this.news = [];
            this.pageNo = 1;
            this.getInfo(this.pageNo, this.index, this.salesId, this.value1, this.value2);
        },
        select() {
            $(".side").slideToggle("fast");
            this.show2 = !this.show2;
            this.show = false;
            this.show1 = false;
            $(".anchor").slideUp("fast");
            $(".tasking").slideUp("fast");
            $(".foot").slideUp("fast");
        },
        sort() {
            $(".anchor").slideToggle("fast");
            this.show = !this.show;
            this.show1 = false;
            this.show2 = false;
            $(".foot").slideUp("fast");
            $(".tasking").slideUp("fast");
            $(".side").slideUp("fast");
        },
        checked(i, y) {
            this.show1 = false;
            $(".tasking").slideUp("fast");
            $(".tasking p").eq(i).addClass("pitch").siblings().removeClass("pitch");
            this.clientele = $(".tasking>.pitch").text();
            this.salesId = y;
            this.showding = true;
            this.news = [];
            this.pageNo = 1;
            this.getInfo(this.pageNo, this.index, this.salesId, this.value1, this.value2);
        },
        client() {
            this.show = false;
            this.show2 = false;
            this.show1 = !this.show1;
            $(".tasking").slideToggle("fast");
            $(".foot").slideUp("fast");
            $(".side").slideUp("fast");
            $(".anchor").slideUp("fast");
        },
        custom(e) {
            $(".foot").slideDown("fast");
            $(".side").slideUp("fast");
            this.show3 = true;
            $(".side li").removeClass("pitch");
            $(e.target).addClass("pitch");
        },
        quit() {
            this.isShow = !this.isShow;
        },
        cancel() {
            $(".foot").slideUp("fast");
            $(".side").slideDown("fast");
        },
        confirm() {
            this.value1 = this.value3;
            this.value2 = this.value4;
            $(".foot").slideUp("fast");
            this.show2 = false;
            this.news = [];
            this.pageNo = 1;
            this.getInfo(this.pageNo, this.index, this.salesId, this.value1, this.value2);
        },
        conceal() {
            this.show = false;
            this.show1 = false;
            this.show2 = false;
            $(".side").slideUp("fast");
            $(".foot").slideUp("fast");
            $(".anchor").slideUp("fast");
            $(".tasking").slideUp("fast");
        },
        initial() {
            if (this.render) {
                this.pageNo = 1;
                this.value1 = "";
                this.value2 = "";
                this.index = "01";
                this.news = [];
                this.salesId = "";
                this.count = "执行中";
                this.clientele = "全部销售";
                $(".tasking p").eq(0).addClass("pitch").siblings().removeClass("pitch");
                $(".side li").eq(0).addClass("pitch").siblings().removeClass("pitch");
                if (this.count == "执行中") {
                    $(".quit_time>span").eq(0).css("color", "#f26628");
                } else {
                    $(".quit_time>span").eq(0).css("color", "#01a09a");
                }
                this.getTime();
                this.getInfo(this.pageNo, this.index, this.salesId, this.value1, this.value2);
            }
        }
    },
    beforeRouteEnter(to, from, next) {
        if (from.path == "/home/workbench") {
            next(vm => {
                vm.initial();
            })
        } else {
            next()
        }

    }
}
</script>
<style scoped>
.quit_time {
    display: flex;
    margin-top: 46px;
    height: 50px;
    line-height: 50px;
    background: #fff;
    border-top: 1px solid #f8f8f9;
    font-size: 12px;
    color: #666;
    box-sizing: border-box;
    padding: 0 21px;
    border-bottom: 2px solid #f2f2f2;
}

.quit_time>span:nth-child(1) {
    flex: 0.8;
    font-size: 12px;
}

.quit_time>span:nth-child(2) {
    flex: 1;
}

.quit_time i {
    font-size: 12px;
    color: #ccc;
    font-weight: normal!important;
}

.returned {
    display: flex;
    height: 52px;
    align-items: center;
    justify-content: center;
    color: #eb6877;
    font-size: 12px;
    background: #fff;
    border-bottom: 1px solid #f2f2f2;
}

.return_color {
    color: #f26628;
}

.ul_count {
    box-sizing: border-box;
    padding-left: 22px;
    background: #fff;
    margin-bottom: 10px;
}

.ul_count li {
    display: flex;
    box-sizing: border-box;
    padding-right: 22px;
    font-size: 14px;
}

.tasking,
.anchor {
    width: 100%;
    position: fixed;
    top: 95px;
    background: #fff;
    text-align: center;
    font-size: 16px;
    color: #666;
    display: none;
    z-index: 1200;
}

.tasking {
    height: 250px;
    overflow: auto;
}

.anchor li,
.tasking>p {
    height: 50px;
    line-height: 50px;
}

.side {
    width: 100%;
    position: fixed;
    top: 95px;
    display: none;
    background: #fff;
    z-index: 1200;
    height: 300px;
    color: #666;
    border-top: 1px solid #f2f2f2;
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

.alterone {
    color: #000;
}

.altertwo {
    color: #ff6600;
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

.pitch {
    color: #4284d9!important;
}


.cover,
.covs,
.cvs {
    position: fixed;
    top: 95px;
    left: 0;
    width: 100%;
    height: 100%;
    opacity: 0.2;
    z-index: 100;
    background: #000;
}

.error_tips {
    position: fixed;
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

