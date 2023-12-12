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
      <template #giorno_demo="{ item }">
        <td>{{ item.giorno_demo | formatDate }} ore {{ item.orario_demo }}</td>
      </template>
      <template #giorno_formazione="{ item }">
        <td>
          {{ item.data_formazione | formatDate }} ore {{ item.ora_formazione }}
        </td>
      </template>
      <template #opzioni="row">
        <td>
          <div class="d-flex">
            <Informazioni
              class="ml-2"
              :itemId="row.item.id"
              :candidato="row.item"
              :step="step"
              @aggiorna_grid="aggiorna_grid"
              @updateCandidato="getLista"
            ></Informazioni>
            <Note :itemId="row.item.id" :candidato="row.item"></Note>
            <Log :itemId="row.item.id" :candidato="row.item"></Log>
          </div>
        </td>
      </template>

      <template #actions="row">
        <td>
          <div class="d-flex">
            <Attivazione
              v-if="gridType === 'attivazione_account'"
              class="ml-2"
              :itemId="row.item.id"
              :candidato="row.item"
              :step="step"
              @aggiorna_grid="aggiorna_grid"
            ></Attivazione>
            <Formazione
              v-if="gridType === 'formazione' && row.item.formatore"
              class="ml-2"
              :itemId="row.item.id"
              :candidato="row.item"
              :step="step"
              @aggiorna_grid="aggiorna_grid"
            ></Formazione>
            <PrenotaFormazione
              v-if="gridType === 'formazione' && !row.item.formatore"
              class="ml-2"
              :itemId="row.item.id"
              :candidato="row.item"
              :step="step"
              @aggiorna_grid="aggiorna_grid"
            ></PrenotaFormazione>
            <Demo
              v-if="row.item.id_step == 3"
              class="ml-2"
              :itemId="row.item.id"
              :candidato="row.item"
              :step="step"
              @aggiorna_grid="aggiorna_grid"
            ></Demo>
            <ValidaDoc
              v-if="gridType === 'registrazione_documentazione'"
              class="ml-2"
              :itemId="row.item.id"
              :candidato="row.item"
              :step="step"
              @aggiorna_grid="aggiorna_grid"
            ></ValidaDoc>
            <Lavorazione
              v-if="gridType === 'primo_contatto' || gridType === 'social'"
              class="ml-2"
              :itemId="row.item.id"
              :candidato="row.item"
              :step="step"
              @aggiorna_grid="aggiorna_grid"
              @updateCandidato="getLista"
            ></Lavorazione>
            <Elimina
              v-if="gridType != 'eliminati' && row.item.id_step != 10"
              :candidato="row.item"
              :step="step"
              @aggiorna_grid="aggiorna_grid"
            ></Elimina>
            <Ripristina
              v-if="gridType == 'eliminati' || row.item.id_step == 10"
              :candidato="row.item"
              :step="step"
              @aggiorna_grid="aggiorna_grid"
            ></Ripristina>
          </div>
        </td>
      </template>
    </CDataTable>
  </div>
</template>
<script>
import axios from "axios";
import Note from "./noteCandidato.vue";
import Log from "./logCandidato.vue";
import Lavorazione from "./Lavorazione.vue";
import ValidaDoc from "./ValidaDoc.vue";
import Elimina from "./Elimina.vue";
import Ripristina from "./Ripristina.vue";
import Demo from "./Demo.vue";
import Formazione from "./Formazione.vue";
import PrenotaFormazione from "./PrenotaFormazione.vue";
import Attivazione from "./Attivazione.vue";
import Informazioni from "./Informazioni.vue";
export default {
  name: "Grid",
  components: {
    Note,
    Log,
    ValidaDoc,
    Lavorazione,
    Elimina,
    Demo,
    Formazione,
    Attivazione,
    Informazioni,
    PrenotaFormazione,
    Ripristina,
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
        // { key: "tipologia", label: "PF/PG" },
        { key: "candidato", label: "Candidato" },
        { key: "RUI", label: "Tipologia" },
        { key: "origine", label: "Fonte" },
        { key: "provincia", label: "Provincia" },
        { key: "regione", label: "Regione" },
        { key: "data_ins", label: "Inserito il" },
        { key: "actions", label: "Azioni" },
        { key: "opzioni", label: "Opzioni" },
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
      switch (this.gridType) {
        case "webinar":
          this.fields = [
            { key: "stato", label: "Stato" },
            // { key: "tipologia", label: "PF/PG" },
            { key: "candidato", label: "Candidato" },
            { key: "giorno_demo", label: "Appuntamento" },
            { key: "regione", label: "Regione" },
            { key: "data_ins", label: "Inserito il" },
            { key: "actions", label: "Azioni" },
            { key: "opzioni", label: "Opzioni" },
          ];
          break;
        case "formazione":
          this.fields = [
            { key: "stato", label: "Stato" },
            // { key: "tipologia", label: "PF/PG" },
            { key: "candidato", label: "Candidato" },
            { key: "giorno_formazione", label: "Appuntamento" },
            { key: "regione", label: "Regione" },
            { key: "actions", label: "Azioni" },
            { key: "opzioni", label: "Opzioni" },
          ];
          break;

        default:
          this.fields = [
            { key: "stato", label: "Stato" },
            // { key: "tipologia", label: "PF/PG" },
            { key: "candidato", label: "Candidato" },
            { key: "RUI", label: "Tipologia" },
            { key: "origine", label: "Fonte" },
            { key: "provincia", label: "Provincia" },
            { key: "regione", label: "Regione" },
            { key: "data_ins", label: "Inserito il" },
            { key: "actions", label: "Azioni" },
            { key: "opzioni", label: "Opzioni" },
          ];
          break;
      }
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
        this.step = [5, 9, 13, 14, 16, 17, 18, 19];
        // stato = "Registrazione";
      }
      if (this.gridType === "formazione") {
        this.step = [6, 13, 14];
        // stato = "Formazione";
      }
      if (this.gridType === "attivazione_account") {
        this.step = [7, 16, 18];
        // stato = "Da attivare";
      }
      if (this.gridType === "follow_up") {
        this.step = 8;
      }
      if (this.gridType === "social") {
        this.step = 12;
      }
      if (this.gridType === "utenti_attivi") {
        this.step = [15, 17, 19];
      }
      if (this.gridType === "eliminati") {
        this.step = 10;
      }
      if (this.gridType === "ricerca") {
        this.step = 99;
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
          if (this.gridType == "formazione" && !item.formatore) {
            // SE IL CANDIDATO NON HA ANCORA PRENOTATO EVIDENZIO LA RIGA
            item._classes = "orange darken-4";
          }
          // Se ha già prenotato la data per la formazione allora controllo se è scaduta, se è oggi o se deve arrivare
          if (this.gridType == "formazione" && item.formatore) {
            const giornoFormazione = new Date(item.data_formazione);
            const oggi = new Date();
            const formattedOggi = oggi.toISOString().slice(0, 10);
            const formattedGiornoFormazione = giornoFormazione
              .toISOString()
              .slice(0, 10);
            if (formattedGiornoFormazione === formattedOggi) {
              item._classes = "green accent-3";
            } else if (formattedGiornoFormazione > formattedOggi) {
              // la data è futura non cambio colore alla riga
            } else {
              // data scaduta
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
