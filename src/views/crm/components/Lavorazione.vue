<template>
  <v-dialog
    v-model="dialog"
    fullscreen
    hide-overlay
    transition="dialog-bottom-transition"
  >
    <template v-slot:activator="{ on, attrs }">
      <v-btn color="primary" dark v-bind="attrs" v-on="on">
        <i class="fas fa-user-edit"> </i> Lavora contatto
      </v-btn>
    </template>

    <v-card>
      <v-container>
        <v-toolbar dark color="blue darken-1">
          <v-btn icon dark @click="dialog = false">
            <v-icon>mdi-close</v-icon>
          </v-btn>
          Lavorazione {{ candidato.candidate }}
          <v-spacer></v-spacer>
          <v-toolbar-items>
            <v-btn text dark @click="dialog = false"> Salva </v-btn>
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
        <v-row>
          <v-col cols="12" sm="4" md="4">
            <v-radio-group row v-model="preferenzaIncontro">
              <template v-slot:label>
                <div>Richiesto incontro commerciale / Mini Demo</div>
              </template>
              <v-radio label="Si" value="si"></v-radio>
              <v-radio label="No" value="no" checked></v-radio>
            </v-radio-group>
          </v-col>
          <v-col cols="12" sm="4" md="4">
            <div v-if="preferenzaIncontro === 'si'">
              Giorno fissato per l'appuntamento
              <v-date-picker
                v-model="dataIncontro"
                no-title
                locale="it-it"
                format="dd/MM/yyyy"
              ></v-date-picker>
            </div>
          </v-col>
          <v-col cols="12" sm="4" md="4">
            <div v-if="preferenzaIncontro === 'si'">
              <v-text-field
                v-model="oraIncontro"
                label="Orario appuntamento"
                prepend-inner-icon="mdi-clock-time-four-outline"
                outlined
              ></v-text-field>
            </div>
            <div v-if="preferenzaIncontro === 'si'">
              Luogo:
              <v-radio-group v-model="luogoIncontro">
                <v-radio label="c/o nostra Sede" value="sede"></v-radio>
                <v-radio label="Web Meeting / Mini-Demo" value="web"></v-radio>
              </v-radio-group>
            </div>
          </v-col>
        </v-row>
        <v-divider></v-divider>
        <div class="container">
          <div class="pb-3 font-weight-bold h5">
            Scrivi alcune righe per descrivere il colloquio con il candidato
          </div>
          <VueEditor v-model="nota_primo_contatto"></VueEditor>
        </div>
      </v-container>
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
  watch: {
    preferenzaIncontro() {
      this.dataIncontro = "";
      this.oraIncontro = "";
      this.luogoIncontro = "";
    },
  },
  data() {
    return {
      dialog: false,
      conferma: false,
      nota_primo_contatto: "",
      preferenzaIncontro: "no",
      dataIncontro: null,
      oraIncontro: null,
      luogoIncontro: "",
      user: JSON.parse(localStorage.getItem("chisono_data")),
    };
  },
};
</script>
