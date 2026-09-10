<template>
    <v-container>
        <h3>#การประเมิน</h3>
        <v-tabs v-model="tab" color="primary">
            <v-tab value="topics">หัวข้อประเมิน</v-tab>
            <v-tab value="indicators">ตัวชี้วัด</v-tab>
            <v-tab value="assign">มอบหมายกรรมการ</v-tab>
        </v-tabs>
        <v-divider class="mb-4"></v-divider>

        <v-tabs-window v-model="tab">
            <!-- แท็บ 1: หัวข้อประเมิน -->
            <v-tabs-window-item value="topics">
                <div class="d-flex justify-end mb-2">
                    <v-btn color="primary" prepend-icon="mdi-plus" @click="openTopicDialog()">เพิ่มหัวข้อ</v-btn>
                </div>
                <v-data-table :items="topics" :headers="headersTopic" hover class="border rounded-lg">
                    <template #item.sdate="{ item }">{{ formatDate(item.sdate) }}</template>
                    <template #item.edate="{ item }">{{ formatDate(item.edate) }}</template>
                    <template #item.action="{ item }">
                        <v-btn icon="mdi-pencil" size="small" variant="text" color="primary" @click="openTopicDialog(item)"></v-btn>
                        <v-btn icon="mdi-delete" size="small" variant="text" color="red" @click="deleteTopic(item.id)"></v-btn>
                    </template>
                </v-data-table>
            </v-tabs-window-item>

            <!-- แท็บ 2: ตัวชี้วัด -->
            <v-tabs-window-item value="indicators">
                <div class="d-flex ga-2 mb-2">
                    <v-select v-model="selectedTopic" :items="topics" item-title="topic_name" item-value="id" density="compact" label="เลือกหัวข้อประเมิน" hide-details></v-select>
                    <v-btn color="primary" prepend-icon="mdi-plus" @click="openIndicatorDialog()">เพิ่มตัวชี้วัด</v-btn>
                </div>
                <v-data-table :items="indicators" :headers="headersIndicator" hover class="border rounded-lg">
                    <template #item.evidence_kind="{ item }">
                        <v-chip v-for="e in item.evidence_kind" :key="e" size="small" class="mr-1">{{ e }}</v-chip>
                    </template>
                    <template #item.action="{ item }">
                        <v-btn icon="mdi-pencil" size="small" variant="text" color="primary" @click="openIndicatorDialog(item)"></v-btn>
                        <v-btn icon="mdi-delete" size="small" variant="text" color="red" @click="deleteIndicator(item.id)"></v-btn>
                    </template>
                </v-data-table>
            </v-tabs-window-item>

            <!-- แท็บ 3: มอบหมายกรรมการ -->
            <v-tabs-window-item value="assign">
                <div class="d-flex ga-2 mb-2">
                    <v-select v-model="selectedTopic" :items="topics" item-title="topic_name" item-value="id" density="compact" label="เลือกหัวข้อประเมิน" hide-details></v-select>
                    <v-btn color="primary" prepend-icon="mdi-plus" @click="openAssignDialog()">มอบหมายกรรมการ</v-btn>
                </div>
                <v-data-table :items="assignments" :headers="headersAssignment" hover class="border rounded-lg">
                    <template #item.evaluatee="{ item, index }">
                        <span v-if="index === 0 || assignments[index - 1].evaluatee !== item.evaluatee">{{ item.evaluatee }}</span>
                    </template>
                    <template #item.committee_role="{ item }">
                        <v-chip size="small" :color="item.committee_role === 'chair' ? 'indigo' : 'default'">
                            {{ item.committee_role === 'chair' ? 'ประธานกรรมการ' : 'กรรมการ' }}
                        </v-chip>
                    </template>
                    <template #item.action="{ item }">
                        <v-btn icon="mdi-pencil" size="small" variant="text" color="primary" @click="openAssignDialog(item)"></v-btn>
                        <v-btn icon="mdi-delete" size="small" variant="text" color="red" @click="deleteAssign(item.id)"></v-btn>
                    </template>
                </v-data-table>
            </v-tabs-window-item>
        </v-tabs-window>

        <!-- Dialog 1: เพิ่ม/แก้ไขหัวข้อประเมิน (ยุบรวมจาก 2 dialogs) -->
        <v-dialog v-model="topicDialog" max-width="450px">
            <v-card :title="formTopic.id ? 'แก้ไขหัวข้อประเมิน' : 'เพิ่มหัวข้อประเมิน'">
                <v-form @submit.prevent="saveTopic">
                    <v-card-text>
                        <v-text-field v-model="formTopic.topic_name" label="หัวข้อประเมิน" density="compact" required></v-text-field>
                        <v-textarea v-model="formTopic.description" label="คำอธิบาย" density="compact" rows="3"></v-textarea>
                        <div class="d-flex ga-2">
                            <v-text-field v-model="formTopic.sdate" type="date" label="วันเริ่ม" density="compact"></v-text-field>
                            <v-text-field v-model="formTopic.edate" type="date" label="วันสิ้นสุด" density="compact"></v-text-field>
                        </div>
                    </v-card-text>
                    <v-card-actions class="justify-center">
                        <v-btn color="red" variant="tonal" @click="topicDialog = false">ยกเลิก</v-btn>
                        <v-btn color="success" variant="flat" type="submit">บันทึก</v-btn>
                    </v-card-actions>
                </v-form>
            </v-card>
        </v-dialog>

        <!-- Dialog 2: เพิ่ม/แก้ไขตัวชี้วัด (ยุบรวมจาก 2 dialogs) -->
        <v-dialog v-model="indicatorDialog" max-width="450px">
            <v-card :title="formIndicator.id ? 'แก้ไขตัวชี้วัด' : 'เพิ่มตัวชี้วัด'">
                <v-form @submit.prevent="saveIndicator">
                    <v-card-text>
                        <v-text-field v-model="formIndicator.description" label="ตัวชี้วัด" density="compact" required></v-text-field>
                        <v-select v-model="formIndicator.type" label="ประเภท" :items="indicatorTypes" density="compact"></v-select>
                        <v-text-field v-if="formIndicator.type === '1_4'" v-model="formIndicator.weight" type="number" label="น้ำหนัก" density="compact"></v-text-field>
                        <div class="d-flex mb-2">
                            <v-checkbox v-model="formIndicator.evidence_kind" label="PDF" value="PDF" density="compact" hide-details></v-checkbox>
                            <v-checkbox v-model="formIndicator.evidence_kind" label="IMG" value="IMG" density="compact" hide-details></v-checkbox>
                            <v-checkbox v-model="formIndicator.evidence_kind" label="URL" value="URL" density="compact" hide-details></v-checkbox>
                        </div>
                        <div v-if="formIndicator.evidence_name?.length" class="mb-2">
                            <v-chip v-for="(name, idx) in formIndicator.evidence_name" :key="idx" closable size="small" class="mr-1 mb-1" @click:close="removeEvidenceFile(idx)">
                                {{ name }}
                            </v-chip>
                        </div>
                        <v-file-input v-model="formIndicatorFiles" label="เลือกไฟล์แนบหลักฐาน" density="compact" multiple></v-file-input>
                        <v-text-field v-model="formIndicator.evidence_url" label="หลักฐาน URL" type="url" density="compact"></v-text-field>
                    </v-card-text>
                    <v-card-actions class="justify-center">
                        <v-btn color="red" variant="tonal" @click="indicatorDialog = false">ยกเลิก</v-btn>
                        <v-btn color="success" variant="flat" type="submit">บันทึก</v-btn>
                    </v-card-actions>
                </v-form>
            </v-card>
        </v-dialog>

        <!-- Dialog 3: เพิ่ม/แก้ไขการมอบหมายกรรมการ (ยุบรวมจาก 2 dialogs) -->
        <v-dialog v-model="assignDialog" max-width="450px">
            <v-card :title="formAssign.id ? 'แก้ไขการมอบหมายกรรมการ' : 'มอบหมายกรรมการ'">
                <v-form @submit.prevent="saveAssign">
                    <v-card-text>
                        <v-select v-model="formAssign.topic_id" :items="topics" item-title="topic_name" item-value="id" label="หัวข้อประเมิน" density="compact"></v-select>
                        <v-select v-model="formAssign.evaluator_id" :items="evaluators" item-title="fname" item-value="id" label="กรรมการ" density="compact"></v-select>
                        <v-select v-model="formAssign.evaluatee_id" :items="evaluatees" item-title="fname" item-value="id" label="ผู้รับการประเมิน" density="compact"></v-select>
                        <v-select v-model="formAssign.committee_role" :items="committeeRoles" label="บทบาท" density="compact"></v-select>
                    </v-card-text>
                    <v-card-actions class="justify-center">
                        <v-btn color="red" variant="tonal" @click="assignDialog = false">ยกเลิก</v-btn>
                        <v-btn color="success" variant="flat" type="submit">บันทึก</v-btn>
                    </v-card-actions>
                </v-form>
            </v-card>
        </v-dialog>
    </v-container>
