<template>
        <v-container  class="d-flex align-center justify-center fill-height">
                <v-card max-width="500px" width="100%" elevation="1" rounded="lg" class="text-center pa-4">
                    <v-form @submit.prevent="login">
                        <v-card-title class="text-h5 font-weight-bold pa-5 pb-2">เข้าสู่ระบบ</v-card-title>
                        <v-card-text>
                            <v-text-field v-model="userLogin.username" label="Username" type="text" block></v-text-field>
                            <v-text-field v-model="userLogin.password" label="Password" type="password" block></v-text-field>
                        </v-card-text>
                        <div class="d-flex align-center justify-center">
                            <v-card-actions>
                                <v-btn color="primary" variant="elevated" block type="summit" size="large">เข้าสู่ระบบ</v-btn>
                            </v-card-actions>
                        </div>
                    </v-form>
                </v-card>
        </v-container>
</template>

<script setup>
import axios from 'axios';
const userLogin = ref({});

const login = async () =>{
    try {
        const res = await axios.post(`http://localhost:3001/api/login`,userLogin.value);
        useCookie('token').value = res.data.token;
        useCookie('user').value = res.data.data;
        if(res.data.data.status=='newbie'){
            return navigateTo('/first-login')
        }
        if(res.data.data.status==='suspend'){
            useCookie('token').value = null;
            useCookie('user').value = null;
            alert('คุณถูกระงับการใช้งานกรุณาติดต่อผู้ดูแลระบบ');
            return
        }
        navigateTo('/'+res.data.data.role);

    } catch (error) {
        alert('การเข้าสู่ระบบผิดพลาดกรุณาลองอีกครั้ง')
    }
}

</script>
