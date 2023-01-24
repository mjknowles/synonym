<script setup lang="ts">
import { onMounted, ref, watch } from "vue";
import { Synonym } from "./synonym";

const synonyms = ref<{ [key: string]: Synonym }>({});
const props = defineProps(["lastGuess"]);

watch(
  () => props.lastGuess,
  (newGuess: string) => {
    if (!synonyms.value[newGuess]) return;
    synonyms.value[newGuess].guessed = true;
  }
);

onMounted(async () => {
  [new Synonym("canine"), new Synonym("puppy"), new Synonym("mutt")].forEach(
    (s) => {
      synonyms.value[s.word] = s;
    }
  );
  await Promise.resolve();
});
</script>

<template>
  <li v-for="synonym in synonyms" :key="synonym.word">
    {{ synonym.guessed ? synonym.word : "---" }}
  </li>
</template>
