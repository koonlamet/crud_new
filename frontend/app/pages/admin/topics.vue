<template>
    <v-container>
        <h3>#การประเมิน</h3>
        <v-tabs v-model="tab">
            <v-tab value="topics">หัวข้อประเมิน</v-tab>
            <v-tab value="indicators">ตัวชี้วัด</v-tab>
            <v-tab value="assign">มอบหมายกรรมการ</v-tab>
        </v-tabs>
        <v-divider></v-divider>

        <v-tabs-window v-model="tab" class="mt-2">
            <v-tabs-window-item value="topics">
                <div class="d-flex ga-2 justify-end">
                    <v-btn color="primary" icon="mdi-plus" @click="addTopic=!addTopic"></v-btn>
                </div>
                <v-data-table :items="topic" :headers="headers_topic" density="comfortable" hover class="border rounded-lg">
                    <template #item.sdate="{item}">{{ item.sdate.split('T')[0] }}</template>
                    <template #item.edate="{item}">{{ item.edate.split('T')[0] }}</template>
                    <template #item.action="{item}">
                        <v-btn icon="mdi-pencil" color="primary" variant="outlined" @click="editTopic(item.id)"></v-btn>
                        <v-btn icon="mdi-delete" color="red" variant="outlined" @click="delTopic(item.id)"></v-btn>
                    </template>
                </v-data-table>
            </v-tabs-window-item>

            <v-tabs-window-item value="indicators">
                <div class="d-flex ga-2">
                    <v-select v-model="selectedTopic" :items="topic" item-title="topic_name" item-value="id" density="compact"></v-select>
                    <v-btn color="primary" icon="mdi-plus" @click="addIndicatorDialog = !addIndicatorDialog"></v-btn>
                </div>
                <v-data-table :items="indicator" :headers="headers_indicator">
                    <template #item.evidence_kind="{item}">
                        <v-chip v-for="e in item.evidence_kind" :key="e" size="small">{{ e }}</v-chip>
                    </template>
                    <template #item.action="{item}">
                        <v-btn icon="mdi-pencil" color="primary" variant="outlined" @click="editIndicator(item.id)"></v-btn>
                        <v-btn icon="mdi-delete" color="red" variant="outlined" @click="delIndicator(item.id)"></v-btn>
                    </template>
                </v-data-table>
            </v-tabs-window-item>

            <v-tabs-window-item value="assign">
                <div class="d-flex ga-2">
                    <v-select v-model="selectedTopic" :items="topic" item-title="topic_name" item-value="id" density="compact"></v-select>
                    <v-btn color="primary" icon="mdi-plus" @click="addAssignDialog = !addAssignDialog"></v-btn>
                </div>
                <v-data-table :items="assignment" :headers="headers_assignment">
                    <template #item.action="{item}">
                        <v-btn icon="mdi-pencil" color="primary" variant="outlined" @click="editIndicator(item.id)"></v-btn>
                        <v-btn icon="mdi-delete" color="red" variant="outlined" @click="delIndicator(item.id)"></v-btn>
                    </template>
                </v-data-table>
            </v-tabs-window-item>
        </v-tabs-window>

        <v-dialog v-model="addTopic" max-width="400px" width="100%">
            <v-card>
                <v-form @submit.prevent="addNewTopic">
                <v-card-title>เพิ่มหัวข้อประเมิน</v-card-title>
                <v-card-text>
                    <v-text-field v-model="newTopic.topic" label="หัวข้อประเมิน"></v-text-field>
                    <v-textarea v-model="newTopic.desc" label="คำอธิบาย"></v-textarea>
                    <div class="d-flex ga-2">
                        <v-text-field v-model="newTopic.sdate" type="date" label="วันเริ่ม"></v-text-field>
                        <v-text-field v-model="newTopic.edate" type="date" label="วันสิ้นสุด"></v-text-field>
                    </div>
                </v-card-text>
                <v-card-actions class="d-flex align-center justify-center">
                    <v-btn color="red" variant="outlined" @click="addTopic=!addTopic">ยกเลิก</v-btn>
                    <v-btn color="success" variant="elevated" type="submit">บันทึก</v-btn>
                </v-card-actions>
                </v-form>
            </v-card>
        </v-dialog>


        <v-dialog v-model="editTopicDialog" max-width="400px" width="100%">
            <v-card>
                <v-form @submit.prevent="editSaveTopic">
                <v-card-title>แก้ไขตัวชี้วัด</v-card-title>
                <v-card-text>
                    <v-text-field v-model="eTopic.topic_name" label="หัวข้อประเมิน"></v-text-field>
                    <v-textarea v-model="eTopic.description" label="คำอธิบาย"></v-textarea>
                    <div class="d-flex ga-2">
                        <v-text-field v-model="eTopic.sdate" type="date" label="วันเริ่ม"></v-text-field>
                        <v-text-field v-model="eTopic.edate" type="date" label="วันสิ้นสุด"></v-text-field>
                    </div>
                </v-card-text>
                <v-card-actions class="d-flex align-center justify-center">
                    <v-btn color="red" variant="outlined" @click="editTopicDialog=!editTopicDialog">ยกเลิก</v-btn>
                    <v-btn color="success" variant="elevated" type="submit">บันทึก</v-btn>
                </v-card-actions>
                </v-form>
            </v-card>
        </v-dialog>

        <v-dialog v-model="addIndicatorDialog" max-width="400px" width="100%">
            <v-card>
                <v-form @submit.prevent="addIndicator">
                <v-card-title>เพิ่มตัวชัดวัด</v-card-title>
                <v-card-text>
                    <v-text-field v-model="newIndicator.description" label="ตัวชี้วัด"></v-text-field>
                    <v-select label="ประเภท" v-model="newIndicator.type" :items="[{title:'1 ถึง 4 คะแนน',value:'1_4'},{title:'มี/ไม่มี',value:'yes_no'}]"></v-select>
                    <v-text-field v-model="newIndicator.weight" type="number" label="น้ำหนัก" v-if="newIndicator.type=='1_4'"></v-text-field>
                    <div class="d-flex">
                        <v-checkbox v-model="newIndicator.evidence_kind" label="PDF" value="PDF" hide-details></v-checkbox>
                        <v-checkbox v-model="newIndicator.evidence_kind" label="IMG" value="IMG" hide-details></v-checkbox>
                        <v-checkbox v-model="newIndicator.evidence_kind" label="URL" value="URL" hide-details></v-checkbox>
                    </div>
                    <v-file-input v-model="newIndicator_file" label="เลือกไฟแนบหลักฐาน" type="file" density="comfortable" multiple></v-file-input>
                    <v-text-field v-model="newIndicator.evidence_url" label="หลักฐาน URL" type="url" density="comfortable"></v-text-field>
                </v-card-text>
                <v-card-actions class="d-flex align-center justify-center">
                    <v-btn color="red" variant="outlined" @click="addIndicatorDialog=!addIndicatorDialog">ยกเลิก</v-btn>
                    <v-btn color="success" variant="elevated" type="submit">บันทึก</v-btn>
                </v-card-actions>
                </v-form>
            </v-card>
        </v-dialog>

        <v-dialog v-model="editIndicatorDialog" max-width="400px" width="100%">
            <v-card>
                <v-form @submit.prevent="sEditIndicator">
                <v-card-title>เพิ่มตัวชัดวัด</v-card-title>
                <v-card-text>
                    <v-text-field v-model="eIndicator.description" label="ตัวชี้วัด"></v-text-field>
                    <v-select label="ประเภท" v-model="eIndicator.type" :items="[{title:'1 ถึง 4 คะแนน',value:'1_4'},{title:'มี/ไม่มี',value:'yes_no'}]"></v-select>
                    <v-text-field v-model="eIndicator.weight" type="number" label="น้ำหนัก" v-if="eIndicator.type=='1_4'"></v-text-field>
                    <div class="d-flex">
                        <v-checkbox v-model="eIndicator.evidence_kind" label="PDF" value="PDF" hide-details></v-checkbox>
                        <v-checkbox v-model="eIndicator.evidence_kind" label="IMG" value="IMG" hide-details></v-checkbox>
                        <v-checkbox v-model="eIndicator.evidence_kind" label="URL" value="URL" hide-details></v-checkbox>
                    </div>
                    <v-chip v-for="(name,idx) in eIndicator.evidence_name" :key="idx" closable @click:close="eIndicator.evidence_name.splice(idx,1);eIndicator.evidence_path.splice(idx,1);">{{ name }}</v-chip>
                    <v-file-input class="mt-2" v-model="eIndicator_file" label="เลือกไฟแนบหลักฐาน" type="file" density="comfortable" multiple></v-file-input>
                    <v-text-field v-model="eIndicator.evidence_url" label="หลักฐาน URL" type="url" density="comfortable"></v-text-field>
                </v-card-text>
                <v-card-actions class="d-flex align-center justify-center">
                    <v-btn color="red" variant="outlined" @click="editIndicatorDialog=!editIndicatorDialog">ยกเลิก</v-btn>
                    <v-btn color="success" variant="elevated" type="submit">บันทึก</v-btn>
                </v-card-actions>
                </v-form>
            </v-card>
        </v-dialog>
    </v-container>
