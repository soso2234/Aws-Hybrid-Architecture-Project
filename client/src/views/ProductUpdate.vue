<template>
    <main class="mt-4">
        <div class="container">
            <div class="inner">
                <h2 class="text-center">Update Product</h2><br/>
                <div class="productCreatInput">
                    <div class="mb-3 row">
                        <label class="col-md-3 col-form-label">Product Name</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control" v-model="productDetail.product_name" disabled>
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label class="col-md-3 col-form-label">Price</label>
                        <div class="col-md-9">
                            <input type="number" class="form-control" v-model="productDetail.product_price" @keyup.enter="this.$refs.ship.focus();">
                        </div>
                    </div>    
                    <div class="mb-3 row">
                        <label class="col-md-3 col-form-label">Shipping Charge</label>
                        <div class="col-md-9">
                            <input type="number" class="form-control" v-model="productDetail.delivery_price" ref="ship" @keyup.enter="this.$refs.addi.focus();">
                        </div>
                    </div>        
                    <div class="mb-3 row">
                        <label class="col-md-3 col-form-label">Additional Shipping Charge</label>
                        <div class="col-md-9">
                            <input type="number" class="form-control" v-model="productDetail.add_delivery" ref="addi" @keyup.enter="this.$refs.tag.focus();">
                        </div>
                    </div>     
                    <!-- <div class="mb-3 row">
                        <label class="col-md-3 col-form-label">Category</label>
                        <div class="col-md-9">
                            <div class="row">
                                <div class="col-auto">
                                    <select class="form-select">
                                        <option>Electronics</option>
                                    </select>
                                </div>
                                <div class="col-auto">
                                    <select class="form-select">
                                        <option>Apple</option>
                                    </select>
                                </div>
                                <div class="col-auto">
                                    <select class="form-select">
                                        <option>Acc</option>
                                    </select>
                                </div>                               
                            </div>
                        </div>
                    </div>  -->
                    <div class="mb-3 row">
                        <label class="col-md-3 col-form-label">Tag</label>
                        <div class="col-md-9">
                            <input type="text" class="form-control" v-model="productDetail.tags" ref="tag" @keyup.enter="this.$refs.save.focus();">
                        </div>
                    </div>  
                    <div class="cart__mainbtns">
                        <button type="button" class="cart__bigorderbtn left" @click="$router.go(-1)">Cancel</button> &nbsp;&nbsp;

                        <button type="button" class="cart__bigorderbtn right" ref="save" @click="productUpdate">Save</button>
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
            id: 0,
            productDetail: {}
        };
    },
    computed: {
      user() {
        return this.$store.state.user;
      }
    },
    mounted(){
      if(this.user.email == undefined) {
        alert("로그인 해주세요!");
        this.$router.push({path:'/'});
      }
    },
    created() {
        this.id = this.$route.query.id;
        this.getProductDetail();
    },
    methods: {
        goToList() {
            this.$router.push({path:'/sales'});
        },
        async getProductDetail() {
            let productDetail = await this.$api("/api/productDetail2",{param:[this.id]});
            if(productDetail.length > 0){
            this.productDetail = productDetail[0];
            }
        },
        productUpdate() {
            //입력값이 없을 경우
            if(this.productDetail.product_name == ""){
                return this.$swal("product name is empty!");                
            }

           //제품가격이 0이거나 null일때
            if(this.productDetail.product_price == "" || this.productDetail.product_price == 0){
                return this.$swal("Please enter the price of product!");                
            }
            if(this.productDetail.add_delivery == ""){
                this.productDetail.add_delivery = 0;
            }
            this.$swal.fire({
                title: 'Would you like to update?',
                showCancelButton: true,
                confirmButtonText: 'Save',
                cancelButtonText: 'Cancel',
                }).then(async(result) => {
                if (result.isConfirmed) {
                    await this.$api("/api/updateProduct",{param:[this.productDetail.product_price, this.productDetail.delivery_price, this.productDetail.add_delivery, this.productDetail.tags, this.productDetail.id]});
                    this.$swal.fire('Save Success!', '', 'success');
                    this.$router.push({path:'/sales'});
                }
            });
        }        
    }
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