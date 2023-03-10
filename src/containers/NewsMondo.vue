<template>
  <div v-if="news != null && news != ''">
    <CModal
      color="dark"
      centered
      :show.sync="newsModal"
      
      size="lg"
    >
      <template #header>
        <strong style="text-transform: uppercase">{{
          news[newsNum].titolo
        }}</strong>
        <CButton style="color: white" class="close" @click="newsModal = false">
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
              news[newsNum].immagine
            "
            style="max-width: 760px; max-height: 500px"
          />
        </div>
        <div class="text-justify" v-html="news[newsNum].contenuto"></div>
      </template>

      <template #footer>
        <em
          ><small>Notizia pubblicata il: {{ news[newsNum].data }} </small></em
        >
      </template>
    </CModal>
    <CCard
      id="world-list"
      md="8"
      class="h-100"
     
      :show.sync="news"
    >
      <CCardHeader class="main_title d-flex justify-content-between">
        <strong class="h3 titolo_gradient">NEWS DAL MONDO</strong>
        <div class="card-header-actions">
          <CLink to="./Elenco_news" class="card-header-action btn-setting">
            <strong
              ><CIcon name="cil-justify-center" /> Elenco completo...</strong
            >
          </CLink>
        </div>
      </CCardHeader>
      <CCardBody md="4" class="news_card py-0">
        <CListGroup>
          <CListGroupItem
            v-for="(item, index) in news.slice(0, 4)"
            :key="index"
          >
            <CMedia aside-right aside-vertical-position="center">
              <template #aside>
                <CImg
                  :src="
                    $custom_json.base_url +
                    $custom_json.img_news_url +
                    item.immagine
                  "
                  width="100px"
                  height="100px"
                />
              </template>

              <div class="mt-0 text-justify" style="text-transform: uppercase">
                <strong>{{ item.titolo }}</strong>
              </div>
              <p
                class="text-justify testo_news"
                v-html="
                  $options.filters.truncate(item.contenuto, 150, ' [...]')
                "
              ></p>
            </CMedia>
            <div class="d-flex justify-content-between">
              <CButton
                @click="showModal(index)"
                color="primary"
                size="sm"
                variant="outline"
              >
                Leggi tutto
              </CButton>
              <em
                ><small class="text-muted"
                  >Notizia pubblicata il {{ item.data }}</small
                ></em
              >
            </div>
          </CListGroupItem>
        </CListGroup>
      </CCardBody>
      <CCardFooter class="pt-0">
        <div class="card-header-actions" v-if="admin">
          <CLink to="Gestione_news_Mondo" class="card-header-action btn-setting"
            ><CIcon name="cil-settings" /><strong> Gestione</strong>
          </CLink>
        </div>
      </CCardFooter>
    </CCard>
  </div>
  <div v-else>
    <CCard id="world-list" md="8" class="h-100" style="z-index: 10">
      <CCardHeader class="d-flex justify-content-between">
        <strong class="h4">NEWS DAL MONDO</strong>
        <div class="card-header-actions">
          <CLink to="./Elenco_news" class="card-header-action btn-setting">
            <strong
              ><CIcon name="cil-justify-center" /> Elenco completo...</strong
            >
          </CLink>
        </div>
      </CCardHeader>
      <CCardBody md="4" class="news_card py-0">
        <div class="errore_caricamento px-5 py-3 mt-5">
          <i class="far fa-frown fa-10x"></i>
          <p class="py-3 px-3">
            Spiacenti si è verificato un errore durante il caricamento delle
            news prova a ricaricare
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
      </CCardBody>
      <CCardFooter>
        <div class="card-header-actions" v-if="admin">
          <CLink to="Gestione_news_Mondo" class="card-header-action btn-setting"
            ><CIcon name="cil-settings" /><strong> Gestione</strong>
          </CLink>
        </div>
      </CCardFooter>
    </CCard>
  </div>
</template>
<script>
export default {
  name: "NewsMondo",
  props: ["newsParent"],
  watch: {
    newsParent: function (newVal) {
      // console.log(JSON.stringify(newVal));
      this.news = newVal;
    },
  },

  data() {
    return {
      news: [],
      newsNum: 0,
      newsModal: false,
      user_storage: [],
      admin: JSON.parse(localStorage.getItem("chisono_data")).Is_Sede,
    };
  },
  mounted() {
    this.news = this.newsParent;
  },
  methods: {
    load_news() {
      this.$emit("reload_mondo");
    },
    showModal(indice) {
      this.newsModal = true;
      this.newsNum = indice;
    },
  },
};
</script>