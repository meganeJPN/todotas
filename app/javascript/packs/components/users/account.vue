<template>
  <div>
    <el-card class="box-card login" shadow="never">
      <div slot="header" class="clearfix">
        <span>ユーザー情報</span>
      </div>
      <el-form
        :model="form"
        label-width="180px"
        label-position="top"
      >
        <el-form-item label="ユーザー名">
          <el-input v-model="form.name" readonly></el-input>
        </el-form-item>
        <el-form-item label="EMAIL">
          <el-input v-model="form.email" readonly></el-input>
        </el-form-item>
        <el-form-item>
          <router-link to="/users/edit">
          <el-button style="float: right" type="primary"
            >ユーザー情報編集</el-button
          ></router-link>
        </el-form-item>
        <el-form-item>
          <router-link to="/">
          <el-button style="float: right" type="primary"
            >戻る</el-button
          ></router-link>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>
<style scoped>
.box-card {
  width: 480px;
}

.login {
  position: relative;
  top: 100px;
  right: 0px;
  bottom: 0px;
  left: 0px;
  margin: auto;
}

.center {
  text-align: center;
}
</style>
<script>
import axios from 'axios';
import { reject } from 'lodash';

export default {
  data: function() {
    return {
      form: {
        name: '',
        email:'',
      },
    };
  },
  mounted: function() {
    this.fetchUser();
  },
  methods: {
    fetchUser: function(){
      axios.get('/v1/auth/validate_token', {
        headers: {
          'access-token': localStorage.getItem('access-token'),
          uid: localStorage.getItem('uid'),
          client: localStorage.getItem('client'),
        },
      }).then((response)=>{
        console.log(response.data)
        console.log(response.data.data.name)
        console.log(response.data.data.email)
        this.form.name = response.data.data.name
        this.form.email = response.data.data.email
      },
      (error) =>{
        for (let i =0; i<error.response.data.errors.length; i++){
          this.$notify({
            title: 'Error',
            type: 'error',
            message: error.response.data.errors[i],
          });
        }
      }
  );
    }
  },
};
</script>
