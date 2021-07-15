<template>
  <div class="container">
    <div class="text-center">
      <section class="section">
        <div class="container">
          <div class="columns">
            <div class="column is-8 is-offset-2">
              <horizontal-stepper
                :steps="demoSteps"
                @completed-step="completeStep"
                @active-step="isStepActive"
                @stepper-finished="alert"
              >
              </horizontal-stepper>
            </div>
          </div>
        </div>
      </section>
    </div>
  </div>
</template>

<script>
import VueFileAgent from "vue-file-agent";
import VueFileAgentStyles from "vue-file-agent/dist/vue-file-agent.css";
import HorizontalStepper from "vue-stepper";

// This components will have the content for each stepper step.
import StepOne from "./stepper/StepOneUpload.vue";
import StepTwo from "./stepper/StepTwoUpload.vue";
import StepThree from "./stepper/StepThreeUpload.vue";

// Vue.use(VueFileAgent);

export default {
  name: "newUpload",
  components: {
    HorizontalStepper,
  },
  data() {
    return {
      demoSteps: [
        {
          icon: "format_list_numbered",
          name: "first",
          title: "Descrizione allegati",
          subtitle: "Informazioni preliminari",
          component: StepOne,
          completed: true,
        },
        {
          icon: "note_add",
          name: "second",
          title: "Caricamento File",
          subtitle: "Scelta file e destinazione",
          component: StepTwo,
          completed: true,
        },
        {
          icon: "cloud_done",
          name: "three",
          title: "Conferma",
          subtitle: "Esito del caricamento",
          component: StepThree,
          completed: true,
        },
      ],
    };
  },
  methods: {
    // Executed when @completed-step event is triggered
    completeStep(payload) {
      this.demoSteps.forEach((step) => {
        if (step.name === payload.name) {
          step.completed = true;
        }
      });
    },
    // Executed when @active-step event is triggered
    isStepActive(payload) {
      this.demoSteps.forEach((step) => {
        if (step.name === payload.name) {
          if (step.completed === true) {
            step.completed = false;
          }
        }
      });
    },
    // Executed when @stepper-finished event is triggered
    alert(payload) {
      alert("end");
    },
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