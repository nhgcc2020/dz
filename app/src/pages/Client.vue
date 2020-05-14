<template>
  <button @click="qiye">点击发送短信</button>
   
</template>
<script>
import BackHeader from '../common/BackHeader'
export default {
    components: {
       BackHeader
    },
    data() {
        return {
            isFirent:true,
            show:true
        }
    },
    methods: {
        qiye(){
            var params = "partnerKey=7b2357e5aa6343318831b568a99e533a&phone=13027795895"
             this.axios.post("http://test.yiduizhang.com/app/partner/sendInviteCompanyByApp?token=" + localStorage.getItem('token'),params)
             .then(function(data) {
               console.log(data);
            // 
             })
        }
    }
}
</script>

<style scoped>

</style>

