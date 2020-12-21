<template>
  <div id="app">
    <p>{{ message }}</p>
    <button class="btn btn-primary">bootstrap</button>
  </div>
</template>

<script>
export default {
  data: function() {
    return {
      message: 'todotas',
    };
  },
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
