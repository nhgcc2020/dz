<template>
    <div>
        <div class="x-header">
            <back-header>
                <p class="title">销售趋势</p>
            </back-header>
        </div>
        <div class="big_first">
            <div class="header">
                <span @click="Year" :class="{'header-active':Isactive}">按自然年</span>
                <span @click="month" :class="{'header-active':!Isactive}">按自然月</span>
            </div>
            <div class="time">
                <span class="monthDate" v-cloak>{{year}}</span>
                <span v-if="!Isactive" class="monthDate" v-cloak>{{Month}}月</span>
                <i @click="showTime" class="iconfont">&#xe6a6;</i>
                <div v-if="Isactive" v-show="Iconfont" class="iconfont_year">
                    <span @click="select($event)">2017年</span>
                    <span @click="select($event)">2018年</span>
                </div>
                <div v-if="!Isactive" v-show="Iconfont" class="iconfont_month">
                    <span @click="content($event)">1月</span>
                    <span @click="content($event)">2月</span>
                    <span @click="content($event)">3月</span>
                    <span @click="content($event)">4月</span>
                    <span @click="content($event)">5月</span>
                    <span @click="content($event)">6月</span>
                    <span @click="content($event)">7月</span>
                    <span @click="content($event)">8月</span>
                    <span @click="content($event)">9月</span>
                    <span @click="content($event)">10月</span>
                    <span @click="content($event)">11月</span>
                    <span @click="content($event)">12月</span>
                </div>
            </div>
            <div class="order">
                <div>
                    <span class="order_one" v-cloak>{{money}}</span>
                    <i @click="showPlugin" class="iconfont iconfont_one">&#xe6b8;</i>
                </div>
                <div @click="seleMoney" class="order_two">
                    <i class="iconfont">&#xe6dd;</i>
                    <span v-cloak>{{selectNum}}</span>
                </div>
            </div>
            <div class="money" v-cloak>{{sum}}</div>
    
            <div class="chart_parent" style="width:100%; overflow: scroll;">
                <div v-show="Isactive" id="main_one" style="width: 45rem;height:230px;"></div>
                <div v-show="!Isactive" id="main_two" style="width: 90rem;height:230px;"></div>
            </div>
    
            <div v-show="show" class="alart">
                <p>数据统计</p>
                <p>订单生成即计入统计
                    <br>根据订单日期（非制单时间）归入所属月份</p>
                <p @click="know">我知道了</p>
            </div>
            <div class="empty"></div>
            <div class="titl">
                <span v-cloak>{{number}}</span>
                <span>笔数</span>
                <span>金额</span>
            </div>
            <ul id="b">
                <li v-for="(room,index) in datum" key="index">
                    <span v-if='room.days == ""' v-cloak>{{room.months | number}}月</span>
                    <span v-if='room.days !== ""' v-cloak>{{room.days | number}}号</span>
                    <span class='ul_one' v-cloak>{{room.orderNum}}笔</span>
                    <span class='ul_two' v-cloak>{{room.totalPrice}}</span>
                </li>
            </ul>
        </div>
        <div @click="showcover" v-show="Iconfont" class="cover"></div>
        <div v-show="show" class="cover covs"></div>
    </div>
