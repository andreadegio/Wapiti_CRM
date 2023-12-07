<template>
  <v-dialog v-model="dialog2" max-width="600px" persistent>
    <template v-slot:activator="{ on, attrs }">
      <v-btn color="#1f4b6b" dark v-bind="attrs" v-on="on"
        ><i class="fas fa-desktop"></i>&nbsp;Demo
      </v-btn>
    </template>
    <v-card class="text-center">
      <v-card-text>
        <v-container>
          <div class="text-h5" style="color: #1f4b6b">
            Conferma di aver fatto la demo a <br />
            {{ candidato.candidato }}
          </div>
          <section>
            <div class="container pb-0">
              <div class="pb-3 font-weight-bold h5">
                Descrivi come si è svolta la demo
              </div>

              <v-textarea rows="4" outlined v-model="notaDemo"></v-textarea>
            </div>
            <v-divider class="mt-0"></v-divider>
            <v-row class="text-center">
              <v-container>
                <div class="pb-3 font-weight-bold h5 text-center">
                  Cosa vuol fare il candidato?
                </div>
                <v-row>
                  <v-col cols="12" sm="6">
                    <v-checkbox
                      style="font-weight: 600; color: green !important"
                      color="green"
                      v-model="prosegui"
                    >
                      <template v-slot:label>
                        <span style="color: green !important"
                          >INTERESSATO, procede con l'invio dei documenti</span
                        >
                      </template>
                    </v-checkbox></v-col
                  >
                  <v-col cols="12" sm="6">
                    <v-checkbox
                      style="font-weight: 600; color: darkred !important"
                      color="red darken-3"
                      v-model="confermaDel"
                    >
                      <template v-slot:label>
                        <span style="color: darkred !important"
                          >NON INTERESSATO, confermando elimini il contato
                          dall'elenco</span
                        >
                      </template>
                    </v-checkbox></v-col
                  >
                </v-row>
              </v-container>
            </v-row>
            <v-row>
              <v-col cols="12" sm="6" md="6">
                <small>
                  {{ confermaDel ? "Eliminato" : "Salvato" }} in data e ora<br />
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
          v-if="confermaDel"
          color="#1f4b6b"
          dark
          @click="(dialog2 = false), EliminaContatto()"
          :class="{ disabled_input: isSaveButtonDisabled }"
          ><i class="far fa-trash-alt"></i> &nbsp;Elimina
        </v-btn>
        <v-btn
          v-if="prosegui"
          color="#1f4b6b"
          dark
          @click="(dialog2 = false), AvanzaCandidato()"
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
  name: "Demo",
  props: ["candidato", "step"],
  computed: {
    isSaveButtonDisabled() {
      if (this.notaDemo && (this.confermaDel || this.prosegui)) {
        return false;
      }
      return true;
    },
  },
  data() {
    return {
      dialog2: false,
      notaDemo: "",
      confermaDel: false,
      prosegui: false,
      user: JSON.parse(localStorage.getItem("chisono_data")),
    };
  },
  watch: {
    confermaDel() {
      this.confermaDel ? (this.prosegui = false) : this.prosegui;
    },
    prosegui() {
      this.prosegui ? (this.confermaDel = false) : this.confermaDel;
    },
  },
  methods: {
    async AvanzaCandidato() {
      let params = {
        contatto: this.candidato,
        notaDemo: this.notaDemo || "",
        utente: this.user,
      };
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.crm.accettaDemo,
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
    async EliminaContatto() {
      let params = {
        contatto: this.candidato,
        notaDemo: this.notaDemo || "",
        utente: this.user,
      };
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.crm.eliminaContatto,
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
      this.confermaDel = false;
      this.notaDemo = "";
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
