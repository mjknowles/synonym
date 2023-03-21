<script setup lang="ts">
import { onMounted, ref, watch } from "vue";
import { Stem } from "./stem";

const emit = defineEmits(["startNewGame", "endGame"]);
const props = defineProps(["possibleAnswers", "correctGuesses"]);

const stem = ref<Stem>({ word: "", functionalLabel: "" });
const possible = ref<number>(0);
const answered = ref<number>(0);

onMounted(async () => {
  await startNewGame();
});

watch(
  () => props.possibleAnswers,
  (possibleAnswers: number) => {
    possible.value = possibleAnswers;
  }
);

watch(
  () => props.correctGuesses,
  (correctGuesses: number) => {
    answered.value = correctGuesses;
  }
);

async function startNewGame() {
  stem.value = await getBaseWord();
  emit("startNewGame", stem.value);
}

async function endGame() {
  emit("endGame");
}

async function getBaseWord() {
  const stems = [
    new Stem("dog", "noun"),
    new Stem("house", "noun"),
    new Stem("nice", "adjective"),
    new Stem("good", "adjective"),
    new Stem("sleep", "verb"),
  ];
  return Promise.resolve(stems[Math.floor(Math.random() * stems.length)]);
}
</script>

<template>
  <div class="button-container">
    <button @click="startNewGame" class="game-button">New Game</button>
    <button @click="endGame" class="game-button">Reveal Answers</button>
  </div>
  <h2>
    Your word is: <b>{{ stem.word }}</b>
  </h2>
  <h3>
    Score:
    <b
      >{{ possible > 0 ? answered : "*" }}/{{
        possible > 0 ? possible : "*"
      }}</b
    >
  </h3>
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
