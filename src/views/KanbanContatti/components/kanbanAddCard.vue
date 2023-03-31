<template>
    <v-card class="kanban-add-card" @click="showForm">
      <v-card-text class="kanban-add-card-text">
        <v-icon>mdi-plus-circle</v-icon> Aggiungi un nuovo task
      </v-card-text>
      <v-card-actions v-if="showForm">
        <v-form @submit.prevent="addTask">
          <v-text-field
            v-model="newTaskTitle"
            label="Titolo"
            required
            outlined
          />
          <v-btn type="submit">Aggiungi</v-btn>
          <v-btn @click="hideForm">Annulla</v-btn>
        </v-form>
      </v-card-actions>
    </v-card>
  </template>
  
  <script>
  export default {
    data() {
      return {
        showForms: false,
        newTaskTitle: "",
      };
    },
    methods: {
      showForm() {
        this.showForm = true;
      },
      hideForm() {
        this.showForm = false;
        this.newTaskTitle = "";
      },
      addTask() {
        if (this.newTaskTitle.trim() !== "") {
          // Aggiungi il nuovo task alla lista
          this.$emit("new-task-added", { title: this.newTaskTitle.trim() });
          this.hideForm();
        }
      },
    },
  };
  </script>
  
  <style scoped>
  .kanban-add-card {
    margin-bottom: 10px;
    cursor: pointer;
  }
  
  .kanban-add-card-text {
    text-align: center;
  }
  </style>
  