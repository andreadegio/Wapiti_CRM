<template>
  <v-dialog v-model="dialog2" max-width="600px" persistent>
    <template v-slot:activator="{ on, attrs }">
      <v-btn color="#1f4b6b" dark v-bind="attrs" v-on="on"
        ><i class="fas fa-user-lock"></i>&nbsp;Attiva account
      </v-btn>
    </template>
    <v-card class="text-center">
      <v-card-text>
        <v-container>
          <div class="text-h5" style="color: #1f4b6b">
            Attivazione <br />
            {{ candidato.candidato }}
          </div>
          <section>
            <div class="container pb-0">
              <div class="pb-3 font-weight-bold h5">
                Breve descrizione sull'attivazione
              </div>

              <v-textarea
                rows="4"
                outlined
                v-model="notaAttivazione"
              ></v-textarea>
            </div>
            <v-divider class="mt-0"></v-divider>
            <v-row class="text-center">
              <v-container>
                <v-row>
                  <v-checkbox style="font-weight: 600" v-model="attiva">
                    <template v-slot:label>
                      <span>Conferma di aver attivato l'utente</span>
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
          v-if="attiva"
          color="#1f4b6b"
          dark
          @click="(dialog2 = false), AttivaCandidato()"
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
  name: "Formazione",
  props: ["candidato", "step"],
  computed: {
    isSaveButtonDisabled() {
      if (this.notaAttivazione && this.attiva) {
        return false;
      }
      return true;
    },
  },
  data() {
    return {
      dialog2: false,
      notaAttivazione: "",

      attiva: false,
      user: JSON.parse(localStorage.getItem("chisono_data")),
    };
  },
  methods: {
    async AttivaCandidato() {
      let params = {
        contatto: this.candidato,
        notaAttivazione: this.notaAttivazione || "",
        utente: this.user,
      };
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.crm.AttivaCandidato,
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
      this.attiva = false;
      this.notaAttivazione = "";
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