</template>

<script setup>
import axios from 'axios';

definePageMeta({ layout: 'navbar' });

// 1. สร้าง Axios instance กำหนด baseURL และ Header กลางที่จุดเดียว
const api = axios.create({ baseURL: 'http://localhost:3001/api' });
api.interceptors.request.use((config) => {
    config.headers.Authorization = `Bearer ${useCookie('token').value}`;
    return config;
});

// 2. State & Constants
const tab = ref('topics');
const selectedTopic = ref(null);
const topics = ref([]);
const indicators = ref([]);
const assignments = ref([]);
const evaluators = ref([]);
const evaluatees = ref([]);

// Dialog visibility & Form models
const topicDialog = ref(false);
const indicatorDialog = ref(false);
const assignDialog = ref(false);

const formTopic = ref({});
const formIndicator = ref({ evidence_kind: [] });
const formIndicatorFiles = ref(null);
const formAssign = ref({});

const indicatorTypes = [
    { title: '1 ถึง 4 คะแนน', value: '1_4' },
    { title: 'มี/ไม่มี', value: 'yes_no' }
];

const committeeRoles = [
    { title: 'ประธานกรรมการ', value: 'chair' },
    { title: 'กรรมการ', value: 'member' }
];

const headersTopic = [
    { title: 'หัวข้อประเมิน', key: 'topic_name' },
    { title: 'คำอธิบาย', key: 'description' },
    { title: 'วันเริ่ม', key: 'sdate' },
    { title: 'วันจบ', key: 'edate' },
    { title: '#', key: 'action', sortable: false }
];

