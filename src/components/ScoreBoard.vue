<script setup lang="ts">
import { onMounted, ref } from "vue";

const emit = defineEmits(["startNewGame", "endGame"]);
const baseWord = ref<string>("");

onMounted(async () => {
  await startNewGame();
});

async function startNewGame() {
  baseWord.value = await getBaseWord();
  emit("startNewGame", baseWord.value);
}

async function endGame() {
  emit("endGame");
}

async function getBaseWord() {
  const words = ["dog", "house", "nice", "good", "sleep"];
  return Promise.resolve(words[Math.floor(Math.random() * words.length)]);
}
</script>

<template>
  <button @click="startNewGame">New Game</button>
  <button @click="endGame">Reveal Answers</button>
  <h2>
    Your word is: <b>{{ baseWord }}</b>
  </h2>
</template>
