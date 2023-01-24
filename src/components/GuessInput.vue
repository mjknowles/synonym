<script setup lang="ts">
import { ref } from "vue";

const emit = defineEmits(["guessEntered"]);
const answer = ref("");

function guessEntered() {
  emit("guessEntered", answer.value);
}
</script>

<template>
  Answer:
  <input
    v-model="answer"
    placeholder="Press enter to submit"
    @keyup.enter="guessEntered"
  />
</template>
