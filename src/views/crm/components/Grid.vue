<template>
  <div class="grid">
    <!-- {{ gridType }} -->
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
      :noItemsView="{ noItems: 'Nessun contatto presente' }"
    >
      <template #tipologia="{ item }">
        <td style="text-align: center !important">
          <div>
            <i v-if="item.tipologia === 'PF'" class="far fa-user"></i>
            <i v-else-if="item.tipologia === 'PG'" class="far fa-building"></i>
          </div>
        </td>
      </template>
      <template #data_ins="{ item }">
        <td>{{ item.data_ins | formatDate }}</td>
      </template>

      <template #actions="row">
        <td>
          <div class="d-flex">
            <ValidaDoc
              v-if="row.item.id_step == 9"
              class="ml-2"
              :itemId="row.item.id"
              :candidato="row.item"
              :step="step"
              @aggiorna_grid="aggiorna_grid"
            ></ValidaDoc>
            <Lavorazione
              v-if="row.item.id_step != 9"
              class="ml-2"
              :itemId="row.item.id"
              :candidato="row.item"
              :step="step"
              @aggiorna_grid="aggiorna_grid"
              @updateCandidato="getLista"
            ></Lavorazione>
            <Note :itemId="row.item.id" :candidato="row.item.candidato"></Note>
            <Elimina
              :candidato="row.item"
              :step="step"
              @aggiorna_grid="aggiorna_grid"
            ></Elimina>
          </div>
        </td>
      </template>
    </CDataTable>
  </div>
</template>
<script>
import axios from "axios";
import Note from "./Note.vue";
import Lavorazione from "./Lavorazione.vue";
import ValidaDoc from "./ValidaDoc.vue";
import Elimina from "./Elimina.vue";
export default {
  name: "Grid",
  components: {
    Note,
    ValidaDoc,
    Lavorazione,
    Elimina,
  },
  props: {
    gridType: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      step: 0,
      items: [],
      fields: [
        { key: "stato", label: "Stato" },
        { key: "tipologia", label: "PF/PG" },
        { key: "candidato", label: "Candidato" },
        { key: "RUI", label: "RUI" },
        { key: "origine", label: "Fonte" },
        { key: "provincia", label: "Provincia" },
        { key: "regione", label: "Regione" },
        { key: "data_ins", label: "Inserito il" },
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
      this.fields = [
        { key: "stato", label: "Stato" },
        { key: "tipologia", label: "PF/PG" },
        { key: "candidato", label: "Candidato" },
        { key: "RUI", label: "RUI" },
        { key: "origine", label: "Fonte" },
        { key: "provincia", label: "Provincia" },
        { key: "regione", label: "Regione" },
        { key: "data_ins", label: "Inserito il" },
        { key: "actions", label: "Azioni" },
      ];
    },
    updateItems() {
      // Logica per aggiornare il valore di "items" in base a "gridType"
      // var stato = "";
      this.step = 0;

      if (this.gridType === "primo_contatto") {
        this.step = [1, 2];
        // stato = "Nuovo";
      }
      if (this.gridType === "webinar") {
        this.step = 3;
        // stato = "Mini Demo";
      }
      if (this.gridType === "solleciti") {
        this.step = 4;
        // stato = "Sollecito";
      }
      if (this.gridType === "registrazione_documentazione") {
        this.step = [5, 9];
        // stato = "Registrazione";
      }
      if (this.gridType === "formazione") {
        this.step = 6;
        // stato = "Formazione";
      }
      if (this.gridType === "attivazione_account") {
        this.step = 7;
        // stato = "Da attivare";
      }
      if (this.gridType === "follow_up") {
        this.step = 8;
      }
      if (this.gridType === "social") {
        this.step = 12;
      }

      if (this.step != 0) {
        // Se è stato scelto un pulsante valido allora recupero le liste
        this.aggiorna_grid(this.step);
      }
    },

    async getLista(stato) {
      //  console.log(stato);
      let param = { step: stato };
      try {
        const response = await axios.post(
          this.$custom_json.base_url +
            this.$custom_json.api_url +
            this.$custom_json.crm.getListaByStep,
          param
        );
        return response.data; // Restituisci i dati dalla risposta
      } catch (error) {
        console.error(error);
        return []; // In caso di errore, ritorna un array vuoto ogestisci l'errore in un altro modo
      }
    },
    async aggiorna_grid(state) {
      this.getLista(state).then((candidati) => {
        this.items = candidati.map((item) => {
          if (item.rag_soc) {
            var candidato = item.rag_soc;
          } else {
            candidato = item.nome + " " + item.cognome;
          }
          if (item.richiama) {
            const giornoRichiamo = new Date(item.richiama[0].giorno);
            const oggi = new Date();

            // Trasformo le date in formato "YYYY-MM-DD" per poterle confrontare correttamente
            const formattedGiornoRichiamo = giornoRichiamo
              .toISOString()
              .slice(0, 10);
            const formattedOggi = oggi.toISOString().slice(0, 10);

            if (formattedGiornoRichiamo === formattedOggi) {
              // La data è odierna
              // console.log("Il richiamo è oggi!");
              item._classes = "green accent-3";
            } else if (formattedGiornoRichiamo > formattedOggi) {
              // La data è futura
              // console.log("Il richiamo è in futuro.");
            } else {
              // La data è già trascorsa
              // console.log("Il richiamo è già passato.");
              item._classes = "red";
            }
          }
          return {
            ...item,
            candidato: candidato,
          };
        });
      });
    },
  },
  mounted() {
    this.updateFields();
    this.updateItems();
  },
};
</script>
