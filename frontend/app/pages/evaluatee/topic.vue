<template>
    <v-container>
        <div v-if="!selectedTopic">
            <h3>#การประเมิน</h3>
            <v-data-table :items="topic" :headers="header">
                <template #item.status="{item}">
                    <v-chip :color="item.chip">{{ item.status }}</v-chip>
                </template>
                <template #item.progress="{item}">
                    <v-progress-linear rounded="lg" color="success" :model-value="100*(item.ans_count/item.indi_count)" height="15">{{ item.ans_count }} / {{ item.indi_count }}</v-progress-linear>
                </template>
                <template #item.action="{item}">
                    <v-btn icon="mdi-pencil" color="success" v-if="item.status==='ดำเนินการ' && item.ans_count==0" @click="openEvaluation(item.id)"></v-btn>
                    <v-btn icon="mdi-clipboard-edit-outline" color="info" v-if="item.status==='ดำเนินการ' && item.ans_count>0" @click="openEvaluation(item.id)"></v-btn>
                    <v-btn icon="mdi-eye" color="grey" v-if="item.status==='หมดเวลา'" :to="`/evaluatee/${item.id}`"></v-btn>
                </template>
            </v-data-table>
        </div>
        <div v-else>
            <h3># {{ ind[0]?.topic_name }}</h3>
            <h5>  {{ ind[0]?.topic_desc }}</h5>
            <v-data-table :items="ind" :headers="header_ind">
                <template #item.weight="{item}">
                    {{ item.type=='1_4'?item.weight:'-' }}
                </template>
                <template #item.self_score="{item}">
                    {{displayScore(item)}}
                </template>
                <template #item.type="{item}">
                    {{ item.type==='1_4'? 'คะแนน':'มี/ไม่มี' }}
                </template>
                <template #item.files="{item}">
                    <div v-if="item.files && item.files.length>0">
                        <v-chip v-for="file in item.files" :key="file.id"><a :href="`http://localhost:3001/${file.file_path}`" class="text-black text-decoration-none">{{ file.file_name }}</a></v-chip>
                    </div>
                </template>
                <template #item.status="{item}">
                    <v-chip  :color="item.self_score==null? 'red':'green'">{{ item.self_score == null ? 'ยังไม่ตอบ':'ตอบแล้ว'}}</v-chip>
                </template>
                <template #item.action="{item}">
                    <v-btn icon="mdi-clipboard-edit-outline" @click="openIndicator(item)"></v-btn>
                </template>
            </v-data-table>
            <v-btn @click="selectedTopic = null" icon="mdi-arrow-left"></v-btn>
        </div>

        <v-dialog v-model="openIndicatorDialog" max-width="600px" scrollable>
            <v-card>
                <v-card-title class="text-warp">
                    {{ indicator_data.indicator_desc }}
                </v-card-title>
                <v-card-text>
                    <v-select v-if="indicator_data.type=='1_4'" v-model="indicator_data.self_score" :items="[1,2,3,4]" label="เลือกคะแนน 1-4"></v-select>
                    <v-select v-if="indicator_data.type=='yes_no'" v-model="indicator_data.self_score" :items="[{title:'มี',value:1},{title:'ไม่มี',value:0}]" item-title="title" item-value="value" label="มี/ไม่มี"></v-select>
                    <div v-if="indicator_data.files && indicator_data.files.length>0">
                        <v-chip closable @click:close="removeFile(index,file.id)" v-for="(file,index) in indicator_data.files" :key="file.id">{{ file.file_name }}</v-chip>
                    </div>
                    <v-file-input v-model="newFile" type="file" multiple label="เลือกไฟล์หลักฐานเพิ่มเติม PDF,รูปภาพ" class="mt-2"></v-file-input>
                    <div v-for="(item , index) in details">
                        <v-text-field   v-model="details[index]" 
                                        :label="`รายละเอียดที่ ${index+1}`"
                                        append-inner-icon="mdi-close "
                                        @click:append-inner="details.splice(index,1)"
                        ></v-text-field>
                    </div>
                    <div class="d-flex align-center justify-end">
                        <v-btn @click="details.push('')" icon="mdi-plus"></v-btn>
                    </div>
                    <v-divider class="mt-2"></v-divider>
                    <div class="mt-2 d-flex align-center justify-center ga-2">
                        <v-btn @click="openIndicatorDialog = !openIndicatorDialog">ยกเลิก</v-btn>
                        <v-btn @click="saveIndicator">บันทึก</v-btn>
                    </div>
                </v-card-text>
            </v-card>
        </v-dialog>
    </v-container>
