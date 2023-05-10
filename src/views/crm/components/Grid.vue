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
          <CButton @click="addNote(row.item.id)" variant="outline-primary"
            >Aggiungi nota</CButton
          >
          <CButton @click="workCandidate(row.item.id)" variant="outline-primary"
            >Lavora candidatura</CButton
          >
          <CButton
            @click="rejectCandidate(row.item.id)"
            variant="outline-danger"
            >Rifiuta candidatura</CButton
          >
        </div>
      </template>
    </CDataTable>
  </div>
</template>
<script>
export default {
  name: "Grid",
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
          type: "Candidatura spontanea",
          contact_origin: "LinkedIn",
          contacts: "mario.rossi@email.com",
          region: "Lombardia",
        },
        {
          id: 2,
          state: "Nuovo",
          candidate: "Giuseppe Bianchi",
          type: "Ricerca attiva",
          contact_origin: "Sito web aziendale",
          contacts: "giuseppe.bianchi@email.com",
          region: "Toscana",
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
    addNote(id) {
      console.log(id);
      // Implementazione per l'aggiunta di una nota alla candidatura con l'id specificato
    },
    workCandidate(id) {
      console.log(id);
      // Implementazione per il lavoro sulla candidatura con l'id specificato
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