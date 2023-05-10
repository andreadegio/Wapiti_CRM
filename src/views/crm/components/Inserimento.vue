<template>
  <div>
    <div>INSERIMENTO CANDIDATURE</div>
    <div>
      <v-app>
        <v-main>
          <v-container>
            <v-form>
              <v-radio-group v-model="tipoPersona" row>
                <template v-slot:label>
                  <div>Tipologia</div>
                </template>
                <v-radio
                  label="Persona Fisica"
                  value="persona-fisica"
                ></v-radio>
                <v-radio
                  label="Persona Giuridica"
                  value="persona-giuridica"
                ></v-radio>
              </v-radio-group>

              <v-row>
                <v-col
                  v-if="tipoPersona === 'persona-fisica'"
                  cols="12"
                  sm="6"
                  md="6"
                >
                  <v-text-field
                    outlined
                    v-model="nome"
                    label="Nome"
                  ></v-text-field>
                </v-col>
                <v-col
                  v-if="tipoPersona === 'persona-fisica'"
                  cols="12"
                  sm="6"
                  md="6"
                >
                  <v-text-field
                    outlined
                    v-model="cognome"
                    label="Cognome"
                  ></v-text-field>
                </v-col>
                <v-col
                  v-if="tipoPersona === 'persona-giuridica'"
                  cols="12"
                  sm="6"
                  md="6"
                >
                  <v-text-field
                    outlined
                    v-model="ragioneSociale"
                    label="Ragione Sociale"
                  ></v-text-field>
                </v-col>
                <v-col
                  v-if="tipoPersona === 'persona-giuridica'"
                  cols="12"
                  sm="6"
                  md="6"
                >
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
                <v-col cols="12" sm="6" md="6">
                  <v-select
                    outlined
                    v-model="tipologia"
                    :items="['agente', 'broker', 'sezione E', 'altro']"
                    label="Tipologia"
                  ></v-select
                ></v-col>
                <v-col cols="12" sm="6" md="6">
                  <v-select
                    outlined
                    v-model="priorita"
                    :items="['Alta', 'Normale']"
                    label="Priorità"
                  ></v-select>
                </v-col>
              </v-row>
              <v-row>
                <v-col cols="12" sm="6" md="6">
                  <v-radio-group row v-model="iscrittoRui" class="iscrittoRui">
                    <template v-slot:label>
                      <div>Iscritto al RUI</div>
                    </template>
                    <v-radio label="Si" value="si"></v-radio>
                    <v-radio label="No" value="no"></v-radio> </v-radio-group
                ></v-col>
                <v-col cols="12" sm="6" md="6">
                  <v-text-field
                    outlined
                    v-if="iscrittoRui === 'si'"
                    v-model="numeroIscrizione"
                    label="Numero Iscrizione"
                  ></v-text-field
                ></v-col>
              </v-row>

              <v-row>
                <v-col cols="12" sm="4" md="4">
                  <v-text-field
                    outlined
                    v-model="cellulare"
                    label="Cellulare"
                  ></v-text-field>
                </v-col>
                <v-col cols="12" sm="4" md="4">
                  <v-text-field
                    outlined
                    v-model="telefono"
                    label="Telefono"
                  ></v-text-field>
                </v-col>
                <v-col cols="12" sm="4" md="4">
                  <v-text-field
                    outlined
                    v-model="email"
                    label="Email"
                  ></v-text-field>
                </v-col>
              </v-row>
              <v-row>
                <v-col cols="12" sm="6" md="6">
                  <v-text-field
                    outlined
                    v-model="viaCivico"
                    label="Via e Civico"
                  ></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="6">
                  <v-text-field
                    outlined
                    v-model="citta"
                    label="Città"
                  ></v-text-field>
                </v-col>
              </v-row>
              <v-row>
                <v-col cols="12" md="6" sm="6">
                  <v-text-field
                    outlined
                    v-model="provincia"
                    label="Provincia"
                  ></v-text-field>
                </v-col>

                <v-col cols="12" md="6" sm="6">
                  <v-text-field
                    outlined
                    v-model="regione"
                    label="Regione"
                  ></v-text-field>
                </v-col>
              </v-row>
              <v-row>
                <v-col cols="12" sm="4" md="4" >
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
                    Scegli il giorno fissato per l'appuntamento
                    <v-date-picker v-model="dataIncontro"></v-date-picker>
                  </div>
                </v-col>
              </v-row>

              <v-btn @click="submit">Salva</v-btn>
            </v-form>
          </v-container>
        </v-main>
      </v-app>
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
      ragioneSociale: "",
      partitaIva: "",
      agenzia: "",
      tipologia: "",
      priorita: "Normale",
      iscrittoRui: "",
      preferenzaIncontro: "no",
      dataIncontro: null,
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