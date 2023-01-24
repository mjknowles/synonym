<script setup lang="ts">
import SynonymList from "@/components/SynonymList.vue";
import { ref } from "vue";
import AnswerInput from "../components/GuessInput.vue";

var lastGuess = ref("");

function updateLastGuess(guess: string) {
  console.log(`last guess: ${guess}`);
  lastGuess.value = guess;
}
</script>

<template>
  <h1>Synonym</h1>
  <AnswerInput @guess-entered="updateLastGuess" />
  <SynonymList :last-guess="lastGuess" />
</template>
