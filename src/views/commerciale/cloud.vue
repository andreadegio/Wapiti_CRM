<template>
  <div>
    <div>
      <!-- Pulsanti di navigazione -->
      <hr />
      <CButton
        class="mr-3"
        color="primary"
        variant="outline"
        square
        size="sm"
        @click="get_tree('reset')"
        ><i class="fas fa-home fa-2x"></i><br />{{ area }}
      </CButton>
      <CButton
        color="primary"
        variant="outline"
        square
        size="sm"
        @click="get_tree(percorso)"
        ><i class="fas fa-sync-alt fa-2x"></i><br />
        Aggiorna
      </CButton>
      <hr />
      <!-- BREADCRUMBS -->
      <cite v-show="percorso != ''" style="color: #1e2f56"
        >{{ area }} > {{ breadcrumbs.join(" > ") }}</cite
      >
    </div>
    <div class="area_cloud row text-center">
      <!-- INDICATORE -> LIVELLO SUPERIORE -->
      <div
        class=" cloud ml-5 mt-3 col-lg-2 col-md-3 col-xs-6 upper"
        v-show="sub != ''"
        @click="rem_breadcrumbs()"
      >
        <div class="desc_elemento">..</div>
      </div>

      <!-- FRONTEND -> CARTELLE E FILE -->
      <div
        v-for="elemento in tree_RC"
        :key="elemento.descrizione"
        class="cloud m-3 col-lg-2 col-md-3 col-xs-6"
      >
        <div
          :class="elemento.ext"
          v-if="elemento.tipo == 'directory'"
          @click="add_breadcrumbs(elemento.descrizione)"
        >
          <div class="desc_elemento">
            {{ elemento.descrizione }}

            <div class="info_elemento">
              <cite
                style="font-size: 0.7rem"
                v-show="elemento.tipo != 'directory'"
                >({{ elemento.size }}byte)</cite
              >
              <cite
                style="font-size: 0.7rem"
                v-show="
                  elemento.tipo == 'directory' && elemento.contenuto == null
                "
                >(cartella vuota)</cite
              >
            </div>
          </div>
        </div>
        <div v-else :class="elemento.ext">
          <div class="desc_elemento">
            {{ elemento.descrizione }}

            <div class="info_elemento">
              <cite
                style="font-size: 0.7rem"
                v-show="elemento.tipo != 'directory'"
                >({{ elemento.size }}byte)</cite
              >
              <cite
                style="font-size: 0.7rem"
                v-show="
                  elemento.tipo == 'directory' && elemento.contenuto == null
                "
                >(cartella vuota)</cite
              >
            </div>
          </div>
        </div>
      </div>
      <!-- FINE EXPLORER FILE -->
      <div class="cloud m-3 col-lg-2 col-md-3 col-xs-6">
        <span v-show="tree_RC == null"> Nessun elemento presente </span>
      </div>
    </div>

    <br />

    <!-- <span>
      Risposta servizio:<code>{{ tree_RC }}</code></span
    > -->
  </div>
</template>
<script>
import axios from "axios";

export default {
  name: "PersonalCloud",
  props: ["area"],
  data() {
    return {
      tree_RC: {},
      sub: "",
      breadcrumbs: [],
      percorso: "",
    };
  },
  created() {
    this.get_tree();
  },
  methods: {
    add_breadcrumbs(dest) {
      this.breadcrumbs.push(dest);
      // console.log(this.breadcrumbs);
      this.percorso = this.area + "/" + this.breadcrumbs.join("/");

      // console.log("percorso " + this.percorso);
      this.get_tree(this.percorso);
    },

    rem_breadcrumbs() {
      this.breadcrumbs.pop();
      // console.log(this.breadcrumbs);
      this.percorso = this.area + "/" + this.breadcrumbs.join("/");
      // console.log("percorso " + this.percorso);
      this.get_tree(this.percorso);
    },
    async get_tree(subfolder = "") {
      //chiamata per il recupero dell'albero dei file
      // controllo se è stato premuto il tasto home -> reset
      url_cloud = this.$custom_json.ep_api.cloud;
      if (subfolder == "reset") {
        subfolder = "";
        this.percorso = "";
        this.breadcrumbs = [];
      }

      this.sub = subfolder;
      var url_cloud;
      var UO_tipo = JSON.parse(localStorage.getItem("chisono_data")).idUtente;
      var param;
      try {
        if (subfolder != "" && subfolder != this.area + "/") {
          // subfolder == this.area+"/" ? console.log("uguale") : console.log("diverso");
          // console.log("percorso " + subfolder + " " + this.area);
          param = {
            subfolder: subfolder,
            UO_tipo: UO_tipo,
            settore: this.area,
          };
          // console.log("subfolder " + JSON.stringify(subfolder));
          this.subTipo = "directory";
        } else {
          subfolder = "";
          this.percorso = "";
          this.breadcrumbs = [];
          param = {
            subfolder: subfolder,
            UO_tipo: UO_tipo,
            settore: this.area,
          };
          this.sub = "";
          this.subTipo = "";
        }
        // console.log(param);
        await axios
          .post(this.$custom_json.api_url + url_cloud, param)
          .then((response) => {
            this.tree_RC = response.data;
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
/* CLASSI PER LA VISUALIZZAZIONE DEI FILE DEL CLOUD  */
.area_cloud {
  display: flex;
}
.cloud {
  font-size: 2rem;
  cursor: pointer;
  list-style-type: none;
}
.upper::before {
  content: "\f3bf";
  font-family: "Font Awesome 5 free";
  color: rgb(103, 103, 104);
  font-size: 2em;
  font-weight: 900;
  padding-right: 5px;
}
.jpg::before {
  content: "\f1c5";
  font-family: "Font Awesome 5 free";
  color: rgb(103, 103, 104);
  font-size: 2em;
  font-weight: 900;
  padding-right: 5px;
}
.pdf::before {
  content: "\f1c1";
  font-family: "Font Awesome 5 free";
  color: rgb(103, 103, 104);
  font-size: 2em;
  font-weight: 900;
  padding-right: 5px;
}
.txt::before {
  content: "\f15c";
  font-family: "Font Awesome 5 free";
  color: rgb(103, 103, 104);
  font-size: 2em;
  font-weight: 900;
  padding-right: 5px;
}
.directory::before {
  content: "\f07b";
  font-family: "Font Awesome 5 free";
  color: rgb(252, 198, 3);
  font-size: 2em;
  font-weight: 900;
  padding-right: 5px;
}
.directory:hover::before {
  content: "\f07c";
  font-family: "Font Awesome 5 free";
  color: rgb(252, 198, 3);
  font-size: 2em;
  font-weight: 900;
  padding-right: 5px;
}
.directory.highlight::before {
  content: "\f07c";
  font-family: "Font Awesome 5 free";
  color: rgb(252, 198, 3);
  font-size: 2em;
  font-weight: 900;
  padding-right: 5px;
}
/* FINE CLOUD */
</style>