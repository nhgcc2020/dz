<template>
    <div>
        <div class="x-header">
            <x-header :left-options="{showBack: false}">报表</x-header>
        </div>
        <div class="big_first" style="background:#fff;padding-bottom:0;">
            <ul class="count">
                <li></li>
                <li>应收金额</li>
                <li>&yen; {{Sum}}</li>
                <li>
                    <div style="width:46%;">
                        <p style="color:#999;font-size:0.9rem;">待对账销售单</p>
                        <p style="color:#333;font-size:1.2rem;">&yen; {{total04}}</p>
                    </div>
                    <div style="font-size:1.8rem;color:#ccc;width:8%;">+</div>
                    <div style="width:46%;">
                        <p style="color:#999;font-size:0.9rem;">待收款对账单</p>
                        <p style="color:#333;font-size:1.2rem;">&yen; {{total07}}</p>
                    </div>
                </li>
                <li>
                    <router-link tag="div" to="/tendency">
                        <i class="iconfont" style="font-size:2.5rem;color:#f2725e;">&#xe6d2;</i>
                        <p>销售趋势</p>
                    </router-link>
                    <router-link @click.native="total" tag="div" to="/reconciliation" style="border-left:1px solid #f2f2f2;border-right:1px solid #f2f2f2;">
                        <i class="iconfont" style="font-size:2.5rem;color:#4da9eb;">&#xe6f4;</i>
                        <p>待对账</p>
                    </router-link>
                    <router-link @click.native="total" tag="div" to="/gathering">
                        <i class="iconfont" style="font-size:2.5rem;color:#f7b55e;">&#xe6be;</i>
                        <p>待收款</p>
                    </router-link>
                </li>
                <li class="statistics">
                    <router-link tag="div" to="/statistics">
                        <i class="iconfont" style="font-size:2.5rem;color:#44ae80;">&#xe714;</i>
                        <p>客户销售</p>
                    </router-link>
                    <router-link tag="div" to="/returned" style="border-left:1px solid #f2f2f2;border-right:1px solid #f2f2f2;">
                        <i class="iconfont" style="font-size:2.5rem;color:#f2725e;">&#xe6b1;</i>
                        <p>回款分布</p>
                    </router-link>
                    <router-link tag="div" to="/margin">
                        <i class="iconfont" style="font-size:2.5rem;color:#f2725e;">&#xe716;</i>
                        <p>营业毛利</p>
                    </router-link>
                </li>
            </ul>
        </div>
        <div v-if="showding" class="la-timer" style="position: absolute;top:45%;left:45%;">
                <div></div>
            </div>
    </div>
</template>
<script>
import { XHeader, Actionsheet, TransferDom } from 'vux';
import address from '../../url.js';
import { mapState, mapGetters } from 'vuex';
import $ from 'jquery';
export default {
    computed: mapState(['datum','report']),
    directives: {
        TransferDom,
    },
    components: {
        XHeader,
        Actionsheet
    },
    data() {
        return {
            Sum: "0.00",
            total04: "0.00",
            total07: "0.00",
            showding: true
        }
    },
  created() {
  var mess = setInterval(function() {
      if(this.report.Sumx!=undefined){
        this.getInfo();
        clearInterval(mess);
        this.showding = false;
      }
    }.bind(this), 100);
  },
    methods: {
        getInfo() {
           this.Sum = this.fmoney(this.report.Sumx, 2);
           this.total04 = this.fmoney(this.report.total04x, 2); 
           this.total07 = this.fmoney(this.report.total07x, 2);
        },
        total() {
            var _this = this;
            this.$store.commit('searching', { "startTime": "", "endTime": "", "partnerKey": "", "pit": "" });
        },
        fmoney(s, n) //s:传入的float数字 ，n:希望返回小数点几位  
        {
            n = n > 0 && n <= 20 ? n : 2;
            s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
            var l = s.split(".")[0].split("").reverse(),
                r = s.split(".")[1];
            var t = "";
            for (var i = 0; i < l.length; i++) {
                t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
            }
            return t.split("").reverse().join("") + "." + r;
        }
    }
}
</script>
<style scoped>
.count li {
    list-style: none;
    text-align: center;
}


/*.count li:nth-child(1){
    margin-top:3px; 
    border-top:1px solid #f2f2f2;
}*/

.count li:nth-child(2) {
    font-size: 1rem;
    color: #999;
    margin-top: 2rem;
}

.count li:nth-child(3) {
    font-size: 1.7rem;
    color: #f15822;
}

.count li:nth-child(4) {
    margin: 1.5rem auto 0;
    width: 80%;
    display: flex;
    justify-content: center;
}

.count li:nth-child(4) div {
    display: inline-block;
    /*width: 33%;*/
}

.count li:nth-child(5) {
    margin-top: 2rem;
    border-top: 1px solid #f2f2f2;
    border-bottom: 1px solid #f2f2f2;
    display: flex;
    justify-content: center;
}

.count li:nth-child(5) div,.statistics div {
    display: inline-block;
    width: 33%;
    text-align: center;
    height: 8rem;
    line-height: 6rem;
}

.count li:nth-child(5) p,.statistics p {
    position: relative;
    color: #999;
    font-size: .9rem;
    line-height: normal;
    top: -2rem;
}
.statistics{
    border-bottom: 1px solid #f2f2f2;
    display: flex;
    justify-content: center;
}
.vux-header {
    background: #4284d9;
}
</style>