</template>

<script setup>
import axios from 'axios';
import { id } from 'vuetify/locale';


definePageMeta({
    layout:'navbar'
})

const header_ind = [
    {title:'ตัวชี้วัด',key:'indicator_desc'},
    {title:'น้ำหนัก',key:'weight'},
    {title:'คะแนนตนเอง',key:'self_score'},
    {title:'ประเภท',key:'type'},
    {title:'หลักฐาน',key:'files'},
    {title:'สถานะ',key:'status'},
    {title:'#',key:'action'},
]
const header = [
    {title:'หัวข้อประเมิน',key:'topic_name'},
    {title:'ความก้าวหน้า',key:'progress'},
    {title:'เวลาเริ่มต้น',key:'sdate'},
    {title:'เวลาสิ้นสุด',key:'edate'},
    {title:'สถานะ',key:'status'},
    {title:'#',key:'action'},
]

const details = ref([]);
const deleteFile = ref([]);
const newFile = ref([]);
const topic = ref([]);
const selectedTopic = ref(null);
const ind = ref([]);
const indicator_data = ref({});
const openIndicatorDialog = ref(false);

const openEvaluation = async (id)=>{

    try {
        selectedTopic.value = id
        const res = await axios.get(`http://localhost:3001/api/evaluatee/indicator/${selectedTopic.value}`,{
            headers:{
                Authorization:`Bearer ${useCookie('token').value}`
            }
        })
        console.log(res.data.data)
        ind.value = res.data.data
    } catch (error) {
        console.log(error)
    }

}
const fetchTopic = async () =>{
    try {
        const today = new Date().toLocaleDateString('en-CA'); 
        const res = await axios.get(`http://localhost:3001/api/evaluatee/topic`,{
            headers:{
                Authorization:`Bearer ${useCookie('token').value}`
            }
        })
        topic.value = res.data.data
        topic.value.forEach(item => {
            item.sdate = item.sdate.split('T')[0],
            item.edate = item.edate.split('T')[0]

           
                if(today<item.sdate){
                    item.status = 'ยังไม่เริ่ม'
                    item.chip = 'warning'
                }else if(today>item.edate){
                    item.status = 'หมดเวลา'
                    item.chip = 'grey'
                }else{
                    item.status = 'ดำเนินการ'
                    item.chip = 'success'
                }
            
        })
        console.log(topic.value)
    } catch (error) {
        console.log('error')
       // console.log(error.response?.data?.message)
    }
}

const displayScore = (item)=>{
    if(!item.self_score) return '-';
    if(item.type==='yes_no'){
        return item.self_score == 1 ? 'มี':'ไม่มี';
    }
    return item.self_score;
}

const openIndicator = (c) =>{
    try {
        deleteFile.value = [];
        openIndicatorDialog.value = true;
        newFile.value = [];
        indicator_data.value = JSON.parse(JSON.stringify(c))
        details.value = JSON.parse(indicator_data.value.evidence_detail || [''])
        if(indicator_data.value.self_score!=null){
            indicator_data.value.self_score = Number(indicator_data.value.self_score)
        }
        console.log(indicator_data.value)
    } catch (error) {
        console.log(error)
    }
}


const removeFile = (index , fileId)=>{
    indicator_data.value.files.splice(index,1)
    if(fileId){
        deleteFile.value.push(fileId)
    }

    console.log(deleteFile.value)
}


const saveIndicator = async () =>{
    try {
        const fd = new FormData();
        fd.append('topic_id',indicator_data.value.topic_id);
        fd.append('evidence_id',indicator_data.value.evidence_id);
        fd.append('indicator_id',indicator_data.value.indicator_id);
        fd.append('self_score',indicator_data.value.self_score)
        fd.append('deleteFile',JSON.stringify(deleteFile.value));
        fd.append('detail',JSON.stringify(details.value));

        if(newFile.value && newFile.value.length>0){
            newFile.value.forEach(file =>{fd.append('files',file)
            })
        }

        const res = await axios.post(`http://localhost:3001/api/evaluatee/evidence`,fd,{
            headers:{
                Authorization:`Bearer ${useCookie('token').value}`
            }
        })
        console.log(res.data)
        openEvaluation(selectedTopic.value)
        openIndicatorDialog.value = false
        indicator_data.value = {};
        details.value = [];
        alert(res.data.message)
    } catch (error) {
        console.log(error)
    }
} 

onMounted(()=>{
    fetchTopic();
})
</script>