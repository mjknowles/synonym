<script setup lang="ts">
import { ref } from "vue";

const emit = defineEmits(["guessEntered"]);
const guess = ref("");

function guessEntered() {
  const word = guess.value.replace(" ", "");
  if (word == "") return;
  emit("guessEntered", word);
  guess.value = "";
}
</script>

<template>
  <label for="guess">Your Guess:</label>
  <input
    v-model="guess"
    placeholder="Press enter to submit"
    id="guess"
    @keydown.enter="guessEntered"
    class="guess-input"
  />
</template>

<style>
.guess-input {
  width: 10rem;
}
</style>
