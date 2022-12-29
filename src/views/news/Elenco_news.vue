<template>
  <div
    v-if="loader"
    style="position: relative; width: 100%; top: 50%; left: 50%"
  >
    <img
      src="img/loader.gif"
      style="
        position: fixed;
        top: 50%;
        left: 50%;
        width: auto !important;
        height: auto !important;
        -webkit-transform: translate(-50%, -50%);
        -moz-transform: translate(-50%, -50%);
        -ms-transform: translate(-50%, -50%);
        -o-transform: translate(-50%, -50%);
        transform: translate(-50%, -50%);
        object-fit: none;
      "
    />
  </div>
  <div v-else>
    <div v-if="news != null" id="elenco_mondo" style="display: grid !important">
      <CModal color="dark" centered :show.sync="newsModal" size="lg">
        <template #header>
          <strong style="text-transform: uppercase">{{
            news_filtrate[newsNum].titolo
          }}</strong>
          <CButton
            style="color: white"
            class="close"
            @click="newsModal = false"
          >
            <!-- <button type="button" class="close" aria-label="Close"> -->
            <span aria-hidden="true">&times;</span>
          </CButton>
        </template>
        <template>
          <div style="text-align: center">
            <CImg
              :src="
                $custom_json.base_url +
                $custom_json.img_news_url +
                news_filtrate[newsNum].immagine
              "
              style="max-width: 760px; max-height: 500px"
            />
          </div>
          <div class="pt-3 text-justify testo_news" v-html="news_filtrate[newsNum].contenuto"> </div>
        </template>

        <template #footer>
          <em
            ><small>Notizia pubblicata il: {{ news_filtrate[newsNum].data }} </small></em
          >
        </template>
      </CModal>
      <h1 class="mb-4 mt-4 text-center titolo_sezione">Elenco News</h1>
      <div id="filtro_ricerca" class="mt-2 mx-5 riquadro row">
        <div class="text-left col-sm-3 separatore">
          <strong> <i class="fas fa-filter"></i> Filtra per anno:</strong>
          <treeselect
            v-model="filtroAnno"
            class="ml-2 filtro"
            :multiple="false"
            :options="anni_select"
            :max-height="300"
            placeholder="Seleziona un anno"
          />
        </div>

        <div class="text-left col-sm-4 separatore">
          <strong><i class="fas fa-search"></i> Ricerca: </strong><br />
          <input
            v-model="ricercaTxt"
            id="ricercaTesto"
            placeholder="Testo da cercare"
            class="filtro mx-1 inputSearch"
            style="
              border-bottom: 1px solid gray !important;
              border-left: 0 !important;
              border-right: 0 !important;
              border-top: 0 !important;
              background-color: unset !important;
              border-radius: 0 !important;
              padding-left: 3px !important;
              margin-bottom: 0 !important;
              width: 100%;
              line-height: 2rem;
            "
          />
        </div>
        <div class="text-center col-sm-4" v-if="admin">
          <CLink
            to="Gestione_news_Mondo"
            class="card-header-action btn-setting"
            style="position: absolute"
            ><CIcon name="cil-settings" /><strong> Gestione News</strong>
          </CLink>
        </div>
      </div>
      <CCardGroup class="latest col-12">
        <div
          class="col-lg-2 col-sm-6 px-0"
          v-for="(item, index) in news_filtrate"
          :key="index"
        >
          <CCard
            class="mx-1 card_materiale"
            style="height: 100%"
            @click="showModal(index)"
          >
            <CCardImg
              :src="
                $custom_json.base_url +
                $custom_json.img_news_url +
                item.immagine
              "
              style="height: 15rem; object-fit: cover"
              alt="- IMPOSSIBILE CARICARE -"
            >
            </CCardImg>
            <CCardBody class="py-1 px-2 card_post">
              <div class="text-center dettagli">
                <i class="far fa-calendar-alt"></i>
                {{ item.data | formatDate }}
              </div>
              <div class="titolo text-center pt-3">
                {{ item.titolo }}
              </div>
            </CCardBody>
            <CCardFooter class="text-center py-2">
              <strong>Leggi...</strong>
            </CCardFooter>
          </CCard>
        </div>
      </CCardGroup>
    </div>
    <div v-else>
      <div class="errore_caricamento px-5 py-3 mt-5">
        <i class="far fa-frown fa-10x"></i>
        <p class="py-3 px-3">
          Spiacenti si è verificato un errore durante il caricamento delle news
          prova a ricaricare
        </p>
        <CButton
          @click="load_news()"
          color="primary"
          size="lg"
          variant="outline"
        >
          <i class="fas fa-redo-alt"></i> Ricarica
        </CButton>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Treeselect from "@riophae/vue-treeselect";
