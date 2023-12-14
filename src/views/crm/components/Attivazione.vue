<template>
  <div>
    <v-dialog v-model="preview" max-width="800px">
      <v-card>
        <v-toolbar dark color="#1f4b6b">
          {{ previewFileName }}
          <v-spacer></v-spacer>
          <v-btn icon @click="preview = false">
            <v-icon>mdi-close</v-icon>
          </v-btn>
        </v-toolbar>
        <v-card-text>
          <object
            width="100%"
            height="600"
            :data="previewUrl"
            type="application/pdf"
          ></object>
          <!-- <iframe width="100%" height="600px" :src="previewUrl"></iframe> -->
        </v-card-text>
      </v-card>
    </v-dialog>
    <v-dialog
      v-model="dialog2"
      fullscreen
      hide-overlay
      transition="dialog-bottom-transition"
      persistent
    >
      <template v-slot:activator="{ on, attrs }">
        <v-btn
          color="#1f4b6b"
          dark
          v-bind="attrs"
          v-on="on"
          @click="getUploadedFiles()"
          ><i class="fas fa-user-lock"></i>&nbsp;Attiva account
        </v-btn>
      </template>
      <v-card class="text-center">
        <v-card-text>
          <v-container>
            <v-toolbar dark color="#1f4b6b">
              <v-btn icon dark @click="dialog2 = false">
                <v-icon>mdi-close</v-icon>
              </v-btn>
              <div class="text-h5">Attiva &nbsp;{{ candidato.candidato }}</div>
            </v-toolbar>
            <scheda
              :candidato="candidato"
              @updateCandidato="updateCandidato"
            ></scheda>
            <v-divider></v-divider>
            <v-row justify="space-around">
              <v-col cols="12" sm="6"
                ><v-tabs centered color="warning">
                  <v-tab
                    ><v-icon left>mdi-file-document-edit-outline</v-icon
                    >Documentazione</v-tab
                  >
                  <v-tab
                    ><v-icon left>
                      mdi-information-variant-circle-outline </v-icon
                    >info</v-tab
                  >
                  <v-tab-item>
                    <v-divider></v-divider>
                    <section
                      id="documenti caricati"
                      v-if="uploadedFiles.length > 0"
                      class="text-left"
                    >
                      <h3 style="color: #1f4b6b">
                        <strong>Documenti caricati:</strong>
                      </h3>
                      <v-simple-table dense>
                        <template v-slot:default>
                          <thead>
                            <tr>
                              <th class="text-left">Documento</th>
                              <th class="text-left">Anteprima</th>
                            </tr>
                          </thead>
                          <tbody align="left">
                            <tr v-for="item in fileRichiesti" :key="item.label">
                              <td>
                                {{ item.label }}<br />
                                <p
                                  :style="{
                                    color:
                                      item.validato == 0
                                        ? 'orange'
                                        : item.validato == 1
                                        ? 'green'
                                        : '',
                                  }"
                                >
                                  <i
                                    class="far fa-pause-circle fa-lg"
                                    v-show="item.validato == 0"
                                  ></i>
                                  <i
                                    class="far fa-check-circle fa-lg"
                                    v-show="item.validato == 1"
                                  ></i>
                                  <small>
                                    {{
                                      item.validato == null
                                        ? "Documento non ancora caricato"
                                        : item.validato == 0
                                        ? "Caricato, in attesa di validazione"
                                        : "Documento validato"
                                    }}</small
                                  >
                                </p>
                              </td>
                              <td style="cursor: pointer; padding: 10px">
                                <v-img
                                  style="border: 1px solid grey"
                                  height="100"
                                  width="100"
                                  v-if="item.validato != null"
                                  :src="
                                    $custom_json.base_url +
                                    $custom_json.api_url +
                                    'crm/pub/thumbs/' +
                                    candidato.id_anagrafica +
                                    item.tipo +
                                    '.jpg'
                                  "
                                  @click="openPreview(item)"
                                ></v-img>
                              </td>
                            </tr>
                          </tbody>
                        </template>
                      </v-simple-table>
                    </section>
                    <section v-else>
                      <h3 style="color: #1f4b6b">
                        <strong>Documenti caricati:</strong>
                      </h3>
                      <p>Il candidato non ha caricato documenti</p>
                    </section>
                  </v-tab-item>
                  <v-tab-item>
                    <v-divider></v-divider>
                    <section>
                      <div>Lista delle operazioni effettuate</div>
                    </section>
                  </v-tab-item>
                </v-tabs>
                <v-divider></v-divider
              ></v-col>
              <v-col cols="12" sm="4">
                <section
                  style="
                    border: 1px solid red;
                    border-radius: 5px;
                    padding: 20px;
                    background-color: rgb(249, 242, 230);
                  "
                >
                  <div>
                    <div
                      class="pb-3 font-weight-bold h5"
                      style="color: #1f4b6b"
                    >
                      Inserisci le credenziali assegnate per l'accesso alla
                      piattaforma Abyway
                    </div>
                    <v-text-field
                      outlined
                      background-color="white"
                      v-model="username"
                      label="Username"
                    ></v-text-field>
                    <v-text-field
                      v-model="password"
                      background-color="white"
                      outlined
                      :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
                      :type="show1 ? 'text' : 'password'"
                      label="Password"
                      @click:append="show1 = !show1"
                    ></v-text-field>
                    <div class="pb-3 font-weight-bold h5">
                      Breve descrizione sull'attivazione
                    </div>
                    <v-textarea
                      background-color="white"
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
                            <span>Conferma di voler attivare l'utente</span>
                          </template>
                        </v-checkbox>
                      </v-row>
                    </v-container>
                  </v-row>
                  <v-row>
                    <v-col cols="12" sm="6" md="6">
                      <small>
                        Salvato in data e ora<br />
                        <strong>{{
                          new Date().toLocaleString("it-IT")
                        }}</strong>
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
                <v-card-actions class="mt-4">
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
                    @click="(dialog2 = false), AttivaCandidato()"
                    :class="{ disabled_input: isSaveButtonDisabled }"
                    ><i class="far fa-save"></i> &nbsp;Salva
                  </v-btn>
                </v-card-actions></v-col
              >
            </v-row>
          </v-container>
        </v-card-text>
      </v-card>
    </v-dialog>
  </div>
