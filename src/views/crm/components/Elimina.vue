<template>
  <v-dialog v-model="dialog2" max-width="600px" persistent>
    <template v-slot:activator="{ on, attrs }">
      <!-- <v-btn color="blue-grey" dark v-bind="attrs" v-on="on" class="ml-2">
        <i class="far fa-edit"></i> Aggiungi nota
      </v-btn> -->
      <CButton
        v-bind="attrs"
        v-on="on"
        class="mx-2"
        color="danger"
        variant="ghost"
        ><i class="fas fa-user-slash"></i>&nbsp;Rifiuta
      </CButton>
    </template>
    <v-card class="text-center">
      <v-card-text>
        <v-container>
          <div class="text-h5" style="color: darkred">
            Conferma di voler eliminare <br />
            {{ candidato.candidato }}
          </div>
          <section>
            <div class="container pb-0">
              <div class="pb-3 font-weight-bold h5">
                Scrivi la motivazione per cui vuoi eliminare il candidato
              </div>

              <v-textarea rows="4" outlined v-model="notaDel"></v-textarea>
            </div>
            <v-divider class="mt-0"></v-divider>
            <v-row align-content="center">
              <v-checkbox
                style="font-weight: 600; color: darkred !important"
                color="red darken-3"
                v-model="confermaDel"
              >
                <template v-slot:label>
                  <span style="color: darkred !important"
                    >Confermando elimini il contato dall'elenco</span
                  >
                </template>
              </v-checkbox>
            </v-row>
            <v-row>
              <v-col cols="12" sm="6" md="6">
                <small>
                  Eliminato in data e ora<br />
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
          color="#1f4b6b"
          dark
          @click="(dialog2 = false), EliminaContatto()"
          :class="{ disabled_input: isSaveButtonDisabled }"
          ><i class="far fa-trash-alt"></i> &nbsp;Elimina
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>
<script>
import axios from "axios";
export default {
  name: "RimuoviContatto",
  props: ["candidato", "step"],
  computed: {
    isSaveButtonDisabled() {
      if (this.notaDel && this.confermaDel) {
        return false;
      }
      return true;
    },
  },
  data() {
    return {
      dialog2: false,
      notaDel: "",
      confermaDel: false,
      user: JSON.parse(localStorage.getItem("chisono_data")),
    };
  },
  methods: {
    async EliminaContatto() {
      let params = {
        contatto: this.candidato,
        notaDel: this.notaDel || "",
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
      this.confermaDel = false;
      this.notaDel = "";
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
