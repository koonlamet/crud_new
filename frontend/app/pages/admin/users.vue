<template>
    <div>
        <v-container>
            <div class="d-flex align-center">
                <h3>#จัดการผู้ใช้งาน</h3>
                <v-spacer></v-spacer>
                <v-btn icon="mdi-account-plus" color="primary" @click="addDialog = !addDialog"></v-btn>
            </div>
            <v-text-field density="compact" prepend-inner-icon="mdi-magnify" label="ค้นหา" v-model="search"></v-text-field>
            <v-tabs v-model="tab">
                <v-tab value="evaluator" @click="fetchData('evaluator')">กรรมการ</v-tab>
                <v-tab value="evaluatee" @click="fetchData('evaluatee')">ผู้รับการประเมิน</v-tab>
            </v-tabs>
            <v-divider></v-divider>
            <v-tabs-window v-model="tab">
                <v-tabs-window-item value="evaluator">
                    <v-data-table :items="data" :headers="header" :search="search">
                        <template #item.id="{index}">{{ index+1 }}</template>
                        <template #item.status="{item}"><v-chip :color="chip[item.status].color">{{item.status}}</v-chip></template>
                        <template #item.action="{item}">
                            <v-btn icon="mdi-lock-reset" color="green" @click="passReset(item.id)"></v-btn>
                            <v-btn icon="mdi-magnify" color="primary" @click="lookDataDetail(item.id)"></v-btn>
                            <v-btn icon="mdi-pencil" @click="dataEdit(item.id)"></v-btn>
                            <v-btn icon="mdi-delete" color="red" @click="dataDelete(item.id,'evaluator')"></v-btn>
                        </template>
                    </v-data-table>
                </v-tabs-window-item>
                <v-tabs-window-item value="evaluatee">
                    <v-data-table :items="data" :headers="header" :search="search">
                        <template #item.id="{index}">{{ index+1 }}</template>
                        <template #item.status="{item}"><v-chip :color="chip[item.status].color">{{item.status}}</v-chip></template>
                        <template #item.action="{item}">
                            <v-btn icon="mdi-lock-reset" color="green" @click="passReset(item.id)"></v-btn>
                            <v-btn icon="mdi-magnify" color="primary" @click="lookDataDetail(item.id)"></v-btn>
                            <v-btn icon="mdi-pencil" @click="dataEdit(item.id)"></v-btn>
                            <v-btn icon="mdi-delete" color="red" @click="dataDelete(item.id,'evaluatee')"></v-btn>
                        </template>
                    </v-data-table>
                    
                </v-tabs-window-item>
            </v-tabs-window>

            <v-dialog v-model="addDialog" max-width="500px" width="100%">
                <v-card>
                    <v-card-title class="text-center">เพิ่มข้อมูลสมาชิก</v-card-title>
                    <v-form @submit.prevent="addNewUser">
                    <v-card-text>
                        <v-text-field v-model="addUser.fname" label="ชื่อ-สกุล" density="compact" type="text"></v-text-field>
                        <v-select v-model="addUser.role" :items="selectItem" label="บทบาท" density="compact"></v-select>
                        <v-divider class="pa-2"></v-divider>
                        <v-text-field v-model="addUser.username" label="ชื่อผู้ใช้" density="compact" type="text"></v-text-field>
                        <v-text-field v-model="addUser.password" label="รหัสผ่าน" density="compact" type="password"></v-text-field>
                        <v-text-field v-model="addUser.cpassword"  label="ยืนยันรหัสผ่าน" density="compact" type="password"></v-text-field>
                    </v-card-text>
                    <v-card-actions class="justify-center">
                        <v-btn color="red" variant="tonal" @click="addDialog = !addDialog">ยกเลิก</v-btn>
                        <v-btn color="green" variant="flat" type="submit">ยืนยัน</v-btn>
                    </v-card-actions>
                    </v-form>
                </v-card>
            </v-dialog>

            <v-dialog v-model="resetDialog" max-width="500px" width="100%">
                <v-card>
                    <v-card-title class="text-center">รีเซตรหัสผ่าน</v-card-title>
                    <v-form @submit.prevent="confirmPass">
                    <v-card-text>
                        <v-text-field v-model="dataDetail.username" density="compact" type="text" label="ชื่อผู้ใช้" disabled></v-text-field>
                        <v-divider class="pa-2"></v-divider>
                        <v-text-field v-model="resetPass.password"  density="compact" type="password" label="รหัสผ่าน"></v-text-field>
                        <v-text-field v-model="resetPass.cpassword"  density="compact" type="password" label="ยืนยันรหัสผ่าน"></v-text-field>
                    </v-card-text>
                    <v-card-actions class="justify-center">
                        <v-btn color="red" variant="tonal" @click="resetDialog = !resetDialog">ยกเลิก</v-btn>
                        <v-btn color="green" variant="flat" type="submit">ยืนยัน</v-btn>
                    </v-card-actions>
                    </v-form>
                </v-card>
            </v-dialog>

            <v-dialog v-model="lookupDialog" max-width="500px" width="100%">
                <v-card>
                    <v-card-title class="text-center">ดูข้อมูลเพิ่มเติม</v-card-title>
                    <v-card-text>
                        <v-text-field v-model="dataDetail.username" density="compact" type="text" label="ชื่อผู้ใช้" disabled></v-text-field>
                        <v-divider class="pa-2"></v-divider>
                        <v-text-field v-model="dataDetail.fname" density="compact" type="text" label="ชื่อ-สกุล" disabled></v-text-field>
                        <v-text-field :model-value="selectItem.find(item => item.value === dataDetail.role)?.title || dataDetail.role"  density="compact" type="text" label="บทบาท" disabled></v-text-field>
                        <v-text-field v-model="dataDetail.status" density="compact" type="text" label="สถานะ" disabled></v-text-field>
                    </v-card-text>
                    <v-card-actions class="justify-center">
                        <v-btn color="red" variant="tonal" @click="lookupDialog = !lookupDialog">ปิด</v-btn>
                    </v-card-actions>
                </v-card>
            </v-dialog>


            <v-dialog v-model="editDialog" max-width="500px" width="100%">
                <v-card>
                    <v-card-title class="text-center">แก้ไขข้อมูล</v-card-title>
                    <v-form @submit.prevent="editSave">
                    <v-card-text>
                        <v-text-field v-model="dataDetail.username" label="ชื่อผู้ใช้" density="compact" type="text" disabled></v-text-field>
                        <v-divider class="pa-2"></v-divider>
                        <v-text-field v-model="dataDetail.fname" label="ชื่อ-สกุล" density="compact" type="text"></v-text-field>
                        <v-select v-model="dataDetail.role" :items="selectItem" label="บทบาท" density="compact"></v-select>
                        <v-select v-model="dataDetail.status" :items="selectRole" label="สถานะ" density="compact"></v-select>
                    </v-card-text>
                    <v-card-actions class="justify-center">
                        <v-btn color="red" variant="tonal" @click="editDialog = !editDialog">ยกเลิก</v-btn>
                        <v-btn color="green" variant="flat" type="submit">ยืนยัน</v-btn>
                    </v-card-actions>
                    </v-form>
                </v-card>
            </v-dialog>

        </v-container>
    </div>
