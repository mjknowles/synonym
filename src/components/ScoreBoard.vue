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
  <div class="button-container">
    <button @click="startNewGame" class="game-button">New Game</button>
    <button @click="endGame" class="game-button">Reveal Answers</button>
  </div>
  <h2>
    Your word is: <b>{{ baseWord }}</b>
  </h2>
</template>

<style>
.button-container {
  display: flex;
  flex-direction: row;
  flex-flow: row wrap;
  padding: 0;
  margin: 0;
}

.game-button {
  width: 10rem; /* Or whatever */
}
</style>