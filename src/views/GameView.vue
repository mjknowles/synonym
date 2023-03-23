<script setup lang="ts">
import { ref } from "vue";
import GuessInput from "@/components/GuessInput.vue";
import WordleKeyboard from "@/components/WordleKeyboard.vue";
import ScoreBoard from "@/components/ScoreBoard.vue";
import type { Synonym } from "@/components/synonym";

var lastGuess = ref("");
var wordInProgress = ref("");
var gameInProgress = ref(false);
const synonyms = ref<Synonym[]>([]);

function synonymsAcquired(syns: Synonym[]) {
  synonyms.value = syns;
}

function startGame() {
  gameInProgress.value = true;
}

function endGame() {
  gameInProgress.value = false;
}

function handleLetterSelection(letter: string) {
  if (!gameInProgress.value) return;
  wordInProgress.value += letter;
}

function handleLetterDeleted() {
  if (!gameInProgress.value || wordInProgress.value.length == 0) return;
  wordInProgress.value = wordInProgress.value.slice(
    0,
    wordInProgress.value.length - 1
  );
}

function handleSubmit() {
  if (!gameInProgress.value) return;
  lastGuess.value = wordInProgress.value;
  wordInProgress.value = "";
}
</script>

<template>
  <div class="outer-container">
    <div class="info-container">
      <h1>Guess the Synonyms</h1>
      <p>Guess as many synonyms as you can.</p>
      <ScoreBoard
        @end-game="endGame"
        @start-game="startGame"
        @synonyms-acquired="synonymsAcquired"
        :last-guess="lastGuess"
      />
      <GuessInput class="guess-input" :word-in-progress="wordInProgress" />
      <WordleKeyboard
        class="keyboard"
        @letter-selected="handleLetterSelection"
        @letter-deleted="handleLetterDeleted"
        @submit-pressed="handleSubmit"
      ></WordleKeyboard>
      <ul>
        <li
          v-for="synonym in synonyms"
          :key="synonym.word"
          :style="{ fontWeight: synonym.guessed ? 'normal' : 'bold' }"
        >
          {{
            synonym.guessed || !gameInProgress
              ? synonym.word
              : "-".repeat(synonym.word.length)
          }}
        </li>
      </ul>
    </div>
  </div>
</template>

<style>
.outer-container {
  position: relative;
  max-width: 960px;
  margin: auto;
  width: 100%;
  height: 100%;
}

.info-container {
  display: flex;
  flex-direction: column;
}

ul {
  display: flex;
  flex-wrap: wrap;
  list-style-type: none;
  gap: 1rem;
  margin: 1rem 0 0 0;
  padding: 0;
  justify-content: space-between;
}

.guess-input {
  box-sizing: border-box;
  margin-top: 1rem;
}

.keyboard {
  margin-top: 1rem;
}
</style>
