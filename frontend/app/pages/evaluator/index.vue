<template>
    <v-container>
        <div v-if="!selectedTopic">
            <h3>#การประเมิน</h3>
            <v-data-table :items="topic" :headers="header">
                <template #item.status="{item}">
                    <v-chip :color="item.chip">{{ item.status }}</v-chip>
                </template>
                <template #item.total_assign="{item}">
                    {{ item.total_assign }} คน
                </template>
                <template #item.action="{item}">
                    <v-btn icon="mdi-eye" @click="selectedTopic = item.id;pageStep+=1"></v-btn>
                </template>
            </v-data-table>
        </div>

        <div v-else>
            <v-btn icon="mdi-arrow-left" @click="selectedTopic=null;pageStep-=1"></v-btn>
            <v-data-table :items="evaluatee" :headers="header_evaluatee">
                <template #item.action="{item}">
                    <v-btn icon="mdi-clipboard-edit-outline" @click="getScore(item.assignment_id)"></v-btn>
                </template>
            </v-data-table>
        </div>

    </v-container>
</template>

<script setup>
import axios from 'axios';
import Navbar from '~/layouts/navbar.vue';

definePageMeta({
    layout:'navbar'
})
const header = [
    {title:'หัวข้อ',key:'topic_name'},
    {title:'เวลาเริ่ม',key:'sdate'},
    {title:'เวลาสิ้นสุด',key:'edate'},
    {title:'สถานะ',key:'status'},
    {title:'จำนวนผู้รับการประเมิน',key:'total_assign'},
    {title:'#',key:'action'},
]

const header_evaluatee = [
    {title:'ชื่อผู้ใช้',key:'username'},
    {title:'ผู้รับการประเมิน',key:'fname'},
    {title:'#',key:'action'}
    
]
const topic = ref([]);
const selectedTopic = ref();
const evaluatee = ref([]);

const getTopic = async ()=>{
    try {
        const res = await axios.get(`http://localhost:3001/api/gettopic`,{
            headers:{
                Authorization:`Bearer ${useCookie('token').value}`
            }
        })
        topic.value = res.data.data
        console.log(topic.value)
    } catch (error) {
        console.log(error)
    }
}

const getEvaluatee = async (id)=>{
    try {
        const res = await axios.get(`http://localhost:3001/api/getevaluatee/${id}`,{
            headers:{
                Authorization:`Bearer ${useCookie('token').value}`
            }
        })
        evaluatee.value = res.data.data
        console.log(evaluatee.value)
    } catch (error) {
        console.log(error)
    }
}

const getScore = async (id)=>{
    try {
        const res = await axios.get(`http://localhost:3001/api/getscore/${id}`,{
            headers:{
                Authorization:`Bearer ${useCookie('token').value}`
            }
        })
        console.log(res.data.data)
    } catch (error) {
        console.log(error)
    }
}

onMounted(()=>{
    getTopic();
})
watch(selectedTopic , (id) =>{if(id)getEvaluatee(id)})
</script>
