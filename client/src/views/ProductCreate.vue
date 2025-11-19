<template>
    <main class="mt-3">
        <div class="container">
        <div class="inner">
          <h2 class="text-center">Register Product</h2><br/>
          <div class="productCreatInput">
            <div class="mb-3 row">
                <label class="col-md-3 col-form-label">Product Name</label>
                <div class="col-md-9">
                    <input type="text" class="form-control" v-model="product.product_name" @keyup.enter="this.$refs.price.focus();">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-md-3 col-form-label">Price</label>
                <div class="col-md-9">
                    <input type="number" size="10" class="form-control" ref="price" v-model="product.product_price" @keyup.enter="this.$refs.deliveryPrice.focus();" placeholder="$">
                </div>
            </div>    
            <div class="mb-3 row">
                <label class="col-md-3 col-form-label">Shipping Charge</label>
                <div class="col-md-9">
                    <input type="number" class="form-control" ref="deliveryPrice" v-model="product.delivery_price" @keyup.enter="this.$refs.addDelivery.focus();" placeholder="$">
                </div>
            </div>        
            <div class="mb-3 row">
                <label class="col-md-3 col-form-label">Additional Shipping Charge</label>
                <div class="col-md-9">
                    <input type="number" class="form-control" ref="addDelivery" v-model="product.add_delivery" @keyup.enter="this.$refs.cate1.focus();" placeholder="$">
                </div>
            </div>     
            <div class="mb-3 row">
                <label class="col-md-3 col-form-label">Category</label>
                <div class="col-md-9">
                    <div class="row">
                        <div class="col-auto">
                            <select class="form-select" v-model="cate1" @change="changeCategory1" ref="cate1" @keyup.enter="this.$refs.cate2.focus();">
                                <option :value="cate" :key=i v-for="(cate,i) in category1">{{cate}}</option>
                            </select>
                        </div>
                        <div class="col-auto">
                            <select class="form-select" v-model="cate2" @change="changeCategory2" ref="cate2" @keyup.enter="this.$refs.cate3.focus();">
                                <option :value="cate" :key=i v-for="(cate,i) in category2">{{cate}}</option>
                            </select>
                        </div>
                        <div class="col-auto">
                            <select class="form-select" v-model="cate3" ref="cate3" @keyup.enter="this.$refs.tag.focus();">
                                    <option :value="cate" :key=i v-for="(cate,i) in category3">{{cate}}</option>
                            </select>
                        </div>                               
                    </div>
                </div>
            </div> 
            <div class="mb-3 row">
                <label class="col-md-3 col-form-label">Tag</label>
                <div class="col-md-9">
                    <input type="text" class="form-control" v-model="product.tags" ref="tag" @keyup.enter="this.$refs.outboundDays.focus();" placeholder="Enter Keywords">
                </div>
            </div>  
            <br/>
            <div class="mb-3 row">
                <div class="col-6 p-1">
                    <button type="button" class="btn btn-outline-dark" style="width:230px;">Cancel</button>
                </div>
                <div class="col-5 p-1">
                    <button type="button" class="btn btn-outline-success" @click="productInsert" ref="save" style="width:230px;">Save</button>
                </div>
            </div>
          </div> 
        </div>
        </div>
  </main>
</template>
<script>
export default {
    data(){
        return {
            product: {
                product_name: "",
                product_price: "",
                delivery_price: "",
                add_delivery: "",
                tags: "",
                outbound_days: 0,
                seller_id: 1,
                category_id: 1,
                id: 0 //nextVal 사용해야함
            },
            categoryList: [],
            category1:[],
            category2:[],
            category3:[],
            cate1: "",
            cate2: "",
            cate3: ""
        };
    },
    computed: {
      user() {
        return this.$store.state.user;
      }
    },
    created(){
        this.getCategoryList();
        this.getProducListMaxId();
    },
    mounted(){
      if(this.user.email == undefined) {
        alert("Please Login!");
        this.$router.push({path:'/'});
      }
    },
    methods: {
        goToList() {
            this.$router.push({path:'/sales'});
        },
        async getCategoryList(){
            let categoryList = await this.$api("/api/categoryList",{});
            this.categoryList = categoryList;
            let oCategory = {};
            categoryList.forEach(item => {
                oCategory[item.category1] = item.id;
            });

            let category1 = [];
            for(let key in oCategory){
                category1.push(key);
            } 
            this.category1 = category1;

            let category2 = [];
            category2 = categoryList.filter(c => {      //filter는 만족한 조건에 해당하는 것만 가져와
                return c.category1 == category1[0];
            });

            let oCategory2 = {};
            category2.forEach(item => {
                oCategory2[item.category2] = item.id;
            });

            category2 = [];
            for(let key in oCategory2) {
                category2.push(key);
            }

            this.category2 = category2;
        },
        changeCategory1(){
            //카테고리3번 초기화
            this.category3 = [];

            let categoryList = this.categoryList.filter(c => {
                return c.category1 == this.cate1;
            });

            let oCategory2 = {};
            categoryList.forEach(item => {
                oCategory2[item.category2] = item.id;
            });

            let category2 = [];
            for(let key in oCategory2) {
                category2.push(key);
            }

            this.category2 = category2;
        },
        changeCategory2(){
            let categoryList = this.categoryList.filter(c => {
                return (c.category1 == this.cate1 && c.category2 == this.cate2);
            });

            let oCategory3 = {};
            categoryList.forEach(item => {
                oCategory3[item.category3] = item.id;
            });

            let category3 = [];
            for(let key in oCategory3) {
                category3.push(key);
            }

            this.category3 = category3;
        },
        async getProducListMaxId() {
            let producListMaxId = await this.$api("/api/producListMaxId",{});
            this.product.id = producListMaxId[0].id+1;
            console.log(this.product.id);
            if(this.product.id == 0){
                this.imageMaxId = 1;
            }      
        },
        productInsert() {
            //입력값이 없을 경우
            if(this.product.product_name == ""){
                return this.$swal("product name is empty!");                
            }

           //제품가격이 0이거나 null일때
            if(this.product.product_price == "" || this.product.product_price == 0){
                return this.$swal("Please enter the price of product!");                
            }
            
            //출고일 0이거나 null일때
            // if(this.product.outbound_days == "" || this.product.outbound_days == 0){
            //     return this.$swal("Please enter the release date!");                
            // }

            if(this.product.add_delivery == ""){
                this.product.add_delivery = 0;
            }

            //저장하면서, category 컬럼에 값을 입력해주는 로직
            this.product.category_id = this.categoryList.filter(c => {
                return (c.category1 == this.cate1 && c.category2 == this.cate2 && c.category3 == this.cate3);
            })[0].id;

            this.$swal.fire({
                title: 'Would you like to register?',
                showCancelButton: true,
                confirmButtonText: 'Create',
                cancelButtonText: 'Cancel',
                }).then(async(result) => {
                if (result.isConfirmed) {
                    await this.$api("/api/productInsert",{param:[this.product]});
                    this.$swal.fire('Save Success!', '', 'success');
                    this.$router.push({path:'/sales'});
                }
            });
        },
        /* 숫자 콤마 찍기 */
        changeNum : function(value) {
          value = this.comma(this.uncomma(value));
          console.log(value);
          return value;
        },
        comma(str) {
           str = String(str);
           return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
        },
        uncomma(str) {
            str = String(str);
            return str.replace(/[^\d]+/g, '');
        },
        setFocus: function()
        {
            this.$refs.search.focus();
        }
    },
}
</script>
<style scoped>
.container {
    /*display flex 붙어다녀요 - 안에 내용물을 가운데 정렬*/
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}
</style>