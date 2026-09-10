<template>
    <div>
        <v-container>
            <!-- Header -->
            <div class="d-flex align-center mb-2">
                <h3>#จัดการผู้ใช้งาน</h3>
                <v-spacer></v-spacer>
                <v-btn icon="mdi-account-plus" color="primary" @click="addUser = {}; addDialog = true"></v-btn>
            </div>

            <!-- Search -->
            <v-text-field density="compact" prepend-inner-icon="mdi-magnify" label="ค้นหา" v-model="search" clearable></v-text-field>

            <!-- Tabs: ไม่ต้องใส่ @click แล้ว เพราะมี watch ดักให้อัตโนมัติ -->
            <v-tabs v-model="tab" color="primary">
                <v-tab value="evaluator">กรรมการ</v-tab>
                <v-tab value="evaluatee">ผู้รับการประเมิน</v-tab>
            </v-tabs>
            <v-divider class="mb-4"></v-divider>

            <!-- Table: ใช้ตารางเดียว รองรับทุกแท็บ -->
            <v-data-table :items="data" :headers="header" :search="search">
                <template #item.id="{ index }">{{ index + 1 }}</template>
                <template #item.status="{ item }">
                    <v-chip :color="chip[item.status]?.color">{{ item.status }}</v-chip>
                </template>
                <template #item.action="{ item }">
                    <div class="d-flex ga-1">
                        <v-btn icon="mdi-lock-reset" size="small" variant="text" color="green" @click="openAction('reset', item)"></v-btn>
                        <v-btn icon="mdi-magnify" size="small" variant="text" color="primary" @click="openAction('view', item)"></v-btn>
                        <v-btn icon="mdi-pencil" size="small" variant="text" color="orange" @click="openAction('edit', item)"></v-btn>
                        <v-btn icon="mdi-delete" size="small" variant="text" color="red" @click="dataDelete(item.id)"></v-btn>
                    </div>
                </template>
            </v-data-table>

            <!-- Dialog: เพิ่มผู้ใช้ -->
            <v-dialog v-model="addDialog" max-width="500px">
                <v-card title="เพิ่มข้อมูลสมาชิก">
                    <v-form @submit.prevent="addNewUser">
                        <v-card-text>
                            <v-text-field v-model="addUser.fname" label="ชื่อ-สกุล" density="compact"></v-text-field>
                            <v-select v-model="addUser.role" :items="selectRole" label="บทบาท" density="compact"></v-select>
                            <v-divider class="my-2"></v-divider>
                            <v-text-field v-model="addUser.username" label="ชื่อผู้ใช้" density="compact"></v-text-field>
                            <v-text-field v-model="addUser.password" label="รหัสผ่าน" type="password" density="compact"></v-text-field>
                            <v-text-field v-model="addUser.cpassword" label="ยืนยันรหัสผ่าน" type="password" density="compact"></v-text-field>
                        </v-card-text>
                        <v-card-actions class="justify-center">
                            <v-btn color="red" variant="tonal" @click="addDialog = false">ยกเลิก</v-btn>
                            <v-btn color="green" variant="flat" type="submit">ยืนยัน</v-btn>
                        </v-card-actions>
                    </v-form>
                </v-card>
            </v-dialog>

            <!-- Dialog: รีเซตรหัสผ่าน -->
            <v-dialog v-model="resetDialog" max-width="500px">
                <v-card title="รีเซตรหัสผ่าน">
                    <v-form @submit.prevent="confirmPass">
                        <v-card-text>
                            <v-text-field v-model="selectedUser.username" label="ชื่อผู้ใช้" density="compact" disabled></v-text-field>
                            <v-divider class="my-2"></v-divider>
                            <v-text-field v-model="passForm.password" label="รหัสผ่านใหม่" type="password" density="compact"></v-text-field>
                            <v-text-field v-model="passForm.cpassword" label="ยืนยันรหัสผ่านใหม่" type="password" density="compact"></v-text-field>
                        </v-card-text>
                        <v-card-actions class="justify-center">
                            <v-btn color="red" variant="tonal" @click="resetDialog = false">ยกเลิก</v-btn>
                            <v-btn color="green" variant="flat" type="submit">ยืนยัน</v-btn>
                        </v-card-actions>
                    </v-form>
                </v-card>
            </v-dialog>

            <!-- Dialog: ดูข้อมูลเพิ่มเติม -->
            <v-dialog v-model="lookupDialog" max-width="500px">
                <v-card title="ดูข้อมูลเพิ่มเติม">
                    <v-card-text>
                        <v-text-field v-model="selectedUser.username" label="ชื่อผู้ใช้" density="compact" disabled></v-text-field>
                        <v-text-field v-model="selectedUser.fname" label="ชื่อ-สกุล" density="compact" disabled></v-text-field>
                        <v-select v-model="selectedUser.role" :items="selectRole" label="บทบาท" density="compact" disabled></v-select>
                        <v-text-field v-model="selectedUser.status" label="สถานะ" density="compact" disabled></v-text-field>
                    </v-card-text>
                    <v-card-actions class="justify-center">
                        <v-btn color="red" variant="tonal" @click="lookupDialog = false">ปิด</v-btn>
                    </v-card-actions>
                </v-card>
            </v-dialog>

            <!-- Dialog: แก้ไขข้อมูล -->
            <v-dialog v-model="editDialog" max-width="500px">
                <v-card title="แก้ไขข้อมูล">
                    <v-form @submit.prevent="editSave">
                        <v-card-text>
                            <v-text-field v-model="selectedUser.username" label="ชื่อผู้ใช้" density="compact" disabled></v-text-field>
                            <v-divider class="my-2"></v-divider>
                            <v-text-field v-model="selectedUser.fname" label="ชื่อ-สกุล" density="compact"></v-text-field>
                            <v-select v-model="selectedUser.role" :items="selectRole" label="บทบาท" density="compact"></v-select>
                            <v-select v-model="selectedUser.status" :items="selectStatus" label="สถานะ" density="compact"></v-select>
                        </v-card-text>
                        <v-card-actions class="justify-center">
                            <v-btn color="red" variant="tonal" @click="editDialog = false">ยกเลิก</v-btn>
                            <v-btn color="green" variant="flat" type="submit">ยืนยัน</v-btn>
                        </v-card-actions>
                    </v-form>
                </v-card>
            </v-dialog>
        </v-container>
    </div>
