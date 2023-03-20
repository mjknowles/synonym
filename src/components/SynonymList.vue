<script setup lang="ts">
import { onMounted, ref, watch } from "vue";
import { Synonym } from "./synonym";
import axios from "axios";

const synonyms = ref<{ [key: string]: Synonym }>({});
const props = defineProps(["lastGuess", "baseWord", "gameEnded"]);
var gameEnded = ref<boolean>(false);

watch(
  () => props.lastGuess,
  (newGuess: string) => {
    alert(`${newGuess} received`);
    if (!synonyms.value[newGuess]) return;
    alert(`${newGuess} present`);
    alert(`guess status: ${synonyms.value[newGuess].guessed}`);
    synonyms.value[newGuess].guessed = true;
    alert(`${synonyms.value[newGuess].guessed} ${gameEnded.value}`);
  }
);

watch(
  () => props.baseWord,
  async (baseWord: string) => {
    synonyms.value = {};
    gameEnded.value = false;
    (await getSynonyms(baseWord)).forEach((s) => {
      synonyms.value[s.word] = s;
    });
  }
);

watch(
  () => props.gameEnded,
  async () => {
    if (!props.gameEnded) return;
    gameEnded.value = true;
  }
);

onMounted(async () => {});

async function getSynonyms(word: string): Promise<Synonym[]> {
  try {
    const response = await axios.get(
      "https://api.datamuse.com/words?rel_syn=" + word
    );
    const synonymsList = response.data
      .map((synonym: any) => new Synonym(synonym.word))
      .sort((a: Synonym, b: Synonym) =>
        a.word.length === b.word.length
          ? a.word.localeCompare(b.word)
          : a.word.length - b.word.length
      );
    return synonymsList;
  } catch (error) {
    console.error(error);
    return [];
  }
}
</script>

<template>
  <li
    v-for="synonym in synonyms"
    :key="synonym.word"
    :style="{ fontWeight: synonym.guessed ? 'normal' : 'bold' }"
  >
    {{
      synonym.guessed || gameEnded
        ? synonym.word
        : "-".repeat(synonym.word.length)
    }}
  </li>
</template>
