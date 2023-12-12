<template>
  <div>
    <v-tooltip bottom color="#1f4b6b">
      <template v-slot:activator="{ on, attrs }">
        <v-btn
          color="warning"
          fab
          x-small
          class="ml-2"
          v-bind="attrs"
          v-on="on"
          @click="openLogModal"
        >
          <v-icon>mdi-alarm</v-icon>
        </v-btn>
      </template>
      <span>Cronologia</span>
    </v-tooltip>
    <v-dialog v-model="logMode" width="600px">
      <v-card>
        <v-card-title>
          <span class="text-h5"
            >Cronologia delle operazioni sul candidato<br />
            {{ candidato.candidato }}</span
          >
        </v-card-title>
        <v-card-text>
          <v-timeline align-top dense>
            <v-timeline-item
              :color="getItemColor(item)"
              small
              v-for="item in logData"
              :key="item.id_log"
            >
              <v-row class="pt-1">
                <v-col cols="3">
                  <strong>{{ item.data | formatDate }}</strong>
                </v-col>
                <v-col>
                  <strong>{{ item.action }}</strong>
                  <div class="text-caption">
                    {{ item.desc }}
                    <br /><cite
                      style="font-size: 0.6rem; color: #1f4b6b !important"
                      >{{ item.nome_user }}</cite
                    >
                  </div>
                </v-col>
              </v-row>
            </v-timeline-item>
          </v-timeline>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn outlined color="blue-grey" text @click="logMode = !logMode">
            <i class="fas fa-times"></i>&nbsp; chiudi
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import axios from "axios";
export default {
  props: {
    candidato: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      logData: [],
      logMode: false,
    };
  },
  methods: {
    async openLogModal() {
      let params = {
        idAnagrafica: this.candidato.id_anagrafica,
      };
      try {
        const response = await axios.post(
          this.$custom_json.base_url +
            this.$custom_json.api_url +
            this.$custom_json.crm.getLogByIdAnagrafica,
          params
        );
        this.logData = response.data;
        this.logMode = true;
      } catch (error) {
        console.error("Errore durante il recupero dei log:", error);
      }
    },
    getItemColor(item) {
      return item.action === "NUOVO INSERIMENTO"
        ? "green"
        : item.action === "ATTIVAZIONE UTENTE"
        ? "green"
        : item.action === "ELIMINATO"
        ? "red"
        : item.action === "RIFIUTATO"
        ? "red"
        : this.getTimelineColor(item);
    },
    getTimelineColor(item) {
      return this.logData.indexOf(item) % 2 == 0 ? "#1f4b6b" : "teal lighten-3";
    },
  },
};
</script>
<style scoped>
.iscrittoRui {
  margin-top: 0px !important;
  padding-top: 0px !important;
}
.disabled_input {
  pointer-events: none;
  opacity: 0.5;
}
.nuova_origine {
  cursor: pointer;
  color: #1976d2;
  display: flex;
  vertical-align: middle;
  top: -1rem;
  position: relative;
  font-size: 1rem;
  font-weight: 500;
  padding: 0.5rem;
  padding-bottom: 0.5rem;
  padding-bottom: 0.1rem !important;
  width: fit-content;
}
</style>
