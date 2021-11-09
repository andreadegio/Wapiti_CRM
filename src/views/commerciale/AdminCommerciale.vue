<template>
  <CContainer
    id="cover_admin"
    :style="{ '--urlImg': urlImgSettore }"
    class="align-items-center min-vh-100"
  >
    <div>
      <new-com
        v-show="addCom"
        @back="step_back"
        :colore="coloreSettore"
        class="animate__animated animate__fadeIn"
        :lista_aree="lista_aree"
      />
      <new-upload
        v-show="addFile"
        @back="step_back"
        :colore="coloreSettore"
        :lista_aree="lista_aree"
        class="animate__animated animate__fadeIn"
      />
      <archivio
        v-show="showArchivio"
        :colore="coloreSettore"
        :settore="$attrs.settore"
        :lista_aree="lista_aree"
        @back="step_back"
        class="animate__animated animate__fadeIn"
      />
      <div v-show="home" class="container">
        <div class="row text-center mt-5 riga">
          <div
            class="col-md-2 action justify-content-center"
            :style="{ '--bgColor': coloreSettore }"
            @click="(addCom = true), (home = false)"
          >
            <i class="fas fa-rss fa-3x animate__animated animate__bounce"></i>
            <br /><span>Nuova<br />Comunicazione</span>
          </div>
          <div
            class="col-md-2 action"
            :style="{ '--bgColor': coloreSettore }"
            @click="(addFile = true), (home = false)"
          >
            <i
              class="
                fas
                fa-cloud-upload-alt fa-3x
                animate__animated animate__bounce
              "
            ></i
            ><br /><span>Carica<br />Materiale</span>
          </div>
          <div
            class="col-md-2 action"
            :style="{ '--bgColor': coloreSettore }"
            @click="(showArchivio = true), (home = false)"
          >
            <i
              class="fas fa-archive fa-3x animate__animated animate__bounce"
            ></i
            ><br /><span>Visualizza<br />Archivio</span>
          </div>
        </div>
      </div>
    </div>
  </CContainer>
</template>

<script>
import NewCom from "./newCom.vue"; // componente per l'inserimento di una nuova comunicazione
import NewUpload from "./newUpload.vue"; // componente per l'inserimento di un nuovo contenuto (file)
import Archivio from "./gestMateriale.vue"; //componente per la gestione dei post(materiale + comunicazioni)
import "animate.css";
import axios from "axios";

export default {
  name: "AdminCommerciale",
  components: {
    NewCom,
    NewUpload,
    Archivio,
  },
  data() {
    return {
      // tipologie: [],
      addCom: false, // trigger per visualizzare il componente di aggiunta comunicazione
      addFile: false, // trigger per visualizzare il componente di aggiunta file
      home: true, // trigger per visualizzare i pulsanti di scelta
      coloreSettore: "",
      showArchivio: false,
      lista_aree: [],
      urlImgSettore: "",
    };
  },

  created() {
    // console.log("AdminCommerciale " + this.$attrs.settore);
    this.get_tipologie();
    this.get_color_settore(this.$attrs.settore);
    this.get_area();
    this.set_background();
    this.get_reference();
  },
  updated() {
    this.get_color_settore(this.$attrs.settore);
  },
  methods: {
    get_reference() {
      if (this.$attrs.reference == "elenco") {
        this.addCom = false;
        this.addFile = false;
        this.showArchivio = true;
        this.home = false;
      }
    },
    set_background() {
      if (this.$attrs.settore == "Assicurazioni") {
        this.urlImgSettore =
          'url("http://localhost:8080/img/filigranaAuto.png")';
      }
      if (this.$attrs.settore == "Energy") {
        this.urlImgSettore =
          'url("http://localhost:8080/img/filigranaGas.png")';
      }
    },
    step_back() {
      this.addCom = false;
      this.addFile = false;
      this.showArchivio = false;
      this.home = true;
    },

    async get_area() {
      // Chiamata per recuperare le aree
      let params = {
        settore: this.$route.params.settore,
      };
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.area,
            { params }
          )
          .then((response) => {
            // la risposta con l'elenco delle aree  la salvo nello storage
            localStorage.setItem("area", JSON.stringify(response.data));
            this.lista_aree = response.data;
            // console.log(JSON.stringify(response.data));
          });
      } catch (error) {
        console.log("impossibile recuperare le aree");
      }
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
    async get_color_settore(desc_settore) {
      // console.log(desc_settore);
      let params = {
        settore: desc_settore,
      };
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.color_settore,
            { params }
          )
          .then((response) => {
            this.coloreSettore = response.data;
            localStorage.setItem("settore", desc_settore);
            localStorage.setItem("col_settore", this.coloreSettore);
          });
      } catch (error) {
        console.log("errore: " + error);
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
  background-color: var(--bgColor);
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

  background-image: var(--urlImg);
}
</style>