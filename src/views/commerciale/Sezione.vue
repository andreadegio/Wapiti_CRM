<template>
  <div class="my-3 row">
    <div class="col-md-1"></div>
    <div v-show="contenuto == 'Assicurazioni'" class="col-md-10">
      <CTabs variant="tabs" :active-tab="0">
        <CTab>
          <template slot="title">
            <i class="fas fa-rss fa-2x"></i>
            <span class="tabs-nav"> Comunicazioni</span>
          </template>
          <CCardGroup class="latest">
            <div
              class="col-lg-3 col-sm-6 px-0 pb-0"
              v-for="(item, index) in post"
              :key="index"
            >
              <CCard
                class="mx-1 pt-2 card_materiale card_post pb-0 mb-0"
                :style="{ '--bgColor': item.color_settore }"
              >
                <CLink
                  :to="{
                    name: 'Comunicazione',
                    params: {
                      notizia: item.titolo,
                      id: item.id,
                      lista_post: post,
                    },
                  }"
                >
                  <CCardHeader class="text-uppercase pt-0 titolo_color"
                    ><strong class="titolo_color">
                      <u>{{ item.settore }}</u>
                    </strong></CCardHeader
                  >
                  <CCardImg
                    :src="$custom_json.base_url + item.copertina"
                    style="height: 15rem; object-fit: cover"
                    alt="- IMPOSSIBILE CARICARE -"
                  >
                  </CCardImg>
                  <CBadge
                    v-if="
                      lista_nuovi != null && lista_nuovi.includes(item.id_post)
                    "
                    color="danger"
                    class="badgeNuovo"
                    >Nuovo
                  </CBadge>
                  <CCardBody class="py-0 px-1" style="min-height: 5rem">
                    <div class="text-right">
                      <cite> {{ item.data_ins | formatDate }}</cite>
                    </div>
                    <h2 class="text-center">
                      {{ item.titolo | truncate(20, "[...]") }}
                    </h2>

                    <!-- <div
                v-html="$options.filters.truncate(item.contenuto, 50, ' [...]')"
              ></div> -->
                  </CCardBody>
                  <CCardFooter class="text-center py-2"
                    ><strong>Leggi di più...</strong>
                  </CCardFooter>
                </CLink>
              </CCard>
            </div>
          </CCardGroup>
          <div class="text-center">
            <span v-show="post.length == 0" class="display-4">
              Nessun contenuto disponibile
            </span>
          </div>
        </CTab>
        <CTab>
          <template slot="title">
            <i class="fas fa-paperclip fa-2x"></i>
            <span class="tabs-nav"> Materiale disponibile</span>
          </template>
          <PersonalCloud :area="contenuto" />
        </CTab>
      </CTabs>
    </div>
    <div v-show="contenuto == 'Energy'" class="col-md-10">
      <CTabs variant="tabs" :active-tab="0">
        <CTab>
          <template slot="title">
            <i class="fas fa-rss fa-2x"></i>
            <span class="tabs-nav"> Comunicazioni</span>
          </template>
          <CCardGroup class="latest">
            <div
              class="col-lg-3 col-sm-6 px-0 pb-0"
              v-for="(item, index) in post"
              :key="index"
            >
              <CCard
                class="mx-1 pt-2 card_materiale card_post pb-0 mb-0"
                :style="{ '--bgColor': item.color_settore }"
              >
                <CLink
                  :to="{
                    name: 'Comunicazione',
                    params: {
                      notizia: item.titolo,
                      id: item.id,
                      lista_post: post,
                    },
                  }"
                >
                  <CCardHeader class="text-uppercase pt-0 titolo_color"
                    ><strong class="titolo_color">
                      <u>{{ item.settore }}</u>
                    </strong></CCardHeader
                  >
                  <CCardImg
                    :src="$custom_json.base_url + item.copertina"
                    style="height: 15rem; object-fit: cover"
                    alt="- IMPOSSIBILE CARICARE -"
                  >
                  </CCardImg>
                  <CBadge
                    v-if="
                      lista_nuovi != null && lista_nuovi.includes(item.id_post)
                    "
                    color="danger"
                    class="badgeNuovo"
                    >Nuovo
                  </CBadge>
                  <CCardBody class="py-0 px-1" style="min-height: 10rem">
                    <div class="text-right">
                      <cite> {{ item.data_ins | formatDate }}</cite>
                    </div>
                    <h2 class="text-center">{{ item.titolo }}</h2>

                    <!-- <div
                v-html="$options.filters.truncate(item.contenuto, 50, ' [...]')"
              ></div> -->
                  </CCardBody>
                  <CCardFooter class="text-center py-2"
                    ><strong>Leggi di più...</strong>
                  </CCardFooter>
                </CLink>
              </CCard>
            </div>
          </CCardGroup>
          <div class="text-center">
            <span v-show="post.length == 0" class="display-4">
              Nessun contenuto disponibile
            </span>
          </div>
        </CTab>
        <CTab>
          <template slot="title">
            <i class="fas fa-paperclip fa-2x"></i>
            <span class="tabs-nav"> Materiale disponibile</span>
          </template>
          <PersonalCloud :area="contenuto" />
        </CTab>
      </CTabs>
    </div>
  </div>