const headersIndicator = [
    { title: 'ตัวชี้วัด', key: 'description' },
    { title: 'ประเภท', key: 'type' },
    { title: 'น้ำหนัก', key: 'weight' },
    { title: 'ประเภทหลักฐาน', key: 'evidence_kind' },
    { title: '#', key: 'action', sortable: false }
];

const headersAssignment = [
    { title: 'ผู้รับการประเมิน', key: 'evaluatee' },
    { title: 'กรรมการ', key: 'evaluator' },
    { title: 'ตำแหน่ง', key: 'committee_role' },
    { title: '#', key: 'action', sortable: false }
];

const formatDate = (val) => (val ? val.split('T')[0] : '');

// 3. Data Fetching
const fetchTopics = async () => {
    try {
        const res = await api.get('/topic');
        topics.value = res.data.data || [];
        if (topics.value.length && !selectedTopic.value) {
            selectedTopic.value = topics.value[0].id;
        }
    } catch (error) {
        console.error(error);
    }
};

const fetchUsers = async () => {
    try {
        const res = await api.get('/users');
        const allUsers = res.data.data || [];
        evaluators.value = allUsers.filter(u => u.role === 'evaluator');
        evaluatees.value = allUsers.filter(u => u.role === 'evaluatee');
    } catch (error) {
        console.error(error);
    }
};

const fetchIndicators = async (topicId) => {
    if (!topicId) return;
    try {
        const res = await api.get(`/indicator/${topicId}`);
        indicators.value = res.data.data || [];
    } catch (error) {
        console.error(error);
    }
};

const fetchAssignments = async (topicId) => {
    if (!topicId) return;
    try {
        const res = await api.get(`/assignment/${topicId}`);
        assignments.value = res.data.data || [];
    } catch (error) {
        console.error(error);
    }
};

// 4. Dialog Openers (กำหนดค่าตั้งต้นให้ form)
const openTopicDialog = (item = null) => {
    formTopic.value = item
        ? { ...item, sdate: formatDate(item.sdate), edate: formatDate(item.edate) }
        : {};
    topicDialog.value = true;
};

const openIndicatorDialog = (item = null) => {
    formIndicatorFiles.value = null;
    formIndicator.value = item
        ? { ...item, evidence_kind: item.evidence_kind ? [...item.evidence_kind] : [] }
        : { evidence_kind: [], type: '1_4' };
    indicatorDialog.value = true;
};

const removeEvidenceFile = (idx) => {
    formIndicator.value.evidence_name.splice(idx, 1);
    formIndicator.value.evidence_path.splice(idx, 1);
};

