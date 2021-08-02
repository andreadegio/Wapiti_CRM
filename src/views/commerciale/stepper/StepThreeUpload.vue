<template>
    <div>
         <div class="container">
      <strong>Scegli dove vuoi caricare i file o crea una nuova cartella </strong><br/>
      <personal-cloud :area="contenuto" :uso="'gestione'" @get_percorso ="get_percorso"/>
    </div>
    </div>
</template>


<script>
import PersonalCloud from "../cloud.vue";
export default {
  props: ["clickedNext", "currentStep", "uploadObject"],
  name:"StepThree",

  components: {
    PersonalCloud,
  },
data: function(){
    return{
        contenuto : this.$route.params.settore,
        
     };
},

  mounted() {
    this.$emit("can-continue", { value: true });
  },
  methods:{
      get_percorso(path){
        //   console.log("funzione"+ path);
          this.uploadObject.percorso = path;
      }
  }

}
</script>