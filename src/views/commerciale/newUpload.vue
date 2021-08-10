<template>
  <div>
    <div class="text-center">
      <cite>- Ti trovi nel settore - {{ $route.params.settore }} - </cite>
    </div>
    <horizontal-stepper
      ref="horizzontal"
      :steps="uploadSteps"
      @completed-step="completeStep"
      :top-buttons="true"
      @active-step="isStepActive"
      @uploadFiles="uploadFiles"
      @stepper-finished="uploadFiles"
      :uploadObject="uploadObject"
      :keep-alive="true"
    ></horizontal-stepper>
  </div>
</template>

<script>
// import axios from "axios";
// import Vue from "vue";

import HorizontalStepper from "../../../node_modules/vue-stepper/src/HorizontalStepper.vue";

// Componenti che compongono i vari step
import StepOne from "./stepper/StepOneUpload.vue";
import StepTwo from "./stepper/StepTwoUpload.vue";
import StepThree from "./stepper/StepThreeUpload.vue";
// import StepFour from "./stepper/StepFourUpload.vue";

export default {
  name: "newUpload",
  components: {
    HorizontalStepper,
  },
  data() {
    return {
      uploadObject: {
        titolo: "",
        descrizione: "",
        percorso: "",
        permessi: [],
        file: [],
      },
      uploadSteps: [
        {
          icon: "format_list_bulleted",
          name: "First",
          title: "Informazioni",
          subtitle: "Descrizione e permessi per i file",
          component: StepOne,
          completed: false,
        },
        {
          icon: "folder",
          name: "third",
          title: "Destinazione",
          subtitle: "Scegli dove caricare o crea nuove cartelle",
          component: StepThree,
          completed: false,
        },
        {
          icon: "note_add",
          name: "second",
          title: "Scelta file",
          subtitle: "Seleziona i file da caricare",
          component: StepTwo,
          completed: false,
        },
        // {
        //   icon: "cloud_done",
        //   name: "four",
        //   title: "Upload",
        //   subtitle: "Conferma caricamento",
        //   component: StepFour,
        //   completed: false,
        // },
      ],
      activeStep: 0,
      uploadHeaders: "",
    };
  },
  computed: {},
  methods: {
    // uploadFiles: function (uploadHeaders, fileRecordsForUpload) {
    uploadFiles: function () {
      console.log("NEW-UPLOAD -> HORIZZONTAL ");
      this.$refs.horizzontal.uploadFiles();

      // console.log("upload", uploadHeaders, fileRecordsForUpload);

      // //  var destinazione = this.$custom_json.cloud_abyway + this.uploadObject.percorso;
      // var messaggio_esito = "";
      // var destinazione =
      //   this.$custom_json.api_url + this.$custom_json.ep_api.upload_cloud;
      // if (this.uploadObject.file.length > 0) {
      //   console.log("ci sono " + this.uploadObject.file.length + " file");
      //   //Recupero il nome del file dal parametro name e lo assegno al nuovo valore 'nome_file'
      //   this.uploadObject.file.forEach((element) => {
      //     // console.log(element.name(true));
      //     // console.log(element.ext);
      //     Vue.set(element, "nome_file", element.name(true));
      //     Vue.set(element, "sorgente", element.src(true));
      //   });
      //   // this.$refs.vueFileAgent.upload(destinazione,this.uploadHeaders,this.fileRecordsForUpload);

      //   var formData = new FormData();
      //   formData.append("file", this.$refs.file.files[0]);
      //   console.log("formdata ", formData.file);
      //   axios
      //     .post(destinazione, fileRecordsForUpload, uploadHeaders)
      //     .then((response) => {
      //       // console.log(JSON.stringify(response));
      //       messaggio_esito = response.data.message;
      //       this.esito_add_edit = response.data.status;
      //       if (response.data.status == "KO") {
      //         this.$alert(messaggio_esito, "Attenzione", "warning");
      //       } else {
      //         this.$alert(messaggio_esito, "OK", "success");
      //         // this.$router.go(-1);
      //       }
      //     });

      // try {
      //   axios
      //     .post(
      //       destinazione,
      //       {
              // params: {
              //   settore: this.$route.params.settore,
              //   titolo: this.uploadObject.titolo,
              //   contenuto: this.uploadObject.descrizione,
              //   percorso: this.uploadObject.percorso,
              //   permessi: this.uploadObject.permessi,
              //   file: fileRecordsForUpload,
              //   utente: JSON.parse(localStorage.getItem("chisono_data"))
              //     .Nominativo,
              //   idUtente: JSON.parse(localStorage.getItem("chisono_data"))
              //     .idUtente,
              // },
      //       },
      //       headers
      //     )
      // .then((response) => {
      //   // console.log(JSON.stringify(response));
      //   messaggio_esito = response.data.message;
      //   this.esito_add_edit = response.data.status;
      //   if (response.data.status == "KO") {
      //     this.$alert(messaggio_esito, "Attenzione", "warning");
      //   } else {
      //     this.$alert(messaggio_esito, "OK", "success");
      //     // this.$router.go(-1);
      //   }
      // });
      // } catch {
      //   console.log("Impossibile comunicare con il server");
      // }

      // try {
      //   axios
      //     .post(
      //       destinazione,
      //       {
      //         params: {
      //           settore: this.$route.params.settore,
      //           titolo: this.uploadObject.titolo,
      //           contenuto: this.uploadObject.descrizione,
      //           percorso: this.uploadObject.percorso,
      //           permessi: this.uploadObject.permessi,
      //           file: this.uploadObject.file,
      //           utente: JSON.parse(localStorage.getItem("chisono_data"))
      //             .Nominativo,
      //           idUtente: JSON.parse(localStorage.getItem("chisono_data"))
      //             .idUtente,
      //         },
      //       },
      //       {
      //         header: {
      //           "Content-Type": "multipart/form-data",
      //         },
      //       }
      //     )
      //     .then((response) => {
      //       // console.log(JSON.stringify(response));
      //       messaggio_esito = response.data.message;
      //       this.esito_add_edit = response.data.status;
      //       if (response.data.status == "KO") {
      //         this.$alert(messaggio_esito, "Attenzione", "warning");
      //       } else {
      //         this.$alert(messaggio_esito, "OK", "success");
      //         // this.$router.go(-1);
      //       }
      //     });
      // } catch {
      //   console.log("Impossibile comunicare con il server");
      // }

      // this.$refs.vueFileAgent.upload(
      //   destinazione,
      //   this.uploadHeaders,
      //   this.uploadObject.file
      // );
      // this.uploadObject.file;
      // } else {
      //   this.$alert("Non è stato scelto nessun file", "Attenzione", "warning");
      // }
    },
    completeStep(payload) {
      this.uploadSteps.forEach((step) => {
        if (step.name === payload.name) {
          step.completed = true;
        }
      });
    },
    isStepActive(payload) {
      this.uploadSteps.forEach((step) => {
        if (step.name === payload.name) {
          if (step.completed === true) {
            step.completed = false;
          }
        }
      });
    },
    // eslint-disable-next-line no-unused-vars
    // alert(payload) {
    //   this.uploadFiles();
    // },
  },
};
</script>


<style scoped>
#app {
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
.pointer {
  cursor: pointer;
}
h1,
h2 {
  font-weight: normal;
}
hr {
  background-color: transparent;
  border: none;
  display: block;
  height: inherit;
  margin: 1.5rem 0;
  border-top: dashed 1px;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #0b99b9;
  text-decoration: underline;
}
.text-medium-grey {
  color: #333;
}
.text-light-grey {
  color: #888;
}
.box.formated {
  position: relative;
  padding: 0;
}
.box.formated .heading {
  font-size: 1rem;
  text-transform: capitalize;
  padding: 0.8rem 1.5rem;
  background-color: #fafafa;
}
.box.formated .content {
  padding: 1rem 2rem;
}
i.top-left {
  position: absolute;
  left: 1.5rem;
  top: 0.8rem;
}
.vertical-separator {
  display: flex;
  justify-content: space-around;
}
.vertical-separator .line {
  border-right: 1px solid #cccccc;
}
</style>