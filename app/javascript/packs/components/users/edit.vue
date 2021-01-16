<template>
  <div>
    <el-card class="box-card login" shadow="never">
      <div slot="header" class="clearfix center">
        <span>ユーザー情報編集</span>
      </div>
      <el-form
        ref="form"
        :model="form"
        :rules="rules"
        label-width="180px"
        label-position="top"
      >
        <el-form-item label="name">
          <el-input id="name" v-model="form.name" maxlength="100" show-word-limit></el-input>
        </el-form-item>
        <el-form-item label="Email">
          <el-input id="email" v-model="form.email" maxlength="100" show-word-limit></el-input>
        </el-form-item>
        <el-form-item label="Password" prop="pass">
          <el-input
            id ="password"
            type="password"
            v-model="form.password"
            show-password
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="Confirm Password" prop="confirm_password">
          <el-input
            id="confirm_password"
            type="password"
            v-model="form.confirm_password"
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item>
          <el-button id="update" style="float: right" type="primary" @click="edit('form')"
            >更新</el-button
          >
        </el-form-item>
         <el-form-item>
          <router-link to="/users/account">
          <el-button style="float: right" type="primary"
            >戻る</el-button
          ></router-link>
        </el-form-item>
      </el-form>
      <div class="center">
        <router-link to="/users/login">
          <el-button type="text">Have account? Log In</el-button>
        </router-link>
      </div>
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
    var validatePass = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('Please input the password'));
      } else {
        if (this.form.confirm_password !== '') {
          this.$refs.form.validateField('confirm_password');
        }
        callback();
      }
    };
    var validatePass2 = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('Please input the password again'));
      } else if (value !== this.form.password) {
        callback(new Error("Two inputs don't match!"));
      } else {
        callback();
      }
    };
    return {
      form: {
        name: '',
        email:'',
        password: '',
        confirm_password: '',
      },
      rules: {
        pass: [{ validator: validatePass, trigger: 'blur' }],
        confirm_password: [{ validator: validatePass2, trigger: 'blur' }],
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
    },
    edit: function(formName){
      this.$refs[formName].validate((valid)=>{
        if(valid){
          axios.put('/v1/auth',{
          name: this.form.name,
          email: this.form.email,
          password: this.form.password
          },
        { headers: {
            'access-token': localStorage.getItem('access-token'),
            uid: localStorage.getItem('uid'),
            client: localStorage.getItem('client'),
          },
      }).then((response)=>{
        localStorage.setItem('access-token', response.headers['access-token'])
        localStorage.setItem('client', response.headers.client)
        localStorage.setItem('uid', response.headers.uid)
        localStorage.setItem('token-type', response.headers['token-type'])
        this.$router.push('/users/account') 
      },
      (error) => {
        for (let i =0; i<error.response.data.errors.full_messages.length; i++){
          this.$message.error(error.response.data.errors.full_messages[i]);
          }
      }
      );
        }else{
          console.log(Login)
          return false;
        }
      });
    },
  },
};
</script>
