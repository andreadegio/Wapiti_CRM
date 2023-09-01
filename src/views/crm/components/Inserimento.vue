<template>
  <div>
    <div class="text-center display-1">NUOVO CONTATTO</div>
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

          <v-row v-if="tipoPersona === 'PF'">
            <v-col cols="12" sm="4" md="4">
              <v-text-field outlined v-model="nome" label="Nome"></v-text-field>
            </v-col>
            <v-col cols="12" sm="4" md="4">
              <v-text-field
                outlined
                v-model="cognome"
                label="Cognome"
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="4" md="4">
              <v-text-field
                outlined
                v-model="cf"
                label="Codice Fiscale"
              ></v-text-field>
            </v-col>
          </v-row>
          <v-row>
            <v-col v-if="tipoPersona === 'PG'" cols="12" sm="4" md="4">
              <v-text-field
                outlined
                v-model="ragioneSociale"
                label="Ragione Sociale"
              ></v-text-field>
            </v-col>
            <v-col v-if="tipoPersona === 'PG'" cols="12" sm="4" md="4">
              <v-text-field
                outlined
                v-model="partitaIva"
                label="Partita IVA"
              ></v-text-field>
            </v-col>
            <v-col v-if="tipoPersona === 'PG'" cols="12" sm="4" md="4">
              <v-text-field
                outlined
                v-model="referente"
                label="Referente"
              ></v-text-field>
            </v-col>
          </v-row>
          <section :class="{ disabled_input: tipoPersona === '' }">
            <v-row>
              <v-col cols="12" sm="3" md="3">
                <v-text-field
                  outlined
                  v-model="agenzia"
                  label="Agenzia"
                ></v-text-field>
              </v-col>
              <v-col cols="12" sm="3" md="3">
                <v-select
                  id="originOption"
                  outlined
                  v-model="provenienza"
                  :items="originiOptions"
                  item-value="id_origin"
                  item-text="desc"
                  label="Origine del contatto"
                ></v-select>
                <div class="nuova_origine" @click="addOriginOption()">
                  <i class="fas fa-plus-circle fa-2x"> </i>
                  <p style="margin-left: 0.5rem">Aggiungi nuova origine</p>
                </div>
              </v-col>
              <v-col cols="12" sm="3" md="3">
                <v-select
                  outlined
                  v-model="tipologia"
                  :items="tipologiaOptions"
                  item-value="id_tipologia"
                  item-text="desc"
                  label="Tipologia"
                ></v-select
              ></v-col>
              <v-col cols="12" sm="3" md="3">
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
                <v-radio-group v-model="iscrittoRui" row class="iscrittoRui">
                  <template v-slot:label>
                    <div>Iscritto al RUI</div>
                  </template>
                  <v-radio label="Si" value="si"></v-radio>
                  <v-radio label="No" value="no" checked></v-radio>
                </v-radio-group>
              </v-col>
              <v-col cols="12" sm="3" md="3">
                <v-text-field
                  outlined
                  v-if="iscrittoRui === 'si'"
                  v-model="numeroIscrizione"
                  label="Numero Iscrizione"
                ></v-text-field
              ></v-col>
              <v-col cols="12" sm="3" md="3">
                <v-text-field
                  outlined
                  v-if="iscrittoRui === 'si'"
                  v-model="dataIscrizione"
                  label="Data Iscrizione"
                  type="date"
                ></v-text-field>
              </v-col>
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
                    <v-radio label="c/o Candidato" value="candidato"></v-radio>
                    <v-radio label="c/o nostra Sede" value="sede"></v-radio>
                    <v-radio
                      label="Web Meeting / Mini-Demo"
                      value="web"
                    ></v-radio>
                  </v-radio-group>
                </div>
              </v-col>
            </v-row>
            <v-row>
              <v-textarea v-model="note" label="Note" outlined></v-textarea>
            </v-row>
            <v-row>
              <v-btn
                color="primary"
                elevation="2"
                large
                @click="salvaContatto()"
                >Salva</v-btn
              >
            </v-row>
          </section>
        </v-form>
      </v-container>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      tipoPersona: "",
      nome: "",
      cognome: "",
      cf: "",
      ragioneSociale: "",
      partitaIva: "",
      referente: "",
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
      dataIscrizione: null,
      preferenzaIncontro: "no",
      dataIncontro: null,
      oraIncontro: null,
      luogoIncontro: "",
      note: "",
      originiOptions: [],
      tipologiaOptions: [],
    };
  },
  mounted() {
    this.getProvenienze();
    this.getTipologia();
  },
  watch: {
    tipoPersona() {
      // Inizializzo i campi se passo da una tipologia all'altra
      //   if (newTipo == 'PF'){

      //   }
      // else if (newTipo=='PG'){
      //   // reset dei campi
      // }
      this.nome = "";
      this.cognome = "";
      this.cf = "";
      this.ragioneSociale = "";
      this.partitaIva = "";
      this.referente = " ";
    },
    iscrittoRui() {
      this.numeroIscrizione = "";
      this.dataIscrizione = null;
    },
    preferenzaIncontro() {
      this.dataIncontro = "";
      this.oraIncontro = "";
      this.luogoIncontro = "";
    },
  },
  methods: {
    async addOriginOption() {
      // Aggiungo un origine nella select
      this.$prompt("Inserisci una nuova origine").then((text) => {
        if (text) {
          // this.originiOptions.push(text);
          // Aggiungo il valore sul db
          let param = {
            nuovaOrigine: text,
          };
          try {
            axios
              .post(
                this.$custom_json.base_url +
                  this.$custom_json.api_url +
                  this.$custom_json.ep_api.addSource,
                param
              )
              .then((response) => {
                var message = response.data.message;
                switch (response.data.esito) {
                  case "OK":
                    this.$alert(
                      "Nuova origine inserita correttamente",
                      "OK",
                      "success"
                    );
                    this.getProvenienze();
                    break;
                  case "KO":
                    this.$alert(message, "Attenzione", "warning");
                    break;
                }
              });
          } catch (error) {
            this.$alert(text, "Attenzione", "warning");
          }
        }
      });
    },
    async getProvenienze() {
      try {
        await axios
          .get(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.getSource
          )
          .then((response) => {
            this.originiOptions = response.data;
          });
      } catch (error) {
        console.error(error);
      }
    },
    async getTipologia() {
      try {
        await axios
          .get(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.getTipo
          )
          .then((response) => {
            this.tipologiaOptions = response.data;
          });
      } catch (error) {
        console.error(error);
      }
    },
    async salvaContatto() {
      // Controllo campi obbligatori

      // Controllo formale dei dati
      var param = {
        tipo_persona: this.tipoPersona,
        nome: this.nome,
        cognome: this.cognome,
        codiceFiscale: this.cf,
        ragioneSociale: this.ragioneSociale,
        partitaIva: this.partitaIva,
        referente: this.referente,
        agenzia: this.agenzia,
        provenienza: this.provenienza,
        tipologia: this.tipologia,
        priorita: this.priorita,
        iscrittoRui: this.iscrittoRui,
        cellulare: this.cellulare,
        telefono: this.telefono,
        email: this.email,
        via: this.via,
        civico: this.civico,
        comune: this.comune,
        provincia: this.provincia,
        regione: this.regione,
        cap: this.cap,
        numeroIscrizione: this.numeroIscrizione,
        dataIscrizione: this.dataIscrizione,
        preferenzaIncontro: this.preferenzaIncontro,
        dataIncontro: this.dataIncontro,
        oraIncontro: this.oraIncontro,
        luogoIncontro: this.luogoIncontro,
        note: this.note,
      };
      // invio i dati al backend
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.newContatto,
            param
          )
          .then((response) => {
            var message = response.data.message;
            switch (response.data.esito) {
              case "OK":
                this.$alert(message, "OK", "success");
                break;
              case "KO":
                this.$alert(message, "Attenzione", "warning");
                break;
            }
          });
      } catch (error) {
        console.log("Errore di comunicazione con il back-end");
      }
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
  /* border: 1px solid #1976d2; */
  /* border-radius: 5px; */
  padding: 0.5rem;
  padding-bottom: 0.5rem;
  padding-bottom: 0.1rem !important;
  width: fit-content;
}
</style>
