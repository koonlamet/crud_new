<template>
        <v-app-bar color="primary" elevation="1">
            <v-app-bar-nav-icon @click="slidebar = !slidebar"></v-app-bar-nav-icon>
            <v-app-bar-title>ระบบประเมินบุคลากร</v-app-bar-title>
            <v-spacer></v-spacer>
                {{ useCookie('user').value.fname }}
              <v-menu v-model="menu">
                <template #activator="menu">
                    <v-btn icon="mdi-cog" v-bind="menu.props"></v-btn>
                </template>
                <v-list >
                  <v-list-item prepend-icon="mdi-account-edit" @click.stop="openEditProfile">
                      <v-list-item-title>แก้ไขข้อมูลส่วนตัว</v-list-item-title>
                  </v-list-item>
                  <v-list-item prepend-icon="mdi-lock-reset" @click="openChangePassword">
                      <v-list-item-title>เปลี่ยนรหัสผ่าน</v-list-item-title>
                  </v-list-item>
                </v-list>
              </v-menu>
            <v-btn icon="mdi-logout" @click="handleLogout"></v-btn>
        </v-app-bar>

        <v-dialog v-model="editProfileDailog" max-width="500px" width="100%">
          <v-card>
            <v-card-title>แก้ไขข้อมูลส่วนตัว</v-card-title>
            <v-card-text>
                <v-text-field v-model="userEdit.username" readonly label="Username"></v-text-field>
                <v-text-field v-model="userEdit.fname" label="Fullname"></v-text-field>
            </v-card-text>
            <v-card-actions class="d-flex align-center justify-center">
                <v-btn color="red" variant="outlined" @click="editProfileDailog = !editProfileDailog">ยกเลิก</v-btn>
                <v-btn color="green" variant="elevated" @click="editProfile">บันทึก</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>

        <v-dialog v-model="editChangePassword" max-width="500px" width="100%">
          <v-card>
            <v-card-title>เปลี่ยนรหัสผ่าน</v-card-title>
            <v-card-text>
              <v-text-field type="password" v-model="ePassword.oldpassword" label="รหัสเดิม"></v-text-field>
              <v-divider class="m-2"></v-divider>
              <v-text-field type="password" v-model="ePassword.newpassword" label="รหัสใหม่"></v-text-field>
              <v-text-field type="password" v-model="ePassword.cnewpassword" label="ยืนยันรหัสใหม่"></v-text-field>
            </v-card-text>
            <v-card-actions class="d-flex align-center justify-center">
                <v-btn color="red" variant="outlined" @click="editChangePassword = !editChangePassword">ยกเลิก</v-btn>
                <v-btn color="green" variant="elevated" @click="ChangePassword">บันทึก</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
       <v-navigation-drawer v-model="slidebar">
            <v-list-item v-for="item in menus[user.role]" :to="item.to" :key="item.to" :title="item.title"></v-list-item>
       </v-navigation-drawer>
        <v-main>
            <slot />
        </v-main>
</template>

<script setup>
import axios from 'axios'

const slidebar = ref(true)
const editProfileDailog = ref(false),editChangePassword = ref(false)
const user = useCookie('user')
const userEdit = ref({})
const ePassword = ref({});
const menu = ref(false)
const menus = {
  admin: [
    { title: 'หน้าแรก', to: '/admin' },
    { title: 'จัดการหัวข้อประเมิน', to: '/admin/topics' },
    { title: 'จัดการผู้ใช้', to: '/admin/users' },
    { title: 'ติดตามสถานะ', to: '/admin/tracking' }
  ],
  evaluator: [
    { title: 'ตรวจประเมิน', to: '/evaluator/tasks' }
  ],
  evaluatee: [
    { title: 'หน้าแรก', to: '/evaluatee' },
    { title: 'การประเมิน', to: '/evaluatee/topic' }
  ]
};
const openEditProfile = () =>{
  menu.value = false;
  editProfileDailog.value = true;
  userEdit.value = {...user.value}
}
const openChangePassword = ()=>{
  menu.value = false;
  editChangePassword.value = true;
}

const ChangePassword = async () =>{
  try {
    if(ePassword.value.newpassword!==ePassword.value.cnewpassword){
      alert('ยืนยันพาสเวิร์ดผิดพลาด');
      return
    }
    const res = await axios.put(`http://localhost:3001/api/users/changepassword/${user.value.id}`,ePassword.value,{
      headers:{
        Authorization:`Bearer ${useCookie('token').value}`
      }
    })
    alert(res.data.message)
    handleLogout();
  } catch (error) {
    console.log(error.response?.data?.message)
  }
}

const editProfile = async () =>{
  try {
    const {id,fname} = userEdit.value
    const res = await axios.put(`http://localhost:3001/api/users/editprofile/${id}`,{fname},{
      headers:{
        Authorization:`Bearer ${useCookie('token').value}`
      }
    })
    user.value = userEdit.value
    alert(res.data?.message)
    editProfileDailog.value=false
  } catch (error) {
    console.log(error.response?.data?.message)
  }
}

const handleLogout = () =>{
    useCookie('token').value = null;
    useCookie('user').value = null;
    navigateTo('/')
}
</script>
