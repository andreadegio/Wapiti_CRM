<template>
  <div style="margin-top: 50px">
    <CRow>
      <!-- <CCol md="1"> </CCol> -->

      <!-- colonna file manager -->
      <CCol
        md="3"
        style="background-color: white; border-right: 1px solid lightgrey"
      >
        <!-- Documenti Broker -->
        <div
          v-for="folder in documenti_list"
          :key="folder.slug"
          class="folder parent pt-0 pl-5"
        >
          <!-- <span @click="call_intermediario_list(folder)" class="icon_folder h4"> -->
          <span @click="call_folder_list(folder.slug, folder)" class="icon_folder h4">
            {{ folder.nome }}</span
          >
        </div>

        <!-- Settori -->
        <div
          v-for="folder in folder_list"
          :key="folder.slug"
          class="folder parent pt-0 pl-5"
        >
          <span @click="call_parent_list(folder)" class="icon_folder h4">
            {{ folder.nome }}</span
          >
          <li
            v-for="items in folder.childs"
            :key="items.slug"
            class="folder h5"
          >
            └
            <span
              @click="call_folder_list(items.slug, folder)"
              class="icon_folder"
              >{{ items.nome }}</span
            >
            <div class="pl-4" v-show="items.slug == 'ALTRE_GARANZIE'">
              <li
                v-for="tipo in altre_gar"
                :key="tipo.index"
                @click="filter_garanzie(tipo, folder)"
                class="folder h6"
              >
                └ <span class="icon_folder">{{ tipo }}</span>
              </li>
            </div>
          </li>
        </div>
      </CCol>

      <!-- colonna elenco file browser -->
      <CCol
        md="5"
        style="background-color: white; border-right: 1px solid lightgrey"
      >
        <div>
          <!-- <span class="h2"> Documenti</span><br /> -->
          <!-- breadrumbs -->
          <div v-if="breadcrumbs.length > 0" id="breadcrumbs" class="pt-3">
            <span style="border: 1px solid; border-radius: 3px; padding: 2px">
              <font-awesome-icon :icon="breadcrumbs[0][1]"></font-awesome-icon>
              {{ breadcrumbs[0][0] }}
            </span>
            <span style="padding: 2px"
              ><i class="fas fa-chevron-right"></i
            ></span>
            <span
              v-if="settore !== ''"
              style="border: 1px solid; border-radius: 3px; padding: 2px"
              >{{ settore }}</span
            >
            <span v-if="filtro_gar !== ''" style="padding: 2px"
              ><i class="fas fa-chevron-right"></i>
              <span
                style="border: 1px solid; border-radius: 3px; padding: 2px"
                >{{ filtro_gar }}</span
              ></span
            >
            <div class="pt-5 h2" v-if="settore == ''">
              <span v-if="breadcrumbs[0][0] == 'SETTORI 1 E 2'">
                <div
                  v-for="folder in folder_list"
                  :key="folder.name"
                  class="folder parent pt-0 pl-5"
                  style="background-color: #ebedef"
                >
                  <li
                    v-for="items in folder.childs"
                    :key="items.nome"
                    class="p-2 folder h5"
                  >
                    <span
                      @click="call_folder_list(items.slug, folder)"
                      class="icon_folder"
                      >{{ items.nome }}</span
                    >
                  </li>
                </div>
              </span>
              <span v-else> Al momento non ci sono documenti disponibili </span>
            </div>
          </div>
          <div v-else class="pt-5 display-4">
            <font-awesome-icon icon="arrow-left"></font-awesome-icon> Effettua
            una selezione
          </div>
          <!-- DATA TABLE PER INTERMEDIARIO -->
          <div class="pt-5" v-if="settore === 'INTERMEDIARIO' || settore === 'DOCUMENTAZIONE'">
            <CDataTable
              id="int_table"
              :items="files"
              :fields="fields_INTERMEDIARIO"
              sorter
              pagination
              :table-filter="{
                placeholder: 'Ricerca...',
                label: 'Ricerca:',
              }"
              striped
              :items-per-page-select="{ label: 'Risultati per pagina' }"
            >
              <template #visualizza_POG="{ item }">
                <td class="py-2 text-center">
                  <CButton
                    v-if="item.Pog !== ''"
                    color="primary"
                    variant="outline"
                    square
                    size="sm"
                    @click="preview(item.Pog)"
                  >
                    Visualizza
                  </CButton>
                </td>
              </template>
              <template #visualizza="{ item }">
                <td class="py-2 text-center">
                  <CButton
                    v-if="item.Nomefile !== ''"
                    color="primary"
                    variant="outline"
                    square
                    size="sm"
                    @click="preview(item.Nomefile)"
                  >
                    Visualizza
                  </CButton>
                </td>
              </template>
            </CDataTable>
          </div>
          <!-- DATA TABLE PER RCA -->
          <div class="pt-5" v-if="settore === 'RC AUTO'">
            <CDataTable
              id="rc_table"
              :items="files"
              :fields="fields_RCA"
              sorter
              pagination
              :table-filter="{
                placeholder: 'Ricerca...',
                label: 'Ricerca:',
              }"
              striped
              :items-per-page-select="{ label: 'Risultati per pagina' }"
            >
              <template #visualizza_POG="{ item }">
                <td class="py-2 text-center">
                  <CButton
                    v-if="item.Pog !== ''"
                    color="primary"
                    variant="outline"
                    square
                    size="sm"
                    @click="preview(item.Pog)"
                  >
                    Visualizza
                  </CButton>
                </td>
              </template>
              <template #visualizza="{ item }">
                <td class="py-2 text-center">
                  <CButton
                    v-if="item.Nomefile !== ''"
                    color="primary"
                    variant="outline"
                    square
                    size="sm"
                    @click="preview(item.Nomefile)"
                  >
                    Visualizza
                  </CButton>
                </td>
              </template>
            </CDataTable>
          </div>
          <!-- DATA TABLE PER SERVIZI NON ASSICURATIVI -->
          <div class="pt-5" v-if="settore === 'SERVIZI NON ASSICURATIVI'">
            <CDataTable
              id="altre_table"
              :items="files"
              :fields="fields_SERVIZI"
              sorter
              pagination
              :column-filter-value="{ Tipo: filtro_gar }"
              :table-filter="{
                placeholder: 'Ricerca...',
                label: 'Ricerca:',
              }"
              striped
              :items-per-page-select="{ label: 'Risultati per pagina' }"
            >
              <template #visualizza="{ item }">
                <td class="py-2 text-center">
                  <CButton
                    v-if="item.Nomefile !== ''"
                    color="primary"
                    variant="outline"
                    square
                    size="sm"
                    @click="preview(item.Nomefile)"
                  >
                    Visualizza
                  </CButton>
                </td>
              </template>
            </CDataTable>
          </div>
          <!-- DATA TABLE PER ALTRE GARANZIE -->
          <div class="pt-5" v-if="settore === 'ALTRE GARANZIE'">
            <CDataTable
              id="altre_table"
              :items="files"
              :fields="fields_ALTRE"
              sorter
              pagination
              :column-filter-value="{ Tipo: filtro_gar }"
              :table-filter="{
                placeholder: 'Ricerca...',
                label: 'Ricerca:',
              }"
              striped
              :items-per-page-select="{ label: 'Risultati per pagina' }"
            >
              <template #visualizza_POG="{ item }">
                <td class="py-2 text-center">
                  <CButton
                    v-if="item.Pog !== ''"
                    color="primary"
                    variant="outline"
                    square
                    size="sm"
                    @click="preview(item.Pog)"
                  >
                    Visualizza
                  </CButton>
                </td>
              </template>
              <template #visualizza="{ item }">
                <td class="py-2 text-center">
                  <CButton
                    v-if="item.Nomefile !== ''"
                    color="primary"
                    variant="outline"
                    square
                    size="sm"
                    @click="preview(item.Nomefile)"
                  >
                    Visualizza
                  </CButton>
                </td>
              </template>
            </CDataTable>
          </div>
        </div>
      </CCol>

      <!-- colonna preview pdf -->
      <CCol md="4" style="background-color: white; height: 800px">
        <span class="h2"> Anteprima</span>
        <div
          class="pt-5"
          v-if="file_name !== ''"
          style="background-color: #ebedef"
          :key="file_name"
        >
          <div id="viewer"></div>
          <object
            width="100%"
            height="600"
            :data="file_name"
            type="application/pdf"
            :key="file_name"
          ></object>
          <!-- <embed
            :src="file_name"
            type="application/pdf"
            width="90%"
            height="700px;"
          /> -->
          <!-- <div v-if="loadedRatio > 0 && loadedRatio < 1" style="background-color: green; color: white; text-align: center" :style="{ width: loadedRatio * 100 + '%' }">{{ Math.floor(loadedRatio * 100) }}%</div>
            <pdf v-if="show" ref="pdf" style="border: 1px solid red"  @error="notifica_errore" :src="file_name"  @progress="loadedRatio = $event" ></pdf> -->

          <!-- <pdf @error="notifica_errore" :src="file_name"></pdf> -->
        </div>
        <div
          class="pt-5 text-center"
          style="
            background-color: #ebedef !important;
            height: 600px;
            width: 95%;
          "
          v-if="file_name == ''"
        >
          <div
            v-if="timer != 0 && select == false"
            style="background-color: #fff"
          >
            <img src="img/search-folder.gif" style="width: 50px" /><br />
            <span class="h4">... Recupero documento in corso ...</span>
          </div>
          <div v-show="select">
            <span class="h4">Seleziona un documento</span>
          </div>
        </div>
      </CCol>

      <!-- <CCol md="1"> </CCol> -->
    </CRow>
  </div>
