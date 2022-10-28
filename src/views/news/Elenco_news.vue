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
      <h1 class="mb-3 mt-3 text-center titolo_sezione">
        Elenco News dal mondo
      </h1>
      <CCardGroup class="latest col-12">
        <div
          class="col-lg-2 col-sm-6 px-0"
          v-for="(item, index) in news"
          :key="index"
        >
          <CCard class="mx-1 card_materiale">
            <!-- <CLink
              :to="{
                name: 'Corso',
                params: {
                  corso: item.titolo,
                  id: item.id,
                  lista_corsi: corsi,
                },
              }"
            > -->
              <CCardImg
                :src="$custom_json.base_url +
                $custom_json.img_news_url +
                item.immagine"
                style="height: 15rem; object-fit: cover"
                alt="- IMPOSSIBILE CARICARE -"
              >
              </CCardImg>
              <!-- <CBadge
                v-if="
                  lista_nuovi != null && lista_nuovi.includes(item.id_corso)
                "
                color="danger"
                class="badgeNuovo"
                >Nuovo
              </CBadge> -->

              <CCardBody
                class="py-1 px-2 card_post"
                
                style="min-height: 10rem"
              >
                <div class="titolo text-left pt-3">
                  {{ item.titolo | truncate(20, "[...]") }}
                </div>
                <div class="row dettagli pt-4 pb-5 text-center">
                  <!-- <div class="col-6">
                    <i class="far fa-calendar-alt"></i>
                    {{ item.data_ins | formatDate }}
                  </div>
                  <div class="col-6">
                    <i class="far fa-clock"></i> {{ item.durata }} minuti
                  </div> -->
                </div>
                <div class="text-right"></div>
              </CCardBody>
              <CCardFooter class="text-right py-2">
                <!-- <div
                  class="views"
                  v-c-tooltip="{
                    content: 'Visualizzazioni ',
                    placement: 'bottom-end',
                  }"
                >
                  <i class="far fa-eye"></i> {{ item.visite }}
                </div> -->
                <strong>Vai al corso...</strong>
              </CCardFooter>
            <!-- </CLink> -->
          </CCard>
        </div>
      </CCardGroup>
      <!-- <vue-masonry-wall :items="news" :options="options">
        <template v-slot:default="{ item }">
          <div class="Item elevation-6">
            <img
              :src="
                $custom_json.base_url +
                $custom_json.img_news_url +
                item.immagine
              "
            />

            <div class="Content" style="text-align: center">
              <h5 class="text-ellipsis-1l pb-2">
                <strong>{{ item.titolo }}</strong>
              </h5>
              <p
                class="text-ellipsis-2l text-justify"
                v-html="$options.filters.truncate(item.contenuto, 200, ' [...]')"
              ></p>
              <p style="text-align: right">
                <em
                  ><small class="text-muted" style=""
                    >Notizia pubblicata il {{ item.data }}</small
                  ></em
                >
              </p>
            </div>
          </div>
        </template>
      </vue-masonry-wall> -->
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
// import VueMasonryWall from "vue-masonry-wall";
import axios from "axios";

// eslint-disable-next-line no-unused-vars
function content() {
  const length = Math.random() * 300 + 30;
  let result = "";
  const characters =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  const charactersLength = characters.length;
  for (let i = 0; i < length; i++) {
    result += characters.charAt(Math.floor(Math.random() * charactersLength));
  }
  return result;
}
export default {
  name: "MasonryNews",
  // components: { VueMasonryWall },
  data() {
    return {
      options: {
        width: 300,
        padding: {
          2: 8,
          default: 12,
        },
      },
      news: null,
      loader: true,
    };
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
</style>