<template>
  <div class="grid">
    <!-- {{ gridType }} -->
    <div class="text-center">
      Totale Candidati nella lista: {{ items.length }}
    </div>

    <div class="text-center" v-if="user['idUtente'] != 140 && gridType != 'formazione' && userCRMInfo.idRuolo != '2'">
      <v-checkbox v-model="filtroOperatore" label="Mostra solo i miei contatti:"></v-checkbox>
    </div>

    <CDataTable :items="items" :fields="fields" :table-filter="{
        placeholder: 'Ricerca...',
        label: 'Ricerca:',
      }" sorter hover :itemsPerPage="20" pagination striped :items-per-page-select="{ label: 'Risultati per pagina' }"
      :noItemsView="{
        noItems: noItemsMessage,
      }">
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
      <template #avanzamento_corso="{ item }">
        <td>
          {{ item.corso[0].avanzamento }}%
        </td>
      </template>
      <template #opzioni="row">
        <td>
          <div class="d-flex">
            <Informazioni class="ml-2" :itemId="row.item.id" :candidato="row.item" :step="step"
              @aggiorna_grid="aggiorna_grid" @updateCandidato="getLista"></Informazioni>
            <Note :itemId="row.item.id" :candidato="row.item"></Note>
            <Log :itemId="row.item.id" :candidato="row.item"></Log>
          </div>
        </td>
      </template>

      <template #actions="row">
        <td v-if="(row.item.id_segnalatore != null &&
        row.item.id_referente == user.idUtente) ||
        row.item.id_segnalatore == null || user.idUtente == 140
        ">
          <div class="d-flex">
            <Attivazione v-if="gridType === 'attivazione_account'" class="ml-2" :itemId="row.item.id"
              :candidato="row.item" :step="step" @aggiorna_grid="aggiorna_grid"></Attivazione>
            <!-- <Formazione
              v-if="gridType === 'formazione' && row.item.formatore"
              class="ml-2"
              :itemId="row.item.id"
              :candidato="row.item"
              :step="step"
              @aggiorna_grid="aggiorna_grid"
            ></Formazione> -->
            <!-- <PrenotaFormazione v-if="gridType === 'formazione' && !row.item.formatore" class="ml-2"
              :itemId="row.item.id" :candidato="row.item" :step="step" @aggiorna_grid="aggiorna_grid">
            </PrenotaFormazione> -->
            <Demo v-if="row.item.id_step == 3 && gridType === 'webinar'" class="ml-2" :itemId="row.item.id"
              :candidato="row.item" :step="step" @aggiorna_grid="aggiorna_grid"></Demo>
            <ValidaDoc v-if="gridType === 'registrazione_documentazione'" class="ml-2" :itemId="row.item.id"
              :candidato="row.item" :step="step" @aggiorna_grid="aggiorna_grid"></ValidaDoc>
            <Lavorazione v-if="gridType === 'primo_contatto' || gridType === 'social'" class="ml-2"
              :itemId="row.item.id" :candidato="row.item" :step="step" @aggiorna_grid="aggiorna_grid"
              @updateCandidato="getLista"></Lavorazione>
            <Elimina v-if="gridType != 'eliminati' && row.item.id_step != 10" :candidato="row.item" :step="step"
              @aggiorna_grid="aggiorna_grid"></Elimina>
            <Ripristina v-if="gridType == 'eliminati' || row.item.id_step == 10" :candidato="row.item" :step="step"
              @aggiorna_grid="aggiorna_grid"></Ripristina>
          </div>
        </td>
        <td v-else style="color: #1f4b6b">
          <strong>Questo candidato è assegnato ad un'altro operatore</strong>
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

    Attivazione,
    Informazioni,

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
      filtroOperatore: JSON.parse(localStorage.getItem("userCRMInfo")).idRuolo == "2" ? false : true,
      user: JSON.parse(localStorage.getItem("chisono_data")),
      userCRMInfo: JSON.parse(localStorage.getItem("userCRMInfo")),
      nascondiElem: false,
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
  computed: {
    noItemsMessage() {
      return this.nascondiElem
        ? "Non sei abilitato"
        : "Nessun contatto presente";
    },
  },
  watch: {
    filtroOperatore() {
      if (
        this.filtroOperatore == true &&
        this.user["idUtente"] != 140 &&
        this.userCRMInfo.idRuolo != "2"
      ) {
        this.items = this.items.filter((item) => {
          return item.user_ins_id == this.userCRMInfo.idbroker;
        });
      } else {
        this.aggiorna_grid(this.step);
      }
    },
    gridType() {
      this.updateFields();
      this.updateItems();
    },
  },
  methods: {
    async fetchAvanzamento(item) {

      // console.log(item);
      let totalCompletedVideos = 0;
      let totalVideos = 0;
      let avanzamento = 0;
      let quizAvailable = false;

      // Itera su ciascun corso e calcola il numero di video completati e il numero totale di video
      item.corso.forEach(course => {
        totalCompletedVideos += course.video.filter(video => video.completed).length;
        totalVideos += course.video.length;
        course.quiz == 1 ? quizAvailable = true : quizAvailable = false;
      });
      if (totalVideos === 0) {
        avanzamento = 0; // Per evitare divisioni per zero
      } else {
        quizAvailable ? totalVideos = totalVideos + 1 : totalVideos;
        avanzamento = Math.round((totalCompletedVideos / (totalVideos)) * 100);
      }
      if (item.corso[0].superato == 1) {
        avanzamento = 100;
      }
      // console.log(item.corso[0].superato);
      // Aggiungi l'avanzamento a ciascun corso
      item.corso.forEach(course => {
        course.avanzamento = avanzamento;
      });


      return;
    },
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
            { key: "giorno_formazione", label: "Inizio E-learning" },
            { key: "avanzamento_corso", label: "Avanzamento corso" },
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
        this.step = [1, 2, 20];
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
      let param = { step: stato };
      try {
        const response = await axios.post(
          this.$custom_json.base_url +
          this.$custom_json.api_url +
          this.$custom_json.crm.getListaByStep,
          param
        );
        return response.data;
      } catch (error) {
        console.error(error);
        return [];
      }
    },
    async aggiorna_grid(state) {
      if (
        this.user["idUtente"] == 140 &&
        this.gridType != "formazione" &&
        this.gridType != "attivazione_account" &&
        this.gridType != "utenti_attivi" &&
        this.gridType != "eliminati" &&
        this.gridType != "ricerca"
      ) {
        this.items = [];
        this.nascondiElem = true;
      } else {
        this.nascondiElem = false;
        this.getLista(state).then((candidati) => {
          this.items = candidati
            .filter((item) => {
              if (this.userCRMInfo.idRuolo == "6") {
                return item.id_segnalatore == this.userCRMInfo.idbroker;
              } else {
                if (
                  this.filtroOperatore == true &&
                  this.user["idUtente"] != 140
                  // && this.userCRMInfo.idRuolo != "2"
                ) {
                  return item.user_ins_id == this.userCRMInfo.idbroker || item.id_referente == this.userCRMInfo.idbroker;
                } else {
                  if (this.gridType == "formazione"
                    && this.user["idUtente"] != 140
                    && this.userCRMInfo.idRuolo == "7") {
                    return true; // Se siamo in formazione e l'utente è un operatore allora mostro tutti i candidati
                  } else {
                    return true; // Se l'utente non ha il ruolo 6, mostra tutti gli elementi
                  }
                }
              }
            })
            .map((item) => {
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
              if (this.gridType == "formazione") {
                // SE IL CANDIDATO NON HA ANCORA PRENOTATO EVIDENZIO LA RIGA
                this.fetchAvanzamento(item);
              }
              // Se ha già prenotato la data per la formazione allora controllo se è scaduta, se è oggi o se deve arrivare
              // if (this.gridType == "formazione" && item.formatore) {
              //   const giornoFormazione = new Date(item.data_formazione);
              //   const oggi = new Date();
              //   const formattedOggi = oggi.toISOString().slice(0, 10);
              //   const formattedGiornoFormazione = giornoFormazione
              //     .toISOString()
              //     .slice(0, 10);
              //   if (formattedGiornoFormazione === formattedOggi) {
              //     item._classes = "green accent-3";
              //   } else if (formattedGiornoFormazione > formattedOggi) {
              //     // la data è futura non cambio colore alla riga
              //   } else {
              //     // data scaduta
              //     item._classes = "red";
              //   }
              // }

              return {
                ...item,
                candidato: candidato,
              };
            });
        });
      }
    },
  },
  mounted() {
    this.updateFields();
    this.updateItems();
  },
};
</script>
