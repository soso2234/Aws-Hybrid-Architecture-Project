<template>
    <VueDaumPostcode :options="options" @complete="oncomplete" />
</template>
<script>
import { VueDaumPostcode } from 'vue-daum-postcode'

export default {
    data(){
        return {
          productId: 0
        };
    },
    created() {
        this.productId = this.$route.params.id;
    },
    components: {
        VueDaumPostcode,
    },
    methods: {
        oncomplete:function(result){
        this.zonecode   = result.zonecode;      // 우편번호
        if(result.userSelectedType === 'R'){    // 도로명 주소 선택
            this.address    = result.roadAddress;
        }else{  // 지번 주소 선택
            this.address = result.jibunAddress;
        }
        //orderDetail 함수 호출해서 return값 보내기 
        console.log("id: " + this.productId);
        this.$router.push({name:'orderDetailFromZipcode', params:{id:this.address,code:this.zonecode,productid:this.productId}});   //장바구니로 이동
        this.postOpen = false
        }  
    }
}
</script>