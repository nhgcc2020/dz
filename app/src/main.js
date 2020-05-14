// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import FastClick from 'fastclick'
import VueRouter from 'vue-router'
import App from './App'
// import 'lib-flexible'
import './assets/font-awesome/css/main.css'
import router from './router'
import { AjaxPlugin } from 'vux'
import axios from 'axios'
import echarts from 'echarts'
import store from './store/index.js'
// import VueResource from 'vue-resource'  
// Vue.use(VueResource) 
Vue.use(AjaxPlugin);
//Vue.use(VueRouter)
Vue.prototype.$echarts = echarts;
Vue.prototype.axios = axios;

//const routes = [{
//path: '/',
//component: Home
//}]
var phase = [{"phaseid":"01","phasename":"商机"},{"phaseid":"02","phasename":"报价"},{"phaseid":"03","phasename":"谈判"},{"phaseid":"04","phasename":"赢单"},{"phaseid":"05","phasename":"输单"}]
var contract = [{"contractid":"01","contractname":"执行中"},{"contractid":"02","contractname":"已完成"},{"contractid":"03","contractname":"意外终止"},{"contractid":"04","contractname":"合同作废"}]
var method = [{"contacterId": "1", "contacterName": "现金"}, {
                "contacterId": "2",
                "contacterName": "银行转账"
            }, {"contacterId": "3", "contacterName": "信用卡"}, {
                "contacterId": "4",
                "contacterName": "支付宝"
            }, {"contacterId": "5", "contacterName": "微信钱包"}, {"contacterId": "6", "contacterName": "其他"}];
var wkListType=[
     {
        id: "00",
        text: "简单加工"
    }, {
        id: "01",
        text: "写真打印"
    }, {
        id: "09",
        text: "户外打印"
    }, {
        id: "02",
        text: "写真后道"
    },
    {
        id: "03",
        text: "喷绘打印"
    }, {
        id: "04",
        text: "喷绘后道"
    },
    {
        id: "05",
        text: "UV打印"
    }, {
        id: "06",
        text: "条幅打印"
    }, {
        id: "07",
        text: "条幅后道"
    }, {
        id: "08",
        text: "后道加工"
    }];
function fmoney(s, n) //s:传入的float数字 ，n:希望返回小数点几位  
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
        };
        // 人民币大小写转换
function smalltoBIG(n)     
    {    
        var fraction = ['角', '分'];    
        var digit = ['零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖'];    
        var unit = [ ['元', '万', '亿'], ['', '拾', '佰', '仟']  ];    
        var head = n < 0? '欠': '';    
        n = Math.abs(n);    
      
        var s = '';    
      
        for (var i = 0; i < fraction.length; i++)     
        {    
            s += (digit[Math.floor(n * 10 * Math.pow(10, i)) % 10] + fraction[i]).replace(/零./, '');    
        }    
        s = s || '整';    
        n = Math.floor(n);    
      
        for (var i = 0; i < unit[0].length && n > 0; i++)     
        {    
            var p = '';    
            for (var j = 0; j < unit[1].length && n > 0; j++)     
            {    
                p = digit[n % 10] + unit[1][j] + p;    
                n = Math.floor(n / 10);    
            }    
            s = p.replace(/(零.)*零$/, '').replace(/^$/, '零')  + unit[0][i] + s;    
        }    
        return head + s.replace(/(零.)*零元/, '元').replace(/(零.)+/g, '零').replace(/^整$/, '零元整');    
    }  

Vue.filter('number', value => {
  if (value < 10) {
    return parseInt(value)
  } else {
    return value
  }
})
Vue.filter('type', value => {
  if (value == 1) {
    return value = "有限公司"
  } else {
    return value = "个体工商户"
  }
})
Vue.filter('money', value => {
  return parseFloat(value).toFixed(2)
})
Vue.filter('Price', value => {
  if (value == "") {
    return value = '0.00'
  } else {
    return value
  }
})
Vue.filter('image', value => {
  if (value) {
    if (value.indexOf('http') > -1) {
      return value
    } else {
      return "https://www.yiduizhang.com" + value
    }

  }
})
Vue.filter('message', value => {
  if (value.length > 12) {
    return value.substr(0, 12) + ' . . .'
  } else {
    return value
  }

})
Vue.filter('chitcount', value => {
  if (value.length > 20) {
    return value.substr(0, 20) + ' . . .'
  } else {
    return value
  }
})

Vue.filter('casedesc', value => {
  if (value.length > 23) {
    return value.substr(0, 23) + '...'
  } else if (value == "") {
    return "内容未填"
  } else {
    return value
  }
})

Vue.filter('incision', value => {
  if (value&&value.length > 17) {
    return value.substr(0, 17) + '...'
  } else {
    return value
  }
})

Vue.filter('firm', value => {
  if (value) {
    if (value.length > 11) {
      return value.substr(0, 10) + '...'
    } else {
      return value
    }
  }
})
Vue.filter('character', value => {
  if (value) {
    if (value.length > 4) {
      return value.substr(0, 3) + '...'
    } else {
      return value
    }
  }
})
Vue.filter('kong', value => {
  if (value == "" || value == null) {
    return '—'
  } else {
    return value
  }
})
Vue.filter('content', value => {
  if (value == "" || value == null || value == "  ") {
    return "未填写"
  } else {
    return value
  }
})

Vue.filter('spenderName', value => {
return value.substr(value.length-2)
})
Vue.filter('wltype', value => {
  for(var i=0;i<wkListType.length;i++){
    if(value==wkListType[i].id){
      return wkListType[i].text
    }
  }
})

Vue.filter('pattern', value => {
  for(var i=0;i<method.length;i++){
    if(value==method[i].contacterId){
      return method[i].contacterName
    }
  }
})

Vue.filter('contractStatus', value => {
  for(var i=0;i<contract.length;i++){
    if(value==contract[i].contractid){
      return contract[i].contractname
    }
  }
})

Vue.filter('mold', value => {
  for(var i=0;i<phase.length;i++){
    if(value==phase[i].phaseid){
      return phase[i].phasename
    }
  }
})

Vue.filter('summation', value => {
  var nb  = 0;
  for(var i=0;i<value.length;i++){
       if(value[i].money!=""){
        nb += Number(value[i].money);
       }
  }
 return nb.toFixed(2);
})

Vue.filter('totalMoney', value => {
  var nb  = 0;
  for(var i=0;i<value.length;i++){
       if(value[i].totalPrice!=""){
        nb += Number(value[i].totalPrice);
       }
  }
 return nb.toFixed(2);
})

Vue.filter('condition', value => {
return value.substr(value.length-3,2);
})


Vue.filter('filmoney', value => {
  if(value==undefined){
    return fmoney(0,2);
  }else{
    return fmoney(value,2);
  }
})
Vue.filter('chatone', value => {
return value.split(":")[0];
})
Vue.filter('chattwo', value => {
 if (value.split(":")[1].length > 18) {
    return value.split(":")[1].substr(0, 18) + '...'
  } else {
    return value.split(":")[1]
  }
})

Vue.filter('capital', value => {
  return smalltoBIG(value);
})
//const router = new VueRouter({
//routes
//})

FastClick.attach(document.body)

Vue.config.productionTip = false;

/* eslint-disable no-new */
new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app-box')