</template>
<script>
import axios from "axios";
import { folder_list, documenti_list } from "./folder";
import { config_data } from "../../../public/config/config";
// import pdf from "vue-pdf";

// NOMI DELLE COLONNE DELLA TABELLA PER INTERMEDIARIO
const fields_INTERMEDIARIO = [
  {
    key: "Descrizione",
    _style: "font-weight: bold; text-align:center;",
    label: "Descrizione",
  },
  {
    key: "visualizza",
    label: "Fascicolo  Informativo",
    sorter: false,
    filter: false,
    _style: "text-align:center;",
  },
];
// NOMI DELLE COLONNE DELLA TABELLA PER RCA
const fields_RCA = [
  {
    key: "Descrizione",
    _style: "font-weight: bold; text-align:center;",
    label: "Compagnia",
  },

  {
    key: "visualizza_POG",
    label: "POG",
    sorter: false,
    filter: false,
    _style: "text-align:center;",
  },
  {
    key: "visualizza",
    label: "Set Informativo",
    sorter: false,
    filter: false,
    _style: "text-align:center;",
  },
];
// NOMI DELLE COLONNE DELLA TABELLA PER ALTRE GARANZIE
const fields_ALTRE = [
  {
    key: "Tipo",
    _style: "font-weight: bold; text-align: center;",
    label: "Tipologia",
  },
  {
    key: "Descrizione",
    _style: "font-weight: bold; text-align: center;",
    label: "Compagnia",
  },

  {
    key: "visualizza",
    label: "POG",
    sorter: false,
    filter: false,
    _style: "text-align: center;",
  },
  {
    key: "visualizza",
    label: "Set Informativo",
    sorter: false,
    filter: false,
    _style: "text-align: center;",
  },
];
// NOMI DELLE COLONNE DELLA TABELLA PER ALTRI SERVIZI
const fields_SERVIZI = [
  {
    key: "Tipo",
    _style: "font-weight: bold; text-align: center;",
    label: "Tipologia",
  },
  {
    key: "Descrizione",
    _style: "font-weight: bold; text-align: center;",
    label: "Descrizione",
  },
  {
    key: "visualizza",
    label: "Set Informativo",
    sorter: false,
    filter: false,
    _style: "text-align: center;",
  },
];
export default {
  name: "Documentale",

  components: {},
  data() {
    return {
      file_name: "", // Usato per passare l'url alla preview
      folder_list, // Albero dei documenti (veicoli->rca->altre garanzie / rami / energia)
      select: true,
      documenti_list,
      files: [].map((item, id) => {
        return { ...item, id };
      }),
      fields_RCA,
      fields_ALTRE,
      fields_SERVIZI,
      fields_INTERMEDIARIO,
      settore: "",
      breadcrumbs: [],
      altre_gar: [],
      filtro_gar: "",
      timer: 0,
    };
  },

  methods: {
    call_folder_list(slug, folder_name, filtro = "") {
      this.filtro_gar = filtro;
      this.breadcrumbs = [];
      this.breadcrumbs.push([folder_name.nome, folder_name.ico]);
      let target_api = "";
      this.file_name = "";
      this.select = true;
      // this.timer= 0;
      switch (slug) {
        case "INTERMEDIARIO":
          this.files = [];
          target_api = "DocumentiIntermediario";
          this.settore = "INTERMEDIARIO";
          break;
        case "PRECONTRATTUALE":
          this.files = [];
          target_api = "PreContrattuale";
          this.settore = "DOCUMENTAZIONE";
          break;
        case "RC_AUTO":
          this.files = [];
          target_api = "RCA";
          this.settore = "RC AUTO";
          break;
        case "ALTRE_GARANZIE":
          this.files = [];
          this.settore = "ALTRE GARANZIE";
          target_api = "AltreGaranzie";
          this.call_garanzie_list(); // chiamata per popolare il sotto elenco delle garanzie
          break;
        case "ALTRI_SERVIZI":
          this.settore = "SERVIZI NON ASSICURATIVI";
          target_api = "ServiziNonAssicurativi";
          // AGGANCIARE SERVIZIO PER ELENCO SERVIZI NON ASSICURATIVI
          break;
          default:
            target_api="";
      }
      this.load_documentale(target_api);
    
    },

    async load_documentale(target) {
      var elenco = [];
      var config = {
        method: "post",
        url: config_data.servizi_broker + "Documentale_" + target,
        headers: {
          userID: localStorage.getItem("userID"),
          anagraficaID: localStorage.getItem("anagraficaID"),
        },
      };
      await axios(config)
        .then(function (response) {
          // console.log(JSON.stringify(response.data));
          elenco = response.data;
          //  console.log("valore di elenco " + elenco);
        })
        .catch(function (error) {
          elenco = [];
          console.log(error);
        });
      this.files = elenco;
    },

    async call_garanzie_list(filtro = "") {
      this.select = true;
      // this.timer= 0;
      this.file_name = "";
      this.filtro_gar = filtro;
      this.altre_gar = [];
      var elenco = [];
      var lista_gar = [];
      let target = "AltreGaranzie";
      var config = {
        method: "post",
        url: config_data.servizi_broker + "Documentale_" + target,
        headers: {
          userID: localStorage.getItem("userID"),
          anagraficaID: localStorage.getItem("anagraficaID"),
        },
      };
      await axios(config)
        .then(function (response) {
          // console.log(JSON.stringify(response.data));
          elenco = response.data;
          var lookup = {};
          var items = elenco;
          for (var item, i = 0; (item = items[i++]); ) {
            var name = item.Tipo;

            if (!(name in lookup)) {
              lookup[name] = 1;
              lista_gar.push(name);
            }
          }
        })
        .catch(function (error) {
          elenco = [];
          console.log(error);
        });

      this.altre_gar = lista_gar;
    },

    filter_garanzie(tipo) {
      // console.log(tipo);
      this.select = true;
      if (this.settore !== "ALTRE GARANZIE") {
        this.filtro_gar = tipo;
        this.breadcrumbs = [];
        this.breadcrumbs.push(["SETTORE 1 E 2", "car"]);
        let target_api = "";
        this.file_name = "";
        this.settore = "ALTRE GARANZIE";
        target_api = "AltreGaranzie";
        this.load_documentale(target_api);
        this.call_garanzie_list();
      }
      // svuotamento dell'array files necessario per reimpostare la paginazione
      // let temp_file= this.files;
      // this.files =[];
      // this.files= temp_file;
      this.filtro_gar = tipo;
    },

    // CHIAMATA PER LE SOTTOCARTELLE E PER FILTRARE 
    call_parent_list(folder_name, filtro = "") {
      this.select = true;
      // this.timer= 0;
      this.filtro_gar = filtro;
      this.breadcrumbs = [];
      this.breadcrumbs.push([folder_name.nome, folder_name.ico]);
      // alert(index);
      this.settore = "";
      this.file_name = "";
      this.files = [];
    },

    // CHIAMATA PER VISUALIZZARE I PDF
    preview(url) {
      if (this.timer == 0) {
        this.select = false;
        this.file_name = config_data.documentale_broker + url;
        this.timer = 1;
        setTimeout(() => {
          this.timer = 0;
        }, 8000);
      } else {
        this.file_name = "";
        console.log("riprovo");
        setTimeout(() => {
          this.preview(url);
        }, 1000);
      }
    },
  },
};
</script>
<style scoped>
.parent {
  padding-top: 3em;
}
.folder {
  cursor: pointer;
  list-style-type: none;
}

.icon_folder::before {
  content: "\f07b";
  font-family: "Font Awesome 5 free";
  color: rgb(252, 198, 3);
  font-size: 2em;
  font-weight: 900;
  padding-right: 5px;
}
.icon_folder:hover::before {
  content: "\f07c";
  font-family: "Font Awesome 5 free";
  color: rgb(252, 198, 3);
  font-size: 2em;
  font-weight: 900;
  padding-right: 5px;
}
</style>