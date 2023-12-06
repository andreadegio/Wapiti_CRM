<template>
  <div>
    <v-dialog v-model="dialog2" max-width="600px" persistent>
      <v-card class="pa-3" v-if="!metodoContatto">
        <h1 class="title mb-4" style="color: red">
          Nessuna modalità di contatto selezionata
        </h1>
        <p class="mb-5">Per favore, seleziona una modalità di contatto</p>
        <v-btn color="primary" @click="dialog2 = !dialog2">Ok</v-btn>
      </v-card>
      <v-card
        class="pa-3"
        v-else-if="metodoContatto == 'telefono' && !combinazioni"
      >
        <h1 class="title mb-4" style="color: red">
          Opzioni mancanti o incomplete
        </h1>
        <p class="mb-5">
          Non è stata selezionata alcuna opzione sull'esito della telefonata
          oppure le informazioni sono incomplete, verifica di aver inserito data
          ed ora nel caso di prenotazione di una Demo o per riprogrammare la
          chiamata
        </p>
        <v-btn color="primary" @click="dialog2 = !dialog2">Chiudi</v-btn>
      </v-card>
      <v-card
        v-else-if="metodoContatto == 'telefono' && combinazioni"
        class="text-center"
      >
        <v-card-text>
          <v-container>
            <div class="text-h5" style="color: #1f4b6b">
              Conferma di aver contattato <br />
              {{ candidato.candidato }} <br />tramite
              {{ metodoContatto }}
            </div>
            <section>
              <div
                class="container pb-0"
                v-if="!richiama && metodoContatto == 'telefono'"
              >
                <div
                  v-if="rifiuta"
                  class="pb-3 font-weight-bold h5"
                  style="color: darkred"
                >
                  Scrivi la motivazione per cui vuoi eliminare il candidato
                </div>
                <div
                  v-else
                  class="pb-3 font-weight-bold h5"
                  style="color: #1f4b6b"
                >
                  Descrivere brevemente il colloquio con il candidato
                </div>
                <v-textarea
                  rows="4"
                  outlined
                  v-model="nota_primo_contatto"
                ></v-textarea>
              </div>
              <v-divider class="mt-0"></v-divider>
              <v-row align-content="center" align="center">
                <v-checkbox
                  v-if="preferenzaDemo"
                  style="font-weight: 600"
                  v-model="confermaDemo"
                >
                  <template v-slot:label>
                    Conferma di aver fissato una Demo in data
                    {{ dataDemo | formatDate }} alle ore {{ oraDemo }}
                  </template>
                </v-checkbox>
                <v-checkbox
                  v-if="metodoContatto == 'telefono'"
                  style="font-weight: 600; color: darkred !important"
                  color="red darken-3"
                  v-model="confermaTelefono"
                >
                  <template v-slot:label>
                    <span v-if="rifiuta" style="color: darkred !important"
                      >Confermando elimini il contato dall'elenco</span
                    >
                    <span
                      v-else-if="richiama"
                      style="color: darkred !important"
                    >
                      Confermando riprogrammi la chiamata in data
                      {{ dataChiamata | formatDate }}</span
                    >
                    <span v-else-if="!rifiuta && !richiama"
                      >Conferma di aver contattato il candidato</span
                    >
                  </template>
                </v-checkbox>
              </v-row>
              <v-row>
                <v-col cols="12" sm="6" md="6">
                  <small>
                    {{ !richiama ? "Contattato" : "Riprogrammato" }} in data e
                    ora<br />
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
            @click="(dialog2 = false), lavoraContatto()"
            :class="{ disabled_input: isSaveButtonDisabled }"
            ><i class="far fa-save"></i> &nbsp;
            {{ !rifiuta ? "Salva" : "Elimina" }}
          </v-btn>
        </v-card-actions>
      </v-card>
      <v-card v-else-if="metodoContatto != 'telefono'" class="text-center">
        <v-card-text>
          <v-container>
            <div class="text-h5" style="color: #1f4b6b">
              Conferma di aver contattato <br />
              {{ candidato.candidato }} <br />tramite
              {{ metodoContatto == "forza_mail" ? "mail" : "mail" }}
            </div>
            <section>
              <div
                class="container pb-0"
                v-if="!richiama && metodoContatto == 'telefono'"
              >
                <div class="pb-3 font-weight-bold h5" style="color: #1f4b6b">
                  Descrivere brevemente il colloquio con il candidato
                </div>
                <v-textarea
                  rows="4"
                  outlined
                  v-model="nota_primo_contatto"
                ></v-textarea>
              </div>

              <div v-if="metodoContatto == 'social'">
                <div class="font-weight-bold h5" style="color: #1f4b6b">
                  Quale social è stato utilizzato?
                </div>
                <v-radio-group v-model="socialMethod">
                  <v-radio label="LinkedIn" value="linkedin"></v-radio>
                  <v-radio label="Facebook" value="facebook"></v-radio>
                </v-radio-group>
                <v-text-field
                  v-if="
                    socialMethod === 'linkedin' || socialMethod === 'facebook'
                  "
                  outlined
                  label="Inserisci il link del profilo social"
                  v-model="socialLink"
                ></v-text-field>
              </div>

              <v-divider class="mt-0"></v-divider>
              <v-row align-content="center" align="center">
                <v-checkbox
                  v-if="preferenzaDemo"
                  style="font-weight: 600"
                  v-model="confermaDemo"
                >
                  <template v-slot:label>
                    Conferma di aver fissato una Demo in data
                    {{ dataDemo | formatDate }} alle ore {{ oraDemo }}
                  </template>
                </v-checkbox>
                <v-checkbox
                  v-if="
                    metodoContatto == 'email' || metodoContatto == 'forza_mail'
                  "
                  style="font-weight: 600"
                  v-model="confermaMail"
                  label="Conferma di voler contattare tramite l'invio della mail"
                ></v-checkbox>
                <v-checkbox
                  v-if="metodoContatto == 'social'"
                  style="font-weight: 600"
                  v-model="confermaSocial"
                  label="Conferma di aver contattato tramite social"
                ></v-checkbox>
              </v-row>
              <v-row>
                <v-col cols="12" sm="6" md="6">
                  <small>
                    {{ !richiama ? "Contattato" : "Riprogrammato" }} in data e
                    ora<br />
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
            @click="(dialog2 = false), lavoraContatto()"
            :class="{ disabled_input: isSaveButtonDisabled }"
            ><i class="far fa-save"></i> &nbsp; Salva
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-dialog
      v-model="dialog"
      fullscreen
      hide-overlay
      transition="dialog-bottom-transition"
    >
      <template v-slot:activator="{ on, attrs }">
        <v-btn color="#1f4b6b" outlined v-bind="attrs" v-on="on">
          <i class="far fa-address-card"></i> &nbsp;Scheda
        </v-btn>
      </template>
      <v-card>
        <v-container>
          <v-toolbar dark color="#1f4b6b">
            <v-btn
              icon
              dark
              @click="
                dialog = false;
                resetBeforeClose();
              "
            >
              <v-icon>mdi-close</v-icon>
            </v-btn>
            Scheda anagrafica di:&nbsp; {{ candidato.candidato }} &nbsp;
            <small>
              contatto inserito in data: &nbsp;{{
                candidato.data_ins | formatDate
              }}</small
            >
            <v-spacer></v-spacer>
            <v-alert
              dense
              elevation="4"
              outlined
              text
              type="warning"
              v-if="anaIncompleta"
            >
              Attenzione la scheda anagrafica è incompleta</v-alert
            >
            <v-spacer></v-spacer>
          </v-toolbar>
          <scheda
            :candidato="candidato"
            @updateCandidato="updateCandidato"
          ></scheda>

          <v-divider></v-divider>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="#1f4b6b" dark @click="dialog = false">
              <i class="fas fa-times"></i>&nbsp; Chiudi
            </v-btn>
          </v-card-actions>
        </v-container>
      </v-card>
    </v-dialog>
  </div>
</template>
<script>
import scheda from "./Scheda.vue";
export default {
  name: "Lavorazione",
  components: {
    scheda,
  },
  props: ["step", "itemId", "candidato"],

  data() {
    return {
      dialog: false,
      dialog2: false,

      user: JSON.parse(localStorage.getItem("chisono_data")),
    };
  },
  methods: {
    updateCandidato() {
      this.$emit("aggiorna_grid", this.step);
    },
  },
  computed: {
    anaIncompleta() {
      if (
        this.candidato.tipologia == "PF" &&
        this.candidato.cf != "" &&
        (this.candidato.telefono != null || this.candidato.cell != null) &&
        this.candidato.mail != null
      ) {
        return false;
      }
      if (
        this.candidato.tipologia == "PG" &&
        this.candidato.piva != "" &&
        (this.candidato.telefono != null || this.candidato.cell != null) &&
        this.candidato.mail != null
      ) {
        return false;
      }
      return true;
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
