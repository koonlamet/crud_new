<template>
    <v-container>
        <div v-if="!onPrint" class="d-flex align-center justify-end ga-1">
            <v-btn icon="mdi-arrow-left" to="/evaluatee/topic"></v-btn>
            <v-spacer></v-spacer>
            <v-btn icon="mdi-eye" @click="viewComment"></v-btn>
            <v-btn icon="mdi-printer" @click="isPrint"></v-btn>
        </div>
        <div class="text-center">
            <div><h2>{{ indicator[0]?.topic_name }}</h2></div>
            <div><h5>{{ indicator[0]?.topic_desc }}</h5></div>  
            <div><h5>ผู้รับการประเมิน : {{ evaluatee[0]?.fname }}</h5></div>
        </div>
        <v-table>
            <thead>
                <th>ตัวชี้วัด</th>
                <th>น้ำหนัก</th>
                <th>คะแนนตนเอง</th>
                <th>คะแนนเฉลี่ยกรรมการ</th>
            </thead>
            <tbody>
                <tr v-for="item in indicator" :key="indicator_id">
                    <td>{{ item.indicator_desc }}</td>
                    <td class="text-center">{{ item.weight }}</td>
                    <td class="text-center">{{ item.self_score }}</td>
                    <td class="text-center">{{ item.avg_review }}</td>
                </tr>
                <tr>
                    <td></td>
                    <td class="text-center">รวม</td>
                    <td class="text-center">{{ avgselfscore }}</td>
                    <td class="text-center">{{ finalscore }}</td>
                </tr>
            </tbody>
        </v-table>

        <div class="mt-10 d-flex flex-column align-end">
            <div v-for="item in evaluator" :key="item.evaluator_id" class="d-flex mt-10">
                <span>ลงชื่อ</span>
                <div class="d-flex flex-column align-center ga-2" style="width: 200px;">
                    <div><img style="max-width: 100px; max-height: 70px;" :src="`http://localhost:3001/${item.signature_path}`" alt=""></div>
                    <div>({{ item.evaluator_name }})</div>
                </div>
                <span style="width: 130px;">{{item.committee_role}}</span>
            </div>
        </div>
        

        <v-dialog v-model="onComment" scrollable>
            <v-card append-icon="mdi-close" @click="onComment=!onComment">
                <div v-for="(item,index) in evaluator" class="pa-2">
                    <v-text-title>ความคิดเห็นกรรมการท่านที่ {{ index+1 }}</v-text-title>
                    <v-card-text>
                        <v-textarea v-model="item.comment" readonly></v-textarea>
                    </v-card-text>
                </div>
            </v-card>
        </v-dialog>
    </v-container>
</template>

<script setup>
import axios from 'axios';

const route = useRoute();
const topic_id = route.params.id;
const indicator = ref([]);
const evaluator = ref([]);
const evaluatee = ref([]);
const avgselfscore = ref('');
const finalscore = ref('');
const onPrint = ref(false);
const onComment = ref(false);

const isPrint = async ()=>{
    onPrint.value = true;
    await nextTick();
    window.print();
    onPrint.value = false;
}

const viewComment = async ()=>{
    onComment.value = true;
}

const getScore = async ()=>{
    try {
        const res = await axios.get(`http://localhost:3001/api/evaluatee/getscore/${topic_id}`,{
            headers:{
                Authorization:`Bearer ${useCookie('token').value}`
            }
    })
        console.log(res.data.data)
        indicator.value = res.data.data.indicator;
        evaluator.value = res.data.data.evaluator;
        evaluatee.value = res.data.data.evaluatee;
        avgselfscore.value = res.data.data.avgselfscore;
        finalscore.value = res.data.data.finalscore;
    } catch (error) {
        console.log(error)
        navigateTo('/evaluatee/topic')
    }
}

    onMounted(()=>{
        getScore();
    })

</script>