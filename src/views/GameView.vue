<script setup lang="ts">
import SynonymList from "@/components/SynonymList.vue";
import { ref } from "vue";
import GuessInput from "@/components/GuessInput.vue";
import ScoreBoard from "@/components/ScoreBoard.vue";

var lastGuess = ref("");
var baseWord = ref("");
var gameInProgress = ref(false);

function updateLastGuess(guess: string) {
  alert(`guess received: ${guess}, gameInProgress: ${gameInProgress.value}`);
  if (!gameInProgress.value) return;
  lastGuess.value = guess;
}

function startGame(base: string) {
  gameInProgress.value = true;
  baseWord.value = base;
}

function endGame() {
  gameInProgress.value = false;
}
</script>

<template>
  <div class="container">
    <h1>Guess the Synonyms</h1>
    <p>Guess as many synonyms as you can.</p>
    <ScoreBoard @start-new-game="startGame" @end-game="endGame" />
    <GuessInput @guess-entered="updateLastGuess" />
    <SynonymList
      :last-guess="lastGuess"
      :base-word="baseWord"
      :game-ended="!gameInProgress"
    />
  </div>
</template>

<style>
.container {
  display: flex;
  flex-direction: column;
}
</style>
