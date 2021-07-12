<template>
  <div>
    <div>
      <hr />
      <CButton
      class="mr-3"
        color="primary"
        variant="outline"
        square
        size="sm"
        @click="get_tree('reset')"
        ><i class="fas fa-home fa-2x"></i><br>{{ area }}
      </CButton>
      <CButton
        color="primary"
        variant="outline"
        square
        size="sm"
        @click="get_tree(percorso)"
        ><i class="fas fa-sync-alt fa-2x"></i><br> Aggiorna
      </CButton>
      <hr />
      <cite v-show="percorso != ''" style="color: #1e2f56"
        >{{area}} > {{ breadcrumbs.join(' > ') }}</cite
      >
    </div>
    <div class="area_cloud row">
      <div
        class="cloud m-3 col-lg-2 col-md-3 col-xs-6 upper"
        v-show="sub != ''"
        @click="rem_breadcrumbs()"
      >
        <div class="desc_elemento">..</div>
      </div>
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

      this.percorso = this.breadcrumbs.join("/");

      // console.log("percorso "+this.percorso);
      this.get_tree(this.percorso);
    },
    rem_breadcrumbs() {
      this.breadcrumbs.pop();
      // console.log(this.breadcrumbs);
      this.percorso = this.breadcrumbs.join("/");
      // console.log("percorso "+this.percorso);
      this.get_tree(this.percorso);
    },
    async get_tree(subfolder = "") {
      if (subfolder == "reset") {
        subfolder = "";
        this.percorso = "";
        this.breadcrumbs = [];
      }
      // console.log(subfolder);

      this.sub = subfolder;
      var url_cloud;
      try {
        switch (this.area) {
          case "Assicurazioni":
            url_cloud = this.$custom_json.ep_api.cloudRC;
            break;
          case "Energy":
            url_cloud = this.$custom_json.ep_api.cloudEnergy;
            break;

          default:
            url_cloud = this.$custom_json.ep_api.cloudRC;
            break;
        }
        if (subfolder != "") {
          subfolder = { subfolder: subfolder };
          // console.log("subfolder " + JSON.stringify(subfolder));
          this.subTipo = "directory";
        } else {
          this.sub = "";
          this.subTipo = "";
        }

        await axios
          .post(this.$custom_json.api_url + url_cloud, subfolder)
          .then((response) => {
            this.tree_RC = response.data;
            // console.log(response.data); nb
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