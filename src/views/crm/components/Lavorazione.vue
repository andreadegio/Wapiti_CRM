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
        v-else-if="
          metodoContatto == 'telefono' && combinazioni && candidato.mail
        "
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
      <v-card
        v-else-if="
          metodoContatto == 'telefono' && combinazioni && !candidato.mail
        "
        class="text-center"
      >
        <h1 class="title mb-4" style="color: red">Indirizzo email assente</h1>
        <p class="mb-5">
          Non è possibile proseguire se non si inserisce un'indirizzo email
          valido nella scheda del candidato.
        </p>
        <v-btn color="primary" @click="dialog2 = !dialog2">Chiudi</v-btn>
      </v-card>
      <v-card v-else-if="metodoContatto != 'telefono'" class="text-center">
        <v-card-text>
          <v-container>
            <div class="text-h5" style="color: #1f4b6b">
              Conferma di aver contattato <br />
              {{ candidato.candidato }} <br />tramite
              {{ metodoContatto == "forza_mail" ? "mail" : "social" }}
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
        <v-btn color="#1f4b6b" dark v-bind="attrs" v-on="on">
          <i class="fas fa-user-edit"> </i> &nbsp;Contatta
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
            Lavorazione:&nbsp; {{ candidato.candidato }} &nbsp;
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
            <!-- <v-toolbar-items>
              <v-btn text dark @click="dialog2 = true"
                ><i class="fas fa-save fa-2x"></i> &nbsp; Salva
              </v-btn>
            </v-toolbar-items> -->
          </v-toolbar>
          <scheda
            :candidato="candidato"
            @updateCandidato="updateCandidato"
          ></scheda>

          <v-overlay
            v-if="candidato.richiama"
            :value="candidato.richiama && !forzaChiamata"
          >
            <div
              style="background-color: white; max-width: 600px; padding: 20px"
            >
              <div v-if="scadenza == 'waiting'">
                <v-alert color="blue" dense elevation="6" type="error">
                  La chiamata è stata programmata per il giorno<br />
                  <strong>{{
                    candidato.richiama[0].giorno | formatDate
                  }}</strong>
                  alle ore {{ candidato.richiama[0].orario }}</v-alert
                >
                <v-btn
                  color="blue-grey lighten-2"
                  @click="
                    dialog = false;
                    resetBeforeClose();
                  "
                >
                  Chiudi
                </v-btn>
                <v-btn
                  color="success"
                  @click="forzaChiamata = true"
                  class="ml-4"
                >
                  Chiama adesso
                </v-btn>
              </div>
              <div v-if="scadenza == 'oggi'">
                <v-alert color="green" dense elevation="6" type="error">
                  La chiamata è stata programmata per oggi alle ore
                  {{ candidato.richiama[0].orario }}</v-alert
                >
                <v-btn
                  color="blue-grey lighten-2"
                  @click="
                    dialog = false;
                    resetBeforeClose();
                  "
                >
                  Chiudi
                </v-btn>
                <v-btn
                  color="success"
                  @click="forzaChiamata = true"
                  class="ml-4"
                >
                  Chiama adesso
                </v-btn>
              </div>
              <div v-if="scadenza == 'scaduto'">
                <v-alert color="red" dense elevation="6" type="error">
                  Appuntamento scaduto. La chiamata era stata programmata per il
                  giorno
                  {{ candidato.richiama[0].giorno | formatDate }} alle ore
                  {{ candidato.richiama[0].orario }}</v-alert
                >
                <v-btn
                  color="blue-grey lighten-2"
                  @click="
                    dialog = false;
                    resetBeforeClose();
                  "
                >
                  Chiudi
                </v-btn>
                <v-btn
                  color="warning"
                  @click="forzaChiamata = true"
                  class="ml-4"
                >
                  Chiama adesso
                </v-btn>
              </div>
            </div>
          </v-overlay>
          <v-divider></v-divider>
          <div v-if="candidato.richiama && candidato.richiama.length > 2">
            <p class="h5" style="color: red">
              Sono stati fatti già {{ candidato.richiama.length }} tentativi di
              contatto telefonico, inviare un email al candidato oppure
              rimuoverlo
            </p>
            <v-btn
              color="#1f4b6b"
              dark
              @click="(dialog2 = true), (metodoContatto = 'forza_mail')"
              >Invia Mail</v-btn
            >
          </div>
          <div v-else>
            <section id="modalita_contatto">
              <h3 style="color: #1f4b6b">
                <strong>Modalità di contatto:</strong>
              </h3>

              <small
                >Seleziona il metodo utilizzato per contattare il
                candidato</small
              >
              <v-alert
                dense
                type="warning"
                v-if="candidato.richiama"
                class="ml-4"
              >
                Attenzione il candidato è stato già contattato
                {{ candidato.richiama.length }}
                {{ candidato.richiama.length > 1 ? "volte" : "volta" }}</v-alert
              >
              <v-row>
                <v-col cols="12" sm="6" md="6">
                  <v-radio-group v-model="metodoContatto" row>
                    <v-radio
                      label="Telefono"
                      value="telefono"
                      :disabled="!candidato.telefono && !candidato.cell"
                    ></v-radio>
                    <v-radio
                      label="Email"
                      value="email"
                      :disabled="richiama || !candidato.mail"
                    ></v-radio>
                    <v-radio
                      label="Social"
                      value="social"
                      :disabled="richiama"
                    ></v-radio>
                  </v-radio-group>
                </v-col>
                <v-col
                  v-if="metodoContatto == 'telefono'"
                  cols="12"
                  sm="3"
                  md="3"
                  :class="{
                    disabled_input: richiama || rifiuta,
                  }"
                >
                <v-checkbox label="Interessato al settore Altri Rami"></v-checkbox>
                  
                </v-col>
                <v-col
                  v-if="metodoContatto == 'telefono'"
                  cols="12"
                  sm="3"
                  md="3"
                  :class="{
                    disabled_input: richiama || rifiuta,
                  }"
                >
                <v-checkbox label="Interessato al settore Energia"></v-checkbox>
                  
                </v-col>
                <!-- <v-col
                  v-if="metodoContatto == 'telefono'"
                  cols="12"
                  sm="4"
                  md="4"
                  :class="{
                    disabled_input: richiama || rifiuta,
                  }"
                >
                  <v-btn color="warning">Questionario assuntivo</v-btn>
                </v-col> -->
              </v-row>
            </section>
            <v-divider></v-divider>
            <v-tooltip
              top
              :color="metodoContatto !== 'telefono' ? 'warning' : 'transparent'"
            >
              <template v-slot:activator="{ on, attrs }">
                <section v-bind="attrs" v-on="on" id="opzioni_contatto">
                  <div
                    :class="{
                      disabled_input:
                        !metodoContatto || metodoContatto != 'telefono',
                    }"
                  >
                    <h3 style="color: #1f4b6b">
                      <strong>Opzioni:</strong>
                    </h3>
                    <small
                      >Scegli se procedere, rifiutare, programmare una demo
                      oppure riprogrammare la call
                    </small>
                    <v-row>
                      <v-col
                        cols="12"
                        sm="4"
                        md="4"
                        :class="{
                          disabled_input: richiama || rifiuta || preferenzaDemo,
                        }"
                      >
                        <v-checkbox
                          style="font-weight: 600; color: #1f4b6b !important"
                          v-model="accetta"
                          :checked="preferenzaDemo"
                          :label="'Accetta / Interessato'"
                        ></v-checkbox>
                      </v-col>
                      <v-col
                        cols="12"
                        sm="4"
                        md="4"
                        :class="{
                          disabled_input: richiama || accetta || preferenzaDemo,
                        }"
                      >
                        <v-checkbox
                          style="font-weight: 600; color: #1f4b6b !important"
                          v-model="rifiuta"
                          color="red darken-3"
                          :label="'Rifiuta / Non interessato'"
                        ></v-checkbox>
                      </v-col>
                    </v-row>
                    <v-row>
                      <v-col
                        cols="12"
                        sm="4"
                        md="4"
                        :class="{ disabled_input: richiama || rifiuta }"
                      >
                        <v-checkbox
                          style="font-weight: 600; color: #1f4b6b !important"
                          v-model="preferenzaDemo"
                          :label="'Prenota una Demo'"
                        ></v-checkbox>
                      </v-col>
                      <v-col
                        cols="12"
                        sm="4"
                        md="4"
                        :class="{
                          disabled_input: rifiuta || accetta || preferenzaDemo,
                        }"
                      >
                        <v-checkbox
                          style="font-weight: 600; color: #1f4b6b !important"
                          v-model="richiama"
                          :label="'Riprogramma telefonata'"
                        ></v-checkbox>
                      </v-col>
                    </v-row>
                  </div>
                </section>
              </template>
              <span v-if="metodoContatto !== 'telefono'"
                >Disponibili solo per contatto telefonico</span
              >
            </v-tooltip>
            <v-divider v-if="preferenzaDemo || richiama"></v-divider>
            <section>
              <v-row>
                <v-col cols="12" sm="4" md="4" v-if="preferenzaDemo">
                  <div>
                    <v-date-picker
                      v-model="dataDemo"
                      color="#1f4b6b"
                      no-title
                      locale="it-it"
                      format="dd/MM/yyyy"
                      :min="today"
                    ></v-date-picker>
                  </div>
                </v-col>
                <v-col cols="12" sm="4" md="4" v-if="preferenzaDemo">
                  <div>
                    <v-select
                      v-model="oraDemo"
                      label="Orario appuntamento"
                      prepend-inner-icon="mdi-clock-time-four-outline"
                      outlined
                      :items="rangeOrari"
                    ></v-select>
                  </div>
                </v-col>
                <v-col cols="12" sm="4" md="4" v-if="richiama">
                  <div>
                    <v-date-picker
                      v-model="dataChiamata"
                      color="#1f4b6b"
                      no-title
                      locale="it-it"
                      format="dd/MM/yyyy"
                      :min="today"
                    ></v-date-picker>
                  </div>
                </v-col>
                <v-col cols="12" sm="4" md="4" v-if="richiama">
                  <div>
                    <v-select
                      v-model="oraChiamata"
                      label="Orario nuova chiamata"
                      prepend-inner-icon="mdi-clock-time-four-outline"
                      outlined
                      :items="rangeOrari"
                    ></v-select>
                  </div>
                  <div>
                    <v-textarea
                      v-model="motivoRichiama"
                      rows="3"
                      label="Motivo"
                      outlined
                    ></v-textarea>
                  </div>
                </v-col>
              </v-row>
            </section>
          </div>
          <v-divider></v-divider>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
              color="blue-grey"
              outlined
              @click="
                dialog = false;
                resetBeforeClose();
              "
            >
              <i class="fas fa-times"></i>&nbsp; Chiudi
            </v-btn>
            <v-btn color="#1f4b6b" dark @click="dialog2 = true"
              ><i class="fas fa-save fa-2x"></i> &nbsp; Salva
            </v-btn>
          </v-card-actions>
        </v-container>
      </v-card>
    </v-dialog>
  </div>
