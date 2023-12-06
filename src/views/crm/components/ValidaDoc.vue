<template>
  <div>
    <v-dialog v-model="preview" max-width="800px">
      <v-card>
        <v-card-title>
          Preview di {{ previewFileName }}
          <v-btn icon @click="preview = false">
            <v-icon>mdi-close</v-icon>
          </v-btn>
        </v-card-title>
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
    <v-dialog v-model="showMotivationModal" max-width="600">
      <v-card>
        <v-card-title> Motivazione del rifiuto </v-card-title>
        <v-card-text>
          <v-list v-for="(file, index) in selectedDocuments" :key="index">
            <v-list-item>
              <v-list-item-content>
                {{ file.label }}
                <v-text-field
                  v-model="file.motivation"
                  label="Motivazione del rifiuto"
                  outlined
                  counter="100"
                  :rules="[(v) => !!v || 'Inserisci la motivazione']"
                ></v-text-field>
              </v-list-item-content>
            </v-list-item>
          </v-list>
        </v-card-text>
        <v-card-actions>
          <v-btn color="red" text @click="cancelRefuse">Annulla</v-btn>
          <v-btn color="red" @click="confirmRefuse">Conferma</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-dialog v-model="confermaFormazione" max-width="600px" persistent>
      <v-card class="text-center">
        <div class="text-center text-h5">Conferma procedura di formazione</div>
        <v-card-text class="my-4">
          Confermando permetti l'accesso alla sezione formativa del candidato<br />
          <b>{{ candidato.candidato }}</b>
          <br />
          pur rimanendo dei documenti da ricevere e validare
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="red darken-1"
            outlined
            text
            @click="confermaFormazione = false"
            >Annulla</v-btn
          >
          <v-btn
            color="green darken-1"
            dark
            @click="passaggio_formazione('parziale')"
            >Conferma</v-btn
          >
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-dialog v-model="passaggioFormazione" max-width="600px" persistent>
      <v-card class="text-center">
        <div class="text-center text-h5">Conferma procedura di formazione</div>
        <v-card-text class="my-4">
          Confermando permetti l'accesso alla sezione formativa del candidato<br />
          <b>{{ candidato.candidato }}</b>
          <br />
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="red darken-1"
            outlined
            text
            @click="confermaFormazione = false"
            >Annulla</v-btn
          >
          <v-btn
            color="green darken-1"
            dark
            @click="passaggio_formazione('completo')"
            >Conferma</v-btn
          >
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
        <v-btn
          color="#1f4b6b"
          dark
          v-bind="attrs"
          v-on="on"
          @click="getFileRichiesti(), getUploadedFiles()"
        >
          <i class="far fa-file-alt"></i> &nbsp;Valida Documenti
        </v-btn>
      </template>
      <v-card>
        <v-container>
          <v-toolbar dark color="#1f4b6b">
            <v-btn icon dark @click="dialog = false">
              <v-icon>mdi-close</v-icon>
            </v-btn>
            Validazione dei documenti di:&nbsp; {{ candidato.candidato }} &nbsp;
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
          <section id="verifica_documenti">
            <h3 style="color: #1f4b6b">
              <strong>Documenti da validare:</strong>
            </h3>
            <small>Il candidato ha caricato i seguenti documenti:</small>
            <v-simple-table>
              <template v-slot:default>
                <thead>
                  <tr>
                    <th class="text-left">Documento</th>
                    <th class="text-left">Stato</th>
                    <th class="text-left">Anteprima</th>
                    <th class="text-left">Seleziona</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="item in fileRichiesti" :key="item.label">
                    <td
                      :style="{
                        color:
                          item.validato == 0
                            ? 'orange'
                            : item.validato == 1
                            ? 'green'
                            : '',
                      }"
                    >
                      {{ item.label }}
                    </td>
                    <td
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
                      {{
                        item.validato == null
                          ? "Documento non ancora caricato"
                          : item.validato == 0
                          ? "Caricato, in attesa di validazione"
                          : "Documento validato"
                      }}
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
                    <td>
                      <v-checkbox
                        v-if="item.validato != 1"
                        v-model="item.selezionato"
                        :disabled="item.validato === null"
                      ></v-checkbox>
                    </td>
                  </tr>
                </tbody>
              </template>
            </v-simple-table>
          </section>
          <v-divider></v-divider>
          <section id="Opzioni" class="text-right">
            <h3 style="color: #1f4b6b">
              <strong>Opzioni:</strong>
            </h3>
            <small v-if="!tuttiDocumentiValidati"
              >Scegli se validare o rifiutare i file selezionati
            </small>
            <small v-else
              >Sono stati caricati tutti i documenti avanza alla
              formazione</small
            >
            <div class="options-container">
              <!-- Tutti i documenti inviati documentazione completa -->
              <v-btn
                v-if="tuttiDocumentiValidati && attivaFormazione"
                color="success"
                dark
                @click="passaggioFormazione = true"
              >
                <i class="fas fa-check-circle fa-2x"></i> &nbsp; Formazione
              </v-btn>
              <!-- Solo documenti obbligatori documentazione parziale -->
              <v-btn
                v-if="
                  attivaFormazione &&
                  candidato.id_step == 9 &&
                  !tuttiDocumentiValidati
                "
                color="success"
                dark
                @click="confermaFormazione = true"
              >
                <i class="fas fa-check-circle fa-2x"></i> &nbsp; Formazione
              </v-btn>
              <v-btn
                v-if="!tuttiDocumentiValidati"
                class="ml-2"
                color="#1f4b6b"
                dark
                @click="validaDocumenti"
              >
                <i class="fas fa-check-circle fa-2x"></i> &nbsp; Valida
              </v-btn>
              <v-btn
                v-if="!tuttiDocumentiValidati"
                class="ml-2"
                color="red"
                dark
                @click="rifiutaDocumenti"
              >
                <i class="fas fa-times-circle fa-2x"></i> &nbsp; Rifiuta
              </v-btn>
            </div>
          </section>

          <v-divider></v-divider>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="blue-grey" outlined @click="dialog = false">
              <i class="fas fa-times"></i>&nbsp; Chiudi
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
  name: "ValidaDoc",
  components: {
    scheda,
  },
  props: ["step", "itemId", "candidato"],
  data() {
    return {
      selectedDocuments: [],
      previewFileName: "",
      fileRichiesti: [],
      uploadedFiles: [],
      today: new Date().toISOString().substr(0, 10),
      dialog: false,
      confermaFormazione: false,
      passaggioFormazione: false,
      preview: false,
      showMotivationModal: false,
      previewUrl: "",
      user: JSON.parse(localStorage.getItem("chisono_data")),
    };
  },
  methods: {
    async validaDocumenti() {
      const selectedDocumentsToValidate = this.fileRichiesti.filter(
        (doc) => doc.selezionato
      );
      // lista dei documenti selezionati
      this.selectedDocuments = selectedDocumentsToValidate;
      if (this.selectedDocuments.length === 0) {
        this.$alert("Selezionare almeno un documento", "Attenzine", "warning");
        return;
      }
      let params = {
        elencoFile: this.selectedDocuments,
        idCandidato: this.candidato["id_anagrafica"],
        idUtente: this.user["idUtente"],
        nomeUtente: this.user["Nominativo"],
      };
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.crm.validaDocs,
            params
          )
          .then((response) => {
            var message = response.data.message;
            switch (response.data.esito) {
              case "OK":
                this.updateCandidato();
                this.$alert(message, "OK", "success");

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

    rifiutaDocumenti() {
      const selectedDocumentsToReject = this.fileRichiesti.filter(
        (doc) => doc.selezionato
      );
      this.selectedDocuments = selectedDocumentsToReject;
      if (this.selectedDocuments.length === 0) {
        this.$alert("Selezionare almeno un documento", "Attenzione", "warning");
        return;
      }
      this.showMotivationModal = true;
    },
    cancelRefuse() {
      // Chiudi la modale e resetta le motivazioni
      this.showMotivationModal = false;
      this.selectedDocuments.forEach((file) => {
        file.motivation = ""; // Resetta le motivazioni inserite
      });
    },

    async confirmRefuse() {
      // Verifica se tutte le motivazioni sono state inserite
      const motivazioniIncomplete = this.selectedDocuments.some(
        (file) => !file.motivation
      );

      if (motivazioniIncomplete) {
        // Mostra un messaggio all'utente o gestisci in base alle tue esigenze
        alert("Si prega di compilare tutte le motivazioni prima di procedere.");
        return; // Interrompi il processo se le motivazioni non sono state inserite per tutti i file
      }
      // Invia i dati al backend
      const motivazioni = this.selectedDocuments.map((file) => ({
        idDoc: file.idDoc,
        motivation: file.motivation,
        label: file.label,
      }));
      let params = {
        elencoFile: motivazioni,
        idUtente: this.user["idUtente"],
        nomeUtente: this.user["Nominativo"],
        emailCandidato: this.candidato["mail"],
        candidato: this.candidato,
      };
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.crm.rifiutaDocs,
            params
          )
          .then((response) => {
            var message = response.data.message;
            switch (response.data.esito) {
              case "OK":
                this.$alert(message, "OK", "success");
                this.updateCandidato();
                break;
              case "KO":
                this.$alert(message, "Attenzione", "warning");
                this.updateCandidato();
                break;
            }
          });
      } catch (error) {
        console.log(error);
      }
      // Chiudi la modale e resetta le motivazioni
      this.showMotivationModal = false;
      this.selectedDocuments.forEach((file) => {
        file.motivation = ""; // Resetta le motivazioni inserite
      });
    },

    updateCandidato() {
      this.$emit("aggiorna_grid", this.step);
      this.getFileRichiesti();
      this.getUploadedFiles();
    },
    async getUploadedFiles() {
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

    async getFileRichiesti() {
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
      let params = {
        t: tipo, // tipologia di rapporto dominio: BE BA BB
        i: this.candidato.numRui ? 1 : 0, // flag iscritto / non iscritto
      };

      try {
        const response = await axios.post(
          this.$custom_json.base_url +
            this.$custom_json.api_url +
            this.$custom_json.crm.getListaDocs,
          params
        );
        this.fileRichiesti = response.data;
        this.matchAndUpdateDocuments(); // Dopo aver recuperato fileRichiesti per tipologia di rapporto, fa il match
      } catch (error) {
        console.error("Errore durante il recupero dei files richiesti", error);
      }
    },

    matchAndUpdateDocuments() {
      // Itera sui documenti richiesti
      if (this.uploadedFiles.length > 0 && this.fileRichiesti.length > 0) {
        this.fileRichiesti.forEach((docRic) => {
          // console.log("dentro");
          // Trova il corrispondente documento in uploadedFiles
          const uploadedDoc = this.uploadedFiles.find(
            (uploadedDoc) => uploadedDoc.tipo_documento == docRic.tipo
          );

          if (uploadedDoc) {
            // console.log("trovato");
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
    async passaggio_formazione(tipologia) {
      console.log(tipologia);
      if (tipologia == "parziale") {
        // Passaggio allo stato 13 (Formazione con documentazione incompleta)
        let params = {
          nomeUtente: this.user["Nominativo"],
          idUtente: this.user["idUtente"],
          idCandidato: this.candidato["id_anagrafica"],
          emailCandidato: this.candidato["mail"],
          candidato: this.candidato,
        };
        try {
          await axios
            .post(
              this.$custom_json.base_url +
                this.$custom_json.api_url +
                this.$custom_json.crm.formazioneNoDocs,
              params
            )
            .then((response) => {
              var message = response.data.message;
              switch (response.data.esito) {
                case "OK":
                  this.$alert(message, "OK", "success");
                  this.updateCandidato();
                  this.passaggioFormazione = false;
                  break;
                case "KO":
                  this.$alert(message, "Attenzione", "warning");
                  break;
              }
            });
        } catch (error) {
          console.log(error);
        }
      } else {
        let params = {
          nomeUtente: this.user["Nominativo"],
          idUtente: this.user["idUtente"],
          idCandidato: this.candidato["id_anagrafica"],
          emailCandidato: this.candidato["mail"],
          candidato: this.candidato,
        };
        try {
          await axios
            .post(
              this.$custom_json.base_url +
                this.$custom_json.api_url +
                this.$custom_json.crm.formazione,
              params
            )
            .then((response) => {
              var message = response.data.message;
              switch (response.data.esito) {
                case "OK":
                  this.$alert(message, "OK", "success");
                  this.updateCandidato();
                  this.confermaFormazione = false;
                  break;
                case "KO":
                  this.$alert(message, "Attenzione", "warning");
                  break;
              }
            });
        } catch (error) {
          console.log(error);
        }
      }
    },
  },
  computed: {
    tuttiDocumentiValidati() {
      return this.fileRichiesti.every((docRic) => {
        const uploadedDoc = this.uploadedFiles.find(
          (uploadedDoc) => uploadedDoc.tipo_documento === docRic.tipo
        );
        return uploadedDoc && uploadedDoc.validato === 1;
      });
    },
    attivaFormazione() {
      return this.fileRichiesti
        .filter((doc) => doc.req)
        .every((doc) => doc.validato === 1);
    },
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
.options-container {
  display: flex;
  justify-content: flex-end;
  align-items: center;
}
</style>
