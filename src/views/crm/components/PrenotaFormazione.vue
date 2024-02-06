<template>
  <v-dialog v-model="dialog2" max-width="600px" persistent>
    <template v-slot:activator="{ on, attrs }">
      <v-btn color="#1f4b6b" dark v-bind="attrs" v-on="on"
        ><i class="far fa-calendar-alt"></i>&nbsp;Prenota
      </v-btn>
    </template>
    <v-card class="text-center">
      <v-card-text>
        <v-container>
          <div class="text-h5" style="color: #1f4b6b">
            Il Candidato <br />
            {{ candidato.candidato }} <br />
            deve prenotare la sessione formativa
          </div>
          <section>
            <div class="container pb-0">
              <div class="pb-3 font-weight-bold h5">
                Scegli il giorno e l'ora
              </div>
              <v-row>
                <div>
                  <v-date-picker
                    v-model="dataFormazione"
                    color="#1f4b6b"
                    no-title
                    locale="it-it"
                    format="dd/MM/yyyy"
                    :min="today"
                  ></v-date-picker>
                </div>

                <div>
                  <v-select
                    v-model="oraFormazione"
                    label="Orario appuntamento"
                    prepend-inner-icon="mdi-clock-time-four-outline"
                    outlined
                    :items="rangeOrari"
                  ></v-select>
                </div>
              </v-row>
            </div>
            <v-divider class="mt-0"></v-divider>
            <v-row class="text-center">
              <v-container>
                <v-row>
                  <v-checkbox style="font-weight: 600" v-model="prosegui">
                    <template v-slot:label>
                      <span
                        >Conferma di voler prenotare per il giorno:
                        {{ dataFormazione | formatDate }} alle ore
                        {{ oraFormazione }} la formazione</span
                      >
                    </template>
                  </v-checkbox>
                </v-row>
              </v-container>
            </v-row>
            <v-row>
              <v-col cols="12" sm="6" md="6">
                <small>
                  Salvato in data e ora<br />
                  <strong>{{ new Date().toLocaleString("it-IT") }}</strong>
                </small>
              </v-col>
              <v-col cols="12" sm="6" md="6">
                <small>
                  Operatore<br />
                  <strong>{{ user.Nominativo }}</strong>
                </small>
              </v-col>
            </v-row>
          </section>
        </v-container>
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <CButton
          class="mx-2"
          color="danger"
          @click="
            dialog2 = false;
            resetModaleConferme();
          "
          variant="ghost"
          ><i class="fas fa-times"></i>&nbsp; Annulla
        </CButton>
        <v-btn
          v-if="prosegui"
          color="#1f4b6b"
          dark
          @click="(dialog2 = false), PrenotaFormazione()"
          :class="{ disabled_input: isSaveButtonDisabled }"
          ><i class="far fa-save"></i> &nbsp;Salva
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>
<script>
import axios from "axios";
export default {
  name: "PrenotaFormazione",
  props: ["candidato", "step"],
  computed: {
    isSaveButtonDisabled() {
      if (this.prosegui && this.dataFormazione && this.oraFormazione) {
        return false;
      }
      return true;
    },
  },
  data() {
    return {
      rangeOrari: [
        { text: "09:00", value: "09:00" },
        { text: "09:30", value: "09:30" },
        { text: "10:00", value: "10:00" },
        { text: "10:30", value: "10:30" },
        { text: "11:00", value: "11:00" },
        { text: "11:30", value: "11:30" },
        { text: "12:00", value: "12:00" },
        { text: "12:30", value: "12:30" },
        { text: "15:00", value: "15:00" },
        { text: "15:30", value: "15:30" },
        { text: "16:00", value: "16:00" },
        { text: "16:30", value: "16:30" },
        { text: "17:00", value: "17:00" },
      ],
      dialog2: false,
      prosegui: false,
      dataFormazione: null,
      oraFormazione: null,
      user: JSON.parse(localStorage.getItem("chisono_data")),
      today: new Date().toISOString().substr(0, 10),
    };
  },
  methods: {
    async PrenotaFormazione() {
      let params = {
        contatto: this.candidato,
        giornoFormazione: this.dataFormazione,
        oraFormazione: this.oraFormazione,
        utente: this.user,
      };
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.crm.PrenotaFormazione,
            params
          )
          .then((response) => {
            var message = response.data.message;
            switch (response.data.esito) {
              case "OK":
                this.$alert(message, "OK", "success");
                this.$emit("aggiorna_grid", this.step);
                break;
              case "KO":
                this.$alert(message, "Attenzione", "warning");
                break;
            }
          });
      } catch (error) {
        console.log(error);
      }
    },

    resetModaleConferme() {
      this.prosegui = false;
      this.oraFormazione = null;
      this.dataFormazione = null;
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
