<template>
    <v-container>
        {{ data }}
    </v-container>
</template>

<script setup>
import axios from 'axios';

const route = useRoute();
const topic_id = route.params.id;
const data = ref();

const getScore = async ()=>{
    const res = await axios.get(`http://localhost:3001/api/evaluatee/getscore/${topic_id}`,{
        headers:{
            Authorization:`Bearer ${useCookie('token').value}`
        }
    })
    console.log(res.data.data)
    data.value = res.data.data
    }

    onMounted(()=>{
        getScore();
    })

</script>