</template>
<script>
import axios from "axios";
import PersonalCloud from "./cloud.vue";
export default {
  name: "Area_tematica",
  props: ["contenuto"],

  data() {
    return {
      tree_RC: {},
      post: [],
      lista_nuovi: [],
    };
  },
  mounted() {
    // console.log("contenuto" + this.contenuto);
    this.get_lista_post();
    this.getToSee();
  },
  components: {
    PersonalCloud,
  },
  methods: {
    async getToSee() {
      // Chiamata per recuperare l'array dei corsi da leggere
      let params = {
        categoria: "Post",
        utente: localStorage.getItem("userID"),
        tipo_uo: JSON.parse(localStorage.getItem("chisono_data"))
          .UnitaOperativa_Tipo_ID,
      };
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.get_toSee,
            { params }
          )
          .then((response) => {
            this.lista_nuovi = response.data;
          });
      } catch (error) {
        console.log("errore: " + error);
      }
    },
    async get_lista_post() {
      // Chiamata per recuperare la lista dei post
      let params = {
        UO_tipo: JSON.parse(localStorage.getItem("chisono_data"))
          .UnitaOperativa_Tipo_ID,
        is_sede: JSON.parse(localStorage.getItem("chisono_data")).Is_Sede,
        settore: this.contenuto,
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
        // console.log(this.post);
      } catch (error) {
        console.log("impossibile accedere al cloud");
      }
      // console.log(JSON.stringify(this.post));
    },
  },
};
</script>
<style scoped>
.new_fluid {
  display: grid;
}
.card_post::before {
  content: "";
  display: block;
  position: absolute;
  top: 0;
  left: 0;
  width: 50%;
  height: 8px;
  background: linear-gradient(
    to right,
    var(--bgColor) 60%,
    rgba(255, 255, 255, 0) 100%
  );
  /* border-top: 6px solid var(--bgColor); */
}
.titolo_color {
  color: var(--bgColor) !important;
}
.latest a:hover {
  text-decoration: none;
}
.tabs-nav {
  font-size: 1.5rem !important;
}
.badgeNuovo {
  position: absolute;
  z-index: 99;
  right: 42%;
  top: 56%;
  padding: 0.4em 0.4em !important;
  box-shadow: 0 3px 5px -1px rgba(0, 0, 0, 0.2),
    0 6px 10px 0 rgba(0, 0, 0, 0.55), 0 1px 18px 0 rgba(223, 78, 78, 0.83) !important;
  font-size: 90% !important;
}
</style>