<template>
  <v-dialog
    v-model="dialog"
    fullscreen
    hide-overlay
    transition="dialog-bottom-transition"
  >
    <template v-slot:activator="{ on, attrs }">
      <v-btn color="primary" dark v-bind="attrs" v-on="on">
        Lavora candidatura
      </v-btn>
    </template>
    <v-card>
      <v-toolbar dark color="primary">
        <v-btn icon dark @click="dialog = false">
          <v-icon>mdi-close</v-icon>
        </v-btn>
        Lavorazione {{ candidato.candidate }}
        <v-spacer></v-spacer>
        <v-toolbar-items>
          <v-btn dark text @click="dialog = false"> Salva </v-btn>
        </v-toolbar-items>
      </v-toolbar>
      <scheda :candidato="candidato"></scheda>

      <v-divider></v-divider>

      <v-row align-content="center" align="center">
        <v-col>
          <v-checkbox
            v-model="conferma"
            :label="'Conferma di aver contattato il candidato'"
          ></v-checkbox>
        </v-col>
        <v-col>
          Contattato in data e ora
          <strong>{{ new Date().toLocaleString("it-IT") }}</strong>
        </v-col>
        <v-col>
          Operatore <strong>{{ user.Nominativo }}</strong>
        </v-col>
      </v-row>
      <v-divider></v-divider>
      <div class="container">
        <div class="pb-3 font-weight-bold h5">
          Scrivi alcune righe per descrivere il colloquio con il candidato
        </div>
        <VueEditor v-model="nota_primo_contatto"></VueEditor>
      </div>
    </v-card>
  </v-dialog>
</template>
<script>
import { VueEditor } from "vue2-editor";
import scheda from "./Scheda.vue";
export default {
  name: "Lavorazione",
  components: {
    VueEditor,
    scheda,
  },
  props: {
    itemId: {
      type: Number,
      required: true,
    },
    candidato: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      dialog: false,
      conferma: false,
      nota_primo_contatto: "",
      user: JSON.parse(localStorage.getItem("chisono_data")),
    };
  },
};
</script>