</template>
<script>
import { Actionsheet, TransferDom } from 'vux';
import BackHeader from '../common/BackHeader';
import address from '../url.js';
import $ from 'jquery';
export default {
    directives: {
        TransferDom,
    },
    components: {
        Actionsheet,
        BackHeader
    },
    data() {
        return {
            year: "2018年",
            Iconfont: false,
            show: false,
            Isactive: true,
            Month: "",
            money: "订单金额年汇总",
            selectNum: "切换笔数",
            number: "月份",
            sum: 0,
            datax: [],
            datay: [],
            datum: ""
        }
    },
    created() {
        this.getInfo(this.year, this.Month);
    },
    mounted() {
        this.getNumber();
    },
    methods: {
        getInfo(year, Month) {
            this.sum = 0;
            var _this = this;
            var params = "year=" + parseInt(year) + "&month=" + Month;
            this.axios.post(address.repted + localStorage.getItem('token'), params)
                .then(function (data) {
                    if (data.data.code == -1) {
                        _this.$router.push('/login');
                    } else {
                        _this.datum = data.data.rows
                        if (data.data.total < 13) {
                            _this.datax = [];
                            $.each(data.data.rows, function (i, n) {
                                _this.datax.push(i + 1 + "月")
                            })
                        } else {
                            _this.datax = [];
                            $.each(data.data.rows, function (i, n) {
                                _this.datax.push(i + 1 + "号")
                            })
                        }
                        _this.datay = [];
                        $.each(data.data.rows, function (i, n) {
                            _this.datay.push(n.totalPrice)
                            _this.sum = _this.sum + parseFloat(n.totalPrice);
                        })
                        _this.sum = _this.sum.toFixed(2);
                        _this.drawLine(_this.Isactive, _this.datax, _this.datay);
                    }
                })
                .catch(err => {

                })
        },
        getNumber() {
            var times = new Date();
            $(".chart_parent").animate({ scrollLeft: times.getMonth() * 20 + 'px' }, 800)
        },
        drawLine(Isactive, datax, datay) {
            // 基于准备好的dom，初始化echarts实例

            let myChart
            if (Isactive) {
                myChart = this.$echarts.init(document.getElementById('main_one'));
            } else {
                // console.log("1111") 
                myChart = this.$echarts.init(document.getElementById('main_two'));

            }

            // 绘制图表
            myChart.setOption({
                tooltip: { trigger: 'item' },
                grid: {
                    x: 50,
                    x2: 50
                },
                xAxis: {
                    type: 'category',
                    boundaryGap: false,
                    data: datax,
                    splitLine: { show: false },
                    axisTick: { show: false },
                    axisLine: { show: true, lineStyle: { color: '#CCC' } }

                },
                yAxis: {
                    splitLine: { show: false },
                    axisTick: { show: false },
                    axisLine: { show: false },
                    axisLabel: { show: false }
                },
                series: [
                    {
                        name: "数值",
                        type: 'line',
                        smooth: true,
                        symbolSize: "8",
                        data: datay,
                        itemStyle: { normal: { width: "20px", height: "20px", label: { show: true } } },
                    }

                ],
                radius: '100%',
            });
        },
        showPlugin() {
            $(".covs").fadeIn("slow");
            $(".alart").fadeIn("slow");
            this.show = true;
        },
        Year() {
            this.money = "订单金额年汇总"
            var times = new Date();
            this.Isactive = true;
            this.number = "月份";
            $(".chart_parent").animate({ scrollLeft: times.getMonth() * 20 + 'px' }, 800);
            this.Month = "";
            this.getInfo(this.year, this.Month);
        },
        month() {
            this.money = "订单金额月汇总"
            var times = new Date();
            if (times.getMonth() < 9) {
                this.Month = '0' + (times.getMonth() + 1);
            } else {
                this.Month = times.getMonth() + 1;
            }
            this.Isactive = false
            this.number = "日期"
            $(".chart_parent").animate({ scrollLeft: times.getDate() * 29 + 'px' }, 1000);
            this.getInfo(this.year, this.Month);
        },
        showTime() {
            this.Iconfont = true;
        },
        showcover() {
            this.Iconfont = false;
        },
        select(e) {
            this.Iconfont = false;
            this.year = e.target.innerHTML;
            this.getInfo(this.year, this.Month);

        },
        content(e) {
            this.Iconfont = false
            if (parseInt(e.target.innerHTML) < 10) {
                this.Month = '0' + parseInt(e.target.innerHTML);
            } else {
                this.Month = parseInt(e.target.innerHTML);
            }
            this.getInfo(this.year, this.Month);

        },
        seleMoney() {
            this.sum = 0;
            var _this = this
            if (this.money == "订单金额年汇总") {
                this.money = "订单笔数年汇总"
                this.selectNum = "切换金额"
                this.datay = []
                $.each(this.datum, function (i, n) {
                    _this.datay.push(n.orderNum)
                    _this.sum = _this.sum + parseInt(n.orderNum);
                })
                this.drawLine(this.Isactive, this.datax, this.datay);
            } else if (this.money == "订单金额月汇总") {
                this.money = "订单笔数月汇总"
                this.selectNum = "切换金额"
                this.datay = []
                $.each(this.datum, function (i, n) {
                    _this.datay.push(n.orderNum)
                    _this.sum = _this.sum + parseInt(n.orderNum);
                })
                this.drawLine(this.Isactive, this.datax, this.datay);
            } else if (this.money == "订单笔数年汇总") {
                this.money = "订单金额年汇总"
                this.selectNum = "切换笔数"
                this.datay = []
                $.each(this.datum, function (i, n) {
                    _this.datay.push(n.totalPrice)
                    _this.sum = _this.sum + parseFloat(n.totalPrice);
                })
                _this.sum = _this.sum.toFixed(2);
                this.drawLine(this.Isactive, this.datax, this.datay);
            } else {
                this.money = "订单金额月汇总"
                this.selectNum = "切换笔数"
                this.datay = []
                $.each(this.datum, function (i, n) {
                    _this.datay.push(n.totalPrice)
                    _this.sum = _this.sum + parseFloat(n.totalPrice);
                })
                _this.sum = _this.sum.toFixed(2);
                this.drawLine(this.Isactive, this.datax, this.datay);
            }

        },
        know() {
            this.show = false
        }
    }
}
</script>
<style scoped>
.header {
    font-size: 1rem;
    width: 50%;
    margin: 20px auto;
    color: #ccc;
    height: 2rem;
}

