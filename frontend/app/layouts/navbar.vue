<template>
    <v-app>
        <v-app-bar color="primary" elevation="1">
            <v-app-bar-nav-icon @click="slidebar = !slidebar"></v-app-bar-nav-icon>
            <v-app-bar-title>ระบบประเมินบุคลากร</v-app-bar-title>
            <v-spacer></v-spacer>
            {{ useCookie('user').value.role }}
            <v-btn icon="mdi-logout" @click="handleLogout"></v-btn>
        </v-app-bar>
        
       <v-navigation-drawer v-model="slidebar">
            <v-list-item v-for="item in menus[user.role]" :to="item.to" :key="item.to" :title="item.title"></v-list-item>
       </v-navigation-drawer>
        <v-main>
            <slot />
        </v-main>
    </v-app>
</template>

<script setup>
const slidebar = ref(true)
const user = useCookie('user')

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
    { title: 'ส่งผลงานประเมิน', to: '/evaluatee/evidence' }
  ]
};

const handleLogout = () =>{
    useCookie('token').value = null;
    useCookie('user').value = null;
    navigateTo('/')
}
</script>
