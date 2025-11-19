<template>
    <VueDaumPostcode :options="options" @complete="oncomplete" />
</template>
<script>
import { VueDaumPostcode } from 'vue-daum-postcode'
export default {
    components: {
        VueDaumPostcode, // export VueDaumPostcode is component
    },
    methods: {
        oncomplete:function(result){
        this.zonecode   = result.zonecode;      // 우편번호
        if(result.userSelectedType === 'R'){    // 도로명 주소 선택
            this.address    = result.roadAddress;
        }else{  // 지번 주소 선택
            this.address = result.jibunAddress;
        }
        console.log('adress : ' + this.address);
        //orderDetail 함수 호출해서 return값 보내기 
        this.$router.push({name:'orderDetail2', params:{id:this.address,code:this.zonecode}});   //장바구니로 이동
        this.postOpen = false
        }  
    }
}
</script>