</template>

<script setup>
import axios from 'axios';
definePageMeta({
    layout:'navbar'
})

const newIndicator = ref({
    evidence_kind:[]
});

const evaluator = ref([]),evaluatee = ref([]);
const eIndicator = ref({});
const eIndicator_file = ref(null);
const newIndicator_file = ref(null);
const assignment = ref([]);
const indicator = ref([]);
const selectedTopic = ref();
const topic = ref([]);
const eTopic = ref([]);
const newTopic = ref({});
const addTopic = ref(false),editTopicDialog = ref(false),addIndicatorDialog = ref(false),editIndicatorDialog = ref(false),addAssignDialog=ref(false);
const tab = ref('topics');
const headers_topic = [
    {title:'หัวข้อประเมิน',key:'topic_name'},
    {title:'คำอธิบาย',key:'description'},
    {title:'วันเริ่ม',key:'sdate'},
    {title:'วันจบ',key:'edate'},
    {title:'#',key:'action'},
]

const headers_indicator = [
    {title:'ตัวชี้วัด',key:'description'},
    {title:'ประเภท',key:'type'},
    {title:'น้ำหนัก',key:'weight'},
    {title:'ประเภทหลักฐาน',key:'evidence_kind'},
    {title:'#',key:'action'},
]

const headers_assignment = [
    {title:'ผู้รับการประเมิน',key:'description'},
    {title:'กรรมการ',key:'type'},
    {title:'ตำแหน่ง',key:'committee_role'},
    {title:'#',key:'action'},
]


