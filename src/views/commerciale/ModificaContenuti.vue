<template>
  <div>
      <br/>
      <br/>
      <br/>
      <br/>
      
    Modifica
    {{post}}

    <Visualizzatore
      :showDoc="showDoc"
      :file="file"
      :ext="ext"
      :nome_file="nome_file"
      @aggiorna_modale="aggiorna_modale"
    />
  </div>
</template>

<script >
import Visualizzatore from "../../components/visualizzaDocumenti.vue";

export default {
  name: "ModificaContenuti",
  props: ["post"],
  components: {
    Visualizzatore: Visualizzatore,
  },
  data() {},
  mounted() {},
};
</script>

<style scoped>
</style>

