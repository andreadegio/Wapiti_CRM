<template>
  <div class="text-center" style="display: flex">
    <div class="col-md-12">
      <div><strong>Scegli i file</strong></div>
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
        v-model="uploadObject.file"
      ></VueFileAgent>
      
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import VueFileAgentStyles from "vue-file-agent/dist/vue-file-agent.css";

export default {
  props: ["clickedNext", "currentStep", "uploadObject"],
  name: "StepTwo",

  data: function () {
    return {
      fileRecords: [],
      uploadUrl: "https://www.abyway.it/API/Cloud/upload",
      uploadHeaders: {},
      fileRecordsForUpload: [],
      // contenuto : this.$route.params.settore,
    };
  },
  
  methods: {
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
    uploadFiles: function () {
        // PASSO I VALORI AL PARENT (HORIZONTAL) che li passerà all'ultimo step newUpload
        console.log("file nello step 2", this.fileRecordsForUpload);
        // this.$emit("uploadFiles",this.uploadHeaders, this.fileRecordsForUpload);
        let params= {
                settore: this.$route.params.settore,
                titolo: this.uploadObject.titolo,
                contenuto: this.uploadObject.descrizione,
                percorso: this.uploadObject.percorso,
                permessi: this.uploadObject.permessi,
                utente: JSON.parse(localStorage.getItem("chisono_data"))
                  .Nominativo,
                idUtente: JSON.parse(localStorage.getItem("chisono_data"))
                  .idUtente,
              };
              // console.log(params);

         this.$refs.vueFileAgent.upload(this.uploadUrl, this.uploadHeaders, this.fileRecordsForUpload, params);
         this.fileRecordsForUpload = [];
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
  },

  mounted() {
    this.$emit("can-continue", { value: true });
    
  },
};
</script>