const addNewTopic = async() =>{
    try {
        const res = await axios.post('http://localhost:3001/api/topic',newTopic.value,{
            headers:{
                Authorization:`Bearer ${useCookie('token').value}`
            }
        })
        fetchData();
        addTopic.value = false;
        newTopic.value= {};
        alert(res.data.message)
    } catch (error) {
        console.log(error)
    }
}


const delTopic = async(c)=>{
    try {
        if(!confirm('ยืนยันการลบรายการ')){
            return
        }
        const res = await axios.delete(`http://localhost:3001/api/topic/${c}`,{
            headers:{
                Authorization:`Bearer ${useCookie('token').value}`
            }
        })
        alert(res.data.message)
        fetchData();
    } catch (error) {
        console.log(error)
    }
}

const fetchUser = async () =>{
    try {
        const res = await axios.get('http://localhost:3001/api/users',{
            headers:{
                Authorization:`Bearer ${useCookie('token').value}`
            }
        })
        console.log(res.data.data)
    } catch (error) {
        alert(error)
    }
}

const fetchData = async () =>{
    try {
        const res = await axios.get('http://localhost:3001/api/topic',{
            headers:{
                Authorization:`Bearer ${useCookie('token').value}`
            }
        })
        topic.value = res.data.data
        selectedTopic.value = topic.value[0].id || []
    } catch (error) {
        console.log(error)
    }
}

