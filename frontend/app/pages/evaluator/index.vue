<template>
    <div>
        {{ useCookie('user')}}
    </div>
</template>

<script setup>
import Navbar from '~/layouts/navbar.vue';

definePageMeta({
    layout:'navbar'
})
</script>
