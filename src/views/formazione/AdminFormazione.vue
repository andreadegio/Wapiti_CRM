<template>
  <CContainer id="cover_admin" class="align-items-center min-vh-100">
    <div>
      <new-corso v-show="addCorso" @back="step_back" class="animate__animated animate__fadeIn" />
      <archivio v-show="showArchivio" @back="step_back" class="animate__animated animate__fadeIn" />
      <gest-cat v-show="showCategorie" @back="step_back" class="animate__animated animate__fadeIn" />
      <div v-show="home" class="container">
        <div class="row text-center mt-5 riga">
          <div class="col-md-2 action justify-content-center" @click="(addCorso = true), (home = false)">
            <i class="
                fas
                fa-user-graduate fa-3x
                animate__animated animate__bounce
              "></i>
            <br /><span>Nuovo<br />Corso</span>
          </div>

          <div class="col-md-2 action" @click="(showCategorie = true), (home = false)">
            <i class="fas fa-list-ol fa-3x animate__animated animate__bounce"></i>
            <br /><span>Gestione<br />Categorie</span>
          </div>
          <div class="col-md-2 action" @click="(showArchivio = true), (home = false)">
            <i
              class="fas fa-archive fa-3x animate__animated animate__bounce"></i><br /><span>Visualizza<br />Archivio</span>
          </div>
        </div>
      </div>
    </div>
  </CContainer>
</template>

<script>
import newCorso from "./newCorso.vue"; // componente per l'inserimento di un nuovo corso
import Archivio from "./GestioneCorsi.vue"; //componente per la gestione dei corsi
import GestCat from "./GestCat.vue"; // componente per la gestione delle categorie
// import "animate.css";
import axios from "axios";

export default {
  name: "AdminFormazione",
  components: {
    newCorso,
    Archivio,
    GestCat,
  },
  props: ["reference"],
  data() {
    return {
      addCorso: false, // trigger per visualizzare il componente di aggiunta comunicazione

      home: true, // trigger per visualizzare i pulsanti di scelta
      coloreSettore: "",
      showArchivio: false,
      showCategorie: false,
      lista_aree: [],
      urlImgSettore: "",
    };
  },

  created() {
    this.get_tipologie();

    this.get_reference();
  },

  methods: {
    get_reference() {
      console.log("valore di reference " + this.reference);
      if (this.reference == "elenco") {
        this.addCorso = false;
        this.showArchivio = true;
        this.home = false;
      }
    },

    step_back() {
      this.addCorso = false;
      this.showArchivio = false;
      this.showCategorie = false;
      this.home = true;
    },

    async get_tipologie() {
      // Chiamata per recuperare le tipologie di rapporto
      try {
        await axios
          .post(
            this.$custom_json.base_url +
            this.$custom_json.api_url +
            this.$custom_json.ep_api.tipologie_rapporto
          )
          .then((response) => {
            // la risposta con l'elenco delle tipologie di rapporto la salvo nello storage
            localStorage.setItem("tipologie", JSON.stringify(response.data));
            // console.log(JSON.stringify(response.data));
          });
      } catch (error) {
        console.log("impossibile recuperare le tipologie di rapporto");
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
  text-align: center;
  cursor: pointer;
  margin: 5rem;
  padding: 2rem;
  background-color: #5c5a5a;
  font-size: 1.5rem;
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  font-weight: lighter;
  border-radius: 25%;
  color: rgb(255, 255, 255);
  max-width: 15rem;
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

#cover_admin {
  background-size: cover !important;
  background-position: right !important;
  max-width: none !important;

  background-image: url(/img/formazione/filigranaFormazione.jpg);
}
</style>