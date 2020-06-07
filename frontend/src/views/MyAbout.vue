
<template>
  <div class="about">
    <h1>This is an about page</h1>
    <b-button @click="upCounter">Increase Counter</b-button>
    counter={{count}}
    <br />
    config.Name={{config.Name}}
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'MyAbout',
  components: {},
  data () {
    return {
      message: 'hello',
      config: ''
    }
  },
  computed: {
    count () {
      // console.log('count = ' + store.state.count)
      return this.$store.state.count
    }
  },
  created: function () {
    console.log('@@@ created')

    var _this = this
    // Make a request for a user with a given ID
    axios
      .get('api/config')
      .then(function (response) {
        // handle success
        console.log(response)
        _this.config = response.data
      })
      .catch(function (error) {
        // handle error
        console.log(error)
      })
      .finally(function () {
        // always executed
      })
  },

  methods: {
    upCounter: function () {
      this.$store.commit('increment')
      console.log('upCounter')
    }
  }
}
</script>
