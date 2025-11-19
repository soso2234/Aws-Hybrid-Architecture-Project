<template>
    <body>
    <section class="order">
        <h2 class="text-center">Order Buy Detail</h2><br/>
        <div class="textBox">
            <ul>
                <li>This is the page before the payment.</li>
                <li>Please check your zip code</li>
                <li>Please check the product before ordering.</li>
            </ul>
        </div>
        <div class="orderHistory">
           <table class="cart__list">
                <thead>
                    <tr>
                        <th style="width:40px;padding:20px 0;"></th>
                        <th></th>
                        <th>Product Name</th>
                        <th>Price</th>
                        <th>Shipping Charge</th>
                    </tr>
                </thead>
                <tbody>
                    <tr :key="i" v-for="(userCart, i) in userCartList">
                        <td style="background-color: whitesmoke;">{{i+1}}</td>
                        <td><img v-if="userCart.path!=null" :src="`/download/${userCart.product_id}/${userCart.path}/0`" style="height:50px;width:auto;" /></td>
                        <td>{{userCart.product_name}}</td>
                        <td>{{getCurrencyFormat(userCart.product_price)}}</td>
                        <td>{{getCurrencyFormat(userCart.delivery_price)}}</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <br/><br/>
        <div class="orderList">
            <table class="orderTable">
                <thead style="text-align: left;">
                    <tr>
                        <td class="orderTabetd">Name&nbsp;<span style="color:red">*</span></td>
                        <td><input type="text" id="name1" size="5" maxlength="5" style="width:100px;" :value=this.userName disabled/></td>
                    </tr>
                    <tr>
                        <td class="orderTabetd">Address&nbsp;<span style="color:red">*</span></td>
                        <td>
                            <input type="text" id="postnum1" size="10" maxlength="5" :value="this.zonecode" disabled/>&nbsp;&nbsp;
                            <button type="button" class="btn btn-outline-dark" @click="goToZipCode()">Zip code</button><br/>
                            <!-- <button type="button" style="cursor:pointer; margin-bottom:10px; background-color:#fff">Zip code</button><br/> -->
                            <input type="text" id="addr1" size="50" style="margin-bottom:10px;" :value="this.addressForZipcode" @keyup.enter="this.$refs.add2.focus();"/><br/>
                            <input type="text" id="addr2" size="50" ref="add2" @keyup.enter="this.$refs.num1.focus();" v-model="addDetail"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="orderTabetd">Phone Number&nbsp;<span style="color:red">*</span></td>
                        <td><input type="text" size="3" maxlength="3" style="width:100px;" v-model="num1" ref="num1" @keyup.enter="this.$refs.num2.focus();"/>
                        -<input type="text" size="5" maxlength="4" v-model="num2" style="width:100px;" ref="num2" @keyup.enter="this.$refs.num3.focus();"/>
                        -<input type="text" size="5" maxlength="4" v-model="num3" style="width:100px;" ref="num3" @keyup.enter="this.$refs.message.focus();"/></td>
                    </tr>
                    <tr>
                        <td class="orderTabetd">Message</td>
                        <td><textarea rows="3" cols="100" style="width:500px; height:100px" v-model="note" ref="message" @keyup.enter="this.$refs.pay.focus();"></textarea></td>
                    </tr>
                </thead>
            </table>
        </div>
        <br/><hr/><br/>
        <div class="payList">
            <table class="calc">
                <tr>
                    <th>Total Price</th>
                    <th>Shipping Charge</th>
                    <th style="width:500px; padding:22px 0;">Total Pay</th>
                </tr>
                <tr style="background-color: #fff;">
                    <td style="padding: 23px 0;"><span class="price">{{getCurrencyFormat(this.priceCount)}}</span>$</td>
                    <td><span class="price">{{getCurrencyFormat(this.deliveryCount)}}</span>$</td>
                    <td>= <span class="price">{{getCurrencyFormat(this.totalCount)}}</span>$</td>
                </tr>
            </table>
            <br/><br/>
        </div>
        <!-- 버튼 -->
        <div class="order__mainbtns">
            <button class="order__bigorderbtn left" @click="$router.go(-1)">Cancel</button> &nbsp;&nbsp;
            <button class="cart__bigorderbtn right" @click="goToOrderList()" ref="pay">Pay</button><br/><br/>
        </div>
    </section>