const fecthIndicator = async (topicid) =>{
    try {
        const res = await axios.get(`http://localhost:3001/api/indicator/${topicid}`,{
            headers:{
                Authorization:`Bearer ${useCookie('token').value}`
            } 
        })
        indicator.value = res.data.data || []
        console.log(indicator.value)
    } catch (error) {
        console.log(error)
    }
}

const editSaveTopic = async ()=>{
    console.log(eTopic.value.id)
    try {
        const res = await axios.put(`http://localhost:3001/api/topic/${eTopic.value.id}`,eTopic.value,{
            headers:{
                Authorization:`Bearer ${useCookie('token').value}`
            }
        })
        alert(res.data.message)
        fetchData();
        editTopicDialog.value = false;
    } catch (error) {
        console.log(error)
    }
}
const editTopic = async (c)=>{
    editTopicDialog.value = true;
    eTopic.value = {...topic.value.find((item) => item.id === c)};
    eTopic.value.sdate = eTopic.value.sdate.split('T')[0];
    eTopic.value.edate = eTopic.value.edate.split('T')[0];
}

const addIndicator = async ()=>{
    try {
        if(newIndicator.value.type=='yes_no'){
            newIndicator.value.weight=null;
        }
        const fd = new FormData();
        newIndicator.value = {topic_id:selectedTopic.value,...newIndicator.value};
        if(newIndicator_file.value){
            newIndicator_file.value.forEach(f => {fd.append('files',f)});
        }
        //fd.append('files',newIndicator_file.value);
        fd.append('data',JSON.stringify(newIndicator.value));
        const res = await axios.post('http://localhost:3001/api/indicator',fd,{
            headers:{
                Authorization:`Bearer ${useCookie('token').value}`
            }
        })
        alert('เพิ่มข้อมูลตัวชัดวัดสำเร็จ')
        fecthIndicator(selectedTopic.value);
        newIndicator.value = null;
        newIndicator_file = null;
        addIndicatorDialog.value = false;
    } catch (error) {
        alert('เกิดข้อผิดพลาด')
    }
}

const sEditIndicator = async () =>{
    try {
        if(eIndicator.value.type=='yes_no'){
            eIndicator.value.weight = null;
        }
        const fd = new FormData();
        eIndicator.value = {topic_id:selectedTopic.value,...eIndicator.value};
        if(eIndicator_file.value){
            eIndicator_file.value.forEach(f => {fd.append('files',f)});
        }
        fd.append('data',JSON.stringify(eIndicator.value));
        const res = await axios.put(`http://localhost:3001/api/indicator/${eIndicator.value.id}`,fd,{
            headers:{
                Authorization:`Bearer ${useCookie('token').value}`
            }
        })
        alert('แก้ไขตัวชี้วัดสำเร็จ');
        editIndicatorDialog.value = false;
        fecthIndicator(selectedTopic.value);
    } catch (error) {
        alert('เกิดข้อผิดพลาด');
    }
}

const editIndicator = async (c) =>{
    try {
        editIndicatorDialog.value = true;
        eIndicator.value = {...indicator.value.find(item => item.id === c)}
        console.log(eIndicator.value)
    } catch (error) {
        alert('เกิดข้อผิดพลาด');
    }
}

const delIndicator = async (c) =>{
    try {
        if(!confirm('คุณแน่ใจว่าต้องการลบตัวชี้วัดดังกล่าว')){
            return
        }
        const res = await axios.delete(`http://localhost:3001/api/indicator/${c}`,{
            headers:{
                Authorization:`Bearer ${useCookie('token').value}`
            }
        })
        alert('ลบตัวชี้วัดสำเร็จ');
        fecthIndicator(selectedTopic.value);
    } catch (error) {
        alert('เกิดข้อผิดพลาด');
    }
}

onMounted(()=>{
    fetchData();
    fetchUser();
})

watch(selectedTopic , (newId) => {if(newId){fecthIndicator(newId)}})
</script>
