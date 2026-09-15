<template>
    <v-container>
        {{ useCookie('user').value }}
    </v-container>
</template>

<script setup>
import Navbar from '~/layouts/navbar.vue';

definePageMeta({
    layout:'navbar'
})
</script>