</template>
<script>
import axios from "axios";
import scheda from "./Scheda.vue";
export default {
  name: "Lavorazione",
  components: {
    scheda,
  },
  props: ["step", "itemId", "candidato"],
  mounted() {
    this.checkScadenza();
  },
  watch: {
    metodoContatto() {
      this.preferenzaDemo = false;
      this.richiama = false;
      this.accetta = false;
      this.rifiuta = false;
    },
    preferenzaDemo() {
      this.preferenzaDemo ? (this.accetta = true) : (this.accetta = false);
      this.dataDemo = "";
      this.oraDemo = "";
    },
    richiama() {
      this.preferenzaDemo = false;
      this.dataChiamata = null;
      this.oraChiamata = null;
      this.motivoRichiama = null;
      this.accetta = false;
      this.conferma = false;
      this.confermaDemo = false;
    },
  },
  data() {
    return {
      scadenza: "waiting",
      forzaChiamata: false,
      today: new Date().toISOString().substr(0, 10),
      dialog: false,
      dialog2: false,
      richiama: false,
      confermaSocial: false,
      confermaMail: false,
      confermaDemo: false,
      confermaTelefono: false,
      nota_primo_contatto: "",
      preferenzaDemo: false,
      dataDemo: null,
      oraDemo: null,
      dataChiamata: null,
      oraChiamata: null,
      metodoContatto: null,
      socialLink: null,
      socialMethod: null,
      rifiuta: false,
      accetta: false,
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
      motivoRichiama: "",
      user: JSON.parse(localStorage.getItem("chisono_data")),
    };
  },
  methods: {
    checkScadenza() {
      //assegno la scadenza
      if (this.candidato.richiama) {
        const giornoRichiamo = new Date(this.candidato.richiama[0].giorno);
        const oggi = new Date();

        // Trasformo le date in formato "YYYY-MM-DD" per poterle confrontare correttamente
        const formattedGiornoRichiamo = giornoRichiamo
          .toISOString()
          .slice(0, 10);
        const formattedOggi = oggi.toISOString().slice(0, 10);

        if (formattedGiornoRichiamo === formattedOggi) {
          // La data è odierna
          this.scadenza = "oggi";
        } else if (formattedGiornoRichiamo > formattedOggi) {
          // La data è futura
          this.scadenza = "waiting";
        } else {
          // La data è già trascorsa
          this.scadenza = "scaduto";
        }
      }
    },
    resetBeforeClose() {
      this.scadenza = "waiting";
      this.forzaChiamata = false;
      this.metodoContatto = null;
      this.accetta = false;
      this.rifiuta = false;
      this.richiama = false;
      this.preferenzaDemo = false;
    },
    resetModaleConferme() {
      // reset dei checkbox
      this.confermaSocial = false;
      this.confermaTelefono = false;
      this.confermaMail = false;
      this.confermaDemo = false;

      // reset dei campi compilabili
      this.nota_primo_contatto = null;
      this.socialMethod = null;
      this.socialLink = null;
    },
    async lavoraContatto() {
      // Salvataggio ed avanzamento di stato
      // preparo i parametri da passare al ws
      let params = {
        contatto: this.candidato,
        notePrimoContatto: this.nota_primo_contatto || "",
        canalePrimoContatto: this.metodoContatto,
        preferenzaDemo: this.preferenzaDemo ? true : false,
        dataDemo: this.dataDemo,
        oraDemo: this.oraDemo,
        dataChiamata: this.dataChiamata,
        oraChiamata: this.oraChiamata,
        richiamare: this.richiama,
        motivoRecall: this.motivoRichiama,
        profiloSocial: this.socialLink,
        tipoSocial: this.socialMethod,
        accetta: this.accetta,
        rifiuta: this.rifiuta,
        utente: this.user,
      };
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.crm.lavoraContatto,
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
        this.candidato.mail
      ) {
        return false;
      }
      if (
        this.candidato.tipologia == "PG" &&
        this.candidato.piva != "" &&
        (this.candidato.telefono != null || this.candidato.cell != null) &&
        this.candidato.mail
      ) {
        return false;
      }
      return true;
    },
    isSaveButtonDisabled() {
      if (this.metodoContatto === "social") {
        if (this.socialMethod && this.confermaSocial && this.socialLink) {
          return false;
        }
      }
      if (
        this.metodoContatto == "email" ||
        this.metodoContatto == "forza_mail"
      ) {
        return !this.confermaMail;
      }
      if (this.metodoContatto === "telefono") {
        if (this.preferenzaDemo) {
          if (
            this.nota_primo_contatto &&
            this.confermaTelefono &&
            this.confermaDemo
          ) {
            return false;
          }
          return true;
        }
        if (this.nota_primo_contatto && this.confermaTelefono) {
          return false;
        }
        if (this.richiama) {
          return !this.confermaTelefono;
        }
        return true;
      }

      return true;
    },
    combinazioni() {
      if (this.metodoContatto == "telefono") {
        if (this.accetta && !this.preferenzaDemo) {
          return true;
        }
        if (
          this.accetta &&
          this.preferenzaDemo &&
          this.dataDemo != "" &&
          this.oraDemo != ""
        ) {
          return true;
        }
        if (this.rifiuta) {
          return true;
        }
        if (
          this.richiama &&
          this.dataChiamata != null &&
          this.oraChiamata != null &&
          (this.motivoRichiama != "" || this.motivoRichiama != null)
        ) {
          return true;
        }
      }

      return false;
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
