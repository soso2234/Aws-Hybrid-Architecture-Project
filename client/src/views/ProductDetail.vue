<template>
   <main class="mt-4">
        <div class="container">
            <div class="row">
                <div class="col-md-5">
                    <!--Carousel Start-->
                    <div id="carouselExampleIndicators" class="carousel carousel-dark slide" data-bs-ride="carousel">
                        <div class="carousel-indicators">
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                        </div>
                        <div class="carousel-inner">
                            <div :class="`carousel-item ${i==0?'active':''}`" :key="i" v-for="(pimg, i) in productImage">
                                <img :src="`/download/${this.id}/${pimg.path}/0`" class="d-block w-100" alt="..." >
                            </div>
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div><!--Carousel End-->                    
                </div>
                <!--end-->
                <div class="col-md-7">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title">{{productDetail.product_name}}</h5>
                            <h5 class="card-title pt-3 pb-3" style="font-weight:bold;">{{getCurrencyFormat(productDetail.product_price)}}$</h5>
                            <p class="card-text pt-3 border-top">
                                <span class="badge bg-dark me-1">{{productDetail.category1}}</span>
                                <span class="badge bg-dark me-1">{{productDetail.category2}}</span>
                                <span class="badge bg-dark ">{{productDetail.category3}}</span>
                            </p>
                            <p class="card-text pb-3">
                                Delivery: In Stock {{getCurrencyFormat(productDetail.delivery_price)}}$ <br/> Shipping | Pickup: Check availability 1 within
                            </p>
                            <div class="card-text pb-3">
                                <div class="row">
                                    <div class="col-auto">
                                        <label class="col-form-label">quantity</label>
                                    </div>
                                    <div class="col-auto">
                                        <div class="input-group">
                                            <span class="input-group-text" style="cursor:pointer; background-color:#fff; border: none;" @click="calculateprice(-1);">-</span>
                                            <input type="text" class="form-control" style="width:40px; border: none;" v-model="total">
                                            <span class="input-group-text" style="cursor:pointer; background-color:#fff; border: none;" @click="calculateprice(+1);">+</span>
                                        </div>
                                    </div>
                                </div>
                            </div>          
                            <div class="row pt-3 pb-3 border-top">
                                <div class="col-auto">
                                    <h3>Total</h3>
                                </div>
                                <div class="col-10" style="text-align: right;">
                                    <h3>{{getCurrencyFormat(totalPrice)}}$</h3>
                                </div>                               
                            </div> 
                            <div class="cart__mainbtns">
                                <button class="cart__bigorderbtn left" @click="goTobuyCart()">Cart</button> &nbsp;&nbsp;
                                <button class="cart__bigorderbtn right" @click="goToOrderDetail(productDetail.id)">Buy</button>
                            </div>
                        </div>
                    </div>                     
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                     <img :src="`/download/${productDetail.id}/${productDetail.path}/0`" class="img-fluid"/><!-- <img :src="productDetail.path" class="img-fluid"/>  -->
                </div>
            </div>
        </div>
    </main>
</template>

<script>
export default {
    data(){
        return {
            userEmail : this.$store.state.user.email,
            id: 0,
            productDetail: {},
            productImage: [],
            total: 1,
            totalPrice: 0
        };
    },
    created() {
        this.id = this.$route.query.id;
        this.getProductDetail();
        this.getProductImage();
    },
    methods: {
      //구매수량 +,-
      calculateprice(cnt) {
        let total = this.total + cnt;

        if(total < 1) total = 1; 
        this.total = total;

        if(total > 10) {
          alert("최대 구매 수량은 10개입니다.");
          this.total = 10;
        }
        this.totalPrice = this.productDetail.product_price * this.total;
      },
      getCurrencyFormat(value) {
        return this.$currencyFormat(value);
      },
      async getProductDetail() {
          let productDetail = await this.$api("/api/productDetail",{param:[this.id]});
          if(productDetail.length > 0){
            this.productDetail = productDetail[0];
            this.totalPrice = this.productDetail.product_price * this.total;
          }
      },
      async getProductImage() {
        this.productImage = await this.$api("/api/productMainImages",{param:[this.id]});
      },
      goTobuyCart() {
        if(this.userEmail == undefined) {
            alert("Please login to Kakao");
        }else{
            this.$swal.fire({
                title: 'Would you like to add to cart?',
                showCancelButton: true,
                confirmButtonText: 'Yes',
                cancelButtonText: 'Cancel',
                }).then(async(result) => {
                if (result.isConfirmed) {
                    let id = this.productDetail.id;
                    let product_name = this.productDetail.product_name;
                    let product_price = this.productDetail.product_price;
                    let delivery_price = this.productDetail.delivery_price;
                    // let add_delivery = this.productDetail.add_delivery;
                    let buyer_id = this.userEmail;   //buyer_id는 로그인 한 사람의 이메일
                    let category_id = this.productDetail.category_id;
                    let tags = this.productDetail.tags;
                    let path = this.productDetail.path;
                    await this.$api("/api/cartInsert",{param:[id,product_name,product_price,delivery_price,buyer_id,category_id,tags,path]});
                    this.$router.push({path:'/cart', query:{id:id}});   //장바구니로 이동
                }
                });
            }
        },
        goToOrderDetail(i){
            if(this.userEmail == undefined) {
                alert("Please login to Kakao");
            }else{
                this.$swal.fire({
                    title: 'Would you like to buy it now?',
                    showCancelButton: true,
                    confirmButtonText: 'Yes',
                    cancelButtonText: 'Cancel',
                    }).then(async(result) => {
                    if (result.isConfirmed) {
                        this.$router.push({name:'orderDetailTobuyNow', params:{productid:i}}); 
                    }
                });
            }
        },
    }
}
</script>