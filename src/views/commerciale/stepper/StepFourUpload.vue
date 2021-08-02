<template>
  <div>
    <div class="container">
      <strong>Riepilogo: </strong><br />
      <p><strong>Titolo: </strong> {{ uploadObject.titolo }}</p>
      <p><strong>Descrizione: </strong> {{ uploadObject.descrizione }}</p>
      <p>
        <strong>Cartella di destinazione: </strong> {{ uploadObject.percorso }}
      </p>
<!-- 
      <CButton @click="uploadFiles() " color="secondary" variant="outline"
        >Carica</CButton> -->
      
    </div>
  </div>
</template>


<script>


export default {
  props: ["currentStep", "uploadObject"],
  name: "StepFour",

  components: {},
  data: function () {
    return {
      loading: false,
      
      esito_add_edit: "",
    };
  },

  mounted() {
    this.$emit("can-continue", { value: true });
  },
  methods: {
    uploadFiles:function(){
      this.$emit("uploadFiles");
    },
   
  },
};
</script>