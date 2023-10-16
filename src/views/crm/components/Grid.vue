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

      <template #actions="row">
        <div class="d-flex">
          <Lavorazione
            class="ml-2"
            :itemId="row.item.id"
            :candidato="row.item"
          ></Lavorazione>
          <Note :itemId="row.item.id" :candidato="row.item.candidate"></Note>
          <CButton
            class="mx-2"
            color="danger"
            @click="rejectCandidate(row.item.id)"
            variant="ghost"
            ><i class="fas fa-user-slash"></i> Rifiuta contatto
          </CButton>
        </div>
      </template>
    </CDataTable>
  </div>
</template>
<script>
import axios from "axios";
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
      items: [],
      fields: [
        { key: "state", label: "Stato" },
        { key: "tipologia", label: "PF/PG" },
        { key: "candidate", label: "Candidato" },
        { key: "type", label: "RUI" },
        { key: "contact_origin", label: "Fonte" },
        { key: "provincia", label: "Provincia" },
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
      this.fields = [
        { key: "state", label: "Stato" },
        { key: "tipologia", label: "PF/PG" },
        { key: "candidate", label: "Candidato" },
        { key: "type", label: "RUI" },
        { key: "contact_origin", label: "Fonte" },
        { key: "provincia", label: "Provincia" },
        { key: "region", label: "Regione" },
        { key: "actions", label: "Azioni" },
      ];
    },
    updateItems() {
      // Logica per aggiornare il valore di "items" in base a "gridType"
      var stato = "";
      var step = 0;

      if (this.gridType === "primo_contatto") {
        step = 1;
        stato = "Nuovo";
      }
      if (this.gridType === "webinar") {
        step = 2;
        stato = "Contattato";
      }
      if (this.gridType === "solleciti") {
        step = 3;
        stato = "Sollecito documenti";
      }
      if (this.gridType === "registrazione_documentazione") {
        step = 4;
        stato = "Attesa documenti";
      }
      if (this.gridType === "formazione") {
        step = 5;
        stato = "Documenti registrati";
      }
      if (this.gridType === "attivazione_account") {
        step = 6;
        stato = "Formazione fatta";
      }
      if (this.gridType === "follow_up") {
        step = 7;
        stato = "Nuova attivazione";
        //inserire richiesta ws
        // this.items = [
        //   {
        //     id: 1,
        //     state: "Account attivato",
        //     candidate: "Mario Rossi",
        //     type: "Sezione E",
        //     contact_origin: "LinkedIn",
        //     email: "mario.rossi@email.com",
        //     region: "Lombardia",
        //     tel: "02123456",
        //     cell: "333123456",
        //   },
        //   {
        //     id: 2,
        //     state: "Follow-up",
        //     candidate: "Giuseppe Bianchi",
        //     type: "Agente",
        //     contact_origin: "Sito web aziendale",
        //     email: "giuseppe.bianchi@email.com",
        //     region: "Toscana",
        //     tel: "02123456",
        //     cell: "333123456",
        //     _classes: "bg-warning",
        //   },
        // ];
      }

      if (step != 0) {
        // Se è stato scelto un pulsante valido allora recupero le liste
        this.getLista(step).then((candidati) => {
          this.items = candidati.map((item) => {
            if (item.rag_soc) {
              var candidato = item.rag_soc;
            } else {
              candidato = item.nome + " " + item.cognome;
            }
            return {
              id: item.id,
              state: stato,
              candidate: candidato,
              type: item.RUI,
              contact_origin: item.origine,
              mail: item.mail,
              region: item.regione,
              provincia: item.provincia,
              tel: item.telefono,
              cell: item.cell,
              tipologia: item.tipologia,
              referente: item.referente,
              cf: item.cf,
              piva: item.piva,
              agenzia: item.agenzia,
              numRui: item.numRui,
              via: item.via,
              civico: item.civico,
              cap: item.cap,
              comune: item.comune,
            };
          });
        });
      }
    },
    async getLista(stato) {
      console.log(stato);
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