</template>
<script>
import axios from "axios";
import scheda from "./Scheda.vue";
export default {
  name: "Attivazione",
  components: { scheda },
  props: ["candidato", "step"],
  computed: {
    isSaveButtonDisabled() {
      if (
        this.notaAttivazione &&
        this.attiva &&
        this.username &&
        this.password
      ) {
        return false;
      }
      return true;
    },
  },
  data() {
    return {
      dialog2: false,
      notaAttivazione: "",
      password: "",
      username: "",
      attiva: false,
      show1: false,
      previewFileName: "",
      preview: false,
      previewUrl: "",
      uploadedFiles: [],
      fileRichiesti: [],
      user: JSON.parse(localStorage.getItem("chisono_data")),
    };
  },
  methods: {
    updateCandidato() {
      this.$emit("aggiorna_grid", this.step);
    },
    openPreview(doc) {
      let params = {
        nomeFile: doc.tipo + ".pdf",
        idAnagrafica: this.candidato.id_anagrafica,
      };

      axios
        .post(
          this.$custom_json.base_url +
            this.$custom_json.api_url +
            this.$custom_json.crm.getPresignedUrl,
          params
        )
        .then((response) => {
          const presignedUrl = response.data.presignedUrl;
          this.previewFileName = doc.label;
          // Apri l'URL prefirmato nella modale di anteprima
          this.previewUrl = presignedUrl; // Assegna l'URL prefirmato a una variabile nel data
          this.preview = true; // Mostra la modale di anteprima
        })
        .catch((error) => {
          console.error("Errore nel recuperare l'URL prefirmato:", error);
          // Gestisci l'errore, ad esempio mostrando un messaggio all'utente
        });
    },
    async getUploadedFiles() {
      let tipo = "";
      switch (this.candidato.id_tipologia) {
        case 1:
          tipo = "BA";
          break;
        case 2:
          tipo = "BB";
          break;
        case 3:
          tipo = "BE";
          break;

        default:
          tipo = "BE";
          break;
      }
      let param = {
        t: tipo, // tipologia di rapporto dominio: BE BA BB
        i: this.candidato.numRui ? 1 : 0, // flag iscritto / non iscritto
      };

      try {
        const response = await axios.post(
          this.$custom_json.base_url +
            this.$custom_json.api_url +
            this.$custom_json.crm.getListaDocs,
          param
        );
        this.fileRichiesti = response.data;
      } catch (error) {
        console.error("Errore durante il recupero dei files richiesti", error);
      }
      let params = {
        idAnagrafica: this.candidato.id_anagrafica,
      };

      try {
        const response = await axios.post(
          this.$custom_json.base_url +
            this.$custom_json.api_url +
            this.$custom_json.crm.getFilesById,
          params
        );
        this.uploadedFiles = response.data;
        this.matchAndUpdateDocuments(); // Dopo aver recuperato uploadedFiles, fai il match
      } catch (error) {
        console.error("Errore durante il recupero dei files caricati", error);
      }
    },
    matchAndUpdateDocuments() {
      // Itera sui documenti richiesti
      if (this.uploadedFiles.length > 0 && this.fileRichiesti.length > 0) {
        this.fileRichiesti.forEach((docRic) => {
          // Trova il corrispondente documento in uploadedFiles
          const uploadedDoc = this.uploadedFiles.find(
            (uploadedDoc) => uploadedDoc.tipo_documento == docRic.tipo
          );

          if (uploadedDoc) {
            // Se il documento è stato trovato in uploadedFiles, aggiorna i valori in file richiesti
            docRic.idDoc = uploadedDoc.id;
            docRic.validato = uploadedDoc.validato;
            docRic.data_ins = uploadedDoc.data_ins;
            docRic.disabled = true;
            docRic.selezionato = false; //utilizzato per marcare i doc da validare o rifiutare
          }
        });
      }
    },
    async AttivaCandidato() {
      let params = {
        contatto: this.candidato,
        userBroker: this.username,
        pwdBroker: this.password,
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
