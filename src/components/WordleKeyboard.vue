<script setup lang="ts">
import { onMounted } from "vue";

onMounted(() => {
  window.addEventListener("keydown", (e) => {
    if (!letterLookup[e.key]) return;
    selectLetter(e.key);
  });
});

const emit = defineEmits([
  "letter-selected",
  "letter-deleted",
  "submit-pressed",
]);

const letterLookup: { [key: string]: boolean } = {
  a: true,
  b: true,
  c: true,
  d: true,
  e: true,
  f: true,
  g: true,
  h: true,
  i: true,
  j: true,
  k: true,
  l: true,
  m: true,
  n: true,
  o: true,
  p: true,
  q: true,
  r: true,
  s: true,
  t: true,
  u: true,
  v: true,
  w: true,
  x: true,
  y: true,
  z: true,
  "-": true,
  Enter: true,
  Backspace: true,
};

const letters = [
  "Q",
  "W",
  "E",
  "R",
  "T",
  "Y",
  "U",
  "I",
  "O",
  "P",
  "A",
  "S",
  "D",
  "F",
  "G",
  "H",
  "J",
  "K",
  "L",
  "Z",
  "X",
  "C",
  "V",
  "B",
  "N",
  "M",
];

function selectLetter(letter: string) {
  if (letter == "Enter") {
    emit("submit-pressed");
    return;
  }
  if (letter == "Backspace") {
    emit("letter-deleted", letter);
    return;
  }
  emit("letter-selected", letter.toLowerCase());
}
</script>

<template>
  <div class="wordle-keyboard">
    <div class="keyboard-row">
      <div
        v-for="letter in letters.slice(0, 10)"
        :key="letter"
        class="keyboard-key"
        @click="selectLetter(letter)"
      >
        {{ letter }}
      </div>
    </div>
    <div class="keyboard-row">
      <div
        v-for="letter in letters.slice(10, 19)"
        :key="letter"
        class="keyboard-key"
        @click="selectLetter(letter)"
      >
        {{ letter }}
      </div>
      <div class="keyboard-key" @click="selectLetter('-')">-</div>
    </div>
    <div class="keyboard-row">
      <div class="keyboard-key" @click="selectLetter('Backspace')">
        <svg
          fill="none"
          stroke="currentColor"
          stroke-width="1.5"
          viewBox="0 0 24 24"
          xmlns="http://www.w3.org/2000/svg"
          aria-hidden="true"
          class="icon"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            d="M12 9.75L14.25 12m0 0l2.25 2.25M14.25 12l2.25-2.25M14.25 12L12 14.25m-2.58 4.92l-6.375-6.375a1.125 1.125 0 010-1.59L9.42 4.83c.211-.211.498-.33.796-.33H19.5a2.25 2.25 0 012.25 2.25v10.5a2.25 2.25 0 01-2.25 2.25h-9.284c-.298 0-.585-.119-.796-.33z"
          ></path>
        </svg>
      </div>
      <div
        v-for="letter in letters.slice(19, 27)"
        :key="letter"
        class="keyboard-key"
        @click="selectLetter(letter)"
      >
        {{ letter }}
      </div>
      <div class="keyboard-key submit-key" @click="selectLetter('Enter')">
        <svg
          fill="none"
          stroke="currentColor"
          stroke-width="1.5"
          viewBox="0 0 24 24"
          xmlns="http://www.w3.org/2000/svg"
          aria-hidden="true"
          class="icon"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            d="M12.75 15l3-3m0 0l-3-3m3 3h-7.5M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
          ></path>
        </svg>
      </div>
    </div>
  </div>
</template>

<style>
.wordle-keyboard {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: stretch;
  gap: 4px;
}

.keyboard-row {
  display: flex;
  justify-content: center;
  align-content: space-between;
  gap: 4px;
}

.keyboard-key {
  display: flex;
  justify-content: center;
  align-items: center;
  flex: 1 1 auto;
  border-radius: 4px;
  font-size: 1.5rem;
  cursor: pointer;
  background-color: #f2f2f2;
  color: #333;
  transition: all 0.3s ease;
  height: 58px;
  width: 35px;
}

.keyboard-key:hover {
  background-color: #333;
  color: #f2f2f2;
}

.submit-key {
  background-color: #006ee6;
  color: #f2f2f2;
}

.submit-key:hover {
  background-color: #003166;
  color: #333;
}

.icon {
  width: 100%;
  height: 100%;
}
</style>
