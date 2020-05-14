<template>
    <div style="overflow: hidden;">
        <div class="x-header">
            <back-header>
                <p class="title">设计任务清单</p>
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
                <span>{{value1}}</span>-
                <span>{{value2}}</span>
                <i v-if="!show2" class="iconfont">&#xe68d;</i>
                <i v-if="show2" style="color:#4284d9;" class="iconfont">&#xe68e;</i>
            </span>
        </div>
        <div class="tasking">
            <p @click="checked(0)" class="pitch" style="margin-top:13px;">进行中</p>
            <p @click="checked(1)" style="margin:20px 0;">已完工</p>
        </div>
        <div class="anchor">
            <ul class="anchor_ul">
                <li class="pitch" pack="ALL" @click="keydown(0)">全部客户</li>
                <li v-for="(n,index) in newsone" key="index" @click="keydown(index+1)" :pack="n.partnerKey">{{n.partnerShortname}}</li>
            </ul>
            <div class="last">
                <span @click="dele()" style="color:#999999;">取消</span>
                <span @click="konw()">确定</span>
            </div>
        </div>
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
        <v-scroll :on-refresh="onRefresh" :on-infinite="onInfinite" :dataList="scrollData">
            <ul v-for="(n,index) in news" key="index" class="significant">
                <router-link v-if="n.status==1" tag="li" @click.native="stockpile(n.taskDesc)" :to="'/tasking/'+n.taskNo" replace>
                    <div style="flex:1;">
                        <p>
                            <i style="font-size:30px;color:#44ae80;" class="iconfont">&#xe70c;</i>
                            <span style="position:relative;top:-5px;font-size:14px;color:#000;"> {{n.partnerShortname}}</span>
                        </p>
                        <p style="font-size:14px;color:#666;position:relative;top:-8px;">{{n.orderDate}}</p>
                    </div>
                    <div>
                        <span v-if="t.substr(t.length-1)==1" v-for="(t,index) in n.taskUser" key="index" style="display:inline-block;line-height:30px;width:30px;border-radius:50%;background:#4284d9;font-size:12px;text-align:center;color:#fff;margin-top:20px;margin-right:10px;">{{t | condition}}</span>
                        <span style="position:relative;margin-right:10px;" v-if="t.substr(t.length-1)==2" v-for="(t,index) in n.taskUser">
                            <span style="display:inline-block;line-height:30px;width:30px;border-radius:50%;background:#15bc83;font-size:12px;text-align:center;color:#fff;margin-top:20px;">{{t | condition}}</span>
                            <span style="display:inline-block;width:27px;height:14px;position: absolute;font-size:10px;top:-15px;left:20px;color:#15bc83;border:1px solid #15bc83;border-radius:7px;line-height:15px;text-align:center;z-index:99;background:#fff;">完工</span>
                        </span>
                        <i style="line-height:71px;font-size:14px;color:#999;" class="iconfont">&#xe68b;</i>
                    </div>
                </router-link>
                <router-link v-if="n.status==2" tag="li" to="">
                    <div style="flex:1;">
                        <p>
                            <i style="font-size:30px;color:#44ae80;" class="iconfont">&#xe70c;</i>
                            <span style="position:relative;top:-5px;font-size:14px;color:#000;"> {{n.partnerShortname}}</span>
                        </p>
                        <p style="font-size:14px;color:#666;position:relative;top:-8px;">{{n.taskDate}}</p>
                    </div>
                    <div>
                        <span v-if="t.substr(t.length-1)==1" v-for="(t,index) in n.taskUser" key="index" style="display:inline-block;line-height:30px;width:30px;border-radius:50%;background:#4284d9;font-size:12px;text-align:center;color:#fff;margin-top:20px;margin-right:10px;">{{t | condition}}</span>
                        <span style="position:relative;margin-right:10px;" v-if="t.substr(t.length-1)==2" v-for="(t,index) in n.taskUser">
                            <span style="display:inline-block;line-height:30px;width:30px;border-radius:50%;background:#15bc83;font-size:12px;text-align:center;color:#fff;margin-top:20px;">{{t | condition}}</span>
                            <span style="display:inline-block;width:27px;height:14px;position: absolute;font-size:10px;top:-15px;left:20px;color:#15bc83;border:1px solid #15bc83;border-radius:7px;line-height:15px;text-align:center;z-index:99;background:#fff;">完工</span>
                        </span>
                    </div>
                </router-link>
                <li class="explain">
                    <div v-for="(b,index) in n.businessDesc" key="index" style="margin-top:12px;">
                        <p style="color:#999;line-height:25px">{{b}}</p>
                    </div>
                </li>
                <li style="line-height:38px;font-size:12px; color:#666;border-top:1px solid #f9f9f9;margin-top:0;margin-bottom:0;">
                    说明：{{n.taskDesc | casedesc}}
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
            newsone: [],
            show: false,
            show1: false,
            show2: false,
            show3: false,
            isShow: true,
            totalPage: "",
            pageNo: 1,
            pageSize: 20,
            count: "进行中",
            index1: 1,
            index2: 0,
            index3: 0,
            value1: "",
            value2: "",
            value3: "",
            value4: "",
            clientele: "全部客户",
            partnerKey: "ALL",
            scrollData: {
                noFlag: false //暂无更多数据显示
            }
        }
    },
    created() {
        this.getTime();
        setTimeout(function () {
            if (this.design.status == "") {
                this.getInfo(this.pageNo, this.pageSize, this.index1, this.value1, this.value2, this.partnerKey);
            } else {
                this.count = this.design.status;
                this.clientele = this.design.clientele;
                this.value1 = this.design.startTime;
                this.value2 = this.design.endTime;
                this.index1 = this.design.index1;
                this.partnerKey = this.design.partnerKey;
                this.getInfo(this.pageNo, this.pageSize, this.index1, this.value1, this.value2, this.partnerKey);
            }
        }.bind(this), 100);
    },
    mounted() {
        if (this.design.status != "") {
            $(".tasking p").eq(this.design.index1 - 1).addClass("pitch").siblings().removeClass("pitch");
            $(".anchor_ul li").eq(this.design.index2).addClass("pitch").siblings().removeClass("pitch");
            $(".side li").eq(this.design.index3).addClass("pitch").siblings().removeClass("pitch");
            if (this.design.status == "已完工") {
                $(".quit_time>span").eq(0).css("color", "#15bc83");
            } else {
                $(".quit_time>span").eq(0).css("color", "#fea219");
            }
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
            this.value1 = "2017-01-01";
            this.value2 = this.year + "-" + "12-31";
            if (this.day > 9) {
                this.value4 = this.year + "-" + this.month1 + "-" + this.day;
            } else {
                this.value4 = this.year + "-" + this.month1 + "-0" + this.day;
            }
            var params = "type=1&page=1&rows=30&searchKey=";
            this.axios.post(address.addressbook + localStorage.getItem('token'), params)
                .then(function (data) {
                    if (data.data.length == 0) {
                        $(".error_tips").fadeIn(250).delay(500).fadeOut(250);
                    }
                    _this.newsone = data.data;
                })
                .catch(err => {

                })

        },
        getInfo(pageNo, pageSize, Status, startTime, endTime, partnerKey) {
            var _this = this;
            var params = "page=" + pageNo + "&rows=" + pageSize + "&status=" + Status + "&startTime=" + startTime + "&endTime=" + endTime + "&partnerKey=" + partnerKey;
            this.axios.post(address.design + localStorage.getItem('token'), params)
                .then(function (data) {
                    _this.totalPage = data.data.totalPage;
                    if (data.data.data.length == 0) {
                        $(".error_tips").fadeIn(250).delay(500).fadeOut(250);
                    }
                    _this.news = _this.news.concat(data.data.data);
                    $.each(_this.news, function (key, val) {
                        if (typeof (val.businessDesc) == 'string') {
                            val.businessDesc = val.businessDesc.split(";");
                            val.taskUser = val.taskUser.split(";");
                        }
                    });
                })
                .catch(err => {
                    //
                })
        },
        onRefresh(done) {
            this.showding = true;
            this.news = [];
            this.pageSize = 20;
            this.pageNo = 1;
            this.getInfo(this.pageNo, this.pageSize, this.index1, this.value1, this.value2, this.partnerKey);
            done(); // call done
        },
        onInfinite(done) {
            this.pageNo++;
            this.pageSize = 20;
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
                this.getInfo(this.pageNo, this.pageSize, this.index1, this.value1, this.value2, this.partnerKey);
                more.style.display = 'none'; //隐藏加载条 
            }
            done();
        },
        chose(index) {
            var _this = this;
            switch (index) {
                case 0:
                    _this.value1 = "2017-01-01";
                    _this.value2 = _this.year + "-" + "12-31";
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
            $(".side>div").removeClass("pitch");
            $(".side").slideUp("fast");
            $(".side li").eq(index).addClass("pitch").siblings().removeClass("pitch");
            this.news = [];
            this.pageNo = 1;
            this.index3 = index;
            this.getInfo(this.pageNo, this.pageSize, this.index1, this.value1, this.value2, this.partnerKey);
        },
        select() {
            $(".side").slideToggle("fast");
            this.show2 = !this.show2;
            this.show = false;
            this.show1 = false;
            $(".anchor").slideUp("fast");
            $(".tasking").slideUp("fast");
        },
        sort() {
            $(".tasking").slideToggle("fast");
            this.show = !this.show;
            this.show1 = false;
            this.show2 = false;
            $(".foot").slideUp("fast");
            $(".anchor").slideUp("fast");
            $(".side").slideUp("fast");
        },
        checked(i) {
            this.index1 = i + 1;
            $(".tasking p").eq(i).addClass("pitch").siblings().removeClass("pitch");
            this.count = $(".tasking p").eq(i).text();
            this.icon = true;
            this.show = false;
            this.pageNo = 1;
            this.news = [];
            $(".tasking").slideUp("fast");
            if (this.count == "已完工") {
                $(".quit_time>span").eq(0).css("color", "#15bc83");
            } else {
                $(".quit_time>span").eq(0).css("color", "#fea219");
            }
            this.getInfo(this.pageNo, this.pageSize, this.index1, this.value1, this.value2, this.partnerKey);
        },
        client() {
            this.show1 = !this.show1;
            $(".anchor").slideToggle("fast");
            this.show = false;
            this.show2 = false;
            $(".foot").slideUp("fast");
            $(".side").slideUp("fast");
            $(".tasking").slideUp("fast");
        },
        keydown(i) {
            $(".anchor_ul li").eq(i).addClass("pitch").siblings().removeClass("pitch");
        },
        dele() {
            this.show1 = false;
            $(".anchor").slideUp("fast");
        },
        konw() {
            this.show1 = false;
            this.news = [];
            this.pageNo = 1;
            $(".anchor").slideUp("fast");
            this.clientele = $(".anchor_ul>.pitch").text();
            this.index2 = $(".anchor_ul>.pitch").index;
            this.partnerKey = $(".anchor_ul>.pitch").attr("pack");
            this.getInfo(this.pageNo, this.pageSize, this.index1, this.value1, this.value2, this.partnerKey);
        },
        custom(e) {
            $(".foot").slideDown("fast");
            $(".side").slideUp("fast");
            this.show3 = true;
            this.value3 = this.value1;
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
            this.getInfo(this.pageNo, this.pageSize, this.index1, this.value1, this.value2, this.partnerKey);
        },
        stockpile(text) {
            this.$store.commit('cache', { "status": this.count, "clientele": this.clientele, "startTime": this.value1, "endTime": this.value2, "index1": this.index1, "index2": this.index2, "index3": this.index3, "partnerKey": this.partnerKey });
            this.$store.commit('stylist', "");
            this.$store.commit('millmessage', text);
        },
        conceal() {
            this.show = false;
            this.show1 = false;
            this.show2 = false;
            $(".side").slideUp("fast");
            $(".foot").slideUp("fast");
            $(".anchor").slideUp("fast");
            $(".tasking").slideUp("fast");
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
    font-size: 14px;
    color: #333;
    box-sizing: border-box;
    padding: 0 21px;
    border-bottom: 2px solid #f2f2f2;
}

.quit_time>span:nth-child(1) {
    flex: 0.8;
    font-size: 14px;
    font-weight: 900;
    color: #fea219;
}

.quit_time>span:nth-child(2) {
    flex: 1;
}

.quit_time i {
    font-size: 14px;
    color: #ccc;
    font-weight: normal!important;
}

.tasking {
    width: 100%;
    position: fixed;
    top: 95px;
    height: 103px;
    background: #fff;
    border-top: 1px solid #f2f2f2;
    text-align: center;
    font-size: 16px;
    color: #666;
    display: none;
    z-index: 1200;
}

.yo-scroll {
    top: 96px !important;
}

.anchor {
    background: #f5f3f9;
    width: 100%;
    position: fixed;
    top: 95px;
    z-index: 1200;
    height: 28rem;
    display: none;
    overflow: hidden;
}

.anchor_ul {
    margin-top: 16px;
    margin-left: 1.6rem;
    font-size: 14px;
    height: 24rem;
    overflow: auto;
}

.anchor_ul li {
    line-height: 32px;
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

.significant {
    background: #fff;
    margin-bottom: 10px;
    overflow: hidden;
}

.significant li:nth-child(1) {
    display: flex;
    border-bottom: 1px solid #f2f2f2;
}

.significant li {
    box-sizing: border-box;
    padding-right: 21px;
    margin-left: 21px;
}

.explain {
    margin: 8px 0 8px 21px;
    overflow: hidden;
}

.explain>div:nth-child(1) {
    margin: 0!important;
}

.explain p:nth-child(1) {
    font-size: 12px;
    color: #000;
}

.explain p:nth-child(2) {
    font-size: 12px;
    color: #999;
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

