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
          <span
            @click="
              call_folder_list(folder);
              dove_sono = folder.slug;
            "
            style="white-space: nowrap"
            class="icon_folder h4"
            :class="{ highlight: dove_sono == folder.slug }"
          >
            {{ folder.nome }}</span
          >
        </div>

        <!-- Settori -->
        <div
          v-for="folder in folder_list"
          :key="folder.slug"
          class="folder parent pt-0 pl-5"
        >
          <span
            @click="
              call_folder_list(folder);
              dove_sono = folder.slug;
            "
            style="white-space: nowrap"
            class="icon_folder h4"
            :class="{ highlight: dove_sono == folder.slug }"
          >
            {{ folder.nome }}</span
          >
          <li
            v-for="items in folder.childs"
            :key="items.slug"
            class="folder h5 pl-3"
          >
            └
            <span
              @click="
                call_subfolder_list(items, folder);
                dove_sono = items.slug;
              "
              class="icon_folder"
              :class="{ highlight: dove_sono == items.slug }"
              style="white-space: nowrap"
              >{{ items.nome }}</span
            >
            <div class="pl-4" v-show="items.slug == 'ALTRE_GARANZIE'">
              <li
                v-for="tipo in altre_gar"
                :key="tipo.index"
                class="folder h6 pl-3"
              >
                └
                <span
                  class="icon_folder"
                  style="white-space: nowrap"
                  @click="
                    filter_garanzie(tipo);
                    dove_sono = tipo;
                  "
                  :class="{ highlight: dove_sono == tipo }"
                  >{{ tipo }}</span
                >
              </li>
            </div>
            <div class="pl-4" v-show="items.slug == 'ALTRI_SERVIZI'">
              <li
                v-for="tipo in altri_servizi"
                :key="tipo.index"
                class="folder h6"
              >
                └
                <span
                  class="icon_folder"
                  style="white-space: nowrap"
                  @click="
                    filter_servizi(tipo);
                    dove_sono = tipo;
                  "
                  :class="{ highlight: dove_sono == tipo }"
                  >{{ tipo }}</span
                >
              </li>
            </div>
          </li>
        </div>
      </CCol>

      <!-- colonna centrale elenco file browser -->
      <CCol
        md="5"
        style="background-color: white; border-right: 1px solid lightgrey"
      >
        <div>
          <!-- <span class="h2"> Documenti</span><br /> -->
          <!-- breadcrumbs -->
          <div v-if="breadcrumbs.length > 0" id="breadcrumbs" class="pt-3">
            <span style="border: 1px solid; border-radius: 3px; padding: 2px">
              <font-awesome-icon :icon="breadcrumbs[0][1]"></font-awesome-icon>
              {{ breadcrumbs[0][0] }}
            </span>
            <span v-if="breadcrumbs.length >= 2" style="padding: 2px"
              ><i class="fas fa-chevron-right"></i
            ></span>
            <span
              v-if="breadcrumbs.length >= 2"
              style="border: 1px solid; border-radius: 3px; padding: 2px"
              >{{ breadcrumbs[1][0] }}</span
            >
            <span v-if="breadcrumbs.length == 3" style="padding: 2px"
              ><i class="fas fa-chevron-right"></i
            ></span>
            <span
              v-if="breadcrumbs.length == 3"
              style="border: 1px solid; border-radius: 3px; padding: 2px"
              >{{ breadcrumbs[2][0] }}</span
            >
            <!-- <span v-if="filtro_gar !== ''" style="padding: 2px"
              ><i class="fas fa-chevron-right"></i>
              <span
                style="border: 1px solid; border-radius: 3px; padding: 2px"
                >{{ filtro_gar }}</span
              ></span
            > -->
            <div class="pt-5" v-if="settore == 'SETTORI 1 E 2'">
              <!-- <div class="pt-5 h2"> -->
              <span>
                <div
                  v-for="folder in folder_list"
                  :key="folder.name"
                  class="pt-0"
                >
                  <div v-show="folder.subFolder">
                    <table
                      class="table table-striped table-bordered"
                      style="border: 0 !important"
                    >
                      <thead>
                        <tr>
                          <th
                            style="
                              border-left: 0 !important;
                              border-right: 0 !important;
                            "
                            class="text-center"
                          >
                            Tipologia
                          </th>
                          <th
                            style="
                              border-left: 0 !important;
                              border-right: 0 !important;
                            "
                          ></th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr
                          v-for="items in folder.childs"
                          :key="items.nome"
                          @click="
                            call_subfolder_list(items, folder);
                            dove_sono = items.slug;
                          "
                          style="cursor: pointer"
                        >
                          <td
                            style="
                              border-left: 0 !important;
                              border-right: 0 !important;
                            "
                          >
                            <span class="icon_folder pr-2"></span
                            >{{ items.nome }}
                          </td>

                          <td
                          class="text-right"
                            style="
                              border-left: 0 !important;
                              border-right: 0 !important;
                            "
                          >
                            <CButton
                              color="primary"
                              variant="outline"
                              square
                              size="sm"
                            >
                              Visualizza
                            </CButton>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                  <!-- <li
                    v-for="items in folder.childs"
                    :key="items.nome"
                    class="p-2 folder h5"
                  >
                    <span
                      @click="call_subfolder_list(items, folder)"
                      class="icon_folder"
                      >{{ items.nome }}</span
                    >
                  </li> -->
                </div>
              </span>
              
            </div>
          </div>
          <div v-else class="pt-5 display-4">
            <font-awesome-icon icon="arrow-left"></font-awesome-icon> Effettua
            una selezione
          </div>
          <div v-show="vuoto" class="pt-5 h4 text-center">
               - Al momento non ci sono documenti disponibili -
              </div>
          <!-- DATA TABLE PER INTERMEDIARIO -->
          <div
            class="pt-5"
            v-if="settore === 'INTERMEDIARIO' || settore === 'PRECONTRATTUALE'"
          >
            <CDataTable
              id="int_table"
              :items="files"
              :fields="fields_INTERMEDIARIO"
              
              striped
             
              :noItemsView="{ noItems: ' ' }"
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
              :noItemsView="{ noItems: ' ' }"
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
              :noItemsView="{ noItems: ' ' }"
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
              :noItemsView="{ noItems: ' ' }"
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
    key: "visualizza_POG",
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
// NOMI DELLE COLONNE PER LA TABELLA SETTORE12 (ELENCO SUBFOLDER)
const fields_SETTORE12 = [
  {
    key: "Nome",
    _style: "font-weight: bold; text-align: center;",
    label: "Tipologia",
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
      documenti_list, // Documenti intermediario e precontrattuale
      vuoto: false, // Usato per controllare il messaggio "Non ci sono documenti"
      settore: "", // utilizzato per assegnare il data table
      subfolder: "", // utilizzato per il breadcrumb delle cartelle di secondo livello
      breadcrumbs: [], // breadcrumbs di navigazione
      timer: 0, // Utilizzato per temporizzare il passaggio dall'apertura di un documento a l'altro
      select: true, // utilizzato per la visualizzazione del file per far partire il loader o meno
      files: [].map((item, id) => {
        return { ...item, id };
      }),
      dove_sono: undefined,

      fields_RCA,
      fields_ALTRE,
      fields_SERVIZI,
      fields_INTERMEDIARIO,
      fields_SETTORE12,

      altre_gar: [],
      altri_servizi: [],
      filtro_gar: "",
    };
  },

  methods: {
    call_folder_list(folder) {
      // Funzione chiamata dalle cartelle di primo livello (documenti intermediario, precontrattuale, ecc)
      
      this.vuoto = false; // Inizializzo il messaggio "non ci sono file"
      // Inizializzo le sottocartelle
      this.altre_gar = [];
      this.altri_servizi = [];
      this.filtro_gar = "";

      this.breadcrumbs = []; // per popolare il Breadcrumbs
      this.breadcrumbs.push([folder.nome, folder.ico]);

      this.settore = folder.slug; // Per identificare il data-table
      this.files = []; // array dei risultati
      if (folder.URL) {
        // Chiamo la funzione per recuperare le informazioni dai servizi
        this.load_documentale(folder.URL);
      } else {
        if (folder.subFolder == false) {
          // console.log("vuoto");
          this.vuoto = true;
        }
      }
    },

    call_subfolder_list(subfolder, folder) {
      // Funzione chiamata dalle cartelle di secondo livello (RCA, Altre garanzie, ecc)
      this.vuoto = false; // Inizializzo il messaggio "non ci sono file"

      // Inizializzo le sottocartelle
      this.altre_gar = [];
      this.altri_servizi = [];
      this.filtro_gar = "";

      this.breadcrumbs = []; // per popolare il Breadcrumbs
      this.breadcrumbs.push([folder.nome, folder.ico]);
      this.breadcrumbs.push([subfolder.nome]);
      
      this.subfolder = subfolder.slug; // Per identificare il data-table
      switch (subfolder.slug) {
        case "RC_AUTO":
          this.files = [];
          this.settore = "RC AUTO";
          break;
        case "ALTRE_GARANZIE":
          this.files = [];
          this.settore = "ALTRE GARANZIE";
          this.call_garanzie_list("", "AltreGaranzie"); // chiamata per popolare il sotto elenco delle garanzie
          break;
        case "ALTRI_SERVIZI":
          this.settore = "SERVIZI NON ASSICURATIVI";
          this.call_garanzie_list("", "ServiziNonAssicurativi"); // chiamata per popolare il sotto elenco delle garanzie
          break;
      }
      this.files = []; // array dei risultati
      if (subfolder.URL) {
        // Chiamo la funzione per recuperare le informazioni dai servizi
        this.load_documentale(subfolder.URL);
      } else {
        if (subfolder.subFolder == false) {
          this.vuoto = true;
        }
      }
    },

    async call_garanzie_list(filtro = "", target = "") {
      // FUNZIONE PER GENERARE LE SOTTO CARTELLE DI TERZO LIVELLO DI ALTRE GARANZIE E SERVIZI
      this.select = true;
      this.file_name = "";
      this.filtro_gar = filtro; //utilizzato per filtrare i risultati nel datatable
      var elenco = [];
      var lista_gar = [];
      if (target !== "") {
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
      }
      switch (target) {
        case "AltreGaranzie":
          this.altre_gar = lista_gar;
          break;
        case "ServiziNonAssicurativi":
          this.altri_servizi = lista_gar;
          break;
        default:
          this.altre_gar = lista_gar;
      }
    },

    async load_documentale(target) {
      this.vuoto = false; // Inizializzo in modo da non mostrare il messaggio "nessun documento" in fase di caricamento
      var elenco = [];
      var config = {
        method: "post",
        url: config_data.servizi_broker + target,
        headers: {
          userID: localStorage.getItem("userID"),
          anagraficaID: localStorage.getItem("anagraficaID"),
        },
      };
      await axios(config)
        .then(function (response) {
          elenco = response.data;
        })
        .catch(function (error) {
          elenco = [];
          console.log(error);
        });
      this.files = elenco;
      if (this.files.length <= 0) {
        this.vuoto = true; // Variabile usata per il messaggio "non ci sono documenti"
      }
    },

    filter_garanzie(tipo) {
      this.select = true;
      this.breadcrumbs.length == 3
        ? (this.breadcrumbs[2][0] = tipo)
        : this.breadcrumbs.push([tipo]);
      // svuotamento dell'array files necessario per reimpostare la paginazione
      let temp_file = this.files;
      this.files = [];
      this.files = temp_file;
      this.filtro_gar = tipo;
    },

    filter_servizi(tipo) {
      // console.log(tipo);
      this.select = true;
      // console.log("settore: "+ this.settore);
      this.breadcrumbs.length == 3
        ? (this.breadcrumbs[2][0] = tipo)
        : this.breadcrumbs.push([tipo]);
      // svuotamento dell'array files necessario per reimpostare la paginazione
      let temp_file = this.files;
      this.files = [];
      this.files = temp_file;
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
        // console.log("riprovo");
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
.icon_folder.highlight::before {
  content: "\f07c";
  font-family: "Font Awesome 5 free";
  color: rgb(252, 198, 3);
  font-size: 2em;
  font-weight: 900;
  padding-right: 5px;
}
.highlight {
  font-weight: bold;
}


</style>