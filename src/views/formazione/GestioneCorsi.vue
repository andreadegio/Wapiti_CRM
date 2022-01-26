<template>
  <div id="Archivio">
    <div class="row">
      <div class="col-md-1"></div>
      <div class="col-md-10">
        <div
          class="breadcrumbs card_post"
          :style="{ '--bgColor': $attrs.colore }"
        >
          <CLink @click="back()" class="breadcrumbs_link">Gestione Corsi</CLink>
          > Archivio
        </div>
        <CRow class="justify-content-center">
          <h1 class="mb-3 titolo_sezione">Archivio</h1>
        </CRow>
        <CCardBody color="white" class="mt-2">
          <CDataTable
            :noItemsView="{
              noResults: 'no filtering results available custom',
              noItems: 'Nessun corso presente',
            }"
            ref="tabella_post"
            :items="post"
            :fields="fields"
            :table-filter="{
              placeholder: 'Ricerca...',
              label: 'Ricerca nei corsi:',
            }"
            :items-per-page-select="{ label: 'Risultati per pagina' }"
            :items-per-page="post_per_pagina"
            hover
            sorter
            pagination
            striped
            clickableRows
            @row-clicked="myRowClickHandler"
          >
            <template #show_details="{ item }">
              <td class="py-2" style="text-align: center !important">
                <CButton
                  color="primary"
                  variant="outline"
                  square
                  size="sm"
                  @click="onToggleDetailsClicked(item.id)"
                >
                  {{ Boolean(item._toggled) ? "Nascondi" : "Mostra" }}
                </CButton>
                <router-link
                  :to="{
                    name: 'ModificaCorso',
                    params: {
                      post: item.id,
                      editPost: item,
                      settore: $attrs.settore,
                      lista_aree: $attrs.lista_aree,
                    },
                  }"
                >
                  <CButton
                    :id="'ModificaPost' + item.id"
                    size="sm"
                    color="warning"
                    class="ml-2"
                  >
                    Modifica
                  </CButton>
                </router-link>
              </td>
            </template>

            <template #details="{ item }">
              <CCollapse :show="item._toggled" :duration="collapseDuration">
                <CCardBody>
                  <CMedia
                    :aside-image-props="{
                      src: $custom_json.base_url + item.copertina,
                    }"
                  >
                    <div class="row">
                      <div class="col-sm-8">
                        <div>
                          <span class="text-muted"><h4>Contenuto:</h4></span>
                          <p v-html="item.contenuto"></p>
                        </div>
                      </div>
                      <div class="col-sm-4">
                        <h4>Permessi:</h4>
                        <treeselect
                          v-model="item.permessi"
                          :multiple="true"
                          :always-open="false"
                          :disabled="true"
                          :options="options"
                          :max-height="300"
                          placeholder="Permessi"
                          :disableFuzzyMatching="true"
                        />
                        <hr />
                        <h4>Obiettivi del corso:</h4>
                        {{ item.obiettivi }}
                      </div>
                    </div>
                  </CMedia>
                </CCardBody>
              </CCollapse>
            </template>
          </CDataTable>
        </CCardBody>
      </div>
      <div class="col-md-1"></div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Treeselect from "@riophae/vue-treeselect";

const fields = [
  { key: "titolo", _style: "max-width:20rem; font-weight: bold;" },
  { key: "sottotitolo", label: "Sottotitolo" },
  { key: "data_ins", label: "Data Inserimento" },
  {
    key: "visite",
    label: "Visualizzazioni",
    filter: false,
    _classes: "text-center",
  },
  {
    key: "show_details",
    label: "Opzioni",
    sorter: false,
    filter: false,
  },
];

export default {
  name: "GestionePost",
  components: {
    Treeselect,
  },
  data() {
    return {
      post: [],
      fields,
      details: [],
      collapseDuration: 300,
      modale_is_visible: false,
      post_da_modificare: {},
      post_per_pagina: 10,
      add_edit: "",
      options: [
        {
          id: "999",
          label: "TUTTI",
          isDefaultExpanded: true,
          children: JSON.parse(localStorage.getItem("tipologie")),
        },
      ],
      permessi: [],
    };
  },
  computed: {
    post_template() {
      if (typeof this.post[0] === "undefined") return;
      let post_vuota = {};
      Object.keys(this.post[0]).forEach((key) => {
        post_vuota[key] = "";
      });
      return post_vuota;
    },
  },
  mounted() {
    this.get_lista_corsi();
  },

  methods: {
    myRowClickHandler(record, index, column, e) {
      // console.log(column);
      if (e.target.tagName == "BUTTON") {
        this.onModificaClick;
      } else {
        this.onToggleDetailsClicked(index);
      }
    },
    back() {
      this.$emit("back");
    },
    async get_lista_corsi() {
      // Chiamata per recuperare la lista dei post
      let params = {
        UO_tipo: JSON.parse(localStorage.getItem("chisono_data"))
          .UnitaOperativa_Tipo_ID,
        is_sede: JSON.parse(localStorage.getItem("chisono_data")).Is_Sede,
      };
      var lista_corsi = [];
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.lista_corsi,
            { params },
            {
              header: {
                "Content-Type": "multipart/form-data",
              },
            }
          )
          .then((response) => {
            lista_corsi = response.data;
          });
        this.post = lista_corsi.map((item, id) => {
          return { ...item, id };
        });
        // console.log(this.post[0].color_settore);
      } catch (error) {
        console.log("impossibile recuperare la lista corsi");
      }
      // console.log(JSON.stringify(this.post));
    },

    togglePost(id_post_da_togglare) {
      //   console.log(id_post_da_togglare);
      this.post[id_post_da_togglare]._toggled =
        !this.post[id_post_da_togglare]._toggled;
    },
    onToggleDetailsClicked(id_post_da_togglare) {
      this.togglePost(id_post_da_togglare);
      this.$forceUpdate();
    },

    cambiaPaginazioneTabella(per_page_items) {
      // crea oggetto da inviare alla CDataTable per cambiare la paginazione
      let pagination_object = {
        target: {
          value: per_page_items,
        },
      };
      // chiama la funzione di cambio paginazione sulla CDataTable
      this.$refs.tabella_post.paginationChange(pagination_object);
    },
    forzaUpdateTabella() {
      // per forzare l'update della CDataTable simulo un cambio di paginazione
      // salva l'attuale valore di paginazione
      // metti paginazione a 1
      // rimetti attuale valore di paginazione
      // in questo modo la tabella si ri-renderizza
      let old_val = this.$refs.tabella_post.perPageItems;
      this.cambiaPaginazioneTabella(1);
      this.cambiaPaginazioneTabella(old_val);
    },
  },
};
</script>
<style scoped>
#gestione_mondo {
  margin-right: 20px;
  margin-left: 20px;
  margin-bottom: 20px;
}
</style>