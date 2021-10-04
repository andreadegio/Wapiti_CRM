<template>
  <div id="gestione_mondo">
    <keep-alive>
      <AddNews
        :news_originale="news_da_modificare"
        color="dark"
        :centered="true"
        v-if="modale_is_visible"
        style="z-index: 30"
        size="lg"
        :closeOnBackdrop="false"
        @closeModalClick="nascondiModale()"
        @salvaNews="salvaNews()"
      />
    </keep-alive>

    <CRow class="mt-2 justify-content-center">
      <h1 class="mb-3 titolo_sezione ">Gestione News</h1>
    </CRow>

    <CRow>
      <CCardBody color="white" class="mt-2">
        <CDataTable
          ref="tabella_news"
          :items="news"
          :fields="fields"
          :table-filter="{
            placeholder: 'Ricerca...',
            label: 'Ricerca nelle news:',
          }"
          :items-per-page-select="{ label: 'News per pagina' }"
          :items-per-page="news_per_pagina"
          hover
          sorter
          pagination
          striped
        >
          <!-- testa  -->
          <template #thead-top>
            <div class="text-left" >
              <br />
              <CButton
                @click="onAggiungiClick()"
                color="primary"
                size="sm"
                variant="outline"
              >
                Aggiungi News
              </CButton>
            </div>
            <br />
          </template>

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
            </td>
          </template>

          <template #details="{ item }">
            <CCollapse :show="item._toggled" :duration="collapseDuration">
              <CCardBody>
                <CMedia
                  :aside-image-props="{                    
                    src: $custom_json.base_url + $custom_json.img_news_url + item.immagine,
                  }"
                >
                  <h4>
                    {{ item.titolo }}
                  </h4>
                  <p class="text-muted">
                    <strong> Pubblicata il: </strong>{{ item.data }}
                  </p>
                  <div>
                    <span class="text-muted"
                      ><strong>Testo della news:</strong></span
                    ><br /><p v-html= item.contenuto> </p>
                  </div>

                  <CButton
                    size="sm"
                    color="warning"
                    class="mt-3"
                    @click="onModificaClick(item)"
                  >
                    Modifica
                  </CButton>
                </CMedia>
              </CCardBody>
            </CCollapse>
          </template>
        </CDataTable>
      </CCardBody>
    </CRow>
  </div>
</template>





<script>
import axios from "axios";
import AddNews from "./../../containers/AddNews";


const fields = [
  { key: "titolo", _style: "min-width:200px; font-weight: bold;" },
  "data",
  {
    key: "show_details",
    label: "Opzioni",
    sorter: false,
    filter: false,
  },
];

export default {
  name: "GestioneNews",
  data() {
    return {
      news: [],
      fields,
      details: [],
      collapseDuration: 300,
      modale_is_visible: false,
      news_da_modificare: {},
      news_per_pagina: 10,
      add_edit: "",

    };
  },
  computed: {
    news_template() {
      if (typeof this.news[0] === "undefined") return;
      let news_vuota = {};
      Object.keys(this.news[0]).forEach((key) => {
        news_vuota[key] = "";
      });
      return news_vuota;
    },
  },
  components: {
    AddNews,
  },
  mounted() {
    this.load_news();
  },
  methods: {
    async load_news() {
      var chiamata_news = [];
      await axios
        .get(this.$custom_json.base_url + this.$custom_json.api_url + this.$custom_json.ep_api.listanews)
        .then((response) => {
          chiamata_news = response.data;
        });
      // console.log(this.news);
      // console.log("------" + chiamata_news);
      this.news = chiamata_news.map((item, id) => {
        return { ...item, id };
      });
    },

    modificaNews(news_modificata) {
      console.log("GestioneNews modificaNews", news_modificata);
      this.news[news_modificata.id] = news_modificata;
    },

    aggiungiNews(news_da_aggiungere) {
      news_da_aggiungere._toggled = false;
      //alert ("salvo questo" + JSON.stringify(news_da_aggiungere));
      news_da_aggiungere.id = this.news.length;
      this.news.push(news_da_aggiungere);
    },

    newsEsisteGia(news_da_controllare) {
      return news_da_controllare.id in this.news;
    },

    salvaNews() {
      
      this.forzaUpdateTabella();

    },
    getBadge(stato) {
      switch (stato) {
        case "Attiva":
          return "success";
        case "Disattivata":
          return "secondary";
        default:
          "primary";
      }
    },
    toggleNews(id_news_da_togglare) {
      this.news[id_news_da_togglare]._toggled = !this.news[id_news_da_togglare]
        ._toggled;
    },
    onToggleDetailsClicked(id_news_da_togglare) {
      this.toggleNews(id_news_da_togglare);
      this.$forceUpdate();
    },
    mostraModale() {
      this.modale_is_visible = true;
    },
    nascondiModale() {
      this.modale_is_visible = false;
      console.log("Aggiorno tabella");
      this.load_news();
    },
    onModificaClick(news_da_modificare) {
      this.news_da_modificare = news_da_modificare;
      
      this.add_edit = "edit";
      this.mostraModale();
      this.$forceUpdate();
    },
    onAggiungiClick() {
      this.news_da_modificare = this.news_template;
      this.add_edit = "add";
      this.mostraModale();

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
      this.$refs.tabella_news.paginationChange(pagination_object);
    },
    forzaUpdateTabella() {
      // per forzare l'update della CDataTable simuliamo un cambio di paginazione
      // salva l'attuale valore di paginazione
      // metti paginazione a 1
      // rimetti attuale valore di paginazione
      // in questo modo la tabella si ri-renderizza
      let old_val = this.$refs.tabella_news.perPageItems;
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