</template>

<script setup>
import axios from 'axios';

// ตั้งค่า Axios instance จุดเดียวจบ ไม่ต้องคอยใส่ Token และ baseURL ซ้ำๆ
const api = axios.create({
    baseURL: 'http://localhost:3001/api/users',
});
api.interceptors.request.use((config) => {
    config.headers.Authorization = `Bearer ${useCookie('token').value}`;
    return config;
});

// State
const tab = ref('evaluator');
const search = ref('');
const data = ref([]);

// Form & Dialog States
const addDialog = ref(false);
const resetDialog = ref(false);
const lookupDialog = ref(false);
const editDialog = ref(false);

const addUser = ref({});
const selectedUser = ref({});
const passForm = ref({});

// Constants
const selectStatus = ['newbie', 'suspend', 'active'];
const selectRole = [
    { title: 'กรรมการ', value: 'evaluator' },
    { title: 'ผู้รับการประเมิน', value: 'evaluatee' }
];
const header = [
    { title: 'ลำดับ', key: 'id' },
    { title: 'Username', key: 'username' },
    { title: 'ชื่อ-สกุล', key: 'fname' },
    { title: 'สถานะ', key: 'status' },
    { title: '#', key: 'action', sortable: false },
];
const chip = {
    active: { color: 'green' },
    suspend: { color: 'red' },
    newbie: { color: 'primary' }
};

// Functions
const fetchData = async (role) => {
    try {
        const res = await api.get(`/${role}`);
        data.value = res.data.data || [];
    } catch (error) {
        data.value = [];
    }
};

// รวมฟังก์ชันเปิด Dialog: รับ item มา copy ใส่ selectedUser ทันที
const openAction = (type, item) => {
    selectedUser.value = { ...item };
    if (type === 'view') lookupDialog.value = true;
    if (type === 'edit') editDialog.value = true;
    if (type === 'reset') {
        passForm.value = {};
        resetDialog.value = true;
    }
};

const addNewUser = async () => {
    if (addUser.value.password !== addUser.value.cpassword) return alert('Confirm Password Mismatch');
    try {
        await api.post('', addUser.value);
        alert('เพิ่มข้อมูลสำเร็จ');
        addDialog.value = false;
        fetchData(tab.value);
    } catch (error) {
        alert('เกิดข้อผิดพลาดในการเพิ่มข้อมูล');
    }
};

const dataDelete = async (id) => {
    if (!confirm('ยืนยันการลบข้อมูล')) return;
    try {
        await api.delete(`/${id}`);
        alert('ลบข้อมูลสำเร็จ');
        fetchData(tab.value);
    } catch (error) {
        alert('เกิดข้อผิดพลาดในการลบข้อมูล');
    }
};

const confirmPass = async () => {
    if (passForm.value.password !== passForm.value.cpassword) return alert('Confirm Password Mismatch');
    try {
        await api.put(`/reset/${selectedUser.value.id}`, { password: passForm.value.password });
        alert('รีเซตรหัสผ่านเรียบร้อย');
        resetDialog.value = false;
    } catch (error) {
        alert('เกิดข้อผิดพลาดในการรีเซตรหัสผ่าน');
    }
};

const editSave = async () => {
    try {
        const { fname, role, status } = selectedUser.value;
        await api.put(`/${selectedUser.value.id}`, { fname, role, status });
        alert('แก้ไขข้อมูลเรียบร้อยแล้ว');
        editDialog.value = false;
        fetchData(tab.value);
    } catch (error) {
        alert('เกิดข้อผิดพลาดในการแก้ไขข้อมูล');
    }
};

// Watch แท็บ: โหลดข้อมูลครั้งแรกทันที (immediate) และโหลดใหม่ทุกครั้งที่กดเปลี่ยนแท็บ
watch(tab, (newTab) => fetchData(newTab), { immediate: true });

definePageMeta({ layout: 'navbar' });
</script>