const openAssignDialog = (item = null) => {
    formAssign.value = item
        ? {
            id: item.id,
            topic_id: item.topic_id || selectedTopic.value,
            evaluator_id: item.evaluator_id,
            evaluatee_id: item.evaluatee_id,
            committee_role: item.committee_role || 'member'
        }
        : {
            topic_id: selectedTopic.value,
            evaluator_id: null,
            evaluatee_id: null,
            committee_role: 'member'
        };
    assignDialog.value = true;
};

// 5. Save & Delete Actions
// --- Topic ---
const saveTopic = async () => {
    try {
        const isEdit = !!formTopic.value.id;
        const res = isEdit
            ? await api.put(`/topic/${formTopic.value.id}`, formTopic.value)
            : await api.post('/topic', formTopic.value);

        alert(res.data.message || (isEdit ? 'แก้ไขหัวข้อสำเร็จ' : 'เพิ่มหัวข้อสำเร็จ'));
        topicDialog.value = false;
        fetchTopics();
    } catch (error) {
        alert(error.response?.data?.message || 'เกิดข้อผิดพลาด');
    }
};

const deleteTopic = async (id) => {
    if (!confirm('ยืนยันการลบรายการ')) return;
    try {
        const res = await api.delete(`/topic/${id}`);
        alert(res.data.message || 'ลบรายการสำเร็จ');
        fetchTopics();
    } catch (error) {
        alert(error.response?.data?.message || 'เกิดข้อผิดพลาด');
    }
};

// --- Indicator ---
const saveIndicator = async () => {
    try {
        const fd = new FormData();
        const payload = { ...formIndicator.value, topic_id: selectedTopic.value };
        if (payload.type === 'yes_no') payload.weight = null;

        if (formIndicatorFiles.value) {
            formIndicatorFiles.value.forEach(f => fd.append('files', f));
        }
        fd.append('data', JSON.stringify(payload));

        const isEdit = !!formIndicator.value.id;
        if (isEdit) {
            await api.put(`/indicator/${formIndicator.value.id}`, fd);
        } else {
            await api.post('/indicator', fd);
        }

        alert(isEdit ? 'แก้ไขตัวชี้วัดสำเร็จ' : 'เพิ่มข้อมูลตัวชี้วัดสำเร็จ');
        indicatorDialog.value = false;
        fetchIndicators(selectedTopic.value);
    } catch (error) {
        alert(error.response?.data?.message || 'เกิดข้อผิดพลาด');
    }
};

const deleteIndicator = async (id) => {
    if (!confirm('คุณแน่ใจว่าต้องการลบตัวชี้วัดดังกล่าว')) return;
    try {
        await api.delete(`/indicator/${id}`);
        alert('ลบตัวชี้วัดสำเร็จ');
        fetchIndicators(selectedTopic.value);
    } catch (error) {
        alert(error.response?.data?.message || 'เกิดข้อผิดพลาด');
    }
};

// --- Assignment ---
const saveAssign = async () => {
    try {
        const isEdit = !!formAssign.value.id;
        const payload = {
            id: formAssign.value.topic_id || selectedTopic.value,
            topic_id: formAssign.value.topic_id || selectedTopic.value,
            evaluator: formAssign.value.evaluator_id,
            evaluator_id: formAssign.value.evaluator_id,
            evaluatee: formAssign.value.evaluatee_id,
            evaluatee_id: formAssign.value.evaluatee_id,
            committee_role: formAssign.value.committee_role
        };

        const res = isEdit
            ? await api.put(`/assignment/${formAssign.value.id}`, payload)
            : await api.post('/assignment', payload);

        alert(res.data.message || (isEdit ? 'แก้ไขการมอบหมายสำเร็จ' : 'มอบหมายกรรมการสำเร็จ'));
        assignDialog.value = false;
        fetchAssignments(selectedTopic.value);
    } catch (error) {
        alert(error.response?.data?.message || 'เกิดข้อผิดพลาด');
    }
};

const deleteAssign = async (id) => {
    if (!confirm('ต้องการลบรายการนี้หรือไม่')) return;
    try {
        await api.delete(`/assignment/${id}`);
        fetchAssignments(selectedTopic.value);
    } catch (error) {
        alert(error.response?.data?.message || 'เกิดข้อผิดพลาด');
    }
};

// 6. Watchers & Lifecycle
watch(selectedTopic, (newId) => {
    if (newId) {
        fetchIndicators(newId);
        fetchAssignments(newId);
    }
});

onMounted(() => {
    fetchTopics();
    fetchUsers();
});
</script>
