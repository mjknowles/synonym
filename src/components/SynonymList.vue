<script setup lang="ts">
import { onMounted, ref, watch } from "vue";
import { Synonym } from "./synonym";
import axios from "axios";
import type { Stem } from "./stem";

const synonyms = ref<{ [key: string]: Synonym }>({});
const props = defineProps(["lastGuess", "stem", "gameEnded"]);
var gameEnded = ref<boolean>(false);
const emit = defineEmits(["synonymsAcquired", "correctGuessEntered"]);
const synUri =
  import.meta.env.VITE_SYN_SERV_URI ??
  "https://synonym-server.azurewebsites.net";

watch(
  () => props.lastGuess,
  (newGuess: string) => {
    if (!synonyms.value[newGuess]) return;
    synonyms.value[newGuess].guessed = true;
    emit("correctGuessEntered");
  }
);

watch(
  () => props.stem,
  async (stem: Stem) => {
    synonyms.value = {};
    gameEnded.value = false;
    let symList: Synonym[] = [];
    (await getSynonyms(stem.word, stem.functionalLabel)).forEach((s) => {
      synonyms.value[s.word] = s;
      symList.push(s);
    });
    emit("synonymsAcquired", symList);
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

async function getSynonyms(
  word: string,
  functionalLabel: string
): Promise<Synonym[]> {
  try {
    if (word == "") return [];
    return (
      await axios.get(
        `${synUri}/synonym?stem=${word}&functionalLabel=${functionalLabel}`
      )
    ).data.syns
      .map((synonym: string) => new Synonym(synonym))
      .sort((a: Synonym, b: Synonym) =>
        a.word.length === b.word.length
          ? a.word.localeCompare(b.word)
          : a.word.length - b.word.length
      );
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
