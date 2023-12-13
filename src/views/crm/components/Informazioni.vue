<template>
  <div>
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
          <scheda
            :candidato="candidato"
            @updateCandidato="updateCandidato"
          ></scheda>

          <v-divider></v-divider>
          <section>
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
                      <i
                        class="far fa-pause-circle fa-lg"
                        v-show="item.validato == 0"
                      ></i>
                      <i
                        class="far fa-check-circle fa-lg"
                        v-show="item.validato == 1"
                      ></i>
                      <small
                        :style="{
                          color:
                            item.validato == 0
                              ? 'orange'
                              : item.validato == 1
                              ? 'green'
                              : '',
                        }"
                      >
                        {{
                          item.validato == null
                            ? "Documento non ancora caricato"
                            : item.validato == 0
                            ? "Caricato, in attesa di validazione"
                            : "Documento validato"
                        }}</small
                      >
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
      uploadedFiles: [],
      fileRichiesti: [],
      user: JSON.parse(localStorage.getItem("chisono_data")),
    };
  },
  methods: {
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
