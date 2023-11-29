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
                    <td>
                      <v-img
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
                        v-model="item.selected"
                        :disabled="item.validato === null"
                      ></v-checkbox>
                    </td>
                  </tr>
                </tbody>
              </template>
            </v-simple-table>
          </section>
          <v-divider></v-divider>
          <section>
            <div>
              <h3 style="color: #1f4b6b">
                <strong>Opzioni:</strong>
              </h3>
              <small
                >Scegli se procedere, rifiutare, programmare una demo oppure
                riprogrammare la call
              </small>

              <v-row> </v-row>
            </div>
          </section>

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
  name: "ValidaDoc",
  components: {
    scheda,
  },
  props: ["step", "itemId", "candidato"],
  data() {
    return {
      selected: [],
      previewFileName: "",
      fileRichiesti: [],
      uploadedFiles: [],
      today: new Date().toISOString().substr(0, 10),
      dialog: false,
      preview: false,
      previewUrl: "",
      user: JSON.parse(localStorage.getItem("chisono_data")),
    };
  },
  methods: {
    updateCandidato() {
      this.$emit("aggiorna_grid", this.step);
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
            docRic.validato = uploadedDoc.validato;
            docRic.data_ins = uploadedDoc.data_ins;
            docRic.disabled = true;
            // docRic.selezionato = uploadedDoc.validato == 1 ? true : false;
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
