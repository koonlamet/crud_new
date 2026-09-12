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
                <v-btn prepend-icon="mdi-pencil" color="success" v-if="item.status==='ดำเนินการ' && item.ans_count==0">เริ่ม</v-btn>
                <v-btn prepend-icon="mdi-pencil" color="warning" v-if="item.status==='ดำเนินการ' && item.ans_count>0"  >แก้ไข</v-btn>
                <v-btn prepend-icon="mdi-eye" color="grey" v-if="item.status==='หมดเวลา'">ดูคะแนน</v-btn>
            </template>
        </v-data-table>
        </div>
    </v-container>
</template>

<script setup>
import axios from 'axios';


definePageMeta({
    layout:'navbar'
})

const header = [
    {title:'หัวข้อประเมิน',key:'topic_name'},
    {title:'รายละเอียด',key:'description'},
    {title:'ความก้าวหน้า',key:'progress'},
    {title:'เวลาเริ่มต้น',key:'sdate'},
    {title:'เวลาสิ้นสุด',key:'edate'},
    {title:'สถานะ',key:'status'},
    {title:'#',key:'action'},
]

const topic = ref([]);
const selectedTopic = ref(null)
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

onMounted(()=>{
    fetchTopic();
})
</script>