<template>
    <div class="kanban-task">
      <div class="kanban-task__header">{{ task.title }}</div>
      <div class="kanban-task__description">{{ task.description }}</div>
    </div>
  </template>
  
  <script>
  export default {
    props: {
      task: {
        type: Object,
        required: true,
      },
    },
  };
  </script>
  
  <style scoped>
  .kanban-task {
    background-color: white;
    border: 1px solid gray;
    padding: 10px;
    border-radius: 5px;
    margin-bottom: 10px;
  }
  
  .kanban-task__header {
    font-weight: bold;
    margin-bottom: 5px;
  }
  
  .kanban-task__description {
    font-size: 14px;
    color: gray;
  }
  </style>
  