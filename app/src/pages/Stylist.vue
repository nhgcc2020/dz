<template>
  <div>
    <div class="x-header">
      <back-header>
        <p class="title">选择设计师</p>
      </back-header>
    </div>
    <div class="big_first" style="margin-bottom:50px;">
        <div class="picture">
            <img class="sculpture" src="../assets/font-awesome/image/reconciliation.jpg" alt="">
            <div style="font-size:12px;color:#999;display:inline-block;position:relative;top:-13px;">
                <p>你可以选择多个设计师</p>
                <p>设计师在未完工前，可以随意撤回已选好的设计师</p>
            </div>
        </div>
    <checker v-model="demo1Checkbox" type="checkbox" selected-item-class="demo1-item-selected">
        <checker-item v-for="(n,index) in datalist" key="index" :value="n.employeeId" :disabled="n.state==2" @on-item-click="itemClick(n.state)"><div style="flex:1;">{{n.realName}}</div><i class="iconfont">&#xe6c5;</i><i v-if="n.state==2" class="iconfont forbid">&#xe6c5;</i></checker-item>
    </checker>
    </div>
    <div class="but">
        <button @click="construction">保存</button>
    </div>
    <div class="error_tips"></div>
  </div>
</template>
<script>
import BackHeader from '../common/BackHeader';
import {  Checker, CheckerItem,TransferDom } from 'vux';
import address from '../url.js';
import $ from 'jquery';
import { mapState, mapGetters } from 'vuex';
export default {
  computed: mapState(['millwright']),
  directives: {
    TransferDom
  },
  components: {
    BackHeader,Checker, CheckerItem
  },
  data() {
    return {
      datalist:[],
      demo1Checkbox: [],
      arr1:[],
      arr2:[],
      arr3:[]
    }
  },
  created() {
      var _this = this;
    setTimeout(function() {
        $.each(_this.millwright.doingTaskEmployee, function (key, val) {
                if(val.status==2){
                    _this.arr1.push(val.taskEmployeeId);
                }else{
                    _this.demo1Checkbox.push(val.taskEmployeeId); 
                    }
        });
        for(var i=0;i<_this.arr1.length;i++){
            for(var j=0;j<_this.millwright.taskEmployees.length;j++){
                if(_this.arr1[i]==_this.millwright.taskEmployees[j].employeeId){
                    _this.millwright.taskEmployees[j].state = 2;
                }
            }

        };
        _this.datalist = _this.millwright.taskEmployees;
    }, 100);
  },
  methods: {
    itemClick(state){
        if(state==2){
             $(".error_tips").text("该员工已完工，无法撤回").fadeIn(250).delay(500).fadeOut(250);
        }
      },
     construction(){
         var _this = this;
         if(_this.demo1Checkbox.length==0){
             $(".error_tips").text("请至少选择一位员工").fadeIn(250).delay(500).fadeOut(250);
         }else{
            for(var i=0;i<_this.demo1Checkbox.length;i++) {
               for(var k=0;k<_this.millwright.taskEmployees.length;k++){
                    if(_this.demo1Checkbox[i]==_this.millwright.taskEmployees[k].employeeId){
                        var obj = {};
                        obj.taskEmployeeId = _this.millwright.taskEmployees[k].employeeId;
                        obj.taskUserName = _this.millwright.taskEmployees[k].realName;
                        obj.status = 1;
                        _this.arr2.push(obj); 
                    }
               }
        };
        for(var i=0;i<_this.arr1.length;i++) {
               for(var k=0;k<_this.millwright.taskEmployees.length;k++){
                    if(_this.arr1[i]==_this.millwright.taskEmployees[k].employeeId){
                        var obj = {};
                        obj.taskEmployeeId = _this.millwright.taskEmployees[k].employeeId;
                        obj.taskUserName = _this.millwright.taskEmployees[k].realName;
                        obj.status = 2;
                        _this.arr3.push(obj);
                    }
               }
        };
        this.$store.commit('stylist', this.arr2.concat(this.arr3));
        this.$router.replace("/tasking/"+this.$route.params.salesNo);
         }
     }
  }
}
</script>
<style scoped>
@media only screen and (max-height: 560px) {
  .but{
      display: none;
  }
}
@media only screen and (min-height: 561px) {
  .but{
      display: block;
  }
}
.picture{
    height: 77px;
    border-bottom: 1px solid #f2f2f2;
    overflow: hidden;
    background: #fff;
}
.sculpture{
    width: 50px;
    height: 50px;
    border:2px solid #999;
    border-radius: 50%;
    margin: 14px 7px 0 23px;
}
.vux-checker-box{
    background: #fff;
}
.vux-tap-active:active{
    background-color: transparent!important;
}
.vux-checker-item{
    display: block;
    display: flex;
    line-height: 50px;
    margin-left: 25px;
    border-bottom: 1px solid #f2f2f2;
    padding-right: 25px;
}
.iconfont{
    display: none;
    font-size: 32px;
    color: #44ae80;
}
.forbid{
    display: block;
    color:#ccc!important;
}
.demo1-item-selected .iconfont{
    display: block;
}
.but{
    position: fixed;
    bottom: 0;
    height: 69px;
    width: 100%;
    background: #fff;
}
.but button{
    display: block;
    width: 94%;
    margin: 11px auto;
    background: #4284d9;
    color:#fff;
    height: 48px;
    border: none;
    font-size: 1rem;
    outline: none;
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

