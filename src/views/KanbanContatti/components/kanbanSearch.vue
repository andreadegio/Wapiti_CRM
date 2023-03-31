<template>
    <v-text-field v-model="search" label="Search" @input="searchCards" />
  </template>
  
  <script>
  export default {
    name: "KanbanSearch",
    props: ["cards"],
    data() {
      return {
        search: "",
      };
    },
    methods: {
      searchCards() {
        this.$emit("search", this.search);
      },
    },
  };
  </script>
  