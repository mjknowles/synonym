<script setup lang="ts">
import { ref } from "vue";
import GuessInput from "@/components/GuessInput.vue";
import ScoreBoard from "@/components/ScoreBoard.vue";
import type { Synonym } from "@/components/synonym";

var lastGuess = ref("");
var gameInProgress = ref(false);
const synonyms = ref<Synonym[]>([]);

function updateLastGuess(guess: string) {
  if (!gameInProgress.value) return;
  lastGuess.value = guess;
}

function synonymsAcquired(syns: Synonym[]) {
  synonyms.value = syns;
}

function startGame() {
  gameInProgress.value = true;
}

function endGame() {
  gameInProgress.value = false;
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
    <GuessInput class="guess-input" @guess-entered="updateLastGuess" />
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
  margin: 0;
  padding: 0;
  justify-content: space-between;
}

.guess-input {
  position: absolute;
  bottom: 0px;
  width: 100%;
  box-sizing: border-box;
}
</style>
