<template>
  <div id="elenco_mondo"  >
    <h1 class="mb-3 mt-3 text-center titolo_sezione">Elenco News dal mondo</h1>

    <vue-masonry-wall :items="news" :options="options">
      <template v-slot:default="{ item }">
        <div class="Item elevation-6">
          <img :src="config_data.img_news_url + item.immagine" />

          <div class="Content" style="text-align: center">
            <h5 class="text-ellipsis-1l pb-2">
              <strong>{{ item.titolo }}</strong>
            </h5>
            <p class="text-ellipsis-2l text-justify" v-html= item.contenuto> </p>
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
</template>

<script>
import VueMasonryWall from "vue-masonry-wall";
import axios from "axios";
import { config_data } from "../../../public/config/config";

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
      news:[],
      config_data,
      // news: news
      //   .sort((a, b) => {
      //     return new Date(b.data) - new Date(a.data);
      //   })
      //   .map((item, id) => {
      //     return { ...item, id };
      //   }),
    };
  },
  mounted() {
    this.load_news();
  },
  methods: {
    async load_news() {
      var chiamata_news = [];
      await axios
        .get(config_data.api_url + "listanews")
        .then((response) => {
          chiamata_news = response.data;
        });
      this.news = chiamata_news.map((item, id) => {
        return { ...item, id };
      });
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
</style>