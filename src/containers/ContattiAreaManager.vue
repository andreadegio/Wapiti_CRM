<template>
  <CCard class="h-100" style="z-index: 10">
    <CCardHeader class="d-flex justify-content-between">
      <strong class="h4 titolo_gradient">RECAPITI</strong>
      <div class="card-header-actions"></div>
    </CCardHeader>
    <CCardBody id="manager" class="news_card py-0">
      <CListGroup>
        <CListGroupItem class="flex-column align-items-start" v-show="chisono.DirettoreCommerciale">
          <div
            class="d-flex w-100 justify-content-between pt-4"
            style="text-transform: uppercase"
          >
            <h4 class="mb-1">
              <strong> Direttore Commerciale </strong>
            </h4>
          </div>
          <p
            class="my-3 text-justify nome"
            v-show="chisono.DirettoreCommerciale"
          >
            <i>{{ chisono.DirettoreCommerciale | capitalize }}</i>
          </p>
          <p
            class="my-3 text-justify"
            v-show="chisono.DirettoreCommerciale_Email"
          >
            <i class="far fa-envelope fa-fw"></i> Mail:
            <span class="mail">{{ chisono.DirettoreCommerciale_Email }}</span>
          </p>
          <p
            class="my-3 text-justify" 
            v-show="chisono.DirettoreCommerciale_TelefonoFisso"
          >
            <i class="fas fa-phone fa-fw"></i> Telefono:
           <span style="text-transform:lowercase"> {{ chisono.DirettoreCommerciale_TelefonoFisso }}</span>
          </p>
          <p
            class="my-3 text-justify"
            v-show="chisono.DirettoreCommerciale_Cellulare"
          >
            <i class="fas fa-mobile-alt fa-fw"></i> Cellulare:
            {{ chisono.DirettoreCommerciale_Cellulare }}
          </p>
        </CListGroupItem>
        <CListGroupItem class="flex-column align-items-start" v-show="chisono.AreaManager">
          <div
            class="d-flex w-100 justify-content-between pt-3"
            style="text-transform: uppercase"
          >
            <h4 class="mb-1">
              <strong> Area Manager </strong>
            </h4>
          </div>
          <p class="my-3 text-justify nome" v-show="chisono.AreaManager">
            <i>{{ chisono.AreaManager | capitalize }}</i>
          </p>
          <p class="my-3 text-justify" v-show="chisono.AreaManager_Email">
            <i class="far fa-envelope fa-fw"></i> Mail:
            <span class="mail">{{ chisono.AreaManager_Email }}</span>
          </p>
          <p
            class="my-3 text-justify" 
            v-show="chisono.AreaManager_TelefonoFisso"
          >
            <i class="fas fa-phone fa-fw"></i> Telefono:
            <span style="text-transform:lowercase">{{ chisono.AreaManager_TelefonoFisso }}</span>
          </p>
          <p class="my-3 text-justify" v-show="chisono.AreaManager_Cellulare">
            <i class="fas fa-mobile-alt fa-fw"></i> Cellulare:
            {{ chisono.AreaManager_Cellulare }}
          </p>
        </CListGroupItem>
      </CListGroup>
    </CCardBody>
  </CCard>
</template>
<script>
export default {
  name: "AreaManager",
  data() {
    return {
      chisono: JSON.parse(localStorage.getItem("chisono_data")),
    };
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

#manager .list-group-item {
  border-left: 0px !important;
  border-right: 0px !important;
  border-bottom: 0px !important;
  border-radius: 0px !important;
}
#manager li {
  border-top: 1px solid rgba(0, 0, 21, 0.125) !important;
}

#manager p {
  font-size: 1.1rem;
  font-weight: 100;
}

#manager p.nome {
  font-weight: 500;
  text-transform: capitalize;
}

#manager span.mail {
  text-transform: lowercase;
}

#manager .fa-fw {
  color: #1e2f56;
}

.titolo_gradient {
  background: -webkit-linear-gradient(#ef7a12, #1e2f56);
  background-clip: border-box;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  font-weight: 700;
}
</style>