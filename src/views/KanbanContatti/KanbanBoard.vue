<template>
  <div class="kanban-board">
    <kanban-search :cards="cards" @search="searchCards" />

    <v-row>
      <kanban-list
        v-for="(list, index) in lists"
        :key="index"
        :title="list.title"
        :list="list"
        :tasks="list.cards"
        :group="'kanban'"
        @task-moved="moveTask"
      >
        <kanban-add-card @add-card="addCard(index)" />
        <kanban-card
          v-for="(card, i) in list.cards"
          :key="i"
          :card="card"
          :group="'kanban'"
      
        >
          <kanban-edit-card @edit-card="editCard(index, i)" :card="card" />
          <kanban-delete-card @delete-card="deleteCard(index, i)" />
        </kanban-card>
      </kanban-list>
      <kanban-add-list @add-list="addList" />
    </v-row>
  </div>
</template>

<script>
import KanbanList from "./components/kanbanList.vue";
import KanbanCard from "./components/kanbanCard.vue";
import KanbanAddCard from "./components/kanbanAddCard.vue";
import KanbanEditCard from "./components/kanbanEditCard.vue";
import KanbanDeleteCard from "./components/kanbanDeleteCard.vue";
import KanbanAddList from "./components/kanbanAddList.vue";
import KanbanSearch from "./components/kanbanSearch.vue";

export default {
  name: "KanbanBoard",
  components: {
    KanbanList,
    KanbanCard,
    KanbanAddCard,
    KanbanEditCard,
    KanbanDeleteCard,
    KanbanAddList,
    KanbanSearch,
  },
  data() {
    return {
      // lists: [
      //   { title: "To Do", cards: [] },
      //   { title: "Doing", cards: [] },
      //   { title: "Done", cards: [] },
      // ],
      lists: [
        {
          title: "To Do",
          cards: [
            {
              id: 1,
              title: "Task 1",
              description: "Descrizione del Task 1",
              dueDate: "2023-04-01",
              members: ["Mario Rossi", "Giuseppe Verdi"],
            },
            {
              id: 2,
              title: "Task 2",
              description: "Descrizione del Task 2",
              dueDate: "2023-04-02",
              members: ["Luca Bianchi", "Simone Neri"],
            },
            {
              id: 3,
              title: "Task 3",
              description: "Descrizione del Task 3",
              dueDate: "2023-04-03",
              members: ["Marco Bianchi", "Fabio Neri"],
            },
            {
              id: 4,
              title: "Task 4",
              description: "Descrizione del Task 4",
              dueDate: "2023-04-04",
              members: ["Giovanni Rossi", "Sara Verdi"],
            },
          ],
        },
        {
          title: "In Progress",
          cards: [
            {
              id: 5,
              title: "Task 5",
              description: "Descrizione del Task 5",
              dueDate: "2023-04-05",
              members: ["Mario Rossi", "Giuseppe Verdi"],
            },
            {
              id: 6,
              title: "Task 6",
              description: "Descrizione del Task 6",
              dueDate: "2023-04-06",
              members: ["Luca Bianchi", "Simone Neri"],
            },
          ],
        },
        {
          title: "Done",
          cards: [
            {
              id: 7,
              title: "Task 7",
              description: "Descrizione del Task 7",
              dueDate: "2023-04-07",
              members: ["Marco Bianchi", "Fabio Neri"],
            },
            {
              id: 8,
              title: "Task 8",
              description: "Descrizione del Task 8",
              dueDate: "2023-04-08",
              members: ["Giovanni Rossi", "Sara Verdi"],
            },
          ],
        },
      ],
      members: [
        { id: 1, name: "Mario Rossi" },
        { id: 2, name: "Giuseppe Verdi" },
        { id: 3, name: "Luca Bianchi" },
        { id: 4, name: "Simone Neri" },
        { id: 5, name: "Marco Bianchi" },
        { id: 6, name: "Fabio Neri" },
        { id: 7, name: "Giovanni Rossi" },
        { id: 8, name: "Sara Verdi" },
      ],
      task: [
        {
          id: 1,
          title: "Task 1",
          description: "This is the first task",
          list_id: 1,
        },
        {
          id: 2,
          title: "Task 2",
          description: "This is the second task",
          list_id: 1,
        },
        {
          id: 3,
          title: "Task 3",
          description: "This is the third task",
          list_id: 2,
        },
      ],

      cards: [],
    };
  },
  methods: {
    moveTask(task, fromListIndex, toListIndex, taskIndex) {
      // logica per spostare il task tra le liste
    },
    addCard(listIndex) {
      // Aggiungi una nuova carta alla lista specificata
    },
    editCard(listIndex, cardIndex) {
      // Modifica la carta specificata
    },
    deleteCard(listIndex, cardIndex) {
      // Elimina la carta specificata
    },
    addList() {
      // Aggiungi una nuova lista
    },
    searchCards(search) {
      // Filtra le carte in base alla stringa di ricerca
    },
  },
};
</script>