</template>

<script setup>
import Navbar from '~/layouts/navbar.vue';
import axios from 'axios';
import { fa } from 'vuetify/locale';

const tab = ref('evaluator');
const search = ref('');
const data = ref([]);
const dataDetail = ref({}),resetPass = ref({})
const addDialog = ref(false),lookupDialog = ref(false),resetDialog = ref(false),editDialog = ref(false);
const selectRole = ['newbie','suspend','active']
const selectItem = [
    {title:'กรรมการ',value:'evaluator'},
    {title:'ผู้รับการประเมิน',value:'evaluatee'}
]
const header = [
    {title:'ลำดับ',key:'id'},
    {title:'Username',key:'username'},
    {title:'ชื่อ-สกุล',key:'fname'},
    {title:'สถานะ',key:'status'},
    {title:'#',key:'action'},
]
const chip = {
    active:{title:'active',color:'green'},
    suspend:{title:'suspend',color:'red'},
    newbie:{title:'newbie',color:'primary'}
}
const addUser = ref({})
const fetchData = async (c)=>{
    try {
        const res = await axios.get(`http://localhost:3001/api/users/role/${c}`,{
            headers:{
                Authorization : `Bearer ${useCookie('token').value}`
            }
        });
        data.value = res.data.data;
    } catch (error) {
        alert('การแสดงผลข้อมูลผิดพลาด')
    }
}

