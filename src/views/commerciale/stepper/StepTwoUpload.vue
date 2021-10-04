<template>
  <div style="text-align: left; display: flex">
    <div class="container">
      <div class="cover_box mb-3">
        <personal-cloud
          :area="contenuto"
          :uso="'gestione'"
          @get_percorso="get_percorso"
        />
      </div>
    </div>
  </div>
</template>


<script>
import PersonalCloud from "../cloud.vue";
export default {
  props: ["clickedNext", "currentStep", "uploadObject"],
  name: "StepTwo",

  components: {
    PersonalCloud,
  },
  data: function () {
    return {
      contenuto: this.$route.params.settore,
    };
  },

  mounted() {
    this.$emit("can-continue", { value: true });
  },
  methods: {
    get_percorso(path) {
      //   console.log("funzione"+ path);
      this.uploadObject.percorso = path;
    },
  },
};
</script>
