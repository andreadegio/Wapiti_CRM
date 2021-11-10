<template>
  <div
    style="background-color: white; border-radius: 0.3rem"
    class="container mt-2 card_post"
    :style="{ '--bgColor': $attrs.colore }"
  >
    <div class="breadcrumbs">
      <CLink @click="back()" class="breadcrumbs_link"
        >Gestione {{ $route.params.settore }}</CLink
      >
      > Nuovo Materiale
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
      :coloreTasti="$attrs.colore"
      :lista_aree ="$attrs.lista_aree"
    ></horizontal-stepper>
    <!-- <div class="text-center">
      <cite>- Ti trovi nel settore - {{ $route.params.settore }} - </cite>
    </div> -->
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
        area_post:null
      },
      uploadSteps: [
        {
          icon: "format_list_bulleted",
          name: "First",
          title: "Informazioni",
          subtitle: "Descrizione e permessi per i file",
          component: StepOne,
          completed: false,
          coloreTasti: this.$attrs.colore,
        },
        {
          icon: "folder",
          name: "second",
          title: "Destinazione",
          subtitle: "Scegli dove caricare o crea nuove cartelle",
          component: StepTwo,
          completed: false,
        },
        {
          icon: "note_add",
          name: "third",
          title: "Scelta file",
          subtitle: "Seleziona i file da caricare",
          component: StepThree,
          completed: false,
        },
      ],
      activeStep: 0,
      uploadHeaders: "",
    };
  },

  methods: {
    back() {
      this.$emit("back");
    },
    // uploadFiles: function (uploadHeaders, fileRecordsForUpload) {
    uploadFiles: function () {
      // console.log("NEW-UPLOAD -> HORIZZONTAL ");
      this.$refs.horizzontal.uploadFiles();
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
.breadcrumbs_link {
  color: var(--bgColor) !important;
  text-decoration: underline;
  font-size: 14px;
  line-height: 19px;
  text-transform: uppercase;
  margin-bottom: 5px;
  margin-left: 0.8rem;
  padding-top: 0.5rem;
  padding-bottom: 1.5rem;
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  font-weight: 600;
}
.breadcrumbs {
  color: var(--bgColor);
  font-size: 14px;
  line-height: 19px;
  text-transform: uppercase;
  margin-bottom: 5px;
  margin-left: 0.8rem;
  padding-top: 0.5rem;
  padding-bottom: 1.5rem;
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  font-weight: 600;
}


</style>