const addNewUser = async () =>{
    if(addUser.value.password!==addUser.value.cpassword){
        alert('Confirm Password Mismatch');
        return
    }
    try {
        const res = await axios.post(`http://localhost:3001/api/users`,addUser.value,{
            headers:{
                Authorization:`Bearer ${useCookie('token').value}`
            }
        })
        alert('เพิ่มข้อมูลสำเร็จ');
        fetchData(addUser.value.role)
        addDialog.value = false;
    } catch (error) {
        alert('เกิดข้อผิดพลาดในการเพิ่มข้อมูล');
    }
}

const dataDelete = async(c,r)=>{
    const id = c;
    if(!id){
        console.log('เกิดข้อผิดพลาดกรุณาลองอีกครั้ง')
        return
    }
    try {
        if(!confirm('ยืนยันการลบข้อมูล')){
            return
        }
        const res = await axios.delete(`http://localhost:3001/api/users/${id}`,{
            headers:{
                Authorization:`Bearer ${useCookie('token').value}`
            }
        })
        alert('ลบข้อมูลสำเร็จ');
        fetchData(r);
    } catch (error) {
        console.log('เกิดข้อผิดพลาดกรุณาลองอีกครั้ง')
    }
}

const findDetail = async (c)=>{
    dataDetail.value = {...data.value.find((item)=>item.id === c)}
}

const passReset = async (c)=>{
    resetDialog.value = true;
    findDetail(c);
}

const lookDataDetail = async (c) =>{
    lookupDialog.value = true;
    findDetail(c);
}  

const dataEdit = async (c) =>{
    editDialog.value = true;
    findDetail(c);
}

const confirmPass = async () =>{
    if(resetPass.value.password!==resetPass.value.cpassword){
        alert('Confirm Password Mismatch');
        return;
    }
    try {
        const res = await axios.put(`http://localhost:3001/api/users/reset/${dataDetail.value.id}`,resetPass.value,{
            headers:{Authorization:`Bearer ${useCookie('token').value}`}
        })
        alert('รีเซตรหัสผ่านเรียบร้อย')
        resetDialog.value = false;
    } catch (error) {
        console.log('เกิดข้อผิดพลาดกรุณาลองอีกครั้ง')
    }
}

const editSave = async ()=>{
    try {
        const payload = {
            fname:dataDetail.value.fname,
            role:dataDetail.value.role,
            status:dataDetail.value.status
        }
        console.log(payload)
        const res = await axios.put(`http://localhost:3001/api/users/${dataDetail.value.id}`,payload,{
            headers:{Authorization:`Bearer ${useCookie('token').value}`}
        })
        alert('แก้ไขข้อมูลเรียบร้อยแล้ว')
        fetchData(tab.value);
        editDialog.value = false;
    } catch (error) {
        console.log('เกิดข้อผิดพลาดกรุณาลองอีกครั้ง')
    }
}

onMounted(()=>{
    fetchData('evaluator');
})
definePageMeta({
    layout:'navbar'
})
</script>
