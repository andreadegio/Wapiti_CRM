<template>
  <div
    v-if="loader"
    style="position: relative; width: 100%; top: 50%; left: 50%;"
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
    <!-- <div class="lds-grid">
      <div></div>
      <div></div>
      <div></div>
      <div></div>
      <div></div>
      <div></div>
      <div></div>
      <div></div>
      <div></div>
    </div> -->
  </div>
  <div v-else>
    <div v-if="news != null" id="elenco_mondo" style="display: grid !important">
      <h1 class="mb-3 mt-3 text-center titolo_sezione">
        Elenco News dal mondo
      </h1>

      <vue-masonry-wall :items="news" :options="options">
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
                v-html="item.contenuto"
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
      </vue-masonry-wall>
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
import VueMasonryWall from "vue-masonry-wall";
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
  components: { VueMasonryWall },
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