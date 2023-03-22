<script setup lang="ts">
import axios from "axios";
import { onMounted, ref, watch } from "vue";
import { Stem } from "./stem";
import { Synonym } from "./synonym";

const synUri =
  import.meta.env.VITE_SYN_SERV_URI ??
  "https://synonym-server.azurewebsites.net";

const emit = defineEmits(["startGame", "endGame", "synonymsAcquired"]);
const props = defineProps(["lastGuess"]);

const stem = ref<Stem>({ word: "", functionalLabel: "" });
const possible = ref<number>(0);
const answered = ref<number>(0);
const definitions = ref<string[]>([]);
const synonyms = ref<{ [key: string]: Synonym }>({});

onMounted(async () => {
  await startNewGame();
});

watch(
  () => props.lastGuess,
  (newGuess: string) => {
    if (!synonyms.value[newGuess]) return;
    synonyms.value[newGuess].guessed = true;
    answered.value += 1;
  }
);

async function startNewGame() {
  possible.value = 0;
  answered.value = 0;
  synonyms.value = {};
  emit("synonymsAcquired", []);
  emit("startGame");
  stem.value = await getBaseWord();
  const synResp = await getSynonyms(
    stem.value.word,
    stem.value.functionalLabel
  );
  synResp.synonyms.forEach((s) => {
    synonyms.value[s.word] = s;
    possible.value += 1;
  });
  definitions.value = synResp.definitions;
  emit(
    "synonymsAcquired",
    Object.keys(synonyms.value).map((key) => synonyms.value[key])
  );
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

async function getSynonyms(
  word: string,
  functionalLabel: string
): Promise<{ definitions: string[]; synonyms: Synonym[] }> {
  try {
    if (word == "") return { definitions: [], synonyms: [] };
    const resp = await axios.get(
      `${synUri}/synonym?stem=${word}&functionalLabel=${functionalLabel}`
    );
    return {
      definitions: resp.data.definitions,
      synonyms: resp.data.syns
        .map((synonym: string) => new Synonym(synonym))
        .sort((a: Synonym, b: Synonym) =>
          a.word.length === b.word.length
            ? a.word.localeCompare(b.word)
            : a.word.length - b.word.length
        ),
    };
  } catch (error) {
    console.error(error);
    return { definitions: [], synonyms: [] };
  }
}
</script>

<template>
  <div class="button-container">
    <button @click="startNewGame" class="game-button">New Game</button>
    <button @click="endGame" class="game-button">Reveal Answers</button>
  </div>
  <h2>
    Your word is: <b>{{ stem.word }}</b> <i>({{ stem.functionalLabel }})</i>
  </h2>
  <h2>Definition(s):</h2>
  <li v-for="(definition, index) in definitions" :key="index">
    {{ definition }}
  </li>

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
