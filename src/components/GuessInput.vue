<script setup lang="ts">
const props = defineProps(["wordInProgress"]);
</script>

<template>
  <div>
    <input
      :value="props.wordInProgress"
      placeholder="Your guess"
      id="wordInProgress"
      class="wordInProgress-input"
      :readonly="true"
      tabindex="-1"
    />
  </div>
</template>

<style>
.wordInProgress-input {
  font-size: 24px;
  box-sizing: border-box;
  width: 100%;
}
</style>
