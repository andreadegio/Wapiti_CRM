<template>
    <v-dialog v-model="dialog" max-width="500px">
      <v-card>
        <v-card-title>
          <span v-if="!editing">New Card</span>
          <span v-else>Edit Card</span>
          <v-btn icon @click="closeDialog">
            <v-icon>mdi-close</v-icon>
          </v-btn>
        </v-card-title>
        <v-card-text>
          <v-form ref="form">
            <v-text-field
              v-model="title"
              label="Title"
              required
              :rules="[v => !!v || 'Title is required']"
            />
            <v-textarea
              v-model="description"
              label="Description"
            />
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" @click="saveCard">
            <span v-if="!editing">Create</span>
            <span v-else>Save</span>
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </template>
  
  <script>
  export default {
    props: {
      boardId: {
        type: Number,
        required: true
      },
      listId: {
        type: Number,
        required: true
      },
      card: Object
    },
    data() {
      return {
        dialog: true,
        editing: !!this.card,
        title: this.card ? this.card.title : '',
        description: this.card ? this.card.description : ''
      }
    },
    methods: {
      closeDialog() {
        this.dialog = false
        this.$emit('close')
      },
      saveCard() {
        if (!this.$refs.form.validate()) return
  
        const card = {
          board_id: this.boardId,
          list_id: this.listId,
          title: this.title,
          description: this.description
        }
  
        if (this.card) {
          // Editing an existing card
          card.id = this.card.id
          this.$emit('edit', card)
        } else {
          // Creating a new card
          this.$emit('create', card)
        }
  
        this.dialog = false
      }
    }
  }
  </script>
  