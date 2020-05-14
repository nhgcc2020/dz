import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex)
// 这里定义初始值

export default new Vuex.Store({
    //所有的状态（组件共用的数据）
    state:{
        counts:'',
        names:'',
        alone:'',
        nums:'',
        numbers:'',
        message:'',
        datum:'',
        report:'',
        design:'',
        arraylist:'',
        tasklist:'',
        millwright:'',
        exmessage:''
    },
    // 数据的中间加工，类型过滤
    getters:{
        upperName(state){
            // return '【' + state.names + '】'
        }
    },
    // mutation:改变、突变
    // 可以执行mutation中的方法实现状态的改变
    // 同步的
    mutations:{
        // para1：state状态
        // para2：传递过来的数据
        add(state,payload){
            state.counts = payload 
        },
        seek(state,payload){
            state.alone = payload 
        },
        reserve(state,payload){
            state.nums = payload
        },
        result(state,payload){
            state.numbers = payload
        },
        minus(state,payload){
            state.names = payload
        },
        time(state,payload){
            state.message = payload
        },
        searching(state,payload){
            state.datum = payload
        },
        stockpile(state,payload){
            state.report = payload
        },
        cache(state,payload){
            state.design = payload
        },
        compile(state,payload){
            state.arraylist = payload
        },
        stylist(state,payload){
            state.tasklist = payload
        },
         milllist(state,payload){
            state.millwright = payload
        },
        millmessage(state,payload){
            state.exmessage = payload
        }
    },
    // 异步操作
    actions:{
        // context：上下文，指代当前store对象
        // reserve(context,param){
        //     setTimeout(()=>{
        //         context.commit('reserve',"")
        //     }, 2000);
        // }
    }
})