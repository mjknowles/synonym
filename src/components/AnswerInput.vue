<script setup lang="ts">
import { ref } from "vue";

const answer = ref("Enter a potential synonym");
</script>

<template>Answer: <input v-model="answer" /></template>
