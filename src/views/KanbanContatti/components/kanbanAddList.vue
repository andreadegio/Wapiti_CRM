<template>
    <div>
      <v-dialog v-model="dialog" max-width="600px">
        <v-card>
          <v-card-title class="headline">
            Aggiungi una nuova lista
          </v-card-title>
          <v-card-text>
            <v-text-field
              v-model="title"
              label="Titolo"
              outlined
              required
            ></v-text-field>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="error" text @click="cancel">Annulla</v-btn>
            <v-btn color="primary" text @click="save">Salva</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
      <v-btn color="primary" text @click="dialog = true">
        Aggiungi lista
      </v-btn>
    </div>
  </template>
  
  <script>
  export default {
    name: "kanban-add-list",
    data: () => ({
      dialog: false,
      title: "",
    }),
    methods: {
      save() {
        this.$emit("add-list", this.title);
        this.dialog = false;
        this.title = "";
      },
      cancel() {
        this.dialog = false;
        this.title = "";
      },
    },
  };
  </script>
  