.header span:nth-child(1) {
    float: left;
    padding: 5px;
}

.header span:nth-child(2) {
    float: right;
    padding: 5px;
}

.header-active {
    color: #000;
    border-bottom: 2px solid #3f87d9;
}

.time {
    position: relative;
    background: #f0f0f0;
    padding: 0.4rem 0.8rem;
}

.time i {
    float: right;
    font-size: 1.2rem;
}

.monthDate {
    font-size: 0.8rem;
}

.order {
    padding: 0.6rem;
    border-bottom: 1px solid #CCC;
    color: #000;
    font-weight: 700;
    font-size: 0.9rem;
}

.order div {
    display: inline-block;
    position: relative;
}

.order_two {
    float: right;
    color: #666;
}

.iconfont_one {
    position: absolute;
    font-size: 1.7rem;
    color: #88b9e3;
    font-weight: normal;
    border: none;
    background: transparent;
    padding: 0;
    bottom: -0.7rem;
    left: 100%;
}

.money {
    position: absolute;
    color: #ff3200;
    font-size: 1.4rem;
    width: 100%;
    text-align: center;
    margin-top:1rem;
}

.empty {
    height: 2rem;
    background: #f0f0f0;
}

ul li span {
    display: inline-block;
    width: 33%;
}

ul li {
    display: flex;
    padding: 0.3rem 1rem;
    border-bottom: .1rem solid #f2f2f3;
    justify-content: flex-start;
    font-size: 0.9rem;
}

ul li span:nth-child(1) {
    color: #666;
}

.titl {
    padding: 0.3rem 1rem;
    display: flex;
    justify-content: flex-start;
    border-bottom: .1rem solid #f2f2f3;
    font-size: 0.9rem;
}

.titl span:nth-child(1) {
    color: #666;
}

.titl span {
    display: inline-block;
    width: 33%;
}

.titl span:nth-child(2) {
    text-align: center;
}

.titl span:nth-child(3) {
    text-align: right;
}

.ul_one {
    text-align: center;
}

.ul_two {
    text-align: right;
}

.modal_header {
    margin-top: 2rem;
    text-align: center;
}

.reminder {
    display: inline-block;
    width: 100%;
    text-align: center;
    color: #36a4d7;
}

.chart_parent {
    margin-top: 2rem;
}

.iconfont_year {
    position: absolute;
    right: .8rem;
    width: 100px;
    border: 1px solid #f0f0f0;
    z-index: 800;
    border-radius: 0.5rem;
    background: #f8f8f8;
    font-size: .9rem;
}

.iconfont_year span {
    display: block;
    text-align: center;
    border-bottom: 1px solid #f0f0f0;
    color: #666;
    margin: 5px;
}

.iconfont_year span:last-child {
    border: none;
}

.iconfont_month {
    position: absolute;
    right: .8rem;
    width: 170px;
    border: 1px solid #ccc;
    background: #f8f8f8;
    z-index: 800;
    border-radius: 0.5rem;
}

.iconfont_month span {
    width: 31%;
    font-size: .9rem;
    box-sizing: border-box;
    display: inline-block;
    padding: 6px;
    text-align: center;
    color: #666;
}

.blank {
    height: 50px;
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
}

.vux-header {
    background: #4284d9;
}

.alart {
    position: absolute;
    top: 35%;
    width: 70%;
    margin: 0 auto;
    left: 15%;
    right: 15%;
    background: #fff;
    border-radius: 0.5rem;
    z-index: 1100;
}

.alart p:nth-child(1) {
    text-align: center;
    padding-top: 1rem;
}

.alart p:nth-child(2) {
    font-size: 0.9rem;
    padding: 1rem;
}

.alart p:nth-child(3) {
    padding: 0.5rem 0;
    text-align: center;
    color: #4284d9;
    border-top: 1px solid #ccc;
}
</style>