</body>
</template>
<style scoped>
    body {
        margin: 0;
    }
    * {
        box-sizing: border-box;
    }
    p,span {
        margin: 0;
    }
    a {
        color: black;
    }
    img {
        display: block;
        width: 80%;
        height: 80px;
        margin: auto;
    }
    /* 전체적인 div 정리 */
    .order {
        width: 80%;
        margin: auto;
        padding: 30px;
    }
    /* 장바구니 리스트 */
    .cart__list {
        border-top: solid 1.5px black;
        border-collapse: collapse;
        width: 100%;
        font-size: 14px;
    }
    .cart__list thead {
        text-align: center;
        font-weight: bold;
    }
    .cart__list tbody {
        font-size: 12px;
    }
    .cart__list td {
        padding: 15px 0px;
        border-bottom: 1px solid lightgrey;
    }
    .price {
        font-weight: bold;
    }
    /* 하단에 버튼들 */
    .order__mainbtns {
        width: 420px;
        height: 200px;
        padding-top: 40px;
        display: block;
        margin: auto;
    }
    .order__bigorderbtn {
        width: 200px;
        height: 50px;
        font-size: 16px;
        margin: auto;
        border-radius: 5px;
    }
    .order__bigorderbtn.left {
        background-color: white;
        border: 1px lightgray solid;
    }
    .order__bigorderbtn.right {
        background-color: limegreen;
        color: white;
        border: none;
    }
</style>
<script>
export default {
    data(){
        return {
          userCartList: [],
          orderInsert: {
            product_id: 0,
            buyer_id: "",
            name: "",
            total_price: 0,
            address : "",
            postcode : 0,
            phone : "",
            message : ""
          },
          userEmail : this.$store.state.user.email,
          userName : this.$store.state.user.profile.nickname,
          productId : "",
          priceCount: 0,
          deliveryCount: 0,
          totalCount: 0,
          addressForZipcode: "",
          zonecode: "",
        };
    },
    created() {
        this.getCartList();
        //orderDetail2
        this.addressForZipcode = this.$route.params.id;
        this.zonecode = this.$route.params.code;
        //orderDetail3
        this.productId = this.$route.params.productid;
    },
    methods: {
        async getCartList() {
          this.userCartList = await this.$api("/api/cartList",{param:[this.userEmail]});
          for(let i=0; i<this.userCartList.length; i++) {
              this.priceCount += this.userCartList[i].product_price;
              this.deliveryCount += this.userCartList[i].delivery_price;
              this.productId = this.userCartList[i].product_id;
          }
          this.totalCount = this.priceCount+this.deliveryCount;
        },
        async getProductDetail() {
            let productDetail = await this.$api("/api/productDetail",{param:[this.productId]});
            if(productDetail.length > 0) {
                this.productDetail = productDetail[0];
                console.log(this.productDetail);
            }else{
                alert('wrong path, Try again.');
            }
        },
        goToZipCode(){
            this.$router.push({path:'/zipCode'});
        },
        goToOrderList() {
            console.log('goToOrderList 입장!');
            this.$swal.fire({
                title: 'Would you like to buy it?',
                showCancelButton: true,
                confirmButtonText: 'Yes',
                cancelButtonText: 'Cancel',
                }).then(async(result) => {
                if (result.isConfirmed) {
                    // 다건처리
                    if(this.userCartList.length > 1) {
                        for(let i = 0; i < this.userCartList.length; i++) {
                            this.orderInsert.product_id = this.userCartList[i].product_id;
                            this.orderInsert.name = this.userCartList[i].product_name;
                            this.orderInsert.buyer_id = this.userEmail;
                            this.orderInsert.total_price = this.userCartList[i].product_price + this.userCartList[i].delivery_price;
                            this.orderInsert.address = this.addressForZipcode + this.addDetail;
                            this.orderInsert.postcode = this.zonecode;
                            this.orderInsert.phone = this.num1 + this.num2 + this.num3;
                            this.orderInsert.message = this.note;
                            await this.$api("/api/orderInsert",{param:[this.orderInsert]});
                            this.$api("/api/cartDelete",{param:[this.orderInsert.product_id,this.userEmail]});
                        }
                    }else{  // 단건처리
                        this.orderInsert.address = this.addressForZipcode + " " + this.addDetail;
                        await this.$api("/api/orderInsert",{param:[this.orderInsert]});
                        this.$api("/api/cartDelete",{param:[this.orderInsert.product_id,this.userEmail]});
                    }   
                    

                    console.log(this.orderInsert);
                    this.$swal.fire('Save Success!', '', 'success');
                    this.$router.push({path:'/userOderDetail'});
                }
            });
        },
        getCurrencyFormat(value) {
            return this.$currencyFormat(value);
        },
    }
}
</script>