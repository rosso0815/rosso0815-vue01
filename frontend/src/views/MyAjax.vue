<template>
  <div class="home">
    <h1>AJAX</h1>
    <b-button v-on:click="greet">Greet</b-button>
    <br />
    text: {{ text }}
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "MyAjax",
  components: {},
  data() {
    return {
      text: "undefined",
    };
  },
  methods: {
    greet: function (event) {
      // `this` inside methods points to the Vue instance
      axios
        .get("/api/home")
        .then((response) => {
          this.text = response.data;
        });

      //alert("Hello " + this.name + "!");
      // `event` is the native DOM event
      //if (event) {
      //  alert(event.target.tagName);
      //}
      //this.text = "howdie";
    },
  },
};
</script>
