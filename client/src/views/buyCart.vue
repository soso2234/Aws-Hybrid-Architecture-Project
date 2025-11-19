<template>
    <body>
    <section class="cart">
        <h2 class="text-center">Cart</h2><br/>
        <div class="textBox" v-if="this.userCartList.length > 0">
            <ul>
                <li>Shopping cart products are stored for up to 30 days.</li>
                <li>If the information such as price, option, etc. has changed, you may not be able to order.</li>
                <li>If you want to delete the product from your shopping cart, Please click the delete button.</li>
            </ul>
        </div>
            <table class="cart__list" v-if="this.userCartList.length > 0">
                <thead>
                    <tr>
                        <th></th>
                        <th>Product Name</th>
                        <th>Price</th>
                        <th>Shipping Charge</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <tr :key="i" v-for="(userCart, i) in userCartList">
                        <td>
                        <img v-if="userCart.path!=null" :src="`/download/${userCart.product_id}/${userCart.path}/0`" style="height:50px;width:auto;" />
                        </td>
                        <td>{{userCart.product_name}}</td>
                        <td>{{getCurrencyFormat(userCart.product_price)}}</td>
                        <td>{{getCurrencyFormat(userCart.delivery_price)}}</td>
                        
                        <td>
                            <!-- <button type="button" class="btn btn-danger" @click="deleteProduct(userCart.product_id);">delete</button> -->
                            <button class="btn-sales" type="button" @click="deleteProduct(userCart.product_id);">
                                <img src="https://cdn-icons-png.flaticon.com/512/7945/7945112.png">
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="dataBoxNull" v-else>
                <ul>
                    <li>No data</li>
                    <li>Please fill up the shopping cart!</li>
                </ul>
            </div>
        <div class="cart__mainbtns">
            <button class="cart__bigorderbtn left" @click="goToHome()">Home</button> &nbsp;&nbsp;
            <button class="cart__bigorderbtn right" @click="goToOrderDetail()" v-if="this.userCartList.length > 0">Order</button>
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
</style>
<script>
export default {
    data(){
        return {
          userCartList: [],
          userEmail : this.$store.state.user.email
        };
    },
    created() {
        this.getCartList();
    },
    methods: {
        async getCartList() {
          this.userCartList = await this.$api("/api/cartList",{param:[this.userEmail]});
        },
        deleteProduct(productId) {
            this.$swal.fire({
                title: 'Do you want to Delete the product?',
                showCancelButton: true,
                confirmButtonText: 'Delete',
                cancelButtonText: `Cancel`,
                }).then(async(result) => {
                if (result.isConfirmed) {
                    console.log(productId);
                    await this.$api("/api/cartListDelete",{param:[this.userEmail,productId]});
                    this.getCartList();
                    this.$swal.fire('Delete!', '', 'success')
                }
            });
        },
        goToOrderDetail(){
            this.$swal.fire({
                title: 'Would you like to buy it now?',
                showCancelButton: true,
                confirmButtonText: 'Yes',
                cancelButtonText: 'Cancel',
                }).then(async(result) => {
                if (result.isConfirmed) {
                    for(let i = 0; i < this.userCartList.length; i++){
                        let productId = this.userCartList[i].product_id;
                        this.$router.push({name:'orderDetail', params:{productid:productId}}); 
                    }
                }
            });
        },
        goToHome(){
            this.$router.push({path:'/'});
        },
        getCurrencyFormat(value) {
            return this.$currencyFormat(value);
        },
    }
}
</script>
