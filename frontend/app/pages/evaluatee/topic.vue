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
                    <v-btn prepend-icon="mdi-pencil" color="success" v-if="item.status==='ดำเนินการ' && item.ans_count==0" @click="openEvaluation(item.id)">เริ่ม</v-btn>
                    <v-btn prepend-icon="mdi-pencil" color="info" v-if="item.status==='ดำเนินการ' && item.ans_count>0" @click="openEvaluation(item.id)">ทำต่อ / แก้ไข</v-btn>
                    <v-btn prepend-icon="mdi-eye" color="grey" v-if="item.status==='หมดเวลา'">ดูคะแนน</v-btn>
                </template>
            </v-data-table>
        </div>
        <div v-else>
            <h3># {{ ind[0].topic_name }}</h3>
            <h5>  {{ ind[0].topic_desc }}</h5>
            <v-data-table :items="ind" :headers="header_ind">
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
            </v-data-table>
            <v-btn @click="selectedTopic = null">ยกเลิก</v-btn>
        </div>
    </v-container>
</template>

<script setup>
import axios from 'axios';


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

const topic = ref([]);
const selectedTopic = ref(null)
const ind = ref([]);
const openEvaluation = async (id)=>{
    selectedTopic.value = id
    try {
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

onMounted(()=>{
    fetchTopic();
})
</script>