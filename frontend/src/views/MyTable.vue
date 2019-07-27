
<script>
// @ is an alias to /src

import axios from 'axios'
import CompTable from '@/components/CompTable.vue'

export default {
  name: 'myTable',
  components: {
    CompTable
  },
  data () {
    return {
      debugOn: true,
      info: '<pls define>',
      items: [],
      fields: [
        { key: 'id', label: 'Id', sortable: true },
        { key: 'userId', label: 'UserId', sortable: true },
        { key: 'title', label: 'Title', sortable: true },
        { key: 'body', label: 'Body' }
      ],
      totalRows: 100,
      currentPage: 1,
      perPage: 5,
      pageOptions: [5, 10, 15],
      sortBy: null,
      sortDesc: false,
      sortDirection: 'asc',
      filter: null,
      status: '',
      sortOptions: '',
      selected: [],
      boxOne: '',
      boxTwo: ''
    }
  },
  created () {
    axios
      .get('data.json')
      .then(response => {
        // JSON responses are automatically parsed.
        console.log('load data')
        this.items = response.data
      })
      .catch(e => {
        this.errors.push(e)
      })
  },
  methods: {

    log (text) {
      console.log('log +> ' + text)
    },

    filterGrid (val1, val2) {
      console.log('@@@ filterGrid val1=' + val1 + ' , val2=' + val2)
      return true
    },

    rowSelected (selected) {
      console.log('@@@ selected = ' + selected[0].id)

      this.selected = selected
    },

    showDetail () {
      console.log('@@@ showDetail')
      // var t = this.selected
      // t.body = 'gugusseli'
      // this.items.splice(1, 1, t)
      // var t = this.selected
      // var a = this.items
      // t.body = 'gugusseli'
      // a.splice(1, 1, t)
      // this.items = a
    },

    showDialog () {
      console.log('showDialog')
    },

    edit () {
      console.log('@@@ edit modal')
      this.$bvModal.show('modal-1')
    },
    clone () {
      console.log('@@@ clone modal')
      // this.$bvModal.show("modal-1");
    },
    toDelete () {
      console.log('@@@ toDelete modal selected=' + this.selected)

      if (this.selected === null || this.selected.length < 1) {
        this.$bvModal.msgBoxOk('pls select a row')
      } else {
        this.$bvModal.msgBoxOk('selected row will be deleted')
      }
    }
  },
  watch: {
    filter: function (value) {
      console.log('@@@ filter ' + value)
    }
  }
}
</script>

<template>
  <div>

    <comp-table
      title="Crud Table 01"
    />

  <div v-if="debugOn == true">
    <b>debugOn</b>

  </div>

  </div>
</template>
