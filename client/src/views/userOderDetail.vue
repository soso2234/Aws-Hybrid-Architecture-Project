<template>
    <body>
    <section class="cart">
        <h2 class="text-center">Success Your Order!</h2><br/>
        <div class="textBox" v-if="this.userOrderList.length > 0">
            <ul>
                <li>Thanks for your Shopping</li>
                <li>This is the page where you can check your order.</li>
                <li>If you want to cancel the product, Please click the Cancel button.</li>
            </ul>
        </div>
            <table class="cart__list" v-if="this.userOrderList.length > 0">
                <thead>
                    <tr>
                        <th></th>
                        <th>Product Name</th>
                        <th>Address</th>
                        <th>Phone Number</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <tr :key="i" v-for="(userOrder, i) in userOrderList">
                        <td>
                        <img v-if="userOrder.path!=null" :src="`/download/${userOrder.product_id}/${userOrder.path}/0`" style="height:50px;width:auto;" />
                        </td>
                        <td>{{userOrder.product_name}}</td>
                        <td>{{userOrder.address}}</td>
                        <td>{{userOrder.phone}}</td>
                        <td>{{getCurrencyFormat(userOrder.total_price)}}</td>
                    </tr>
                </tbody>
            </table>
            <div class="dataBoxNull" v-else>
                <ul>
                    <li>No data</li>
                    <li>Please Registrate Products</li>
                </ul>
            </div>
            <div class="cart__mainbtns">
                <button class="cart__bigorderbtn left" @click="goToHome()">Home</button> &nbsp;&nbsp;
            </div>
    </section>
</body>
</template>
<style scoped>
    * {
        box-sizing: border-box;
    }
    p,
    span {
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
    .cart {
        width: 80%;
        margin: auto;
        padding: 30px;
    }
    table {
    border-top: solid 1.5px black;
    border-collapse: collapse;
    width: 100%;
    font-size: 14px;
    }
    thead {
    text-align: center;
    font-weight: bold;
    }
    tbody {
    font-size: 12px;
    }
    td {
    padding: 15px 0px;
    border-bottom: 1px solid lightgrey;
    }
    .cart__list__detail :nth-child(3) {
    vertical-align: top;
    }
    .cart__list__detail :nth-child(3) a {
    font-size: 12px;
    }
    .cart__list__detail :nth-child(3) p {
    margin-top: 6px;
    font-weight: bold;
    }
    .cart__list__smartstore {
    font-size: 12px;
    color: gray;
    }
    .cart__list__option {
    vertical-align: top;
    padding: 20px;
    }
    .cart__list__option p {
    margin-bottom: 25px;
    position: relative;
    }
    .cart__list__option p::after {
    content: "";
    width: 90%;
    height: 1px;
    background-color: lightgrey;
    left: 0px;
    top: 25px;
    position: absolute;
    }
    .cart__list__optionbtn {
    background-color: white;
    font-size: 10px;
    border: lightgrey solid 1px;
    padding: 7px;
    }
    .cart__list__detail :nth-child(4),
    .cart__list__detail :nth-child(5),
    .cart__list__detail :nth-child(6) {
    border-left: 2px solid whitesmoke;
    }
    .cart__list__detail :nth-child(5),
    .cart__list__detail :nth-child(6) {
    text-align: center;
    }
    .cart__list__detail :nth-child(5) button {
    background-color: limegreen;
    color: white;
    border: none;
    border-radius: 5px;
    padding: 4px 8px;
    font-size: 12px;
    margin-top: 5px;
    }
    .price {
    font-weight: bold;
    }
    .cart__mainbtns {
    width: 420px;
    height: 200px;
    padding-top: 40px;
    display: block;
    margin: auto;
    }
    .cart__bigorderbtn {
    width: 200px;
    height: 50px;
    font-size: 16px;
    margin: auto;
    border-radius: 5px;
    }
    .cart__bigorderbtn.left {
    background-color: white;
    border: 1px lightgray solid;
    }
    .cart__bigorderbtn.right {
    background-color: limegreen;
    color: white;
    border: none;
    }
</style>
<script>
export default {
    data(){
        return {
          userOrderList: [],
          productId: "",
          userEmail: this.$store.state.user.email
        };
    },
    created() {
        this.getOrderList();
        //this.deleteCartProduct();       //제품 구매 후, 삭제
    },
    methods: {
        async getOrderList() {
            this.userOrderList = await this.$api("/api/orderList",{param:[this.userEmail]});
            console.log(this.userOrderList);
           // this.productId = this.userOrderList[0].product_id;    //현재 하나의 값만 받게해서 0으로 함
            //this.deleteCartProduct(this.productId)
        },
        // async deleteCartProduct(id) {
        //     this.cartList = await this.$api("/api/cartDelete",{param:[id,this.userEmail]});
        // },
        goToHome(){
            this.$router.push({path:'/'});
        },
        getCurrencyFormat(value) {
            return this.$currencyFormat(value);
        },
    }
}
</script>