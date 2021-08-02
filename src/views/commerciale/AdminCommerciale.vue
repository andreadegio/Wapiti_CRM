<template>
  <div>
    <new-com v-show="addCom" />
    <new-upload v-show="addFile" class="animate__animated animate__fadeIn" />
    <div v-show="home" class="container">
      Settore {{$attrs.settore}}
      <div class="row text-center mt-5 riga">
        <div class="col-md-3 action" @click="(addCom = true), (home = false)">
          <i class="fas fa-rss fa-4x animate__animated animate__bounce"></i
          ><br />Inserisci una Comunicazione
        </div>
        <div class="col-md-3 action" @click="(addFile = true), (home = false)">
          <i
            class="
              fas
              fa-cloud-upload-alt fa-4x
              animate__animated animate__bounce
            "
          ></i
          ><br /><span>Carica Materiale</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import NewCom from "./newCom.vue"; // componente per l'inserimento di una nuova comunicazione
import NewUpload from "./newUpload.vue"; // componente per l'inserimento di un nuovo contenuto (file)
// import "bulma";
import "animate.css";
import axios from "axios";


export default {
  name: "AdminCommerciale",
  components: {
    NewCom,
    NewUpload,
  },
  data() {
    return {
      // tipologie: [],
      addCom: false, // trigger per visualizzare il componente di aggiunta comunicazione
      addFile: false, // trigger per visualizzare il componente di aggiunta file
      home: true, // trigger per visualizzare i pulsanti di scelta
    };
  },
  mounted() {
    this.get_tipologie();
  },
  methods: {
    async get_tipologie() {
      // Chiamata per recuperare le tipologie di rapporto
      try {
        await axios
          .post(
            this.$custom_json.api_url +
              this.$custom_json.ep_api.tipologie_rapporto
          )
          .then((response) => {
      //       this.tipologie =  [
      //   {
      //     id: "ALL",
      //     label: "TUTTI",
      //     isDefaultExpanded: true,
      //     children: ,
      //   },
      // ],
            // la risposta con l'elenco delle tipologie di rapporto la salvo nello storage
            localStorage.setItem("tipologie", JSON.stringify(response.data));
            // console.log(JSON.stringify(response.data));
          });
      } catch (error) {
        console.log("impossibile accedere al cloud");
      }
    },
  },
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
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
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
.action:hover svg {
  transform: translateY(-2rem);
}
</style>