<script setup lang="ts">
import SynonymList from "@/components/SynonymList.vue";
import { ref } from "vue";
import GuessInput from "@/components/GuessInput.vue";
import ScoreBoard from "@/components/ScoreBoard.vue";
import type { Synonym } from "@/components/synonym";
import type { Stem } from "@/components/stem";

var lastGuess = ref("");
var stem = ref<Stem>({ word: "", functionalLabel: "" });
var gameInProgress = ref(false);
var correct = ref(0);
var possible = ref(0);

function updateLastGuess(guess: string) {
  if (!gameInProgress.value) return;
  lastGuess.value = guess;
}

function startGame(stemWord: Stem) {
  correct.value = 0;
  possible.value = 0;
  gameInProgress.value = true;
  stem.value = stemWord;
}

function endGame() {
  gameInProgress.value = false;
}

function correctGuessEntered() {
  correct.value += 1;
}

function synonymsAcquired(synonyms: Synonym[]) {
  possible.value = synonyms.length;
}
</script>

<template>
  <div class="container">
    <h1>Guess the Synonyms</h1>
    <p>Guess as many synonyms as you can.</p>
    <ScoreBoard
      @start-new-game="startGame"
      @end-game="endGame"
      :correct-guesses="correct"
      :possible-answers="possible"
    />
    <GuessInput @guess-entered="updateLastGuess" />
    <SynonymList
      :last-guess="lastGuess"
      :stem="stem"
      :game-ended="!gameInProgress"
      @correct-guess-entered="correctGuessEntered"
      @synonyms-acquired="synonymsAcquired"
    />
  </div>
</template>

<style>
.container {
  display: flex;
  flex-direction: column;
}
</style>
