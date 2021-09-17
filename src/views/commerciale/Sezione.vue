<template>
  <div class="my-3 mx-3">
    <div v-show="contenuto == 'Assicurazioni'">
      <CTabs variant="tabs" :active-tab="0">
        <CTab>
          <template slot="title">
            <i class="fas fa-rss fa-2x"></i>
            <span class="tabs-nav"> Comunicazioni</span>
          </template>
          <CCardGroup class="latest container">
            <div
              class="col-lg-3 col-sm-6"
              v-for="(item, index) in post"
              :key="index"
            >
              <CCard
                class="mx-2 card_materiale card_post"
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
                  <CCardHeader class="text-uppercase"
                    ><strong>
                      <u>{{ item.settore }}</u>
                    </strong></CCardHeader
                  >
                  <CCardImg
                    :src="'../' + item.copertina"
                    style="min-height: 200px"
                    alt="- IMPOSSIBILE CARICARE -"
                  >
                  </CCardImg>
                  <CCardBody class="pb-2"
                    ><h2>{{ item.titolo }}</h2>
                    <cite> {{ item.data_ins | formatDate }}</cite>
                    <div
                      v-html="
                        $options.filters.truncate(item.contenuto, 50, ' [...]')
                      "
                    ></div>
                  </CCardBody>
                  <CCardFooter><strong>Leggi di più...</strong> </CCardFooter>
                </CLink>
              </CCard>
            </div>
          </CCardGroup>
        </CTab>
        <CTab>
          <template slot="title">
            <i class="fas fa-paperclip fa-2x"></i>
            <span class="tabs-nav"> Materiale</span>
          </template>
          <PersonalCloud :area="contenuto" />
        </CTab>
      </CTabs>
    </div>
    <div v-show="contenuto == 'Energy'">
      <CTabs variant="tabs" :active-tab="0">
        <CTab>
          <template slot="title">
            <i class="fas fa-rss fa-2x"></i>
            <span class="tabs-nav"> Comunicazioni</span>
          </template>
          <CCardGroup class="latest container">
            <div
              class="col-lg-3 col-sm-6"
              v-for="(item, index) in post"
              :key="index"
            >
              <CCard
                class="mx-2 card_materiale card_post"
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
                  <CCardHeader class="text-uppercase"
                    ><strong>
                      <u>{{ item.settore }}</u>
                    </strong></CCardHeader
                  >
                  <CCardImg
                    :src="'../' + item.copertina"
                    style="min-height: 200px"
                  >
                  </CCardImg>
                  <CCardBody class="pb-2"
                    ><h2>{{ item.titolo }}</h2>
                    <cite> {{ item.data_ins | formatDate }}</cite>
                    <div
                      v-html="
                        $options.filters.truncate(item.contenuto, 50, ' [...]')
                      "
                    ></div>
                  </CCardBody>
                  <CCardFooter><strong>Leggi di più...</strong> </CCardFooter>
                </CLink>
              </CCard>
            </div>
          </CCardGroup>
        </CTab>
        <CTab>
          <template slot="title">
            <i class="fas fa-paperclip fa-2x"></i>
            <span class="tabs-nav"> Materiale</span>
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
    };
  },
  mounted() {
    this.get_lista_post();
  },
  components: {
    PersonalCloud,
  },
  methods: {
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
            this.$custom_json.api_url + this.$custom_json.ep_api.lista_post,
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
  width: 50%;
  border-top: 6px solid var(--bgColor);
}

.latest a:hover {
  text-decoration: none;
}
.tabs-nav {
  font-size: 1.5rem !important;
}
</style>