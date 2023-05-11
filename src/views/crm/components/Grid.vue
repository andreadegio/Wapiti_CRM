<template>
  <div class="grid">
    {{ gridType }}
    <CDataTable
      :items="items"
      :fields="fields"
      :table-filter="{
        placeholder: 'Ricerca...',
        label: 'Ricerca:',
      }"
      sorter
      hover
      :itemsPerPage="20"
      pagination
      striped
      :items-per-page-select="{ label: 'Risultati per pagina' }"
      :noItemsView="{ noItems: ' ' }"
    >
      <template #actions="row">
        <div class="d-flex">
          <note :itemId="row.item.id" :candidato="row.item.candidate"></note>
          <Lavorazione
            :itemId="row.item.id"
            :candidato="row.item"
          ></Lavorazione>
          <CButton
            color="danger"
            @click="rejectCandidate(row.item.id)"
            variant="ghost"
            >Rifiuta candidatura</CButton
          >
        </div>
      </template>
    </CDataTable>
  </div>
</template>
<script>
import Note from "./Note.vue";
import Lavorazione from "./Lavorazione.vue";
export default {
  name: "Grid",
  components: {
    Note,
    Lavorazione,
  },
  props: {
    gridType: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      items: [
        // elenco di oggetti che rappresentano le righe della tabella
        {
          id: 1,
          state: "Nuovo",
          candidate: "Mario Rossi",
          type: "Sezione E",
          contact_origin: "LinkedIn",
          email: "mario.rossi@email.com",
          region: "Lombardia",
          tel: "02123456",
          cell: "333123456",
        },
        {
          id: 2,
          state: "Nuovo",
          candidate: "Giuseppe Bianchi",
          type: "Agente",
          contact_origin: "Sito web aziendale",
          email: "giuseppe.bianchi@email.com",
          region: "Toscana",
          tel: "02123456",
          cell: "333123456",
        },
      ],
      fields: [
        { key: "state", label: "Stato" },
        { key: "candidate", label: "Candidato" },
        { key: "type", label: "Tipologia" },
        { key: "contact_origin", label: "Origine del contatto" },
        { key: "contacts", label: "Recapiti" },
        { key: "region", label: "Regione" },
        { key: "actions", label: "Azioni" },
      ],
    };
  },
  watch: {
    gridType() {
      this.updateFields();
      this.updateItems();
    },
  },
  methods: {
    updateFields() {
      // Logica per aggiornare il valore di "fields" in base a "gridType"
    },
    updateItems() {
      // Logica per aggiornare il valore di "items" in base a "gridType"
    },
    rejectCandidate(id) {
      console.log(id);
      // Implementazione per il rifiuto della candidatura con l'id specificato
    },
  },
  mounted() {
    this.updateFields();
    this.updateItems();
  },
};
</script>