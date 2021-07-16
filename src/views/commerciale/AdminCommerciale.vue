<template>
  <div>
    <new-com v-show="addCom"/>
    <new-upload v-show="addFile"/>
    <div v-show="home" class="container">
      <div class="row text-center mt-5 riga">
        <div class="col-md-3 action" @click="addCom=true, home=false">
          <i class="fas fa-rss fa-4x animate__animated animate__bounce animate__slow"></i><br />Inserisci una Comunicazione
        </div>
        <div class="col-md-3 action" @click="addFile=true, home=false" >
          <i class="fas fa-cloud-upload-alt fa-4x animate__animated animate__bounce"></i><br /><span >Carica Materiale</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import NewCom from './newCom.vue';
import NewUpload from './newUpload.vue';
import 'animate.css';

export default {
  name: "AdminCommerciale",
  components:{
    NewCom,
    NewUpload
  },
  data(){
    return {
      addCom: false, // trigger per visualizzare il componente di aggiunta comunicazione
      addFile: false, // trigger per visualizzare il componente di aggiunta file
      home:true, // trigger per visualizzare i pulsanti di scelta 
    }
  }

};
</script>

<style scoped>
:root {
  --animate-duration: 800ms;
  --animate-delay: 0.9s;
}

.riga {
  justify-content: center;
}
.action {
  cursor: pointer;
  margin: 5rem;
  padding: 5rem;
  background-color: #1e2f56;
  font-size: 1.5rem;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  font-weight: lighter;
  border-radius: 25%;
  color: rgb(255, 255, 255);
}
.action:hover {
  -webkit-box-shadow: 5px 5px 12px 0px #747474;
-moz-box-shadow: 5px 5px 12px 0px #747474;
-o-box-shadow: 5px 5px 12px 0px #747474;
box-shadow: 5px 5px 12px 0px #747474;
}
.action:hover svg{
  transform: translateY(-2rem);
  
}
</style>