<template>
  <div>
    <v-dialog
      v-model="dialog"
      fullscreen
      hide-overlay
      transition="dialog-bottom-transition"
    >
      <template v-slot:activator="{ on, attrs }">
        <v-btn color="#1f4b6b" outlined v-bind="attrs" v-on="on">
          <i class="far fa-address-card"></i> &nbsp;Scheda
        </v-btn>
      </template>
      <v-card>
        <v-container>
          <v-toolbar dark color="#1f4b6b">
            <v-btn icon dark @click="dialog = false">
              <v-icon>mdi-close</v-icon>
            </v-btn>
            Scheda anagrafica di:&nbsp; {{ candidato.candidato }} &nbsp;
            <small>
              contatto inserito in data: &nbsp;{{
                candidato.data_ins | formatDate
              }}</small
            >
            <v-spacer></v-spacer>
            <v-alert
              dense
              elevation="4"
              outlined
              text
              type="warning"
              v-if="anaIncompleta"
            >
              Attenzione la scheda anagrafica è incompleta</v-alert
            >
            <v-spacer></v-spacer>
          </v-toolbar>
          <scheda
            :candidato="candidato"
            @updateCandidato="updateCandidato"
          ></scheda>

          <v-divider></v-divider>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="#1f4b6b" dark @click="dialog = false">
              <i class="fas fa-times"></i>&nbsp; Chiudi
            </v-btn>
          </v-card-actions>
        </v-container>
      </v-card>
    </v-dialog>
  </div>
</template>
<script>
import scheda from "./Scheda.vue";
export default {
  name: "InfoCandidato",
  components: {
    scheda,
  },
  props: ["step", "itemId", "candidato"],

  data() {
    return {
      dialog: false,

      user: JSON.parse(localStorage.getItem("chisono_data")),
    };
  },
  methods: {
    updateCandidato() {
      this.$emit("aggiorna_grid", this.step);
    },
  },
  computed: {
    anaIncompleta() {
      if (
        this.candidato.tipologia == "PF" &&
        this.candidato.cf != "" &&
        (this.candidato.telefono != null || this.candidato.cell != null) &&
        this.candidato.mail != null
      ) {
        return false;
      }
      if (
        this.candidato.tipologia == "PG" &&
        this.candidato.piva != "" &&
        (this.candidato.telefono != null || this.candidato.cell != null) &&
        this.candidato.mail != null
      ) {
        return false;
      }
      return true;
    },
  },
};
</script>
<style scoped>
.disabled_input {
  pointer-events: none;
  opacity: 0.5;
}
</style>
