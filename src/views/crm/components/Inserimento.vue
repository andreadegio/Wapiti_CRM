<template>
  <div>
    <div>INSERIMENTO CANDIDATURE</div>
    <div>
      <v-container>
        <v-form>
          <v-radio-group v-model="tipoPersona" row class="pb-2">
            <template v-slot:label>
              <div>Tipologia</div>
            </template>
            <v-radio label="Persona Fisica" value="PF"></v-radio>
            <v-radio label="Persona Giuridica" value="PG"></v-radio>
          </v-radio-group>

          <v-row>
            <v-col v-if="tipoPersona === 'PF'" cols="12" sm="4" md="4">
              <v-text-field outlined v-model="nome" label="Nome"></v-text-field>
            </v-col>
            <v-col v-if="tipoPersona === 'PF'" cols="12" sm="4" md="4">
              <v-text-field
                outlined
                v-model="cognome"
                label="Cognome"
              ></v-text-field>
            </v-col>
            <v-col v-if="tipoPersona === 'PF'" cols="12" sm="4" md="4">
              <v-text-field
                outlined
                v-model="cf"
                label="Codice Fiscale"
              ></v-text-field>
            </v-col>
            <v-col v-if="tipoPersona === 'PG'" cols="12" sm="6" md="6">
              <v-text-field
                outlined
                v-model="ragioneSociale"
                label="Ragione Sociale"
              ></v-text-field>
            </v-col>
            <v-col v-if="tipoPersona === 'PG'" cols="12" sm="6" md="6">
              <v-text-field
                outlined
                v-model="partitaIva"
                label="Partita IVA"
              ></v-text-field>
            </v-col>
          </v-row>

          <v-text-field
            outlined
            v-model="agenzia"
            label="Agenzia"
          ></v-text-field>
          <v-row>
            <v-col cols="12" sm="4" md="4">
              <v-select
                outlined
                v-model="provenienza"
                :items="[
                  'Sito web',
                  'Social',
                  'SNA',
                  'Contatto diretto',
                  'Contatto di terzi',
                ]"
                label="Origine del contatto"
              ></v-select>
            </v-col>
            <v-col cols="12" sm="4" md="4">
              <v-select
                outlined
                v-model="tipologia"
                :items="['Agente', 'Broker', 'Sezione E', 'Non iscritto']"
                label="Tipologia"
              ></v-select
            ></v-col>
            <v-col cols="12" sm="4" md="4">
              <v-select
                outlined
                v-model="priorita"
                :items="['Alta', 'Normale']"
                label="Priorità"
              ></v-select>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12" sm="2" md="2">
              <v-radio-group row v-model="iscrittoRui" class="iscrittoRui">
                <template v-slot:label>
                  <div>Iscritto al RUI</div>
                </template>
                <v-radio label="Si" value="si"></v-radio>
                <v-radio
                  label="No"
                  value="no"
                  checked
                ></v-radio> </v-radio-group
            ></v-col>
            <v-col cols="12" sm="3" md="3">
              <v-text-field
                outlined
                v-if="iscrittoRui === 'si'"
                v-model="numeroIscrizione"
                label="Numero Iscrizione"
              ></v-text-field
            ></v-col>
          </v-row>

          <v-row>
            <v-col cols="12" sm="6" md="4">
              <v-text-field
                outlined
                v-model="cellulare"
                label="Cellulare"
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="6" md="4">
              <v-text-field
                outlined
                v-model="telefono"
                label="Telefono"
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="6" md="4">
              <v-text-field
                outlined
                v-model="email"
                label="Email"
              ></v-text-field>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12" sm="4" md="4">
              <v-text-field outlined v-model="via" label="Via"></v-text-field>
            </v-col>
            <v-col cols="12" sm="4" md="4">
              <v-text-field
                outlined
                v-model="civico"
                label="N° Civico"
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="4" md="4">
              <v-text-field
                outlined
                v-model="cap"
                label="cap"
              ></v-text-field> </v-col
          ></v-row>
          <v-row>
            <v-col cols="12" sm="4" md="4">
              <v-text-field
                outlined
                v-model="comune"
                label="Comune"
              ></v-text-field>
            </v-col>

            <v-col cols="12" md="4" sm="4">
              <v-text-field
                outlined
                v-model="provincia"
                label="Provincia"
              ></v-text-field>
            </v-col>

            <v-col cols="12" md="4" sm="4">
              <v-text-field
                outlined
                v-model="regione"
                label="Regione"
              ></v-text-field>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12" sm="4" md="4">
              <v-radio-group row v-model="preferenzaIncontro">
                <template v-slot:label>
                  <div>Richiesto incontro commerciale</div>
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
                  <v-radio label="c/o Candidato" value="candidato"></v-radio>
                  <v-radio label="c/o nostra Sede" value="sede"></v-radio>
                  <v-radio label="Web meeting" value="web"></v-radio>
                </v-radio-group>
              </div>
            </v-col>
          </v-row>

          <v-btn color="primary" elevation="2" large>Salva</v-btn>
        </v-form>
      </v-container>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      tipoPersona: "",
      nome: "",
      cognome: "",
      cf: "",
      ragioneSociale: "",
      partitaIva: "",
      agenzia: "",
      provenienza: "",
      tipologia: "",
      priorita: "Normale",
      iscrittoRui: "no",
      cellulare: "",
      telefono: "",
      email: "",
      via: "",
      civico: "",
      comune: "",
      provincia: "",
      regione: "",
      cap: "",
      numeroIscrizione: "",
      preferenzaIncontro: "no",
      dataIncontro: null,
      oraIncontro:null,
      luogoIncontro: "",
    };
  },
  methods: {
    submitForm() {
      // implementa l'invio del form
      console.log("Form submitted");
    },
  },
};
</script>
<style scoped>
.iscrittoRui {
  margin-top: 0px !important;
  padding-top: 0px !important;
}
</style>