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
    <v-tooltip bottom color="#1f4b6b">
      <template v-slot:activator="{ on, attrs }">
        <v-btn
          fab
          x-small
          v-bind="attrs"
          v-on="on"
          @click="
            dialog = true;
            getUploadedFiles();
          "
        >
          <i class="far fa-address-card fa-2x"></i>
        </v-btn>
      </template>
      <span>Scheda anagrafica</span>
    </v-tooltip>
    <v-dialog
      v-model="dialog"
      fullscreen
      hide-overlay
      transition="dialog-bottom-transition"
    >
      <v-card>
        <v-container>
          <v-toolbar dark color="#1f4b6b">
            <v-btn icon dark @click="dialog = false">
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

          <v-divider></v-divider>
          <v-tabs centered color="warning">
            <v-tab>
              <v-icon left>mdi-account-tie </v-icon>Dati Anagrafici</v-tab
            >

            <v-tab
              ><v-icon left>mdi-file-document-edit-outline</v-icon
              >Documentazione</v-tab
            >
            <v-tab
              ><v-icon left> mdi-information-variant-circle-outline </v-icon
              >info - utility</v-tab
            >
            <v-tab-item>
              <v-divider></v-divider>
              <section>
                <scheda
                  :candidato="candidato"
                  @updateCandidato="updateCandidato"
                ></scheda>
              </section>
            </v-tab-item>

            <v-tab-item>
              <v-divider></v-divider>
              <section id="documenti caricati" v-if="uploadedFiles.length > 0">
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
                    <tbody>
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
                <div>Credenziali Upload</div>
                <div>
                  Invia nuovamente la mail con le istruzioni (pin e link) per
                  accedere alla pagina di upload documenti
                </div>
                <v-btn
                  outlined
                  color="#1f4b6b"
                  :disabled="candidato.id_step < 3"
                  @click="recuperaCredenziali()"
                  ><i class="fas fa-mail-bulk"></i>&nbsp;Invia mail</v-btn
                >
              </section>
            </v-tab-item>
          </v-tabs>

          <v-divider></v-divider>

          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn outlined color="blue-grey" dark @click="dialog = false">
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
  name: "InfoCandidato",
  components: {
    scheda,
  },
  props: ["step", "itemId", "candidato"],

  data() {
    return {
      dialog: false,
      previewFileName: "",
      preview: false,
      previewUrl: "",
      uploadedFiles: [],
      fileRichiesti: [],
      user: JSON.parse(localStorage.getItem("chisono_data")),
    };
  },
  methods: {
    async recuperaCredenziali() {
      let params = {
        contatto: this.candidato,
        utente: this.user,
      };
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.crm.recuperaCredenziali,
            params
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
        console.log(error);
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
    updateCandidato() {
      this.$emit("aggiorna_grid", this.step);
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
