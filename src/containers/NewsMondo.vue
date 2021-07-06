<template>
  <div>
    <CModal
      color="dark"
      centered
      :show.sync="newsModal"
      style="z-index: 30"
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
            :src="$custom_json.img_news_url + news[newsNum].immagine"
            style="max-width: 760px; max-height: 500px"
          />
        </div>
        <div class="text-justify" v-html="news[newsNum].contenuto">
          
        </div>
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
      style="z-index: 10"
    >
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
        <CListGroup>
          <CListGroupItem
            v-for="(item, index) in news.slice(0, 3)"
            :key="index"
          >
            <CMedia aside-right aside-vertical-position="center">
              <template #aside>
                <CImg
                  :src="$custom_json.img_news_url + item.immagine"
                  width="100px"
                  height="100px"
                />
              </template>

              <h5 class="mt-0 text-justify" style="text-transform: uppercase">
                <strong>{{ item.titolo }}</strong>
              </h5>
              <p class="text-justify" v-html="$options.filters.truncate(item.contenuto, 150, ' [...]')">
                
              </p>
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
// import axios from "axios";

export default {
  name: "NewsMondo",

  data() {
    return {
      news: JSON.parse(localStorage.getItem("news_mondo")),
      newsNum: 0,
      newsModal: false,
      user_storage: [],
      admin: JSON.parse(localStorage.getItem("chisono_data")).Is_Sede,
    };
  },
  mounted() {
    this.user_storage = JSON.parse(localStorage.getItem("chisono_data"));
  },
  methods: {
    showModal(indice) {
      this.newsModal = true;
      this.newsNum = indice;
    },
  },
};
</script>
<style scoped>
.card-header {
  border-bottom: 0px !important;
}
.card-footer {
  border-top: 0px !important;
}
#world-list .list-group-item {
  border-left: 0px !important;
  border-right: 0px !important;
  border-bottom: 0px !important;
  border-radius: 0px !important;
}
#world-list li {
  border-top: 1px solid rgba(0, 0, 21, 0.125) !important;
}
img {
  object-fit: cover;
  border-radius: 3px;
}
</style>