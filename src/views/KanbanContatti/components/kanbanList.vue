<template>
  <div
    class="kanban-list"
    :class="{ 'kanban-list--drop-allowed': allowDrop }"
    :data-list-id="list.id"
    @dragover.prevent="allowDrop"
    @drop="onDrop"
  >
    <div class="kanban-list__header">
      {{ list.title }}
    </div>
    <div class="kanban-list__tasks">
      <kanban-task
        v-for="(task, index) in tasks"
        :key="task.id"
        :task="task"
        :allow-drag="allowDrag"
        :allow-drop="allowDrop"
        @task-drag-start="onTaskDragStart"
        @task-dropped="onTaskDropped"
      />
    </div>
  </div>
</template>
  
  <script>
import KanbanTask from "./kanbanTask.vue"

export default {
  components: {
    KanbanTask,
  },
  props: {
    list: {
      type: Object,
      required: true,
    },
    tasks: {
      type: Array,
      required: true,
    },
    allowDrag: {
      type: Boolean,
      default: true,
    },
    // allowDrop: {
    //   type: Boolean,
    //   default: true,
    // },
  },
  methods: {

    allowDrop(event) {
      if (this.allowDrop) {
        event.preventDefault();
      }
    },
    onTaskDragStart(event, task) {
      if (!this.allowDrag) {
        event.preventDefault();
        return;
      }

      event.dataTransfer.effectAllowed = "move";
      event.dataTransfer.setData("task-id", task.id);
      event.dataTransfer.setData("list-id", this.list.id);
    },
    onTaskDropped(event, task) {
      this.$emit("task-dropped", event, task, this.list);
    },
    onDrop(event) {
      event.preventDefault();
      const taskId = JSON.parse(event.dataTransfer.getData("text/plain")).id;
      const listId = this.list.id;
      this.$emit("task-moved", taskId, listId);
    },
  },
};
</script>
  