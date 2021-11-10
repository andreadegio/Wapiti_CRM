<template>
  <div>
    <div v-if="uso">
      <!-- Pulsanti di navigazione -->

      <div class="row">
        <div class="col-md-6 text-left">
          <CButton
            v-show="percorso != ''"
            class="mr-3"
            color="primary"
            variant="outline"
            square
            size="sm"
            @click="get_tree('reset')"
            ><i class="fas fa-home fa-2x"></i><br />{{ area }}
          </CButton>
        </div>
        <div class="col-md-6 text-right">
          <CButton
            class="mr-3"
            color="primary"
            variant="outline"
            square
            size="sm"
            @click="new_folder()"
            ><i class="fas fa-folder-plus fa-2x"></i><br />
            Crea Cartella
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
        </div>
      </div>
      <hr />
    </div>
    <!-- BREADCRUMBS -->
    <cite v-show="percorso != ''" style="color: #1e2f56"
      >{{ area }} > {{ breadcrumbs.join(" > ") }}</cite
    >

    <div class="area_cloud row text-center mt-3">
      <!-- INDICATORE -> LIVELLO SUPERIORE -->
      <div
        class="cloud ml-5 mt-3 col-lg-2 col-md-3 col-xs-6 upper"
        :class="uso"
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
        :class="uso"
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
        <div
          v-else
          :class="elemento.ext.toUpperCase()"
          @click="
            (showDoc = true),
              (file =
                $custom_json.base_url +
                
                elemento.filePath +
                '/' +
                elemento.descrizione),
              (ext = elemento.ext.toUpperCase()),
              (nome_file = elemento.descrizione)
          "
        >
          <div class="desc_elemento">
            {{ elemento.descrizione }}

            <div class="info_elemento">
              <!-- <cite
                style="font-size: 0.7rem"
                v-show="elemento.tipo != 'directory'"
                >({{ elemento.size }}byte)</cite
              > -->
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
      <Visualizzatore
        :showDoc="showDoc"
        :file="file"
        :ext="ext"
        :nome_file="nome_file"
        @aggiorna_modale="aggiorna_modale"
      />
    </div>

    <br />

    <!-- <span>
      Risposta servizio:<code>{{ tree_RC }}</code></span
    > -->
  </div>
</template>
<script>
import axios from "axios";
import Visualizzatore from "../../components/visualizzaDocumenti.vue";

export default {
  name: "PersonalCloud",
  props: ["area", "uso"],
  components: {
    Visualizzatore: Visualizzatore,
  },
  data() {
    return {
      tree_RC: {},
      sub: "",
      breadcrumbs: [],
      percorso: this.path,
      showDoc: false,
      file: "",
      ext: "",
      nome_file: "",
    };
  },
  created() {
    this.get_tree();
  },
  methods: {
    aggiorna_modale(value) {
      this.showDoc = value;
    },
    add_breadcrumbs(dest) {
      this.breadcrumbs.push(dest);
      // console.log(this.breadcrumbs);
      this.percorso = this.area + "/" + this.breadcrumbs.join("/");
      this.$emit("get_percorso", this.percorso);
      // console.log("percorso " + this.percorso);
      this.get_tree(this.percorso);
    },

    rem_breadcrumbs() {
      this.breadcrumbs.pop();
      // console.log(this.breadcrumbs);
      this.percorso = this.area + "/" + this.breadcrumbs.join("/");
      this.$emit("get_percorso", this.percorso);
      // console.log("percorso " + this.percorso);
      this.get_tree(this.percorso);
    },
    async new_folder() {
      // Funzione per creare una nuova cartella
      // premendo il pulsante "nuova cartella" si apre una modale dove inserire
      // il nome per la nuova cartella. Cliccando OK si controlla che non esista già una
      // cartella con lo stesso nome se tutto ok creo la cartella altrimenti avviso che non è
      // possibile creare la cartella

      this.$prompt("Inserisci il nome della cartella").then(async (text) => {
        if (text != "") {
          var param = {
            settore: this.area,
            filePath: this.percorso ? this.percorso : this.area,
            newFolderName: text,
            idUtente: JSON.parse(localStorage.getItem("chisono_data")).idUtente,
            nomeUtente: JSON.parse(localStorage.getItem("chisono_data"))
              .Nominativo,
          };
          // console.log(param);
          try {
            await axios
              .post(
                this.$custom_json.base_url +
                  this.$custom_json.api_url +
                  this.$custom_json.ep_api.new_folder,
                param
              )
              .then((response) => {
                this.get_tree(this.percorso);
                var message = "";
                switch (response.data) {
                  case "ok":
                    message = "Cartella " + text + " creata correttamente";
                    this.$alert(message, "OK", "success");
                    break;
                  case "ko":
                    message =
                      "Cartella " + text + " presente, scegli un nome diverso";
                    this.$alert(message, "Attenzione", "warning");
                    break;
                }
              });
          } catch (error) {
            console.log("impossibile accedere al cloud");
          }
        } else {
          this.$alert("Inserire un nome valido", "Attenzione", "warning");
        }
      });
    },
    async get_tree(subfolder = "") {
      var url_cloud;
      var UO_tipo;
      var param;
      // chiamata per il recupero dell'albero dei file
      // controllo se è stato premuto il tasto home -> reset
      url_cloud = this.$custom_json.ep_api.cloud;
      if (subfolder == "reset") {
        subfolder = "";
        this.percorso = "";
        this.$emit("get_percorso", this.percorso);
        this.breadcrumbs = [];
      }

      this.sub = subfolder;

      // Verifico se esiste la props "uso" -> se esiste passo come unità operativa 999 altrimenti
      // passo quella recuperata dallo storage
      this.uso
        ? (UO_tipo = 999)
        : (UO_tipo = JSON.parse(
            localStorage.getItem("chisono_data")
          ).UnitaOperativa_Tipo_ID);

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
          this.$emit("get_percorso", this.percorso);
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
          .post(
            this.$custom_json.base_url + this.$custom_json.api_url + url_cloud,
            param
          )
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
@import "/css/cloud.css";

.gestione {
  font-size: 1rem !important;
  margin: 0px !important;
  padding: 0px !important;
}
.area_cloud {
  display: flex;
}

/* FINE CLOUD */
</style>