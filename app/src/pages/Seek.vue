<template>
    <div>
        <header>
            <span class="seek_one">
                <router-link @click.native="setting(content)" tag="i" to="/result" class="iconfont">&#xe6df;</router-link>
                <input @input="change" id="ipt" type="text" placeholder="输入 助记码、企业简称 搜索" v-model="content">
            </span>
            <span class="seek_two" @click="cancel"> 
                取消
            </span>
        </header>
        <div class="big_first">
            <ul>
                <router-link v-if="n.partnerKey!=='temp-customer'" tag="li" v-for="(n,index) in news" key="index" @click.native="jumps(n)" to="/result">{{n.partnerShortname}}</router-link>
            </ul>
        </div>
    </div>
</template>
<script>
import BackHeader from '../common/BackHeader';
import address from '../url.js';
import bus from '../bus.js';
import $ from 'jquery';
import {mapState,mapGetters} from 'vuex';
export default {
    computed:mapState(['alone','names']),
    components: {
        BackHeader
    },
    data() {
        return {
            content:"",
            serachtimer:"",
            news:""
        }
    },
     created() {
        this.getInfo(this.alone);
    },
    methods: {
        getInfo(content){
            setTimeout(function () {
                $("input[type=text]").focus();
            }, 500);
        this.content = content
          var login_name = encodeURI(encodeURI(content));
           var params = "type=1&page=1&rows=30&searchKey="+login_name;
           var _this = this;
           if(content!==""){
               if(_this.names=='Adressbook'){
                this.axios.post(address.addressbook + localStorage.getItem('token'),params)
                .then(function (data) {
                    _this.news = data.data;
                })
                .catch(err => {

                })
               }else{
                this.axios.post(address.supplier + localStorage.getItem('token'),params)
                .then(function (data) {
                    _this.news = data.data
                })
                .catch(err => {

                })
               }
           }
        },
        jumps(n){
            this.$store.commit('result',n)
            this.$store.commit('seek',this.content)
        },
        setting(a) {
            this.$store.commit('seek',a)
        },
        cancel(){
            bus.$emit('back');
            this.$store.commit('seek','')
        },
        change(){
        clearTimeout(this.serachtimer);
        this.serachtimer = setTimeout(function() {
           this.getInfo(this.content);
        }.bind(this), 500);
        }
    }
}
</script>
<style scoped>
 header{
    height:46px;
    background:#e4e4e4;
    position:fixed;
    left:0;
    right:0;
    top:0;
    z-index:100;
    padding:0px 15px 0 15px;
    color:#fff;
  }
  .seek_one{
      position: relative;
      /*display: inline-block;*/
      height: 25px;
      top:8px;
  }
  .seek_one i{
      position: absolute;
      top: -.3rem;
      color: #8e8e8e;
      font-size: 1.3rem;
      margin-left: 5px;
  }
  input{
      background: #fff;
      height: 33px;
      outline:none;
      caret-color: #2e8ae6;
      border: none;
      padding-left: 1.8rem;
      border-radius: 3px;
      width: 76%;
  }
  .seek_two{
      position: relative;
      color: #479efd;
      top:10px;
      float: right;
  }
  li{
    padding: 1rem;
    background: #fff;
    border-bottom: 1px solid #f2f2f3;
  }
</style>
