<template>
  <main class="mt-4">
    <div class="container">
      <div class="inner">
      <h2 class="text-center">Image Upload</h2><br/>
      <div class="mb-3 row">
        <label class="col-md-3 col-form-label">Product ID</label>
        <div class="col-md-3">
          {{productId}}
        </div>
      </div>
      <div class="mb-3 row" style="display:none;">
        <label class="col-md-3 col-form-label">max Image Id</label>
        <div class="col-md-3">
          {{this.imageMaxId}}
        </div>
      </div>      
      <div class="mb-3 row">
        <label class="col-md-3 col-form-label">Product Name</label>
        <div class="col-md-3">
          {{productDetail.product_name}}
        </div>
      </div>
      <div class="mb-3 row">
        <label class="col-md-3 col-form-label">Main Image</label>
        <div class="col-md-9">
          <div class="row">
            <div class="col-lg-3 col-md-4 col-sm-2" :key="i" v-for="(m,i) in productImage.filter(c=>c.type==1)">
              <div class="position-relative">
                <img :src="`/download/${productId}/${m.path}/0`" class="img-fluid"/>
                <div class="position-absolute top-0 end-0" style="cursor:pointer;" @click="deleteImage(m.id)">X</div>
              </div>
            </div>
          </div>
          <br/>
          <input type="file" class="form-control" accept="image/png,image/jpeg" @change="uploadFile($event.target.files, 1)" style="width:400px;">
          <div class="alert" role="alert" style="background-color: #fff; width:400px;">
            <ul>
              <li>Image ize : 350*350</li>
              <li>File Size : 1M or less</li>
              <li>File extension : png, jpg</li>
            </ul>
          </div>
        </div>
      </div>
      <div class="mb-3 row">
        <label class="col-md-3 col-form-label">Second Image</label>
        <div class="col-md-9">
          <div class="row">
            <div class="col-lg-3 col-md-4 col-sm-2" :key="i" v-for="(m,i) in productImage.filter(c=>c.type==2)">
              <div class="position-relative">
                <img :src="`/download/${productId}/${m.path}/0`" class="img-fluid"/>
                <div class="position-absolute top-0 end-0" style="cursor:pointer;" @click="deleteImage(m.id)">X</div>
              </div>
            </div>
          </div>
          <br/>
          <input type="file" class="form-control" accept="image/png,image/jpeg"  @change="uploadFile($event.target.files, 2)" style="width:400px;">
          <div class="alert" role="alert" style="background-color: #fff; width:400px;">
            <ul>
              <!-- <li>Max 5 Img</li> -->
              <li>Image ize : 350*350</li>
              <li>File Size : 1M or less</li>
              <li>File extension : png, jpg</li>
            </ul>
          </div>
        </div>
      </div>
      <div class="mb-3 row">
        <label class="col-md-3 col-form-label">Product Info Image</label>
        <div class="col-md-9">
          <div class="row">
            <div class="col-lg-6 col-md-4" :key="i" v-for="(m,i) in productImage.filter(c=>c.type==3)">
              <div class="position-relative">
                <img :src="`/download/${productId}/${m.path}/0`" class="img-fluid"/>
                <div class="position-absolute top-0 end-0" style="cursor:pointer;" @click="deleteImage(m.id)">X</div>
              </div>
            </div>
          </div>
          <br/>
          <div class="col-lg-6 col-md-8">
            <input type="file" class="form-control" accept="image/png,image/jpeg" @change="uploadFile($event.target.files, 3)" style="width:400px;">
              <div class="alert" role="alert" style="background-color: #fff; width:400px;">
                <ul>
                  <li>File Size : 5M or less</li>
                  <li>File extension : png, jpg</li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      <div class="textButton">
        <button type="button" class="btn btn-lg btn-dark" @click="goToList" style="width:600px;">Confirm</button>
      </div>
    </div>
    </div>
  </main>
</template>
<script>
export default {
  data() {
    return {
      productId:0,
      productName: "",
      imageMaxId: 0,
      productDetail: {},
      productImage: []
    };
  },
  computed: {
    user() {
      return this.$store.state.user;
    }
  },
  created() {
    this.productId = this.$route.query.id;
    this.getProductDetail();
    this.getProductImage();
    this.getProductImageMaxId();
  },
  mounted() {
    if(this.user.email == undefined) {
      alert("Please Login");
      this.$router.push({path:'/'}); 
    }
  },
  methods: {
    goToList(){
      this.$router.push({path:'/sales'}); 
    },
    async getProductDetail() {
      let productDetail = await this.$api("/api/productDetail",{param:[this.productId]});
      if(productDetail.length > 0) {
        this.productDetail = productDetail[0];
      }else{
          let productDetail = await this.$api("/api/productDetail2",{param:[this.productId]});
          this.productDetail = productDetail[0];
      }
    },
    async getProductImage() {
      this.productImage = await this.$api("/api/imageList",{param:[this.productId]});
    },
    async getProductImageMaxId() {
      let imageListMaxId = await this.$api("/api/imageListMaxId",{});
      this.imageMaxId = imageListMaxId[0].id+1;

      if(this.imageMaxId == 0){
        this.imageMaxId = 1;
      }
      return this.imageMaxId;
    },
    deleteImage(id) {
      this.$swal.fire({
        title: 'Are you sure delete?',
        showCancelButton: true,
        confirmButtonText: `Delete`,
        cancelButtonText: `Cancel`
      }).then(async (result) => {
        if (result.isConfirmed) {
          await this.$api("/api/imageDelete",{param:[id]});
          this.getProductImage();
          this.$swal.fire('Cancle!', '', 'success');
          this.getProductImageMaxId();
        }
      });
    },
    async uploadFile(files, type) {
      let name = "";
      let data = null;
      if (files) {
        name = files[0].name;
        data = await this.$base64(files[0]);
      }
      const { error } = await this.$api(`/upload/${this.productId}/${type}/${name}/${this.imageMaxId}`, { data });
      if (error) {
        return this.$swal("Image upload failed. Try again.");
      }else{
        this.$swal("Image Upload Complete");
      }
      setTimeout(() => {
        this.getProductImage();
        this.getProductImageMaxId();
        console.log("maxid : " +this.imageMaxId);
      }, 1000);
    }
  },
  watch: {
    input1() { 
        console.log(this.imageMaxId);
    }
  },

}
</script>
<style>
.container {
    /*display flex 붙어다녀요 - 안에 내용물을 가운데 정렬*/
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}
.alert ul li{
  list-style: none;
  list-style-type: none;
}
</style>