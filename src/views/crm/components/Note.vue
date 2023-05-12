<template>
  <v-dialog v-model="dialog" persistent max-width="600px">
    <template v-slot:activator="{ on, attrs }">
      <v-btn color="primary" dark v-bind="attrs" v-on="on">
        Aggiungi nota
      </v-btn>
    </template>
    <v-card>
      <v-card-title>
        <span class="text-h5">Aggiungi una nota per {{ candidato }}</span>
      </v-card-title>
      <v-card-text>
        <v-container>
          <VueEditor v-model="nota"></VueEditor>
        </v-container>
        <v-checkbox
          v-model="riprogrammaCall"
          label="Programma nuovo giorno per contattare il candidato"
        >
        </v-checkbox>
        <v-row>
          <v-col cols="12" sm="6" md="6">
            <div v-if="riprogrammaCall">
              <v-date-picker
                v-model="dataIncontro"
                no-title
                locale="it-it"
                format="dd/MM/yyyy"
              ></v-date-picker>
            </div>
          </v-col>
          <v-col cols="12" sm="6" md="6">
            <div v-if="riprogrammaCall">
              <v-text-field
                v-model="oraIncontro"
                label="Orario appuntamento"
                prepend-inner-icon="mdi-clock-time-four-outline"
                outlined
              ></v-text-field>
            </div>
          </v-col>
        </v-row>
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="blue darken-1" text @click="dialog = false">
          Chiudi
        </v-btn>
        <v-btn color="blue darken-1" text @click="saveNote"> Salva </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
import { VueEditor } from "vue2-editor";
export default {
  name: "Note",
  components: {
    VueEditor,
  },
  props: {
    itemId: {
      type: Number,
      required: true,
    },
    candidato: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      dialog: false,
      nota: "",
      riprogrammaCall: false,
      dataIncontro: "",
      oraIncontro: "",
    };
  },
  methods: {
    open() {
      this.dialog = true;
    },
    saveNote() {
      // codice per salvare la nota con itemId
      this.dialog = false;
    },
  },
};
</script>
