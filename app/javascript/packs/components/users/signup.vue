<template>
  <div>
    <el-card class="box-card login">
      <div slot="header" class="clearfix center">
        <span>SIGN UP</span>
      </div>
      <el-form
        ref="form"
        :model="form"
        :rules="rules"
        label-width="180px"
        label-position="top"
      >
        <el-form-item label="name">
          <el-input v-model="form.name" maxlength="100" show-word-limit></el-input>
        </el-form-item>
        <el-form-item label="Email">
          <el-input v-model="form.email" maxlength="100" show-word-limit></el-input>
        </el-form-item>
        <el-form-item label="Password" prop="pass">
          <el-input
            type="password"
            v-model="form.password"
            show-password
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="Confirm Password" prop="confirm_password">
          <el-input
            type="password"
            v-model="form.confirm_password"
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item>
          <el-button style="float: right" type="primary" @click="signUp('form')"
            >Sign up</el-button
          >
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
  mounted: function() {},
  methods: {
    signUp: function(formName){
      this.$refs[formName].validate((valid)=>{
        if(valid){
          axios.post('/v1/auth',{
        name: this.form.name,
        email: this.form.email,
        password: this.form.password,
      }).then((response)=>{
        axios.post('/v1/auth/sign_in',{
        email: this.form.email,
        password: this.form.password,
      }).then((response)=>{
        localStorage.setItem('access-token', response.headers['access-token'])
        localStorage.setItem('client', response.headers.client)
        localStorage.setItem('uid', response.headers.uid)
        localStorage.setItem('token-type', response.headers['token-type'])
        this.$router.push('/') 
      },
      (error) => {
        for (let i =0; i<error.response.data.errors.length; i++){
          this.$message.error(error.response.data.errors[i]);
          }
      }
      );
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
