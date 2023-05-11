<template>
  <v-card
    class="kanban-card"
    @click="editTask"
    :draggable="true"
    @dragstart="onDragStart"
  >
    <v-card-text>{{ task.title }}</v-card-text>
    <v-card-actions>
      <v-btn icon @click="deleteTask">
        <v-icon>mdi-delete</v-icon>
      </v-btn>
      <v-btn icon @click="moveTask(-1)">
        <v-icon>mdi-chevron-up</v-icon>
      </v-btn>
      <v-btn icon @click="moveTask(1)">
        <v-icon>mdi-chevron-down</v-icon>
      </v-btn>
    </v-card-actions>
  </v-card>
</template>
  
  <script>
export default {
  props: {
    task: {
      type: Object,
      required: true,
    },
  },
  methods: {
    editTask() {
      // Apri il componente per modificare i dettagli del task
    },
    deleteTask() {
      // Elimina il task dalla lista
    },
    moveTask(direction) {
      // Sposta il task in su o in giù nella stessa lista
    },

    onDragStart(event) {
      event.dataTransfer.setData("text/plain", JSON.stringify(this.task));
      event.dataTransfer.dropEffect = "move";
    },
  },
};
</script>
  
  <style scoped>
.kanban-card {
  margin-bottom: 10px;
}
</style>
  