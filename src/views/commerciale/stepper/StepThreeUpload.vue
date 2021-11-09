<template>
  <div style="text-align: left; padding-left: 3rem; padding-right: 3rem">
    <CModal :show="showModaleUpload" centered>
      <template #header>
        <span class="h4 text-uppercase" style="color: white">
          <strong>Upload</strong>
        </span>

        <CButton class="close" @click="chiudi()">
          <span aria-hidden="true">&times;</span>
        </CButton>
      </template>
      <template>
        <div id="uploadInCorso" class="h3 text-center pb-2">
          Caricamento in corso, attendere:
          <CProgress
            :value="progressBar"
            color="success"
            striped
            show-value
            showPercentage
            style="height: 30px; margin-top: 10px"
          />
        </div>
      </template>
      <template #footer-wrapper>
        <span></span>
      </template>
    </CModal>

    <div class="text-center" style="display: flex">
      <div class="col-md-12 cover_box mb-3">
        <!-- <div v-if="this.$refs.vueFileAgent.overallProgress.toFixed(2) == 100"></div> -->
        <VueFileAgent
          class="mx-5"
          ref="vueFileAgent"
          :editable="true"
          :theme="'grid'"
          :multiple="true"
          :deletable="true"
          :meta="true"
          :accept="'image/*,.zip,.pdf,.doc,.xls,.xlsx,.docx,.ppt,.pptx,video/*'"
          :maxSize="'200MB'"
          :maxFiles="14"
          :helpText="'Seleziona o trascina qui i file'"
          :errorText="{
            type: 'Tipo di file non consentito',
            size: 'La dimensione dei file non può superare i 10MB',
          }"
          @select="filesSelected($event)"
          @beforedelete="onBeforeDelete($event)"
          @delete="fileDeleted($event)"
          @carica_file="valore_progress"
          v-model="uploadObject.file"
        ></VueFileAgent>
      </div>
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import VueFileAgentStyles from "vue-file-agent/dist/vue-file-agent.css";
import axios from "axios";

export default {
  props: ["clickedNext", "currentStep", "uploadObject"],
  name: "StepThree",

  data: function () {
    return {
      fileRecords: [],
      uploadUrl: this.$custom_json.base_url + this.$custom_json.api_url + this.$custom_json.ep_api.upload_cloud,
      uploadHeaders: {},
      fileRecordsForUpload: [],
      progressBar: 0,
      showModaleUpload: false,

      // contenuto : this.$route.params.settore,
    };
  },

  methods: {
    valore_progress(percent) {
      // console.log(" nuovo valore ", percent);
      this.progressBar = percent;
    },
    canContinue() {
      this.$emit("can-continue", { value: true });
    },

    deleteUploadedFile: function (fileRecord) {
      // Using the default uploader. You may use another uploader instead.
      this.$refs.vueFileAgent.deleteUpload(
        this.uploadUrl,
        this.uploadHeaders,
        fileRecord
      );
    },
    uploadFiles: async function () {
      // All'avvio del caricamento faccio un primo check per capire se il/i file esistono già
      // creo un'array con i nomi dei file e chiamo il backend se tutto ok mi risponde con l'id del post che verrà creato
      this.showModaleUpload = true;
      let cerca_file = [];
      this.uploadObject.file.forEach((file) => {
        cerca_file.push(file.name(true) + "." + file.ext);
      });

      let params = {
        settore: this.$route.params.settore,
        titolo: this.uploadObject.titolo,
        contenuto: this.uploadObject.descrizione,
        percorso: this.uploadObject.percorso,
        permessi: this.uploadObject.permessi,
        area: this.uploadObject.area_post,
        file_check: cerca_file,
        utente: JSON.parse(localStorage.getItem("chisono_data")).Nominativo,
        idUtente: JSON.parse(localStorage.getItem("chisono_data")).idUtente,
      };
      // preUploadCloud per fare il check e salvare su db setto l'end-point su destinazione
      var destinazione =
        this.$custom_json.base_url + this.$custom_json.api_url + this.$custom_json.ep_api.pre_upload_cloud;
      // chiamo l'API
      await axios.post(destinazione, params).then((response) => {
        // console.log(response);
        // controllo l'esito
        let messaggio_esito = response.data.message;

        if (response.data.status == "OK") {
          // se OK allora vuol dire che posso caricare

          // a questo punto posso inviare tutto alla funzione di upload

          // eslint-disable-next-line no-unused-vars
          this.$refs.vueFileAgent
            .upload(
              this.uploadUrl,
              this.uploadHeaders,
              this.fileRecordsForUpload,
              params
            )
            // eslint-disable-next-line no-unused-vars
            .then((response) => {
              this.$alert(messaggio_esito, "File caricati", "success").then(
                // eslint-disable-next-line no-unused-vars
                (result) => {
                  this.$router.go(-1);
                  this.showModaleUpload = false;
                }
              );
              return;
            });

          return;
        } else {
          //visualizzo il messaggio di errore
          this.$alert(messaggio_esito, "Attenzione", "warning").then(
            // eslint-disable-next-line no-unused-vars
            (result) => {
              this.showModaleUpload = false;
            }
          );
          return;
        }
      });
      // this.fileRecordsForUpload = [];
    },

    filesSelected: function (fileRecordsNewlySelected) {
      var validFileRecords = fileRecordsNewlySelected.filter(
        (fileRecord) => !fileRecord.error
      );
      // console.log(fileRecord.name(true));
      // console.log(this.uploadObject.file[0].name(true));}
      // this.uploadObject.file.forEach(element => {console.log(element.file.name);
      // this.uploadObject.file.forEach((element) => {
      //   // console.log(element);
      // });

      // this.uploadObject.file[0].name= this.uploadObject.file[0].name(true);

      this.fileRecordsForUpload =
        this.fileRecordsForUpload.concat(validFileRecords);
    },
    // fileChange: function (filechanged) {
    //   console.log("cambio "+ JSON.stringify(filechanged));
    //   // console.log(fileRecord.name(true));
    //   // console.log(this.uploadObject.file[0].name(true));}
    //   // this.uploadObject.file.forEach(element => {console.log(element.file.name);
    //   this.uploadObject.file.forEach((element) => {
    //     // console.log(element);
    //   });
    // },

    onBeforeDelete: function (fileRecord) {
      var i = this.fileRecordsForUpload.indexOf(fileRecord);
      if (i !== -1) {
        // queued file, not yet uploaded. Just remove from the arrays
        this.fileRecordsForUpload.splice(i, 1);
        var k = this.fileRecords.indexOf(fileRecord);
        if (k !== -1) this.fileRecords.splice(k, 1);
      } else {
        if (confirm("Sicuro di voler rimuovere il file?")) {
          this.$refs.vueFileAgent.deleteFileRecord(fileRecord); // will trigger 'delete' event
        }
      }
    },
    fileDeleted: function (fileRecord) {
      var i = this.fileRecordsForUpload.indexOf(fileRecord);
      if (i !== -1) {
        this.fileRecordsForUpload.splice(i, 1);
      } else {
        this.deleteUploadedFile(fileRecord);
      }
    },
    chiudi: function () {
      this.showModaleUpload = false;
    },
  },

  mounted() {
    this.$emit("can-continue", { value: true });
  },
};
</script>
