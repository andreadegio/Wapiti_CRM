<template>
  <div id="Archivio">
    <div class="row">
      <div class="col-md-1"></div>
      <div class="col-md-10">
        <div
          class="breadcrumbs card_post"
          :style="{ '--bgColor': $attrs.colore }"
        >
          <CLink @click="back()" class="breadcrumbs_link"
            >Gestione {{ $route.params.settore }}</CLink
          >
          > Archivio
        </div>
        <CRow class="justify-content-center">
          <h1 class="mb-3 titolo_sezione">Archivio</h1>
        </CRow>
        <CCardBody color="white" class="mt-2">
          <CDataTable
          :noItemsView="{ noResults: 'no filtering results available custom', noItems: 'Nessuna comunicazione o materiale presente' }"
            ref="tabella_post"
            :items="post"
            :fields="fields"
            :table-filter="{
              placeholder: 'Ricerca...',
              label: 'Ricerca contenuti:',
            }"
            :items-per-page-select="{ label: 'Post per pagina' }"
            :items-per-page="post_per_pagina"
            hover
            sorter
            pagination
            striped
            clickableRows
            @row-clicked="myRowClickHandler"
          >
            <template #show_details="{ item }">
              <td class="py-2">
                <CButton
                  color="primary"
                  variant="outline"
                  square
                  size="sm"
                  @click="onToggleDetailsClicked(item.id)"
                >
                  {{ Boolean(item._toggled) ? "Nascondi" : "Mostra" }}
                </CButton>
                <router-link :to="{name: 'ModificaContenuti', params: { post: item.id, editPost: item, settore: $attrs.settore, lista_aree : $attrs.lista_aree }}" >
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
                      <div class="col-sm-4">
                        <div>
                          <span class="text-muted"><h4>Contenuto:</h4></span>
                          <p v-html="item.contenuto"></p>
                        </div>
                      </div>
                      <div v-show="item.allegati == 1" class="col-sm-8">
                        <h4>Allegati:</h4>
                        <hr />
                        <div v-for="allegato in item.files" :key="allegato.id">
                          <span>{{ allegato.nome_file }}</span>
                        </div>
                        <div></div>
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

const fields = [
  { key: "titolo", _style: "min-width:200px; font-weight: bold;" },
  { key: "sottotitolo", label: "Sottotitolo" },
  { key: "categoria", label: "Categoria" },
  { key: "data_ins", label: "Data Inserimento" },

  {
    key: "show_details",
    label: "Opzioni",
    sorter: false,
    filter: false,
  },
];

export default {
  name: "GestionePost",
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
    this.get_lista_post();
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
    async get_lista_post() {
      // Chiamata per recuperare la lista dei post
      let params = {
        UO_tipo: JSON.parse(localStorage.getItem("chisono_data"))
          .UnitaOperativa_Tipo_ID,
        is_sede: JSON.parse(localStorage.getItem("chisono_data")).Is_Sede,
        settore: this.$route.params.settore,
      };
      var lista_post = [];
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.lista_post,
            { params },
            {
              header: {
                "Content-Type": "multipart/form-data",
              },
            }
          )
          .then((response) => {
            lista_post = response.data;
          });
        this.post = lista_post.map((item, id) => {
          return { ...item, id };
        });
        // console.log(this.post[0].color_settore);
      } catch (error) {
        console.log("impossibile accedere al cloud");
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
    // onModificaClick(post_da_modificare) {
    //   // console.log("modifica del post " + post_da_modificare.categoria);
    //   // console.log("modifica del post " + JSON.stringify(post_da_modificare));
    //   this.$router.push("ModificaContenuti");
    //   // this.$router.push({
    //   //   name: "ModificaContenuti",
    //   //   params: { post: post_da_modificare.id_post, editPost: post_da_modificare, settore: this.$attrs.settore, lista_aree : this.$attrs.lista_aree },
    //   // });
    // },
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