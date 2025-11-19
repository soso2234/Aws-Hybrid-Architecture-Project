<template>
  <div>
    <!--네비게이션 Start-->
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
          <a class="navbar-brand" href="/">Shop</a>
          <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
              <li class="nav-item">
                <router-link class="nav-link active" to="/">Home</router-link>
              </li>
              <li class="nav-item">
                <router-link class="nav-link" to="/list">List</router-link>
              </li>
              <li v-if="user.email=='hbg199@naver.com'" class="nav-item">
                <router-link class="nav-link" to="/sales">Registration</router-link>
              </li>              
            </ul>
            <form class="d-flex">
              <li v-if="user.email==undefined">
                <button class="btn-login" type="button" @click="kakaoLogin">
                  <img src="https://cdn-icons-png.flaticon.com/512/7856/7856337.png">
                </button>
              </li>
              <li v-else>
                <button class="btn-login" type="button" @click="kakaoLogout">
                  <img src="https://cdn-icons-png.flaticon.com/512/5087/5087592.png">
                </button>
                <button class="btn-cart" type="button" @click="goTobuyCart()">
                  <img src="https://cdn-icons-png.flaticon.com/512/833/833314.png">
                </button>&nbsp;

                <button class="btn-orderList" type="button" @click="goToOrderDetail()">
                  <img src="https://cdn-icons-png.flaticon.com/512/839/839860.png">
                </button>
              </li>
              <!-- <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
              <button class="btn btn-outline-success me-2" type="submit">Search</button> -->
            </form>
          </div>
        </div>
      </nav>
      <!--네비게이션 End-->
  <router-view/>
      <!--footer Start-->
      <footer class="mt-5 py-5 bg-light">
        <div class="row">
          <div class="col-12 col-md">
            <small class="d-block mb-3 text-muted">&copy; aws node-vue project</small>
          </div>
          <div class="col-6 col-md">
            <h5>development environment</h5>
            <ul class="list-unstyled text-small" style="color:#989898">
              <li>Vue</li>
              <li>NodeJS</li>
              <li>JavaScript</li>
              <li>Mysql</li>
            </ul>
          </div>
        </div>
      </footer>
      <!--footer End-->
  </div>
</template>

<script>
  export default {
    computed: {
      user() {
        return this.$store.state.user;
      }
    },
    created() {
      //console.log(this.$store.state.user.email);
    },
    methods: {
      kakaoLogin() {
        window.Kakao.Auth.login({
          scope:'profile_nickname,profile_image,account_email,gender',
          success: this.getProfile
        });
        this.$router.push({path:'/'});
      },
      getProfile(authObj){
        console.log("authObj : " + authObj);
        window.Kakao.API.request({
          url:'/v2/user/me',
          success: res => {
            const kakao_account = res.kakao_account;
            console.log(kakao_account);
            this.login(kakao_account);
            alert("Sucess Login!");
          }
        });
      },
      async login(kakao_account) {
        await this.$api("/api/login",{
          param: [
            {email:kakao_account.email, nickname:kakao_account.profile.nickname},
            {nickname:kakao_account.profile.nickname}
          ]
        });
        this.$store.commit("user", kakao_account);
      },
      kakaoLogout() {
        window.Kakao.Auth.logout((response) => {
          console.log(response);
          this.$store.commit("user",{});
          alert("Logout!");
        });
        this.$router.push({path:'/'});
      },
      goTobuyCart(){
        this.$router.push({path:'/cart'});
      },
      goToOrderDetail(){
        this.$router.push({path:'/userOderDetail'});
      },
    }
  }
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

nav {
  padding: 30px;
  background-color: #E8F5FF;
}

nav a {
  font-weight: bold;
  color: #2c3e50;
}

nav a.router-link-exact-active {
  color: #42b983;
}

.d-flex > li {
  list-style: none;
  list-style-type: none;
}
</style>
