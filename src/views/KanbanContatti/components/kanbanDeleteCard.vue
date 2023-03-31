<template>
    <v-dialog v-model="dialog" max-width="400">
      <v-card>
        <v-card-title class="headline">Elimina Task</v-card-title>
        <v-card-text>
          <p>Sei sicuro di voler eliminare il task "{{ task.title }}"?</p>
        </v-card-text>
        <v-card-actions>
          <v-btn color="error darken-1" text @click="dialog = false">Annulla</v-btn>
          <v-btn color="success darken-1" text @click="deleteTask">Elimina</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </template>
  
  <script>
  export default {
    props: {
      task: {
        type: Object,
        required: true
      }
    },
    data() {
      return {
        dialog: false
      };
    },
    methods: {
      deleteTask() {
        // Effettua la chiamata per l'eliminazione del task nel backend
        // ...
        // Chiudi il dialog
        this.dialog = false;
        // Emetti l'evento per informare la lista che il task è stato eliminato
        this.$emit('task-deleted');
      }
    }
  };
  </script>
  