<script setup lang="ts">
import { ref } from "vue";

const emit = defineEmits(["guessEntered"]);
const guess = ref("");

function guessEntered() {
  let word = guess.value.replace(" ", "");
  word = word.toLocaleLowerCase();
  if (word == "") return;
  emit("guessEntered", word);
  guess.value = "";
}
</script>

<template>
  <div>
    <input
      v-model="guess"
      placeholder="Press enter to submit"
      id="guess"
      @keyup.enter="guessEntered"
      class="guess-input"
    />
  </div>
</template>

<style>
.guess-input {
  font-size: 24px;
  box-sizing: border-box;
  width: 100%;
}
</style>