import "@riophae/vue-treeselect/dist/vue-treeselect.css";
export default {
  name: "ElencoNews",
  components: {
    Treeselect,
  },
  data() {
    return {
      admin: JSON.parse(localStorage.getItem("chisono_data")).Is_Sede,
      ricercaTxt: "",
      filtroAnno: null,
      anni_select: [],
      newsNum: 0,
      newsModal: false,
      news: null,
      loader: true,
    };
  },
  computed: {
    news_filtrate() {
      let tempNews = this.news;

      // Ricerca testuale
      if (this.ricercaTxt != "" && this.ricercaTxt) {
        tempNews = tempNews.filter((item) => {
          return item.titolo
            .toUpperCase()
            .includes(this.ricercaTxt.toUpperCase());
        });
      }

      // Filtro per anno di pubblicazione
      if (this.filtroAnno) {
        tempNews = tempNews.filter((a) => {
          return a.data.substr(0, 4).includes(this.filtroAnno);
        });
      }
      return tempNews;
    },
  },
  mounted() {
    this.load_news();
  },
  methods: {
    async load_news() {
      this.loader = true;
      var chiamata_news = [];
      try {
        await axios
          .get(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.listanews
          )
          .then((response) => {
            chiamata_news = response.data;
          });
        this.news = chiamata_news.map((item, id) => {
          return { ...item, id };
        });
        this.loader = false;
      } catch {
        this.news = null;
        this.loader = false;
      }
      // Genero l'elenco degli anni disponibili per popolare la select del filtro per anno

      const result = [
        ...new Set(
          this.news.map((event) => new Date(event.data).getFullYear())
        ),
      ];
      result.forEach((element) => {
        // console.log(element);
        this.anni_select.push({ id: element, label: element });
        // console.log(this.anni_select);
      });
      // console.log("filtrato= ", result);
    },
    showModal(indice) {
      this.newsModal = true;
      this.newsNum = indice;
      // console.log(indice);
    },
  },
};
</script>

<style scoped>
#elenco_mondo {
  margin-right: 20px;
  margin-left: 20px;
  margin-bottom: 20px;
}
.Item {
  overflow: hidden;
  border-radius: 4px;
  width: 100%;
  background: #f5f5f5;
}
.Content {
  padding: 20px;
}
img {
  object-fit: cover;
  width: 100%;
  height: 100%;
  line-height: 0;
  display: block;
}
.elevation-6 {
  box-shadow: 0 3px 5px -1px rgba(0, 0, 0, 0.2),
    0 6px 10px 0 rgba(0, 0, 0, 0.14), 0 1px 18px 0 rgba(0, 0, 0, 0.12) !important;
}
.errore_caricamento {
  text-align: center;
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  color: #3c4b64;
  font-weight: 600;
}
.errore_caricamento p {
  font-size: 1.5rem;
  font-weight: 300;
}
.titolo {
  font-size: 1.2rem !important;
  max-width: 95%;
  /* white-space: nowrap;
  overflow: hidden; */
  /* text-overflow: ellipsis; */
  letter-spacing: 0.05rem;
  font-weight: 600;
}
.dettagli {
  font-size: 0.8rem !important;
  text-transform: uppercase;
  letter-spacing: 0.025em;
  color: #ef7918 !important;
}
.riquadro {
  border: 1px solid lightgray;
  border-radius: 10px;
  padding: 0.5rem;
  background-color: aliceblue;
  margin-bottom: 3px !important;
}
.views {
  position: absolute;
  top: auto;
  left: 5px;
  right: auto;
  color: rgb(164, 160, 160);
  font-size: 0.7rem;
}
.filtro {
  display: inline-table;
  vertical-align: middle;
  padding: 0px;
}
#ricercaTesto .form-control {
  border-bottom: 1px solid gray !important;
  border-left: 0 !important;
  border-right: 0 !important;
  border-top: 0 !important;
  background-color: unset !important;
  border-radius: 0 !important;
  padding-left: 3px !important;
  margin-bottom: 0 !important;
}
.separatore {
  border-right: 1px dotted gray;
}
.testo_news{
  font-size: 1rem !important;
}
</style>