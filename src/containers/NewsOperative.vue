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
        <strong>{{ news_operative[newsNum].Titolo }}</strong>
      
        <CButton class="close" @click="newsModal = false">
          <!-- <button type="button" class="close" aria-label="Close"> -->
          <span aria-hidden="true">&times;</span>
        </CButton>
      </template>
      <template>
           <CBadge
              :style="
                'background-color:' + news_operative[newsNum].Colore + '!important; color: white;'
              "
            >
              {{ news_operative[newsNum].Categoria }}
            </CBadge>
        <div class="pt-2 text-justify">
          {{ news_operative[newsNum].Contenuto }}
        </div>
      </template>
      <template #footer>
        <em
          ><small
            >Notizia pubblicata il {{ news_operative[newsNum].Data }}
          </small></em
        >
      </template>
    </CModal>

    <CCard data-aos="fade-right" class="h-100" style="z-index: 10">
      <CCardHeader class="d-flex justify-content-between">
        <strong class="h4">NEWS OPERATIVE </strong>
        <div class="card-header-actions">
          <CLink to="./NewsOperative" class="card-header-action btn-setting">
            <strong>
              <CIcon name="cil-justify-center" /> Elenco completo...</strong
            >
          </CLink>
        </div>
      </CCardHeader>
      <CCardBody id="news-list" class="news_card">
        <CListGroup>
          <CListGroupItem
            class="flex-column align-items-start"
            v-for="(item, index) in news_operative.slice(0, 3)"
            :key="index"
          >
            <CBadge
              :style="
                'background-color:' + item.Colore + '!important; color: white;'
              "
            >
              {{ item.Categoria }}
            </CBadge>
            <div
              class="d-flex w-100 justify-content-between"
              style="text-transform: uppercase"
            >
              <h5 class="mb-1">
                <strong>
                  {{ item.Titolo }}
                </strong>
              </h5>
            </div>
            <p class="mb-1 text-justify">
              {{ item.Contenuto | truncate(150, " [...]") }}
            </p>
            <div class="mt-2 mb-2 d-flex justify-content-between">
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
                  >Notizia pubblicata il {{ item.Data }}</small
                ></em
              >
            </div>
          </CListGroupItem>
        </CListGroup>
      </CCardBody>
      <CCardFooter v-if="admin">
        <div class="card-header-actions">
          <!-- <CLink
            to="./news/GestioneNewsBroker"
            class="card-header-action btn-setting"
            ><strong><CIcon name="cil-settings" /> Gestione</strong>
          </CLink> -->
        </div>
      </CCardFooter>
    </CCard>
  </div>
</template>
<script>
export default {
  name: "NewsOperative",
  data() {
    return {
      news_operative: JSON.parse(localStorage.getItem("news_operative")),
      newsNum: 0,
      newsModal: false,
      admin: JSON.parse(localStorage.getItem("chisono_data")).Is_Sede,
    };
  },
  mounted() {
    // console.log("news");
    
    // console.log(this.admin);
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

#news-list .list-group-item {
  border-left: 0px !important;
  border-right: 0px !important;
  border-bottom: 0px !important;
  border-radius: 0px !important;
}
#news-list li {
  border-top: 1px solid rgba(0, 0, 21, 0.125) !important;
}
</style>