<template>
        <v-container  class="d-flex align-center justify-center fill-height">
                <v-card max-width="500px" width="100%" elevation="1" rounded="lg" class="text-center pa-4">
                    <v-form @submit.prevent="login">
                        <v-card-title class="text-h5 font-weight-bold pa-5 pb-2">กรุณาเปลี่ยนรหัสผ่าน</v-card-title>
                        <v-card-text>
                            <v-text-field v-model="userLogin.password" label="รหัสผ่าน" type="password" block></v-text-field>
                            <v-text-field v-model="userLogin.cpassword" label="ยืนยันรหัสผ่าน" type="password" block></v-text-field>
                        </v-card-text>
                        <div class="d-flex align-center justify-center">
                            <v-card-actions>
                                <v-btn color="gray" variant="outlined"  size="large" @click="handleCancel">ยกเลิก</v-btn>
                                <v-btn color="success" variant="elevated"  type="summit" size="large">เปลี่ยนรหัสผ่าน</v-btn>
                            </v-card-actions>
                        </div>
                    </v-form>
                </v-card>
        </v-container>
</template>

<script setup>
import axios from 'axios';
const userLogin = ref({});
const token = useCookie('token');
const user = useCookie('user');

const login = async () =>{
    try {
        if(userLogin.value.password !== userLogin.value.cpassword){
            console.log('Confirm Password Mismatch');
            return;
        }
        const password = userLogin.value.password;
        const res = await axios.put(`http://localhost:3001/api/flogin`,{password},{headers:{Authorization:`Bearer ${token.value}`}})
       // console.log(token.value)
        token.value=res.data.token
        user.value = res.data.data
        navigateTo('/'+user.value.role)

    } catch (error) {
        alert('เปลี่ยนรหัสผ่านผิดพลาดกรุณาอีกครั้ง')
    }
}

const handleCancel = () =>{
    token.value = null;
    user.value = null;
    navigateTo('/')
}

</script>

