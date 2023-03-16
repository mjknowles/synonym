<template>
  <div>
    <h1>Guess the Synonyms</h1>
    <p>Guess as many synonyms as you can for the word "{{ targetWord }}".</p>
    <form @submit.prevent="submitGuess">
      <label for="guess">Your Guess:</label>
      <input type="text" id="guess" v-model="guess" />
      <button type="submit">Guess</button>
    </form>
    <p>You have {{ guessesRemaining }} guesses remaining.</p>
    <p v-if="gameOver">
      Game over! You guessed {{ correctGuesses.length }} out of
      {{ totalSynonyms }} synonyms for "{{ targetWord }}".
      <button @click="newGame">Play Again</button>
    </p>
    <div v-else>
      <p v-if="correctGuesses.length > 0">
        You've guessed {{ correctGuesses.length }} out of
        {{ totalSynonyms }} synonyms so far!
      </p>
      <p v-if="guessesRemaining === 0">
        Sorry, you've run out of guesses. The synonyms were "{{
          synonyms.join(", ")
        }}".
      </p>
      <ul>
        <li v-for="synonym in correctGuesses" :key="synonym">{{ synonym }}</li>
      </ul>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, watch } from "vue";
import axios from "axios";

export default defineComponent({
  setup() {
    const targetWord = ref("");
    const synonyms = ref<string[]>([]);
    const totalSynonyms = ref(0);
    const guess = ref("");
    const correctGuesses = ref<string[]>([]);
    const guessesRemaining = ref(5);
    const gameOver = ref(false);

    const getRandomWord = () => {
      const words = ["apple", "banana", "cherry", "grape", "orange", "pear"];
      return words[Math.floor(Math.random() * words.length)];
    };

    const getSynonyms = async (word: string) => {
      try {
        const response = await axios.get(
          "https://api.datamuse.com/words?rel_syn=" + word
        );
        const synonymsList = response.data.map((synonym: any) => synonym.word);
        return synonymsList;
      } catch (error) {
        console.error(error);
      }
    };

    const newGame = async () => {
      targetWord.value = getRandomWord();
      synonyms.value = await getSynonyms(targetWord.value);
      totalSynonyms.value = synonyms.value.length;
      guess.value = "";
      correctGuesses.value = [];
      guessesRemaining.value = 5;
      gameOver.value = false;
    };

    const submitGuess = () => {
      const guessValue = guess.value.toLowerCase();
      if (
        synonyms.value.includes(guessValue) &&
        !correctGuesses.value.includes(guessValue)
      ) {
        correctGuesses.value.push(guessValue);
      }
      guessesRemaining.value--;
      if (
        guessesRemaining.value === 0 ||
        correctGuesses.value.length === totalSynonyms.value
      ) {
        gameOver.value = true;
      }
      guess.value = "";
    };

    watch(gameOver, (newVal) => {
      if (newVal) {
        guess.value = "";
      }
    });

    newGame();

    return {
      targetWord,
      synonyms,
      totalSynonyms,
      guess,
      correctGuesses,
      guessesRemaining,
      gameOver,
      newGame,
      submitGuess,
    };
  },
});
</script>
``
